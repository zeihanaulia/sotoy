---
id: notes.agentic-engineering.heavyskill-heavy-thinking-as-inner-skill
title: 'HeavySkill: Heavy Thinking as Inner Skill in Agentic Harness'
desc: >-
  Ringkasan arXiv 2605.02396v1 tentang HeavySkill, pola parallel reasoning +
  deliberation dalam agentic harness.
updated: 1778206047521
created: 1778204621041
tags:
  - notes
  - agentic-engineering
  - agentic-harness
  - heavy-thinking
---

## Context check
Paper ini punya istilah yang mudah disalahtafsirkan, jadi gue kunci dulu artinya:
- "Heavy Thinking" = pola inferensi test-time scaling dua tahap: banyak reasoning path dibuat paralel, lalu satu tahap deliberation yang menyintesis.
- "Skill" = dokumen instruksi yang bisa dimuat agentic harness, berisi kapan dipakai, bagaimana dipakai, dan seperti apa outputnya.
- "Agentic harness" = kerangka orkestrasi agent: model, subagent, memory, skill, tool, dan loop eksekusi.
- "Thinker" = satu trajectory generator, bukan agent dengan pengetahuan berbeda. 8 thinker bisa saja model yang sama dengan sampling independen.
- "Bias reviewer/deliberator" ada dua makna: bias posisi dalam prompt dan bias internal model. Paper ini lebih eksplisit soal bias posisi lewat shuffling cache, tetapi belum sepenuhnya menuntaskan bias internal model.

Paper ini bukan tentang "AI mikir lama." Ini tentang:
**AI membuat beberapa percobaan berpikir secara terpisah, lalu satu reviewer membaca semua percobaan itu dan mengambil keputusan final.**

## 1. Masalah yang coba diselesaikan
Masalah dasarnya: satu reasoning path itu rapuh.

Kalau model cuma ikut satu lintasan awal, asumsi pertama bisa menuntun semua langkah berikutnya. Jika asumsi awal salah, jawaban akhir ikut bengkok.

Contoh sederhana:
- "aplikasi lambat di repo besar" bisa jadi karena RAM, indexing, extension, context retrieval, I/O, atau integrasi IDE.

Paper menanyakan: apakah agentic harness yang terlihat rumit sebenarnya hanya melakukan dua tahap sederhana?

Jawabannya: ya — parallel reasoning lalu sequential deliberation.

## 2. Apa itu HeavySkill?
HeavySkill adalah pola kerja yang dipaketkan sebagai skill bagi agentic harness.

Bukan model baru. Bukan framework baru. Bukan sekadar plugin.

Ini adalah dokumen instruksi yang menjelaskan:
- kapan heavy thinking dipakai,
- bagaimana spawn K thinker,
- bagaimana reviewer mengevaluasi trajectory,
- format output final.

Jadi HeavySkill adalah guardrail kognitif, bukan guardrail eksekusi.

## 3. Workflow Heavy Thinking
Workflow Heavy Thinking adalah alur kerja inferensi dari input awal sampai jawaban final.

### 3.1 Kalau input-nya satu pertanyaan, kenapa sistem bikin banyak jawaban dulu?
Karena satu jawaban tunggal rentan terjebak pada satu asumsi awal.

Thinker 1 bisa fokus ke RAM.
Thinker 2 bisa fokus ke indexing.
Thinker 3 bisa fokus ke extension.
Thinker 4 bisa fokus ke context retrieval.

Membuat banyak jawaban dulu memperbanyak hipotesis awal sehingga sistem tidak terkunci pada satu lintasan.

Atomic idea: parallel reasoning = memperbanyak kemungkinan agar tidak semua bergantung pada asumsi pertama.

### 3.2 Apa bedanya “parallel reasoning” dengan “tanya model berkali-kali” biasa?
Beda utamanya:
- Parallel reasoning minta K thinker independen.
- Tanya model berkali-kali biasa bisa menghasilkan jawaban yang saling bias.

Jika thinker B membaca atau dipengaruhi oleh output thinker A, ia bisa meniru asumsi yang sama. Heavy Thinking idealnya membuat setiap trajectory dimulai dari nol.

Jadi parallel reasoning bukan sekadar repetisi. Ia adalah eksplorasi independen.

#### 3.2.1 Thinker adalah trajectory generator
Thinker di sini bukan berarti ada 8 agent berbeda. Thinker berarti satu generator trajectory. Jadi 8 thinker bisa saja model yang sama, dengan sampling independen dan prompt yang memaksa variasi.

Masalah penting: kalau semua thinker berasal dari model yang sama dengan prior dan prompt mirip, diversity bisa palsu. 8 trajectory bisa berakhir sebagai 8 variasi jawaban yang sama.

Atomic idea: parallel reasoning hanya berguna kalau ia benar-benar membuka beberapa jalur hipotesis; bukan sekadar echo chamber yang lebih mahal.

### 3.3 Apa itu trajectory?
Trajectory adalah jalur reasoning dari input sampai kandidat jawaban.

Bukan cuma jawaban akhirnya. Trajectory berisi:
- asumsi awal,
- langkah berpikir,
- evidence yang dipakai,
- kesimpulan sementara.

Trajectory penting karena deliberator nanti akan menilai cara sampai ke jawaban, bukan hanya hasilnya.

### 3.4 Apa yang terjadi di tahap sequential deliberation?
Tahap ini memakai reviewer model.

Reviewer membaca semua trajectory.
Tugasnya bukan memilih yang paling populer.
Tugasnya:
- mengevaluasi reasoning,
- membandingkan evidence,
- mendeteksi error,
- menggabungkan insight,
- menulis final answer.

Deliberation bukan ringkasan biasa. Ia adalah proses kritis.

Contoh final answer yang bagus akan menggabungkan beberapa trajectory, bukan hanya memilih satu.

### 3.5 Kenapa hasil akhirnya bisa lebih baik daripada jawaban tunggal?
Karena deliberator punya bahan dari banyak sumber.

Jika satu trajectory minoritas benar, reviewer bisa menemukan dan memilihnya.
Jika beberapa trajectory berbeda memberi bukti komplementer, reviewer bisa synthesize jawaban baru.

Dengan satu jawaban tunggal, model hanya punya satu kesempatan. Dengan Heavy Thinking, model punya banyak hipotesis lalu satu kesempatan untuk memutuskan.

## 4. Fungsi serialized memory cache
Serialized memory cache adalah mekanisme agentic workflow untuk menyimpan hasil thinkernya sebagai konteks terstruktur bagi tahap deliberation berikutnya.

Di paper ini, "serialized memory cache" bukan memory internal model seperti KV-cache atau hidden state. Ini adalah memory eksternal: kumpulan trajectory yang dikumpulkan, dipangkas, diurutkan, lalu dirender sebagai prompt untuk reviewer.

### 4.1 Apa arti "serialize" di sini?
"Serialize" artinya mengubah beberapa hasil reasoning yang terpisah menjadi satu representasi konteks terstruktur.

Contoh:
- kumpulkan output T1–T4
- ekstrak hipotesis dan evidence penting
- label setiap thinker
- gabungkan menjadi satu paket prompt

Atomic idea: serialization = mengubah output terpisah menjadi konteks yang bisa dibaca ulang.

### 4.2 Kenapa butuh memory cache?
Karena Heavy Thinking adalah workflow dua tahap.

Tahap 1: parallel reasoning.
Tahap 2: sequential deliberation.

Tanpa cache, reviewer tidak punya bahan. Memory cache berfungsi sebagai jembatan antar fase: catatan sementara yang menyimpan kandidat trajectory agar deliberator bisa membandingkan.

Analogi: thinker = analis, memory cache = map berisi notulen mereka, deliberator = reviewer senior.

### 4.3 Di level mana cache ini hidup?
Cache ini hidup di level agent/workflow/harness, bukan di dalam model sebagai mekanisme native.

Di workflow mode, orchestrator eksternal memanggil model beberapa kali, menyimpan output, lalu menyusun prompt deliberation. Di skill mode, instruksi skill memandu orchestration ini, tetapi secara operasional cache tetap dibangun di luar parameter model.

Atomic idea: serialized memory cache adalah runtime artifact, bukan learned memory di weights.

### 4.4 Apa isi cache-nya?
Cache berisi versi terstruktur dari trajectory, bukan dump mentah.

Isi yang ideal:
- hipotesis tiap thinker,
- evidence kunci,
- jawaban kandidat,
- indikasi counter-evidence,
- label thinker,
- metadata verification.

Bentuknya bisa berupa teks terformat, JSON, markdown, atau blok prompt terstruktur.

Atomic idea: cache menyimpan bahan minimum yang cukup untuk dibandingkan.

### 4.5 Apa bedanya dengan KV-cache model?
KV-cache transformer adalah cache internal untuk attention, dipakai model di dalam inference pipeline.

Serialized memory cache adalah cache eksternal untuk reasoning artifact yang dikelola agent/harness.

KV-cache = cache komputasi.
Serialized memory cache = cache reasoning.

### 4.6 Kenapa harus di-prune dan di-shuffle?
Pruning diperlukan karena full trajectory terlalu panjang untuk prompt deliberator. Tanpa pruning, context window bisa meledak, evidence tenggelam, dan reviewer kewalahan.

Shuffling diperlukan untuk mitigasi bias posisi: reviewer tidak selalu terpengaruh oleh jawaban awal atau akhir. Ini mengurangi bias prompt, tetapi bukan menghilangkan bias internal model.

Atomic idea: cache adalah mekanisme presentasi evidence, bukan sekadar penyimpanan.

### 4.7 Bedanya dengan conversation history biasa
Conversation history adalah urutan pesan chat. Serialized memory cache adalah scratchpad terstruktur untuk satu task inferensi.

Cache lebih spesifik: ia memuat hipotesis, evidence, dan struktur per thinker, bukan sekadar dialog user-assistant.

Atomic idea: serialized memory cache adalah working memory eksternal untuk workflow, bukan histori obrolan biasa.

## 5. Kenapa deliberation lebih baik dari majority voting?
Majority voting hanya melihat apa yang paling sering muncul.

Deliberation menilai kualitas reasoning.

Perbedaan inti:
- Voting: "jawaban mana paling populer?"
- Deliberation: "reasoning mana paling valid?"

Ini krusial ketika jawaban benar adalah minoritas dan mayoritas sama-sama salah.

## 6. Di benchmark apa metode ini berhasil dan di mana lemah?
HeavySkill unggul di benchmark correctness-oriented:
- AIME25,
- BeyondAIME,
- HMMT25-Feb,
- GPQA-Diamond.

Di tugas preference-oriented, gain bisa kecil atau negatif:
- Arena-Hard,
- IMO Answer Bench,
- tugas gaya / opini.

Intinya: HeavySkill bagus untuk pertanyaan yang punya sinyal benar-salah, kurang stabil untuk pertanyaan subjektif.

## 7. Implikasi untuk agentic coding dan AI engineering
Buat agentic coding, takeaway utama adalah:
- pisahkan generating options dari evaluating options,
- gunakan tool feedback sebagai evidence,
- jangan berharap single-pass jawaban cukup untuk masalah kompleks,
- jangan biarkan agent "reflect forever." Batasi iterasi.

Workflow yang ideal:
- parallel agents menghasilkan hipotesis,
- serialized cache menyimpan evidence,
- deliberator membandingkan dan menyintesis,
- final answer diverifikasi oleh test/tool.

## 8. Failure mode penting
Heavy Thinking gagal jika:
- trajectory tidak beragam,
- deliberator hanya ikut mayoritas,
- cache terlalu panjang atau terlalu dipangkas,
- task terlalu subjektif,
- reflection berlebihan tanpa evidence,
- tool feedback tidak dipakai.

Khususnya:
- kalau semua thinker sama, parallel reasoning jadi echo chamber.
- kalau reviewer bias, deliberation bisa memilih jawaban yang nyaman, bukan yang benar.

Mitigasi yang lebih kuat:
- desain role-based thinker dengan lensa berbeda,
- struktur cache jadi evidence+hypothesis, bukan narasi panjang,
- randomize order dan anonymize thinker,
- minta reviewer menilai bukti, kontra-evidence, dan kemungkinan kegagalan,
- pakai second-pass verification untuk task penting.

## 9. Analogi praktis
Heavy Thinking mirip mini review board:
- beberapa orang beri solusi sendiri-sendiri,
- satu moderator/reviewer baca semuanya,
- moderator memilih atau menggabungkan solusi terbaik.

Bukan satu orang langsung menjawab.

## Takeaway
Heavy Thinking bukan "AI mikir panjang." Lebih tepat: 
**AI membuat beberapa percobaan berpikir secara terpisah, lalu satu AI reviewer membaca semua percobaan itu dan membuat keputusan final.**

Ini adalah pattern kerja AI yang bisa dipakai di agentic harness.

## Related
- [[notes.agentic-engineering.openclaw.personal-agent-orchestration]]
- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.before-after-judgement-harness]]
- [[zettel.20260508142459]]
- [[zettel.20260508152050]]
