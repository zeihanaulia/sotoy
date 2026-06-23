
Istilah yang gue pakai: SML = Small Language Model, model lokal yang masih realistis jalan di mesin pribadi. Bukan Standard ML.

Gue nulis ini untuk ngetrack apa yang masih realistis buat agent coding lokal, dan apa saja yang berubah setelah Copilot billing pindah ke token.

Menurut gue, untuk konteks, "model kecil" bukan cuma 1B–3B. Yang masuk akal buat coding agent pribadi adalah model kira-kira 7B, 14B, 16B MoE, sampai 30B quantized. 1B–3B biasanya terlalu lemah buat rebranding lintas repo.

Untuk rekomendasi model/token murah yang lebih fokus ke agent coding, ada catatan terpisah: [[notes.copilot.token-cheap-coding-agent-providers]].

Intinya: bisa, tapi jangan harap SML bikin workflow otomatis setara Raptor/Copilot agent. Yang bikin Raptor terasa powerful bukan cuma modelnya. Ada tiga lapis:

- model coding yang cukup kuat,
- agent harness yang jelas,
- context engineering yang rapi.

Kalau elo pakai SML lokal, yang ingin dicontoh bukan hanya modelnya, tapi struktur kerjanya.

## Bukti dan referensi
- GitHub Blog: artikel Copilot agent workflow [How to build reliable AI workflows with agentic primitives and context engineering](https://github.blog/ai-and-ml/github-copilot/how-to-build-reliable-ai-workflows-with-agentic-primitives-and-context-engineering/) menekankan bahwa Copilot CLI menggabungkan model dengan agent primitives dan context engineering, bukan sekadar inferensi model lokal.
- LangChain: artikel [The Anatomy of an Agent Harness](https://www.langchain.com/blog/the-anatomy-of-an-agent-harness) menyatakan secara eksplisit bahwa `Agent = Model + Harness` dan bahwa model sendiri tidak bisa menjalankan tools, menyimpan state, atau mengakses realtime knowledge tanpa harness.
- Raptor Mini: artikel DEV [Raptor Mini: GitHub Copilot’s New Code-First AI Model That Developers Shouldn’t Ignore](https://dev.to/koolkamalkishor/raptor-mini-github-copilots-new-code-first-ai-model-that-developers-shouldnt-ignore-44a4) menjelaskan bahwa Raptor Mini dirancang untuk tool calling, multi-file editing, dan code-aware agents, jadi keunggulannya bukan cuma ukuran model kecil.
- GitHub Copilot local agent docs / commentary: dokumentasi [Local agents in Visual Studio Code](https://code.visualstudio.com/docs/copilot/agents/local-agents) menjelaskan bahwa local Copilot agents di VS Code berjalan langsung di VS Code dengan full access ke workspace tools, MCP servers, extensions, dan BYOK model support. Ini menegaskan bahwa local model hanya bisa “works” kalau dipasangkan dengan agent/tooling yang benar.
- DHH: artikel [Local LLMs are how nerds now justify a big computer they don't need](https://world.hey.com/dhh/local-llms-are-how-nerds-now-justify-a-big-computer-they-don-t-need-af2fcb7b) menegaskan bahwa local LLMs masih jauh di belakang frontier models dan untuk sebagian besar developer lebih cocok sebagai curiosity daripada daily driver.

## 1. Apakah ada model kecil yang cocok?

Untuk kebutuhan personal coding agent, bottleneck-nya bukan hanya "bisa run model lokal atau enggak", tapi kombinasi model size + context length + speed. Local agent GitHub Copilot di VS Code mendukung BYOK model secara eksplisit, jadi model lokal bisa dipakai asalkan harness dan toolingnya juga fit.

### 1.1 Mac M1 16GB: target realistis

Untuk Mac M1 16GB, target lo adalah model lokal yang cukup kuat tapi tidak memaksa swap. Model paling baru belum tentu cocok: yang penting adalah model yang bisa patuh pada workflow agent dan berjalan stabil.

- baseline paling masuk akal: `qwen2.5-coder:7b`.
- comparator instruction-following: `qwen3:8b` bisa dicoba sebagai planner/inventory model.
- heavier experiment: `deepseek-coder-v2:lite` jika lo butuh reasoning coding lebih berat.
- benchmark pendek saja: `qwen2.5-coder:14b`.
- jangan jadikan `qwen3-coder:30b` daily driver di M1 16GB.

Perlu dicatat: kalau `qwen2.5-coder:7b` terasa stuck atau lambat lewat GitHub Copilot, kemungkinan besar bukan karena modelnya mati. Lebih mungkin karena Copilot mengirim packaging agent yang berat:

- system prompt / tool schema besar,
- repo context besar dan chat history,
- agent protocol / tool-call format,
- metadata file / domain rules.

Di Mac M1 16GB, Qwen 7B masih bisa cepat untuk chat kecil. Tapi ketika ia dibungkus oleh Copilot agent, ia bisa ter-overload dan terlihat stuck.

Dari pengamatan saat nge-debug alur Copilot, pola yang muncul cukup jelas: untuk input sekecil “hi”, Copilot masih mengirim sekitar 12k token ke model. Latensi model lokal bisa melonjak jadi 124–302 detik. Jadi masalahnya bukan hanya “hi” yang berat—itu adalah 12k token boilerplate + system prompt/tool prompt/context.

Masalah ini semakin parah kalau sistem sudah swap. Kalau RAM lo sudah di angka 14.7GB dan swap 6.8GB, model inference lokal bisa lambat sekali. macOS unified memory, Metal, cache, dan memory pressure yang kuning/oranye biasanya berarti sebagian kerja sudah didorong ke disk.

Untuk rekomendasi hardware local LLM, pindah ke note terpisah: [[notes.copilot.local-llm-hardware-upgrade]].

## 2. Kenapa model kecil bisa cukup?

Karena pekerjaan elo sempit: rebranding project, rename string/symbol, update config, baca error, repair test. Tidak perlu model besar yang bisa ngerespon semua hal.

Quality sering datang dari workflow, bukan ukuran model. Kalau alurnya jelas:

- inventaris occurrence,
- klasifikasi safe vs ambiguous,
- replacement mekanis untuk yang jelas,
- review dan test,
- repair error,

maka model kecil bisa tampil jauh lebih pinter.

Itu bukan argumen bahwa local LLM otomatis bisa menggantikan semua agentic coding flow. [DHH](https://world.hey.com/dhh/local-llms-are-how-nerds-now-justify-a-big-computer-they-don-t-need-af2fcb7b) benar bahwa local LLMs masih jauh di belakang frontier models untuk sebagian besar use case, tapi itu juga bukan kegagalan kalau konteksnya sempit dan tool/harnessnya tepat.

Sementara model besar pun bisa boros kalau diberi prompt "rebrand semua" tanpa guardrail.

## 3. Apa yang harus dibangun supaya model kecil terasa seperti Raptor?

Yang penting bukan fine-tuning. Yang penting adalah agent harness pribadi.

Minimal komponennya:

- tool access: `grep`, `read_file`, `replace_in_file`, `run_tests`, `git diff`.
- state file: `rebrand-plan.md` atau `agent-state.json` untuk daftar occurrence, keputusan, file yang sudah disentuh, dan error terakhir.
- context pack: `PROJECT_CONTEXT.md`, `REBRAND_RULES.md`, `NAMING_MAP.md`, `DO_NOT_TOUCH.md`.
- budget rule: jangan scan repo berkali-kali; mulai dari inventory lalu kerjakan dari inventory itu.
- deterministic edits first: gunakan script untuk replace yang jelas, gunakan LLM hanya untuk kasus ambigu dan repair.

Ini yang sering terlewatkan. Model besar tidak akan membantu kalau memory kerja eksternal dan workflow state-nya kosong.

## 4. Perlukah fine-tuning?

Untuk tahap awal: belum perlu.

Fine-tuning berguna hanya jika elo punya banyak contoh internal dan pola task yang stabil. Untuk 1 user pribadi, lebih masuk akal:

- level 1: local model + prompt/context pack,
- level 2: local model + tools + state file,
- level 3: local model + retrieval dari repo docs/ADR/pattern lama,
- level 4: fine-tuning/LoRA kecil kalau polanya sudah matang.

Elo sekarang paling mungkin ada di level 2–3. Jadi jangan lompat ke fine-tuning dulu.

## 5. Apa yang berubah setelah Copilot pindah ke AI Credits?

Dulu Raptor mini 0x bisa terasa gratis karena nggak mengurangi jatah premium di UI lama. Sekarang framing-nya berubah:

- Raptor mini masih murah per token,
- tapi long-running task tetap dihitung berdasarkan total token input/output/cached,
- jadi rasa "free" hilang meski biayanya tetap jauh lebih rendah dibanding model premium.

Contoh kasar: task panjang dengan 6 juta input token dan 500k output token bisa jadi sekitar 250 AI Credits dengan Raptor/GPT-5 mini pricing, tapi sekitar 2.550 AI Credits dengan Claude Sonnet 4.6.

Jadi bedanya bukan tipis. Raptor membuat task yang "cukup mahal" jadi masih masuk akal, tapi satu task besar bisa tetap makan seperempat jatah Copilot Pro $10/bulan.

## 6. Temuan riset terbaru

- DeepInfra sekarang menunjukkan Qwen3 30B A3B pada harga sekitar $0.08 input / $0.29 output per 1M token, dengan DeepInfra sebagai cheapest provider.
- Varian Qwen3 Coder 30B A3B Instruct yang lebih khusus coding berada di sekitar $0.07 input / $0.26 output per 1M token, dengan HuggingFace sebagai cheapest provider.
- Contoh MoE Qwen3 235B A22B jadi pelengkap penting: cheapest provider OpenRouter di sekitar $0.071 input / $0.10 output per 1M token.
- Itu artinya total parameter besar tidak otomatis membuat model lebih mahal; active params per token dan arsitektur inference lebih penting.
- Temuan ini bikin thesis gue lebih kuat: harga token murah untuk agent coding bisa datang dari model 30B atau MoE, tidak harus dari model kecil 7B.
- Untuk local hybrid, setup Qwen3.5 lokal + Claude Code di localhost jadi opsi paling menarik sekarang: zero per-token cloud cost, dan tetap bisa pakai UX agent dari Claude.
- Diskusi Reddit r/LocalLLaMA juga memberi sinyal penting: model bisa terlihat “malas” kalau tool-calling dan workflow agent-nya tidak diprioritaskan, bahkan kalau modelnya aman dan harga murah.

### 6.1 Arti riset ini untuk workflow agent

- Model murah bukan jaminan berhasil kalau agentnya tidak tahu kapan memanggil tool.
- Untuk coding agent, patuh terhadap tool schema, konsistensi state, dan minim loop yang tidak perlu lebih penting daripada hanya mencari model termurah.
- Ini sejalan dengan billing Copilot baru: kalau task agent panjang dan loop banyak, token count benar-benar jadi cost driver.
- Tidak ada bukti langsung dari riset ini bahwa GitHub memberi model murah untuk melatih dari kode pengguna. Lebih tepat melihatnya sebagai strategi subsidi/adopsi dan ekonomi token.

## 7. Kenapa thread Theo penting

Thread Theo menunjuk ke masalah inti: pricing GitHub Copilot lama masih flat/message-based, sedangkan agent coding sebenarnya telah berubah jadi long-running compute job.

- dia menunjukkan 15 messages yang terkait dengan sekitar $221 inference cost backend.
- breakdown biaya menunjukkan uncached input, cached input, dan output token masing-masing besar.
- pola ini bukan chat biasa; ini agent loop yang berkali-kali membawa konteks besar.

Intinya: one human message bisa berubah jadi ribuan atau jutaan token internal. Itu yang membuat unit "per message" jadi tidak layak.

### Respons penting dari thread

- Jaid: fixed per-task billing bisa terlalu murah untuk task yang memicu ribuan dolar backend. Fixed task pricing cocok untuk task kecil, tapi rusak untuk agent task yang bisa jalan puluhan jam. [[https://x.com/JaidCodes/status/2051399596530602330]]
  - ini lebih tepat disebut pricing exploit/economic arbitrage, bukan hacking. Dia memakai fitur sebagaimana disediakan, tapi tasknya dibiarkan sangat panjang sehingga cost nyata jauh melebihi harga fixed.
- abdinajib/Cursor: problem ini bukan unik GitHub; tools agent lain yang memberi unlimited/flat access juga mengalami tekanan ekonomi yang sama.
- ByteCrafter: satu agent loop bisa setara 100 autocompletes, jadi cap 1.500-message flat tidak akan bertahan untuk agentic flows.
- Derped: yang bermasalah bukan sekadar kata "credit", tapi credit/allowance yang tidak cukup granular terhadap actual inference cost.
- Sanchit/Vignesh: perubahan ini dilihat banyak orang sebagai normalisasi ekonomi, bukan downgrade produktif; itu wajar dan mungkin inevitable.
- Cheaty: contoh giant task dengan satu request besar menunjukkan bahwa single request dalam agentic coding adalah ilusi karena di belakangnya ada banyak compute.
- Harish: enterprise juga bisa underestimate cost; agent coding di organisasi besar bisa jadi masalah operasional, bukan hanya pricing annoyance. [[https://x.com/iamharishvasu/status/2051389463444836412]]
- Uber story: laporan publik menyebut internal AI coding budget bisa habis dalam empat bulan dan biaya per engineer bisa mencapai $500–$2.000/bulan. Ini menunjukkan bahwa saat agentic coding diadopsi luas, billing menjadi compute budget, bukan lagi seat budget.

Thread Theo dan responsnya mempertegas pola yang sama dengan kasus elo: agentic coding tidak bisa lagi dihitung hanya dari jumlah pesan manusia. [[https://x.com/theo/status/2051395816410210604]]

Thread Theo, Jaid, dan cerita Uber sama-sama menunjukkan pola yang sama:
- billing lama: 1 message/task = 1 unit usage,
- billing baru: 1 message/task bisa punya banyak model call, loop, dan token.
- di level enterprise, limitnya bukan lagi seat count, tapi total compute/token usage.

Untuk kasus elo: Raptor mini tetap biaya rendah, tapi baik thread Theo maupun agent debug panel elo menunjukkan bahwa long-running agent harus mulai dipikir sebagai compute job, bukan sekadar chat interaction.

### 7.1 Subsidy, adoption, dan data

Istilah "yayasan GitHub peduli" lebih tepat dibaca sebagai cross-subsidy atau subsidi produk, bukan charity. GitHub mungkin memberikan model murah/0x sebagai strategi adoption dan validasi produk, bukan karena mereka ingin memberi tanpa batas. Ketika usage agentic meluas, subsidi itu menjadi lubang biaya.

Yang masih perlu dibedakan adalah dua kemungkinan terkait data:

- kemungkinan pertama: GitHub memakai telemetry/usage signal untuk memperbaiki sistem seperti model routing, prompt templates, dan agent behavior. Itu masuk akal.
- kemungkinan kedua: GitHub melatih Raptor mini langsung dari sesi kode pengguna. Dari konteks thread dan docs yang kita lihat, tidak ada bukti langsung untuk klaim itu. Jadi statement yang lebih aman adalah: mungkin ada learning dari pola penggunaan, tapi tidak ada dasar yang cukup untuk mengatakan model dilatih langsung dari kode pengguna.

Raptor mini 0x lebih kemungkinan merupakan strategi produk: model default yang murah untuk 80% task, dengan model premium disimpan untuk 20% kasus sulit. Itu memberi pressure valve agar heavy agentic usage tetap lebih terkendali daripada jika semua user lompat ke Sonnet/Opus/GPT-5.4.

Bukan "GitHub peduli bagi token". Lebih tepat: GitHub memberi subsidi adoption sambil mencari kurva harga yang benar. Dan sekarang kurva lama jebol ketika agentic coding dipakai serius.

## 8. Praktik yang masuk akal untuk elo

Strategi paling rasional tetap:

- pakai Raptor mini sebagai default untuk rebranding, migration kecil, rename, cleanup, dan refactor mekanis,
- jangan biarkan agent eksplor repo tanpa batas,
- pecah task jadi inventory → scripted replace → review diff → fix test,
- gunakan model premium hanya untuk kasus ambiguous, reasoning berat, atau high-impact decision.

Indikator workflow sehat: agent mulai dari inventory, membuat patch/plan, review diff, dan melaporkan hasil secara ringkas — bukan keliling repo dan membawa semua konteks terus-terusan.
