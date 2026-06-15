---
id: til.ai.vllm-opencode-context-pressure
title: "OpenCode + vLLM failure sering karena context pressure, bukan param kecil"
desc: "Catatan singkat bahwa bug OpenCode/vLLM biasanya muncul dari context/KV cache pressure dan LiteLLM masking error asli."
updated: 1778605081234
created: 1778590304474
tags:
  - til
  - ai
  - vllm
  - opencode
  - debugging
---

Yang gue pelajari dari kasus ini: ketika OpenCode + LiteLLM + vLLM ngelempar error seperti `litellm.ServiceUnavailableError`, `litellm.MidStreamFallbackError`, atau `APIConnectionError: Hosted_vllmException - 'id'`, kemungkinan besar bukan sekadar parameter kecil yang salah.

Signal yang paling kuat: habis `ESC` lalu `/compact` langsung normal lagi. Itu bukan kebetulan. Itu clue bahwa masalahnya ada di context state / KV cache / stream state, bukan jaringan.

Intinya:

- `OpenCode` bisa gagal mendeteksi overflow dari `vLLM` karena error signature-nya beda dari OpenAI/Anthropic.
- `LiteLLM` sering nge-wrap root cause asli jadi `MidStreamFallbackError` / `ServiceUnavailableError` / `APIConnectionError`.
- `vLLM` punya behavior yang rentan: streaming stall, preemption, KV cache exhaustion, malformed chunk ketika context panjang.
- `limit.context = 111616` bisa jadi cuma metadata UI/config OpenCode. Belum tentu LiteLLM atau vLLM enforce secara nyata, atau tokenizer sinkron. Runtime KV bisa jebol meski angka metadata terlihat aman.
- `reasoning: true` pada Qwen reasoning model sangat suspicious. Hidden reasoning tokens / internal CoT sering membuat real KV usage jauh lebih besar daripada visible tokens.
- Output 16384 untuk agent coding + long context bukan sekadar "besar"; itu monster. Decode panjang memperbesar chance stream interruption, scheduler preemption, malformed SSE chunk, atau timeout.
- Prefix caching + chunked prefill di vLLM bisa menambah instabilitas untuk agent workflows dengan reasoning, long context, streaming, dan tool calls.

Karena itu, pendekatan paling masuk akal adalah:

1. Turunkan effective context hard limit (misal 48k–60k) walau model support 128k/200k.
2. Trigger compact lebih agresif, jangan tunggu 85–90%; mulai di 55–65%.
3. Batasi `max_tokens` output (coba 4k–8k dulu).
4. Disable parallel requests sementara supaya KV cache / stream competition berkurang.
5. Periksa log `vLLM` langsung, bukan cuma LiteLLM log.
6. Perhatikan compatibility OpenCode ↔ LiteLLM ↔ vLLM versi.
7. Ingat: coding agents meng-inflate context dengan diff, tool output, repo context, dan reasoning trace.

Catatan praktisnya: jika `/compact` langsung memperbaiki masalah, hampir pasti root cause-nya adalah "context state unhealthy". Ini bukan bug acak, ini masalah pressure / overflow yang tertutup oleh wrapper error.

Hal spesifik yang perlu dicek:
- apakah vLLM dijalankan dengan `--enable-prefix-caching` atau `--enable-chunked-prefill`; jika iya, jejalkan disable sementara.
- apakah log vLLM menunjukkan `preempted`, `KV cache eviction`, `recompute`, atau `aborted sequence`.
- apakah `reasoning: true` aktif pada Qwen; ini sering memicu hidden KV growth yang tidak terlihat.
- apakah output size masih 16384; untuk agent coding, coba turunkan ke 4096 dulu.
- apakah OpenCode/LiteLLM/tokenizer accounting mismatch membuat visible context 85k padahal runtime mungkin 105k+.

Kalau error hilang setelah langkah-langkah ini, kemungkinan besar masalahnya bukan hard overflow, tapi runtime instability / KV cache pressure / mismatch detection.
## Serving capacity and admission control

Sekarang diagnosisnya lebih jelas: bukan model atau konteks limit per request, tapi **serving capacity**. Jam sepi aman dan jam sibuk error itu textbook pertanda bahwa beberapa request panjang sedang masuk bersamaan, masing-masing butuh KV cache besar, lalu vLLM mulai preempt/recompute/queue dan LiteLLM menerima stream terputus/malformed.

Penting diubah secara mental:

- `max_model_len = 111k` bukan berarti aman untuk banyak user concurrent.
- Itu lebih mirip batas maksimum per request.
- Kapasitas effective concurrency jauh lebih kecil karena KV cache tumbuh linear terhadap jumlah request aktif × panjang context × output tokens.
- vLLM metrics seperti `vllm:kv_cache_usage_perc`, `vllm:num_requests_running`, `vllm:num_requests_waiting`, `vllm:request_prompt_tokens`, dan `vllm:request_generation_tokens` adalah indikasi tekanan scheduler/KV cache, bukan hanya GPU utilization.

Untuk angka kapasitas GPU nyata, lihat juga [[notes.ai.vllm-qwen3-gpu-capacity]] dan sumber eksternal [Spheron Blog: Deploy Qwen 3.5 on GPU Cloud](https://www.spheron.network/blog/deploy-qwen-3-5-gpu-cloud/) — di situ gue catat bahwa Qwen3.5-397B-A17B-FP8 butuh sekitar 8×H100 dan menyisakan sekitar 100–119 GB untuk KV cache.

### Praktik admission control

Solusi praktisnya mulai dari depan vLLM:

1. Limit concurrency keras.
   - `max concurrent generations = 1–2` per model instance untuk long-context coding workloads.
2. Pisahkan `coding model` dari `chat model`.
   - small model untuk chat ringan;
   - big model hanya untuk coding/deep reasoning.
3. Hard cap session lifetime.
   - auto compact tiap 30–50 turn;
   - restart session setelah task besar.
4. Reduce output tokens drastis.
   - 16384 terlalu agresif untuk jam ramai;
   - production sering clamp di 2k–4k.
5. Set `gpu_memory_utilization` lebih tinggi.
   - vLLM rekomendasi bisa membantu preemption issue.
6. Disable prefix caching sementara.
   - prefix caching bagus untuk throughput, tapi bisa memperparah KV fragmentation / concurrency weirdness.
7. Monitor KV cache usage live.
   - `kv_cache_usage_perc > 0.85` atau `0.95` adalah alert.
8. Jangan pakai streaming untuk internal agent tasks.
   - streaming cocok UX, tapi internal tool/summarization lebih stabil non-streaming.
9. Scale horizontally.
   - beberapa replica dengan concurrency kecil lebih stabil daripada satu replica besar.
10. Separate inference pools.
   - pool kecil untuk chat, pool besar untuk coding.
11. LiteLLM workaround.
   - disable mid-stream fallback atau bypass LiteLLM untuk coding path.
12. Temporary operational workaround.
   - concurrency rendah, compact agresif, output ≤4096, reasoning off, streaming off untuk internal tasks.

### Contoh konfigurasi konservatif

```bash
vllm serve /path/to/model \
  --tensor-parallel-size 8 \
  --max-model-len 65536 \
  --max-num-seqs 2 \
  --max-num-batched-tokens 65536 \
  --gpu-memory-utilization 0.92 \
  --enable-prefix-caching
```

Jika masih error:

```bash
--max-num-seqs 1
--max-model-len 49152
--max-num-batched-tokens 49152
```

Di OpenCode client, batasi juga:

```ts
limit: {
  context: 65536,
  output: 4096,
}
```

## Hosted provider vs self-host mental model

Penting untuk ingat: OpenRouter tidak menjalankan satu instance vLLM polos yang menerima semua request mentah. Mereka stabil karena banyak lapisan proteksi di atas inference engine.

Intinya bukan “GPU mereka kuat lalu semua request masuk”. Ini lebih mirip sistem produksi dengan antrian dan routing.

OpenRouter mendokumentasikan bahwa mereka melakukan provider routing dan load balancing ke beberapa provider, dengan fallback provider aktif secara default. Jadi ketika satu provider lambat/down/throttled, request bisa diarahkan ke provider lain, bukan dipaksa masuk ke satu runtime yang sedang penuh. Mereka juga punya rate limit dan upstream throttle untuk peak usage; traffic tidak dibiarkan masuk tanpa kontrol.

Bandingkan setup lo:

```text
Lo:
OpenCode -> LiteLLM -> 1/self-host vLLM pool -> model besar

Hosted provider:
Client -> gateway -> rate limiter -> router -> queue -> many replicas/providers -> health checker -> fallback -> response
```

Stabilitas mereka datang dari beberapa hal:

1. Admission control
   - request tidak langsung masuk GPU saat sistem penuh.
   - bisa di-queue, di-throttle, di-429, atau diroute ke provider lain.
2. Load balancing dan fallback
   - tidak hanya satu server model.
   - jika satu replica saturated, request bisa diarahkan lain.
3. Pool isolation
   - request pendek, request panjang, free-tier, paid-tier, priority tidak selalu ke resource sama.
4. Horizontal scaling
   - banyak replica dengan concurrency kecil lebih stabil daripada satu replica besar.
5. Scheduler policy matang
   - request 2k token dan 100k token tidak sama.
6. Parameter clamping
   - gateway bisa membatasi parameter agar tidak merusak pool.
7. Retry aman
   - retry biasanya sebelum streaming dimulai atau ke provider lain.

Jadi jawaban pendeknya: OpenRouter stabil bukan karena “satu server kuat”, tapi karena distributed serving dan admission control.

### Minimal architecture target untuk self-host

```text
OpenCode
  -> Gateway / LiteLLM Router
  -> Admission Control
  -> Queue
  -> Pool Router
      -> small-chat pool
      -> coding-agent pool
      -> summarizer pool
  -> vLLM replicas
  -> Metrics + autoscale / manual scale
```

Untuk coding agent pool, mulai dengan:

```text
1 replica:
  max_num_seqs = 1 atau 2
  max_output_tokens = 4096
  context target = 48k–64k
  queue request lain
```

Lebih stabil daripada:

```text
1 replica x max_num_seqs=8
```

Dan request ringan jangan masuk pool sama:

```text
chat biasa       -> model kecil / pool cepat
summarization    -> model kecil / non-streaming
coding long-run  -> model besar / queue ketat
```

## Production sizing mental model

Untuk model kelas Qwen3-Coder-480B-A35B FP8, jawabannya bukan “berapa kuat GPU”, tetapi “berapa concurrent long-agent session yang mau lo support dengan latency stabil”.

Model ini bukan 1–2 GPU kecil. vLLM resmi menyarankan setup kelas **8×H200 atau 8×H20 141GB** untuk Qwen3-Coder-480B-A35B, dan bahkan dengan context asli 262k, satu node tetap bisa tidak cukup. Hugging Face model card juga menyebut model ini total **480B parameters**, **35B activated**, dan native long context **256K tokens**.

Jadi mental model dasarnya:

```text
1 replica = 1 vLLM deployment model besar
1 replica kemungkinan = 8 GPU high-memory
1 long OpenCode session = bisa makan kapasitas besar
production stability = replicas × admission control × queue
```

Estimasi realistis:

- **Internal dev / POC stabil** (1–2 user aktif):
  - 1 replica = 8×H100 80GB / 8×H200 141GB / 8×MI300X 192GB
  - `max_num_seqs = 1–2`
  - `context target = 48k–64k`
  - `output = 2k–4k`

- **Small production** (3–5 concurrent long-agent sessions):
  - 3–5 replicas = sekitar 24–40 GPU high-end
  - 1 replica hanya menerima 1 long-agent request aktif, lainnya queue

- **Serious SaaS / enterprise** (10–20 concurrent long-agent sessions):
  - 10–20 replicas = sekitar 80–160 GPU high-end

Kalau lo paksa:

```text
1 replica × max_num_seqs=5
```

kemungkinan besar balik lagi ke error yang sama: KV cache pressure, preemption, stream stall, LiteLLM error.

Untuk produksi yang lebih sehat:

```text
chat ringan          -> model 7B/14B/32B
summarization        -> model kecil, non-streaming
repo search/RAG      -> retrieval + reranker
coding simple edit   -> 32B/72B coder
hard coding agent    -> Qwen 480B-A35B pool
```

Rekomendasi awal:

```text
Production baseline awal:
2 replicas Qwen besar = 16 GPU high-memory

Replica A:
  active long agent request = 1
  standby/overflow = queue

Replica B:
  active long agent request = 1
  standby/overflow = queue/fallback

Plus:
1–2 smaller model pools untuk summarizer/chat/planner
```

Kenapa minimal 2 replica? Karena 1 replica itu POC, bukan production. Kalau satu replica lagi prefill panjang atau restart, semua kena. Dua replica memberi failover dasar.

Setting awal yang lebih aman:

```bash
vllm serve Qwen/Qwen3-Coder-480B-A35B-Instruct-FP8 \
  --tensor-parallel-size 8 \
  --max-model-len 65536 \
  --max-num-seqs 1 \
  --max-num-batched-tokens 65536 \
  --gpu-memory-utilization 0.92
```

OpenCode/client:

```ts
limit: {
  context: 65536,
  output: 4096,
}
```

Naikkan perlahan jika stabil:

```text
max_num_seqs: 1 -> 2
context: 64k -> 96k
output: 4k -> 8k
```

Rule sizing kasar:

```text
required_replicas = ceil(concurrent_long_agent_sessions / safe_long_sessions_per_replica)
```

Dengan model ini:

```text
safe_long_sessions_per_replica = 1
aggressive = 2
risky = 3+
```

Jadi:

```text
2 concurrent OpenCode users  -> 2 replicas -> 16 GPU
5 concurrent OpenCode users  -> 5 replicas -> 40 GPU
10 concurrent OpenCode users -> 10 replicas -> 80 GPU
```

Kalau budget tidak masuk, desain lo harus berubah: pakai Qwen besar hanya untuk task sulit, dan mayoritas agent loop dialihkan ke model 32B/72B + retrieval + tool execution.

Analogi:
OpenRouter itu seperti bandara dengan gate, antrian, prioritas, reroute, dan fallback. Self-host lo sekarang lebih mirip semua orang disuruh masuk satu pintu pesawat.

Root cause yang mau dibuktikan tetap sama: self-host lo belum punya admission control dan pool isolation yang cukup untuk long-context concurrent agent workload.

Rule of thumb:

- `kv_cache_usage_perc > 0.85` selama beberapa menit → mulai queue/throttle
- `kv_cache_usage_perc > 0.95` → reject/429 long request
- `num_requests_waiting` naik terus → kapasitas kurang
- TTFT naik tajam meski request sedikit → long prefill / HOL blocking
- preemption count naik → kurangi concurrency/context

## Root-cause simulation

Misal config lo:

```text
context limit: 111,616 token
output limit: 16,384 token
model: besar, FP8
traffic: beberapa agent OpenCode concurrent
```

Satu request panjang agent coding tidak cuma prompt awal. Total active sequence length-nya adalah:

```text
active_tokens ≈ prompt_tokens + generated_tokens_so_far
```

Contoh:

```text
request A: prompt = 80k, max output = 16k, active max ≈ 96k
```

Saat sendiri pagi hari:

```text
running requests = 1
active KV pressure ≈ 96k
```

Saat ramai:

```text
request A = 96k
request B = 68k
request C = 48k
request D = 24k

total active pressure ≈ 236k
```

Masing-masing masih di bawah `max_model_len`, tapi gabungannya bisa melampaui kapasitas KV cache efektif. Ini yang menipu: `max_model_len` adalah batas per request, bukan kapasitas concurrent.

Timeline failure yang paling relevan:

```text
T0: request A masuk, prompt panjang.
T1: request B/C/D ikut masuk.
T2: KV cache usage naik 70% → 85% → 95%.
T3: request A sedang decode output panjang sementara B prefill.
T4: vLLM mulai preemption/recompute karena KV tidak cukup.
T5: stream A makin lambat, inter-token latency naik.
T6: salah satu stream timeout/malformed/aborted.
T7: LiteLLM bongkar stream kotor jadi MidStreamFallbackError / APIConnectionError / 'id'.
T8: lo tekan ESC + /compact, request jadi jauh lebih pendek, KV pressure turun, semuanya normal lagi.
```

Jadi `/compact` tidak membuktikan bug LiteLLM saja. Ia menurunkan request size dan menghindari kondisi runtime buruk di vLLM/LiteLLM.

### Eksperimen mental untuk membedakan root cause

1. Single request vs concurrent request
   - Jika satu request panjang stabil tetapi beberapa request panjang bersamaan gagal, root cause adalah capacity contention, bukan context overflow per request.
2. Output 16k vs 4k
   - Jika 16k error tetapi 4k stabil, long decode / scheduler occupancy adalah masalah.
3. Bypass LiteLLM
   - `OpenCode → vLLM langsung`.
   - Jika bypass stabil, LiteLLM streaming layer bermasalah.
4. Turunkan `max_num_seqs`
   - Jika `max_num_seqs=1` stabil, concurrency/vLLM contention jelas.
5. Cari preemption log
   - `Sequence group ... is preempted ... because there is not enough KV cache space`
   - Itu smoking gun runtime.

### Admission-control rule of thumb

Gunakan estimated cost, bukan request count:

```ts
estimatedCost = promptTokens + maxOutputTokens
```

Jangan admit request jika:

```text
currentInflightTokens + estimatedCost > SAFE_INFLIGHT_BUDGET
```

Untuk long coding request, `SAFE_INFLIGHT_BUDGET` sering jauh di bawah total model limit.

Rule alert:

- `kv_cache_usage_perc > 0.85` selama beberapa menit → queue/throttle
- `kv_cache_usage_perc > 0.95` → reject/429 long request
- `num_requests_waiting` naik terus → kapasitas kurang
- TTFT naik tajam dengan sedikit request → long prefill / HOL blocking
- preemption count naik → kurangi concurrency/context

### Bypass test

Coba jalankan:

- `OpenCode → LiteLLM → vLLM`
- `OpenCode → vLLM langsung`
- `curl/openai-sdk → vLLM langsung`

Kalau bypass LiteLLM stabil, berarti layer streaming/proxy LiteLLM bermasalah. Kalau tetap error, berarti vLLM/runtime.
## Hypothesis ranking update

Signal yang sangat penting: kalau model, workflow, dan OpenCode sama, tapi OpenRouter stabil sementara self-host vLLM/LiteLLM bermasalah, probabilitasnya sekarang lebih tinggi ke:

1. `LiteLLM` streaming incompatibility / parser issue.
2. `vLLM` long-stream runtime instability.
3. `OpenCode` auto-compact mismatch dengan vLLM error signature.
4. Actual context overflow.
5. Model issue itself (kemungkinan kecil sekarang).

Itu masuk akal karena hosted provider seperti OpenRouter biasanya punya layer tambahan:

- agresif guard request size (truncate/compact/reject),
- retry/recovery layer untuk malformed chunk, fallback, dan timeout,
- lebih ketat mengendalikan reasoning/hidden CoT,
- scheduler/backpressure yang lebih mature.

Kalau OpenRouter stabil tapi self-host vLLM/LiteLLM bermasalah, itu sangat besar mengarah ke:

- runtime implementation / serving stack,
- bukan modelnya sendiri.

Karena vLLM/LiteLLM direct lebih raw: request pathological bisa masuk sampai runtime kepanasan. OpenRouter kemungkinan mem-filter, retry, dan recover sebelum sampai ke sana.

### Hypothesis ranking update

Urutan kemungkinan sekarang:

1. `LiteLLM` streaming incompatibility / parser issue.
2. `vLLM` long-stream runtime instability.
3. `OpenCode` auto-compact mismatch dengan vLLM error signature.
4. Actual context overflow.
5. Model issue itself (kemungkinan kecil sekarang).

### Most valuable isolation tests

1. Bypass LiteLLM.
   - Test: `OpenCode → vLLM langsung` tanpa LiteLLM.
   - Jika hilang: artinya problem utamanya ada di LiteLLM streaming layer.
   - Jika tetap ada: artinya vLLM/runtime lebih mungkin.
2. Disable streaming sementara.
   - Kalau non-streaming stabil, hampir pasti isu pada SSE chunking/parser/timeout, bukan model inference.
3. Compare exact provider response schema.
   - Bandingkan OpenRouter vs vLLM response format, khususnya `id`, `finish_reason`, dan chunk fields.
4. Upgrade/downgrade LiteLLM.
   - Streaming regression sering versi-spesifik.
5. Test provider lain selain vLLM.
   - Coba SGLang/TGI/Ollama atau server lain.
   - Jika stabil di provider lain, vLLM stack jadi tersangka utama.
6. Cek vLLM OpenAI compatibility mode.
   - Pastikan `/v1/chat/completions` dan schema OpenAI-compatible, bukan custom route.

### Runtime/stack action items

1. Limit concurrency keras.
   - `max concurrent generations = 1–2` per model instance.
   - 397B FP8 + long context adalah monster KV cache consumer.
   - Bottleneck sering bukan GPU utilization, tapi KV cache / scheduler / preemption.
2. Pisahkan "coding model" dari "chat model".
   - Small model untuk chat ringan.
   - Big model hanya untuk coding/deep reasoning.
   - Jangan biarkan autocomplete/summarize/healthcheck/planner ikut masuk ke model besar.
3. Hard cap session lifetime.
   - Auto compact setiap 30–50 turns.
   - Restart session setelah task besar.
   - Long-running session bikin KV fragmentation / preemption / recompute naik.
4. Reduce output tokens drastis.
   - 16384 terlalu agresif untuk concurrent streaming.
   - Banyak infra production clamp di 2k atau 4k, bahkan untuk coding.
5. Set `gpu_memory_utilization` lebih tinggi.
   - vLLM merekomendasikan ini ketika preemption muncul.
   - Misal naik dari 0.90 ke 0.95 / 0.97, dengan hati-hati agar tidak OOM.
6. Disable prefix caching sementara.
   - Prefix caching bagus untuk throughput, tapi bisa bikin KV fragmentation/concurrency weirdness lebih parah di long-running agent workflows.
7. Monitor KV cache usage live.
   - Cari grafik seperti `GPU KV cache usage: 99%`.
   - Jika error selalu muncul saat >90%, itu smoking gun.
8. Jangan pakai streaming untuk internal agent tasks.
   - Streaming bagus untuk UX manusia, tapi untuk internal tool calls/batch coding/summarization lebih stabil non-streaming.
9. Scale horizontally.
   - Multiple vLLM workers, load balancing, sticky sessions.
   - vLLM scheduler under high concurrency bisa saling preempt request.
10. Separate inference pools.
   - Pool A untuk short chat.
   - Pool B untuk long coding sessions.
   - Kalau dicampur, chat ringan kena starvation.
11. LiteLLM workaround.
   - Disable mid-stream fallback.
   - Atau bypass LiteLLM untuk coding path.
12. Temporary operational workaround tercepat.
   - Concurrency limit rendah.
   - Compact lebih agresif.
   - Output ≤ 4096.
   - Reasoning OFF untuk coding default.
   - Streaming OFF untuk internal tasks.

Kalau error muncul hanya saat jam sibuk, itu textbook KV contention + scheduler preemption.

## Prioritas action items

Priority paling efektif:

1. Turunkan `max_output_tokens` dulu.
   - Dari `output: 16384` jadi `output: 4096`.
   - Kalau masih error, turun lagi ke `output: 2048`.
   - Long decode streaming sering jadi sumber stalled stream, malformed SSE, vLLM preemption, dan LiteLLM MidStreamFallbackError.
2. Compact lebih agresif.
   - Set threshold di 50–60%.
   - Jangan tunggu 80% ke atas.
   - Karena usable context bisa jauh lebih kecil dari advertised limit.
3. Disable reasoning sementara untuk isolasi.
   - `reasoning: false`
   - Kalau stabil tiba-tiba, hidden reasoning/KV growth adalah pemicunya.
4. Cek log vLLM langsung.
   - Cari `preempted`, `KV cache`, `recompute`, `aborted`, `OOM`, `scheduler warning`.
   - Khususnya: `preempted due to KV cache pressure`.
5. Disable vLLM optimizations sementara.
   - Jika startup ada `--enable-prefix-caching` atau `--enable-chunked-prefill`, matikan buat test.
6. Pastikan concurrency = 1.
   - Single request only.
   - Tidak ada parallel workers, parallel requests, atau background summarizer.
7. Test model lebih kecil.
   - Coba Qwen 72B atau 32B dengan workflow sama.
   - Kalau stabil, itu artinya problemnya runtime pressure 397B, bukan OpenCode.
8. Tambahkan observability token/context.
   - Log estimated input tokens, output tokens, context sebelum compact, request duration, streaming duration.
   - Supaya bisa lihat apakah error muncul setelah X token / Y menit.
9. Cek apakah OpenCode salah detect overflow dari vLLM.
   - OpenAI provider bisa decent, tapi vLLM OpenAI-compatible sering punya signature beda.
   - Jika terbukti, fix bisa lewat custom error mapping atau patch provider adapter.
10. Temporary operational workaround.
   - Manual compact lebih sering.
   - Jangan biarkan session terlalu panjang.
   - Split task besar.
   - Restart session tiap major task.

Urutan paling efektif:

Phase 1 — isolasi cepat
- output → 4096
- reasoning → false
- concurrency → 1

Kalau langsung stabil: root cause hampir pasti runtime/KV pressure.

Phase 2 — observability
- inspect vLLM logs
- add token metrics
- monitor preemption

Phase 3 — optimization
- compact threshold 50–60%
- disable prefix caching/chunked prefill
- patch overflow detection di OpenCode kalau perlu.

Referensi: issue OpenCode/vLLM context overflow, vLLM KV cache preemption, dan LiteLLM mid-stream parsing mismatch.