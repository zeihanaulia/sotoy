
Kadang lo bikin sistem yang kerjanya di balik layar. Kayak proses code generation yang lo trigger dari web, tapi di balik itu semua, ada proses AI yang jalan di background, parsing metadata, generate kode, dan simpen hasil. Masalahnya: user cuma liat loading spinner, padahal di balik layar lagi banyak hal seru—dan penting—yang terjadi.

Di sinilah lo pengen kasih visibility. Biar user bisa liat log secara real-time. Biar kalau mereka cabut dan balik lagi, masih bisa liat jejak prosesnya. Lo butuh log system yang ringan, bisa di-*stream*, dan bisa di-*persist*. Bukan cuma buat user experience, tapi juga buat debugging, QA, dan observabilitas internal tim dev.

![alt text](assets/til.python.building-sse/image.png)

---

## Sistem Ini Dibangun di Atas Tiga Pilar

FastAPI jadi tulang punggungnya. Server-Sent Events (SSE) yang ngirim log kayak radio satu arah. Dan Supabase jadi storage kalau semua udah kelar. Sisanya? Sedikit HTML dan JavaScript untuk prototipe awal.

Gue tau lo pengen cepat nyoba, jadi UI-nya nggak langsung React atau Refine. Nanti itu bisa nyusul. Sekarang yang penting jalan dulu.

```sh
+-----------+          SSE           +-----------------+
|           |  <------------------  |                 |
|  FastAPI  | ------------------>   |   Frontend UI   |
| (Backend) |   Streaming Logs      | (HTML/JS/React) |
+-----------+                       +-----------------+
     |
     | Background Tasks
     |
     v
+------------------+
|  BufferedLogger  |
|  (In-Memory Log) |
+------------------+
     |
     | flush when done
     v
+------------------+
|    Supabase      |
| (Final Log Store)|
+------------------+

```
Gambaran besarnya:

- FastAPI jadi otaknya, ngatur semua routing dan trigger proses.
- Frontend UI (HTML/JS awalnya, bisa evolve ke React) connect via SSE buat dapetin log real-time.
- Sementara itu di dalam FastAPI, log dicatat dulu di BufferedLogger—disimpan sementara di memori.
- Begitu prosesnya selesai, logger nge-flush log-nya ke Supabase buat diambil lagi nanti kalau user refresh atau datang belakangan.

---

## Logger: Komponen Paling Penting yang Lo Gak Liat

Di dalam FastAPI, kita bikin `BufferedLogger`. Ini semacam log manager lokal. Dia nyimpen log selama proses jalan, terus kasih akses ke client lewat `subscribe()` pake `asyncio.Queue`. Tiap log baru langsung dipush ke semua subscriber aktif. Dan kalau prosesnya udah selesai, dia `flush_to_supabase()` biar gak hilang.

Semua logger disimpan di satu peta global: `logger_map[(upload_id, service)]`. Jadi kapan pun, route mana pun, asal tau ID-nya, bisa ambil logger yang sama. Ini yang bikin komunikasi antara background task dan SSE handler jadi seamless.

```python
import asyncio
from datetime import datetime
from typing import Literal


class BufferedLogger:
    def __init__(self):
        self.subscribers: list[asyncio.Queue] = []
        self.buffer: list[dict] = [] 
        self.done = False
        self.last_used = datetime.now().timestamp()

    def subscribe(self) -> asyncio.Queue:
        queue = asyncio.Queue()
        self.subscribers.append(queue)

        # Kirim log yang sudah ada ke subscriber baru
        for entry in self.buffer:
            queue.put_nowait(entry)

        return queue

    def unsubscribe(self, queue: asyncio.Queue):
        try:
            self.subscribers.remove(queue)
        except ValueError:
            pass

    def mark_done(self):
        self.done = True

    def log(self, message: str, level: Literal["info", "error"] = "info"):
        entry = {
            "timestamp": datetime.now().isoformat(),
            "log_level": level,
            "message": message
        }

        # save buffer
        self.buffer.append(entry)

        # Broadcast to all subscribers
        for q in self.subscribers:
            q.put_nowait(entry)

        self.last_used = datetime.now().timestamp()

    async def flush_to_supabase(self, upload_id: str, service: str, supabase):
        for entry in self.buffer:
            supabase.table("runs_logs").insert({
                "upload_id": upload_id,
                "service_name": service,
                "timestamp": entry["timestamp"],
                "log_level": entry["log_level"],
                "message": entry["message"]
            }).execute()
```

---

## Jalankan Proses, Stream Log-nya

Begitu user nge-trigger endpoint generate, lo bikin logger, simpan ke map, dan langsung jalanin background task. Tapi karena ini async, kita bungkus `background_task()` dalam lambda dan jalanin pake `asyncio.run()`. Di dalam situ, semua log dikirim via logger, dan pas udah selesai baru log-nya di-*flush* ke Supabase.

```python
from fastapi import APIRouter, BackgroundTasks, Request
from starlette.responses import StreamingResponse
import asyncio
import json

router = APIRouter()

@router.post("/{upload_id}/{service}/generate")
async def generate_code(upload_id: str, service: str, background_tasks: BackgroundTasks):
    logger = BufferedLogger()
    logger_map[(upload_id, service)] = logger

    async def background_task():
        try:
            result = await generate_and_save_code(
                upload_id=upload_id,
                service=service,
                logger=logger
            )
        finally:
            logger.done = True
            await logger.flush_to_supabase(upload_id, service)
            logger_map.pop((upload_id, service), None)

    # Bungkus coroutine ke dalam background thread
    background_tasks.add_task(lambda: asyncio.run(background_task()))
    return {"status": "Generation started"}
```

Sementara itu, user bisa buka `/logs`, dan browser akan buka koneksi SSE. Tiap log masuk, langsung di-*yield* ke client. Kalau 30 detik gak ada apa-apa dan proses udah selesai, koneksi ditutup rapi, dan user dapet pesan terakhir: stream ended.

```python
@router.get("/{upload_id}/{service}/logs")
async def stream_logs(upload_id: str, service: str, request: Request):
    logger = logger_map.get((upload_id, service))
    if not logger:
        return StreamingResponse(
            iter(["data: Log not available\n\n"]),
            media_type="text/event-stream"
        )

    async def event_stream():
        queue = logger.subscribe()
        idle_counter = 0

        while True:
            if await request.is_disconnected():
                break
            try:
                log = await asyncio.wait_for(queue.get(), timeout=5)
                idle_counter = 0
                yield f"data: {json.dumps(log)}\n\n"
            except asyncio.TimeoutError:
                idle_counter += 1
                yield ": keep-alive\n\n"
                if idle_counter >= 6 and logger.done:
                    yield f"data: {json.dumps({'message': 'Log stream ended.'})}\n\n"
                    break

        logger.unsubscribe(queue)

    return StreamingResponse(event_stream(), media_type="text/event-stream")
```

Nah, bagian ini yang bikin prosesnya kerasa live. Tiap kali logger .log(...), semua subscriber bakal dapet update, dan user bisa ngeliat langsung progres di layar. Dan karena pakai asyncio.Queue, gak akan blocking route lain—FastAPI tetep responsif.

Dengan kombinasi background_tasks, logger in-memory, dan SSE, proses panjang kayak code generation atau data processing jadi jauh lebih transparan buat user. Lo gak cuma bikin sistem jalan, tapi bikin user ngerti apa yang lagi dikerjain.

---

## Kalau Telat? Gak Masalah. Ada Final Log

```sh
[ User buka UI ]
       |
       v
[ UI panggil /status ]
       |
       v
[ Logger aktif? ]
   |             \
  Ya              Tidak
   |                |
   v                v
[SSE connect]    [GET /logs/final]
   |                |
   v                v
[Streaming]     [Ambil log dari Supabase]
   |                |
   v                v
[Tutup saat done]  [Tampilkan log final]

```

Gak semua user nungguin. Kadang mereka cabut, terus balik 5 menit lagi. Makanya lo siapin endpoint `/logs/final` buat ambil semua log yang udah di-*persist* ke Supabase. Tinggal fetch dan render ulang. Sesimpel itu.

```python
@router.get("/{upload_id}/{service}/logs/final")
async def get_logs_final(upload_id: str, service: str):
    response = supabase.table("runs_logs")\
        .select("*")\
        .eq("upload_id", upload_id)\
        .eq("service", service)\
        .order("timestamp", desc=False)\
        .execute()

    return {"logs": response.data or []}
```

Endpoint `/status` juga lo kasih buat ngecek: logger masih aktif gak? Kalau iya, jalanin SSE. Kalau enggak, langsung fetch final logs.



---

## UI HTML: Cepat, Kecil, Gak Ribet

Jujur aja, lo butuh UI cepat buat testing, dan gak pengen terlalu berat setup-nya. Jadi pakai HTML murni dulu. Satu halaman, satu fungsi `startStream()`, dan satu kotak `<pre>` buat nampilin log.

Begitu tombol “Start” diklik, JS-nya ngecek status logger. Kalau masih aktif, dia buka koneksi SSE dan nampilin setiap log yang masuk. Kalau enggak, dia fallback ke log final dan render dari hasil Supabase. Log box otomatis scroll ke bawah tiap log baru masuk.

```html
<html>
<head>
  <title>OSB Logs UI</title>
  <script>
    function startStream() {
      const uploadId = document.getElementById('uploadId').value;
      const service = document.getElementById('service').value;
      const logContainer = document.getElementById('logs');
      logContainer.innerHTML = '';

      fetch(`/runs/${uploadId}/${service}/status`)
        .then(res => res.json())
        .then(status => {
          if (status.active) {
            const eventSource = new EventSource(`/runs/${uploadId}/${service}/logs`);
            eventSource.onmessage = function(event) {
              try {
                const data = JSON.parse(event.data);
                logContainer.innerHTML += `[${data.timestamp}] ${data.log_level.toUpperCase()}: ${data.message}\n`;
                logContainer.scrollTop = logContainer.scrollHeight;
              } catch (e) {
                console.warn("Malformed log:", event.data);
              }
            };
            eventSource.onerror = function(err) {
              console.error("SSE connection error", err);
              eventSource.close();
              logContainer.innerHTML += `\nLog stream ended. Please refresh to view saved logs.\n`;
            };
          } else {
            fetch(`/runs/${uploadId}/${service}/logs/final`)
              .then(res => res.json())
              .then(data => {
                (data.logs || []).forEach(log => {
                  logContainer.innerHTML += `[${log.timestamp}] ${log.log_level.toUpperCase()}: ${log.message}\n`;
                });
              });
          }
        });
    }
  </script>
</head>
<body style="font-family: sans-serif; padding: 1em;">
  <h2>Live Log Viewer</h2>
  <label>Upload ID: <input id="uploadId" type="text" /></label><br/>
  <label>Service: <input id="service" type="text" /></label><br/><br/>
  <button onclick="startStream()">Start</button>
  <pre id="logs" style="background:#111;color:#0f0;padding:1em;height:400px;overflow:auto;white-space: pre-wrap;"></pre>
</body>
</html>

```

Kelebihan pendekatan ini? Gak ada dependency frontend. Bisa langsung nyatu sama FastAPI. Dan gampang banget buat debugging.

---

## Sebelum Masuk Production, Ada PR

Sistem ini oke buat development, tapi buat jalan di Vercel, Railway, atau VM internal, lo mesti perhatiin beberapa hal.

Pertama, keamanan. Lo belum ada auth. Upload ID dan service bisa dimainin. Jadi perlu validasi ID dan tambahin token atau session check. Akses SSE juga harus dibatasi ke user yang emang punya akses. Admin dan dev aja, misalnya.

Kedua, skalabilitas. Logger sekarang disimpan di RAM. Kalau banyak user atau task, ini gak akan cukup. Lo bisa pindah ke Redis PubSub, atau Kafka kalau lo butuh multiple consumer yang konsumsi log-nya secara paralel.

Ketiga, reliabilitas. Saat idle 30 detik, koneksi ditutup. Tapi kalau user gak sadar, mereka pikir server-nya hang. Lo harus edukasi user atau bikin fallback UX yang jelas. Dan pastikan SSE-nya bisa recover kalau disconnect.

---

## Yang Kita Pelajari Sepanjang Jalan

Ada beberapa hal yang terbukti berhasil.

Mulai dari yang lo butuh dulu, itu kunci. Awalnya cuma pakai Streamlit, terus berevolusi ke FastAPI dan SSE. Logger-nya juga dipisah dari storage—kerja di RAM, baru simpen saat selesai. Ini ngurangin pressure ke Supabase.

Async-nya juga beneran non-blocking. Lo bisa jalanin banyak request FastAPI lain tanpa terganggu sama log stream. Ini penting buat scalability.

Tapi gak semua hal berjalan mulus.

Pernah logger nyangkut karena client SSE disconnect tapi gak unsubscribe. Akhirnya logger-nya stay di RAM terus. Kadang juga log gak dikirim kalau gak ada log baru, dan user bingung. Fallback ke final logs juga gak otomatis, harus manual cek status dulu.

---

## Next Step? Lo Pasti Tau Sendiri Arahannya

Kalau lo mau lebih niat, UI-nya bisa pindah ke React, pake Refine.dev biar modular dan punya UX yang proper. Kalau SSE udah gak cukup, dan lo pengen user bisa submit perintah balik (misalnya kirim prompt ke LLM), berarti waktunya upgrade ke WebSocket.

Dan biar log-nya makin berguna, lo bisa tambahin timestamp relatif, filter severity (INFO, ERROR), atau export ke file langsung.

Tapi intinya, lo udah punya fondasi kuat: sistem log streaming yang bisa live, bisa nyimpen, dan bisa dibersihin otomatis.

Kapan mau dipake di proyek lo yang berikutnya?
