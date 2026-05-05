---
id: notes.security.pii-agent-architecture.memory-autonomous-agents
title: "Memory for Autonomous LLM Agents: Mechanisms, Evaluation, and Emerging Frontiers"
desc: "Ringkasan paper survei tentang memory architecture, kontrol, dan evaluasi untuk autonomous LLM agents." 
updated: 1777874750725
created: 1777871740192
tags:
  - notes
  - security
  - agent
  - memory
---

## Inti yang gue tarik
Yang paling nyantol buat gue dari paper ini adalah: memory agent bukan cuma soal chat history. Model bisa punya context panjang, tapi kalau dia nggak punya mekanisme baca/tulis memory yang jelas, dia cuma ngulang-ngulang apa yang lagi ada di prompt.

Gue sekarang baca paper ini sebagai peta arsitektur: ada input sekarang, ada read path buat ambil memory relevan, ada action, lalu ada write path buat update memory. Kalau lo cuma pake long context window, itu cuma cache besar, bukan memory.

## Loop memory yang gue abadikan
Kalau gue lihat ulang, loop-nya begini:
- Agent lihat input saat ini.
- Agent decide apakah perlu retrieve memory.
- Agent ambil action.
- Agent mendapat observasi/feedback.
- Agent update memory dari pengalaman itu.

Intinya: memory agent dipengaruhi oleh input sekarang, hasil retrieval, dan goal aktif. Lalu memory itu harus diperbarui berdasarkan pengalaman, bukan cuma disalin begitu saja.

## Taxonomy yang gue pakai
Paper ini ngelompokkan memory dalam tiga dimensi yang gue rasa berguna banget.

### Temporal scope
- Working memory: apa yang lagi ada di context sekarang. Contoh: instruksi sistem, pesan terbaru, output tool, scratchpad.
- Episodic memory: kejadian konkret, misalnya "user minta format tanggal DD/MM/YYYY" atau "tool X gagal dengan parameter Y".
- Semantic memory: generalisasi yang muncul dari banyak episode, misalnya "user lebih suka format tanggal DD/MM/YYYY".
- Procedural memory: skill atau prosedur yang bisa dipakai ulang, bukan cuma fakta. Ini contoh paling jelas kalau agent bisa nyimpen kode atau template.

Kalau cuma episodic, agent ingat kejadian, tapi belum tentu bisa tarik pola. Kalau cuma semantic, agent punya aturan umum tapi mungkin lupa bukti. Kalau ada procedural, agent bisa ulangin skill tanpa mulai dari nol.

### Representational substrate
Gue suka penjelasan ini karena dia nyodorin bahwa nggak semua memory bisa disimpan dengan cara sama.

- Context-resident text: letakkan langsung di prompt sebagai ringkasan atau catatan.
- Vector-indexed store: embed memory dan simpan di vector DB.
- Structured store: SQL, key-value, knowledge graph untuk query presisi.
- Executable repository: repo kode, tool definitions, plan template untuk procedural memory.
- Hybrid store: kombinasi beberapa jenis. Ini yang paling realistis buat production.

### Control policy
Kalau paper kuat di sini, karena memory bukan cuma storage, tapi decision.

- Heuristic control: aturan manual, gampang debug tapi nggak adaptif.
- Prompted self-control: LLM sendiri pilih kapan pakai memory tool.
- Learned control: memory operation jadi part dari policy agent.

Gue setuju: agent harus bisa memutuskan kapan menyimpan, kapan retrieve, kapan ringkas, kapan buang.

## Mekanisme memory yang gue catat
Paper bagi mekanisme menjadi lima keluarga besar.

### 1. Context-resident memory + compression
Paling sederhana, tapi juga paling rentan.
Kalau riwayat terus diringkas, detail penting bisa hilang. Ada istilah summarization drift: setiap kali summary diringkas lagi, detail makin fade.

Long context juga bukan panacea: ada attentional dilution. Kalau prompt terlalu panjang, model sulit fokus ke fakta penting di tengah.

### 2. Retrieval-augmented memory stores
Ini mirip RAG, tapi isinya bukan dokumen statis. Isinya log interaksi agent, tool logs, feedback, plan, observasi.

Tantangannya:
- Granularity indexing: kalau terlalu kecil, konteks hilang; kalau terlalu besar, noise ikut masuk.
- Query formulation: user bilang "Kenapa itu crash?" nggak selalu jadi query retrieval yang bagus.

Jadi agent perlu query rewriting, metadata filter, reranker, dan kadang decide: perlu retrieve atau nggak.

### 3. Reflective / self-improving memory
Agent bikin refleksi setelah gagal atau selesai task, lalu pakai refleksi itu.
Ini keren karena memungkinkan learning tanpa fine-tuning.

Tapi ada jebakannya: self-reinforcing error. Kalau refleksi keliru, agent bisa percaya pada kesimpulan yang salah.
Makanya refleksi harus grounded ke bukti episodic, bukan sekadar feeling.

### 4. Hierarchical memory / virtual context management
Analoginya OS memory: RAM, disk, archive.

MemGPT mencoba bikin agent yang kayak punya virtual memory. Context seperti RAM, recall storage seperti disk, archive seperti cold storage.

Kelemahan utamanya bukan storage-nya, tapi orchestration. Kalau agent salah masukin memory ke context, token habis. Kalau agent nggak tahu harus retrieve dari archive, informasi ada tapi nggak kepake.

### 5. Policy-learned memory management
Ini frontier: store/retrieve/update/summarize/discard jadi action yang dilatih.
Contoh: AgeMem pakai RL.

Pros:
- bisa nemu strategi yang nggak obvious.
Cons:
- mahal,
- susah di-interpret,
- forgetting yang salah bisa ngilangin info safety-critical.

## Evaluasi memory agent menurut gue
Paper bener banget nggak puas sama metrik retrieval klasik.
Precision@k atau nDCG cuma jawab "apakah dokumen yang benar diambil?". Sementara yang penting adalah: apakah memory bikin agent lebih baik dalam task.

Gue catat empat layer evaluasi:
- Task effectiveness: success rate, correctness, completion.
- Memory quality: retrieval precision/recall, contradiction, staleness, coverage.
- Efficiency: latency, token overhead, retrieval calls, storage growth.
- Governance: privacy leakage, deletion compliance, access scope.

Benchmark yang disebut:
- LoCoMo: long-term convo lintas sesi.
- MemBench: factual vs reflective memory.
- MemoryAgentBench: retrieval, test-time learning, long-range understanding, forgetting.
- MemoryArena: agentic tasks di mana keputusan sekarang bergantung sesi lalu.

Intinya: recall itu cuma "gue nemu informasi lama". Agentic memory itu "gue nemu informasi lama, nilai relevansinya, lalu pakai buat action yang lebih baik." 

## Aplikasi yang gue lihat relevan
- Personal assistant: preferensi user, kebiasaan, batas privasi.
- Software engineering agent: keputusan arsitektur, bug history, API quirks, deployment constraint.
- Open-world game agent: skill reuse dan executable procedure.
- Scientific reasoning: hipotesis, eksperimen, evidence, confidence.
- Multi-agent collaboration: governance shared vs private memory.
- Tool/API orchestration: schema, parameter yang berhasil, urutan call, versi API.

## Engineering reality yang sering kelewat
Paper ini paling tajam di bagian ini.

### Write path
Gue suka bahwa paper nggak cuma bilang "taruh aja semua".
Sistem idealnya punya:
- filtering,
- canonicalization,
- deduplication,
- priority scoring,
- metadata tagging.

Memory yang bagus bukan cuma "user suka Go". Harus jadi sesuatu seperti:
- subject: user preference,
- content: user prefers Go for backend hands-on exercises,
- source: direct user statement,
- timestamp,
- confidence,
- scope,
- expiry.

### Read path
Nggak semua request butuh retrieval.
Kalau user cuma minta "jelasin ulang", mungkin context sekarang sudah cukup.
Kalau user bilang "lanjut dari minggu lalu", retrieval penting.

Jadi read path perlu gating, metadata filter, vector search/BM25, reranker, dan token budget.

### Staleness, contradiction, drift
Memory lama bisa kedaluwarsa atau bentrok dengan fakta baru.
User statement lebih kuat dari inferensi agent, dan info terbaru biasanya lebih relevan.
Tapi ada fakta permanen juga.

Paper menekankan source attribution dan temporal versioning.

### Latency & cost
Retrieval bikin latency naik, reranking tambah latency, memory injection tambah token.
Jadi lebih baik ambil sedikit info yang benar-benar relevan ketimbang brute-force context panjang.

### Privacy & compliance
Memory lintas sesi bisa jadi gudang PII.
Butuh deletion, scoped access, retention policy, encryption, audit.
Kalau informasi sudah ketanam ke model weights, delete-nya jauh lebih rumit.

### Observability & debugging
Kalau agent salah, bisa jadi karena:
- nggak nulis memory,
- nulis tapi nggak retrieve,
- retrieve tapi nggak dipakai,
- memory stale.

Paper rekomendasi logging semua memory op dan bahkan pakai "memory diff" untuk lihat perubahan antar turn.

## Pattern arsitektur yang gue ingat
- Pattern A: monolithic context. Simpel, cocok untuk prototipe, tapi rapuh jangka panjang.
- Pattern B: context + retrieval store. Praktis dan realistis untuk production sekarang.
- Pattern C: tiered memory + learned control. Paling kuat, paling kompleks.

Rekomendasi praktisnya: mulai dari Pattern B, instrumentasi dulu, baru naik ke Pattern C kalau memang perlu.

## Open challenge yang gue garis bawahi
- Kapan episodic memory berubah jadi semantic memory?
- Relevansi retrieval harusnya lebih sebab-akibat, bukan cuma similar text.
- Refleksi harus punya evidence.
- Forgetting itu fitur, tapi susah.
- Agent multimodal butuh memory visual/spatial/sensor.
- Multi-agent butuh governance dan conflict resolution.
- Idealnya ada model khusus untuk memory management, bukan hanya jawaban teks.

## Takeaway gue
dirangkum:
LLM agent yang serius nggak bisa cuma andalkan prompt panjang. Minimal harus jawab lima pertanyaan:
- apa yang disimpan,
- dalam bentuk apa,
- kapan disimpan,
- kapan dan bagaimana diambil,
- kapan diperbarui atau dilupakan.

Kalau nggak, agent bisa kelihatan pinter di demo singkat, tapi rapuh di deployment.

---
Original paper: https://arxiv.org/abs/2603.07670

Link: [[notes.security.pii-agent-architecture]]
