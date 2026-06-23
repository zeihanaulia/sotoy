
Ini bukan cuma daftar plugin. Yang gue tangkap dari dokumentasi Hermes Agent adalah ini peta otak agent: built-in memory selalu ada, lalu provider eksternal menambahkan lapisan ingatan lintas sesi dengan gaya retrieval/recall tertentu.

## Apa itu Memory Provider di Hermes Agent?

Memory Provider di sini adalah backend eksternal untuk menyimpan, mencari, dan menyuntikkan konteks ke agent. Ini bukan memori komputer biasa, tapi plugin yang membuat Hermes punya persistent memory lintas sesi di luar `MEMORY.md` dan `USER.md`.

Yang penting: built-in memory tetap aktif. Provider eksternal itu additive, bukan pengganti. Jadi agent tetap punya catatan lokal, lalu provider bisa menambahkan kemampuan seperti semantic search, graph reasoning, atau user modeling.

## Bagaimana cara kerjanya saat agent berjalan?

Ketika provider aktif, Hermes melakukan beberapa hal otomatis:

- inject konteks provider ke system prompt;
- prefetch memory relevan sebelum setiap turn (background, non-blocking);
- simpan percakapan setelah respons;
- ekstrak memory sesi akhir jika provider mendukung;
- cerminkan write ke built-in memory ke provider eksternal;
- expose tool khusus untuk search/store/manage memory.

Intinya, saat elo tanya agent, dia tidak hanya pakai prompt sekarang. Dia juga ngecek "ada gak ingatan lama yang relevan?" sebelum menjawab. Itu buat pengalaman agent jadi lebih berkelanjutan, tapi sekaligus menaikkan risiko bias atau kontaminasi konteks jika memorinya salah.

## Kenapa cuma satu external provider yang aktif?

Karena satu provider eksternal udah cukup kompleks. Kalau dipakai banyak sekaligus, masalahnya jadi cepat menumpuk:

- konflik sumber (satu provider bilang A, satunya B),
- biaya API/LLM yang melambung,
- latency per turn naik,
- governance lebih susah: tracking, retention, deletion, dan leakage.

Jadi desainnya: built-in memory selalu hidup, tapi external provider dipilih satu.

## Provider yang tersedia dan perbedaannya

Dari page itu gue bisa bedakan provider jadi beberapa keluarga:

- local/self-hosted: `OpenViking`, `Holographic`, `ByteRover`.
- cloud semantic/user modeling: `Honcho`, `Mem0`, `RetainDB`, `Supermemory`, `Memori`.
- hybrid / graph-heavy: `Hindsight`.

### Honcho

Honcho kuat di user modeling dan cross-session context. Dia bukan sekadar nyimpan catatan, tapi bangun representasi user/agent sebagai peer. Cocok untuk personal agent atau multi-agent system yang butuh memahami peran user secara jangka panjang.

### OpenViking

OpenViking seperti filesystem knowledge. Kamu bisa browse struktur hierarki dan load konten secara tiered. Jadi ini bagus untuk knowledge management self-hosted yang terorganisir.

### Mem0

Mem0 fokus ke automatic extraction: server-side LLM ngekstrak fakta, semantic search, reranking, deduplication.

Kalau lo mau memory yang otomatis tanpa mikir struktur, ini jalannya. Trade-off-nya: lebih cloud/paid dan kontrolnya tidak serinci lokal manual.

### Hindsight

Hindsight pakai knowledge graph dan multistrategy retrieval. Dia juga punya reflect synthesis untuk merangkum hubungan antar entitas. Ini menarik kalau lo pengin memory yang bisa reasoning lewat graph, bukan cuma keyword search.

### Holographic

Holographic lokal, SQLite + FTS5, HRR algebra, trust scoring. Cocok kalau lo pengin sistem yang transparan dan privasi-first. Default auto extraction false, jadi lebih cocok untuk eksperimen dan kontrol manual.

### RetainDB

RetainDB adalah cloud memory API dengan hybrid search dan delta compression. Dia pas buat tim yang sudah pakai infrastrukturnya, tapi ada biaya berkelanjutan.

### ByteRover

ByteRover local-first dengan knowledge tree dan optional cloud sync. Yang menarik adalah pre-compression extraction—dia nyoba menyimpan insight penting sebelum context window dikompres.

### Supermemory

Supermemory sengaja bikin context fencing supaya memory lama tidak tersimpan ulang secara rekursif. Dia juga kuat di semantic recall, user profile, dan session graph ingest.

### Memori

Memori fokus ke structured long-term memory dengan tool-aware context. Ini berguna kalau agent lo banyak memakai tool dan perlu ingatan yang paham konteks tool call.

## Pola besar dan trade-off

Yang gue lihat, provider bukan cuma soal storage. Ini soal gaya ingatan agent:

- kalau butuh privacy dan kontrol: pilih local-first (`Holographic`, `ByteRover`, `OpenViking`);
- kalau butuh otomatisasi dan semantic search: pilih cloud (`Mem0`, `Supermemory`, `Honcho`, `Memori`);
- kalau butuh reasoning relasional: `Hindsight` atau `Honcho` lebih menarik.

Trade-off umum:

- lokal = murah + privat, tapi butuh setup/maintenance;
- cloud = otomatis + pintar, tapi biaya + data keluar;
- satu provider = lebih mudah governance, tapi kurang fleksibel dibanding multi-backend.

## Kapan pakai provider tertentu?

- kalau lo pengin agent memahami preferensi user, pilih yang kuat di user modeling: `Honcho`, `Supermemory`, `Mem0`.
- kalau lo pengin agent ingat knowledge project, pilih yang kuat di struktur: `OpenViking`, `ByteRover`, `Hindsight`.
- kalau lo pengin local-only dan transparan, pilih `Holographic` atau `ByteRover`.
- kalau lo pengin reasoning lintas memori, `Hindsight` dan `Honcho` lebih cocok.
- kalau lo pengin setup mudah dan otomatis, `Mem0` atau `Supermemory` lebih praktis.

## Kesalahan umum memahami page ini

Kesalahan terbesar adalah mengira provider cuma "database chat". Sebenarnya provider menentukan cara agent membangun identitas user, memilih konteks, menyimpan pelajaran, dan menetapkan apa yang dianggap relevan. Jadi memilih provider adalah keputusan epistemik, bukan sekadar pilihan teknis.

## Catatan singkat tentang setup

Perintah utama yang dicatat:

```bash
hermes memory setup
hermes memory status
hermes memory off
```

Atau set langsung lewat config:

```yaml
memory:
  provider: openviking
```

Kalau mau ganti provider, cukup ubah `provider:` dan tambahkan API key/endpoint bila perlu.

## Related documents

- [[notes.agentic-engineering.honcho.stateful-memory]]
- [[notes.agentic-engineering.honcho.architecture]]
- [[notes.agentic-engineering.honcho.design-patterns]]
