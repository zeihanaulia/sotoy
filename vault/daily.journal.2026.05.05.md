---
id: daily.journal.2026.05.05
title: '2026-05-05'
desc: >-
  Catatan perubahan billing GitHub Copilot Pro dari premium request ke
  token-based credit
updated: 1780426712064
created: 1777981844785
tags:
  - daily
  - github
  - copilot
  - ai-billing
  - x
  - twitter
traitIds:
  - journalNote
---

## Hari ini gue baca [GitHub Blog: GitHub Copilot is moving to usage-based billing](https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/)

### Konteks
- artikel 27 April 2026, perubahan efektif 1 Juni 2026.

### Yang gue tangkep
- Copilot Pro tidak naik harga $10/bulan, tapi unit pemakaian berubah dari "premium request units" ke "GitHub AI Credits".

### Apa yang berubah di Copilot Pro
- sistem premium request units (PRU) dihapus.
- diganti dengan GitHub AI Credits yang dipakai berdasarkan token.
- token yang dihitung meliputi input token (konteks/prompt), output token (jawaban/kode), dan cached token (konteks ulang pakai).
- GitHub menyebut 1 AI Credit = $0.01, jadi $10 Copilot Pro = 1.000 AI Credits.
- model sekarang masih punya multiplier, tapi relevansinya berbeda:
  - untuk annual Copilot Pro/Pro+ yang masih berada di sistem request-based sampai masa annual habis.
  - untuk usage-based billing baru, yang sekarang lebih granular: biaya = token × tarif model per jenis token.
- model murah tetap lebih hemat; model kuat tetap lebih mahal, tapi sekarang per-token pricing membuat perbedaan itu lebih presisi.

### Kenapa ini penting buat gue
- model baru bikin billing Copilot lebih mirip layanan compute/AI API.
- request pendek cukup murah; sesi agentic panjang, baca banyak file, atau refactor repo besar bisa pakai kredit jauh lebih cepat.
- dulu satu request kecil dan satu sesi panjang bisa dihitung sama; sekarang biaya lebih dekat ke actual compute/token cost.
- thread Theo menunjukkan anomali lama: sedikit message bisa memicu ratusan juta token backend dan biaya inference besar, padahal billing lama hanya hitung per message. [[https://x.com/theo/status/2051395816410210604]]
  - <blockquote class="twitter-tweet"><p lang="en" dir="ltr">- 15 messages<br>- $221 of tokens<br>- 1.6% of my $40 plan used<br><br>It&#39;s obvious that GitHub couldn&#39;t keep this model for billing on Copilot. <a href="https://t.co/x2QGOCMnhw">https://t.co/x2QGOCMnhw</a> <a href="https://t.co/XRXiwYjn8E">pic.twitter.com/XRXiwYjn8E</a></p>&mdash; Theo - t3.gg (@theo) <a href="https://twitter.com/theo/status/2051395816410210604?ref_src=twsrc%5Etfw">May 4, 2026</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
- respons thread menguatkan bahwa ini bukan sekadar GitHub serakah: banyak user melihat agent coding telah merusak model harga subscription lama.
  - fixed/flat per-task pricing cocok untuk task kecil, tapi boncos saat task agent bisa berjalan puluhan jam.
  - banyak orang setuju unlimited/flat agent pricing akan temui masalah economics yang sama di tools lain.
  - billing harus mengikuti real token consumption, bukan sekadar jumlah interaksi.
- cerita Uber menambah dimensi enterprise: saat ratusan atau ribuan engineer mulai memakai agentic coding, budget bisa berubah dari seat budget menjadi compute/token budget. [[https://x.com/iamharishvasu/status/2051389463444836412]]
- contoh Jaid menguatkan isu pricing exploit pada fixed task pricing, bukan hack teknis. [[https://x.com/JaidCodes/status/2051399596530602330]]

### Apa yang tetap termasuk
- price dasar Copilot Pro: tetap $10/bulan.
- code completions tetap termasuk.
- Next Edit suggestions tetap termasuk.
- akses Pro tetap ada, tapi sekarang ada "potongan" akses/budget token per bulan.

### Perubahan annual plan
- pelanggan bulanan otomatis pindah ke usage-based billing 1 Juni 2026.
- pelanggan tahunan tetap di model premium request sampai masa annual habis.
- multiplier lama masih relevan untuk annual plan yang belum berakhir, karena mereka tetap di sistem request-based sampai expiry.
- setelah annual plan selesai, langganan akan pindah ke Copilot Free; bisa upgrade ke monthly dan sisa nilai annual dikonversi prorata ke kredit.

### Dampaknya buat gue / pemakaian gue
- kalau gue cuma pakai Copilot buat task ringan, dampaknya kemungkinan kecil selama nggak pakai sesi agent panjang atau model premium secara berat.
- kalau gue mulai pakai agentic workflow, kredit bisa habis lebih cepat karena sekarang biaya naik seiring panjang konteks dan model yang dipakai.
- buat gue yang pakai Raptor mini, posisi gue relatif lebih aman dibanding yang sering pakai Claude Sonnet/GPT-5.4/Opus.
- penting dicatat: di UI lama, Raptor mini bisa terasa "free" karena 0x tidak mengurangi jatah premium/request secara kasat mata.
- di sistem baru, Raptor mini tetap murah, tapi tidak benar-benar gratis—meter tokennya mulai kelihatan.
- kasus Jaid Opus menguatkan ini: fixed price per task bisa disalahpakai untuk session long-running yang secara backend cost jauh lebih tinggi.
- yang terjadi di skenario itu lebih tepat disebut economic arbitrage/pricing exploit, bukan hack.
- screenshot token count seperti 59.726 tks kemungkinan menunjukkan konteks per langkah, bukan total biaya final.
  - kalau setiap langkah membawa 40k–60k token dan agent jalan 20 kali, total input bisa mendekati 1 juta token.
  - dengan pricing Raptor/GPT-5 mini, 1 juta input token kira-kira 25 AI Credits; tambahan 100k output token bisa jadi 20 AI Credits.
  - satu task panjang bisa menghabiskan 45–250 AI Credits tergantung berapa banyak step dan output yang dihasilkan.

### Transisi ke local model
- pergeseran Copilot ke billing token-based bikin gue semakin memperhitungkan opsi local/hybrid agents sebagai alternatif biaya.
- kalau cloud token mulai tajam, small model lokal atau Qwen3/MoE 30B murah bisa jadi pertahanan ekonomi, bukan sekadar eksperimen. [[https://www.reddit.com/r/LocalLLaMA/]]
- catatan terkait: [[notes.copilot.raptor-mini-sml-budgeting]], [[notes.copilot.local-llm-hardware-upgrade]], [[notes.copilot.token-cheap-coding-agent-providers]]

### Kesalahan umum
- salah paham bahwa harga Copilot Pro naik. nggak; yang berubah adalah unit ekonominya: dari request-based ke token/credit-based.
- ini bukan kenaikan paket, tapi perubahan cara hitung.

### Insight
- Copilot sekarang diposisikan sebagai layanan AI compute yang bisa jalan lama dan lintas file, bukan sekadar autocomplete/chat kecil.
- buat pemakaian singkat, biaya relatif kecil.
- buat penggunaan agentic panjang, ini bisa jadi sinyal supaya kontrol session, konteks, dan model jadi lebih penting.
- output token jauh lebih mahal daripada input token, jadi prompt yang menghasilkan teks panjang atau banyak file akan meroket biaya.
- istilah "yayasan GitHub peduli" lebih tepat dibaca sebagai cross-subsidy/produk subsidi, bukan charity.
- tidak ada bukti langsung bahwa model murah/0x sengaja diberikan agar GitHub bisa latih Raptor mini dari sesi pengguna.

### Catatan ringkas
- Copilot Pro tetap $10/bulan, tapi budget $10 berubah jadi "AI Credits".
- Raptor mini tercatat di docs sebagai model harga setara GPT-5 mini: murah per token.
- long-running task masih butuh diperhitungkan berdasarkan total token yang dikonsumsi.
- billing baru akan membuat pemakaian panjang / model berat kelihatan lebih mahal.
- peralihan annual plan penting untuk pengguna tahunan yang belum habis masa langganannya.

## Insight lain: Chris Parsons "How I Use AI to Code"
- gue catet artikel ini sebagai case study agentic engineering: bukan sekadar model, tapi harness, verification, dan feedback loop.
- inti argumennya: AI bikin produksi kode murah, tapi verifikasi dan judgement jadi makin mahal.
- `AGENTS.md`, skill file, dan portable Markdown knowledge lebih penting daripada prompt yang panjang.
- senior engineer idealnya jadi trainer harness, bukan reviewer diff manual.
- artikel ini juga ngasih kontras antara vibe coding (terima output AI tanpa cukup cek) dan agentic engineering (AI dipakai agresif tapi dalam sistem guardrail dan test).
- buat detail lebih lengkap, gue pindahin ringkasan ke [[notes.agentic-engineering.how-i-use-ai-to-code]].
- ada nota baru soal next wave: cloud agents + autonomous orchestration di [[notes.agentic-engineering.next-wave-cloud-agents]].
- ada nota baru soal bagaimana judgement senior dipindahkan ke harness di [[notes.agentic-engineering.senior-judgement-to-harness]].
- ada nota before-after workflow tim dan harness untuk N+1 query di [[notes.agentic-engineering.before-after-judgement-harness]].
- ada nota tentang OpenClaw sebagai personal agent orchestration di [[notes.agentic-engineering.openclaw.personal-agent-orchestration]].
- ada nota hands-on self-hosted VM agent runner di [[notes.agentic-engineering.self-hosted-agent-runner]].
- ada nota GitLab MR review agent di Coolify di [[notes.agentic-engineering.gitlab-mr-review-agent-coolify]].

## Thread X Guillermo Rauch: `deepsec`
### Konteks

- gue lagi baca thread [Guillermo Rauch](https://x.com/rauchg/status/2051386798899888539) tentang `npx deepsec`.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">𝚗𝚙𝚡 𝚍𝚎𝚎𝚙𝚜𝚎𝚌<br><br>We&#39;re introducing an open-source agent orchestrator for deep security reviews.<br><br>We built it for internal use, and after running it against some major OSS projects, we gained conviction to share it with the world.<br><br>Coding agents can now find critical… <a href="https://t.co/pl8rPc2rNG">https://t.co/pl8rPc2rNG</a></p>&mdash; Guillermo Rauch (@rauchg) <a href="https://twitter.com/rauchg/status/2051386798899888539?ref_src=twsrc%5Etfw">May 4, 2026</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### Apa itu `deepsec`?
- ini adalah "open-source agent orchestrator for deep security reviews", bukan sekadar SAST atau vulnerability scanner.
- fokusnya di harness: CLI-first, sandbox-based scaling, pluggable coding agents, support repo besar, BYO model/subscription.
- intinya `deepsec` lebih mirip kerangka kerja yang menjalankan banyak coding agent paralel, lalu mengumpulkan dan memfilter hasilnya.

### Kenapa "agent orchestrator" penting?
- agent tunggal punya batasan context window, waktu, dan fokus eksplorasi.
- kalau banyak agent jalan paralel, masing-masing bisa ngejar hipotesis berbeda: auth bypass, SSRF, deserialization, dependency misuse, dll.
- orchestration menjawab masalah praktis: agent mana dijalankan, prompt apa, branch/commit mana, output disimpan di mana, duplicate bagaimana, dan bagaimana hasilnya diverifikasi.
- ini sejalan dengan komentar Dr. Nripanka Das di thread itu: yang berguna bukan agent, tapi harness-nya.

### Nilai utama: agent atau harness?
- agent adalah headline: "AI menemukan vulnerability." Tapi dia juga paling rawan hype dan halusinasi.
- harness adalah yang bikin hasilnya bisa diulang, diukur, dan diaudit.
- tanpa harness, 100 finding dari agent cuma jadi tumpukan noise. dengan harness, lo bisa tahu run mana, prompt mana, model mana, environment mana, dan bukti apa yang mendukung.
- thread ini lebih menunjukkan transisi ke review keamanan berbasis orkestrasi agent, bukan AI security scanner monolitik.

### Mengapa false positive, triage, dan signal-to-noise langsung muncul?
- security review yang bagus bukan cuma banyak menemukan issue, tapi juga membantu maintainer melakukan [triage](til.security.triage): menyaring mana yang valid, mana yang false positive, mana yang paling berbahaya, dan mana yang harus ditangani dulu.
  - contoh triage: dari 40 finding, 8 bisa valid critical/high, 12 valid medium/low, 10 false positive, dan 10 lainnya perlu investigasi lanjutan. Dengan begitu, tim tahu mana yang harus dikerjain sekarang dan mana yang bisa ditunda.
    - kalau agent ngeluarin 40 finding dan 90% noise, maintainer malah kewalahan.
- signal-to-noise ratio jadi ukuran best practice: Intinya, dari banyak alert yang keluar, berapa yang beneran berguna dan bukan cuma noise.
- klaim deepsec adalah punya "very high signal to noise ratio", tapi yang benar-benar meyakinkan adalah benchmark: repo besar apa, berapa confirmed, berapa false positive, dan berapa waktu triage.

### Relasi dengan Swival dan kompetitor
- diskusi di thread sempat menyinggung Swival karena konsepnya tampak mirip: multi-phase audit dengan triage, verification, patch generation.
- Guillermo menekankan pembeda arsitektural: open source, parallel cloud sandbox, large repo testing, BYO agent/model/key, dan CLI-first.
- yang jadi pertanyaan bukan siapa duluan, tapi apakah orchestration dan packaging operasionalnya berbeda.

### Kenapa ini relevan buat gue
- thread ini mengingatkan bahwa manusia bukan hilang, tapi pekerjaannya bergeser: dari nyari bug ke mendesain scope, membaca bukti, memvalidasi exploitability, menentukan severity, dan men-triage.
- ini juga terhubung dengan catatan `[[notes.security.overtrust]]`: selain ngecek codebase, kita harus ingat bahwa workstation dan tool lokal bisa jadi boundary risiko sendiri.
- catatan lain yang relevan:
  - `[[notes.security.deepsec-docs]]` untuk cara kerja Deepsec sebagai harness audit dan bukan cuma scanner.
  - `[[notes.security.deepsec-harness]]` untuk konsep orchestration agentic review dan bagaimana hasil harus masuk workflow.
  - `[[notes.security.deepsec-challenges]]` untuk kritik operasional: false positive, cost, dan apakah outputnya actionable.
  - `[[notes.security.agentic-coding-permission-boundary]]` untuk fokus pada izin lokal dan filesystem access dalam agentic coding.
- pertanyaan yang bener bukan lagi "model apa?" melainkan "bagaimana finding diverifikasi, direproduksi, dan di-triage?"
- pendekatan ini lebih cocok untuk scheduled audit, area sensitif, atau repo besar, bukan PR hook setiap commit.

### Insight kunci
- `deepsec` menarik karena dia mengangkat orkestrasi agentic review sebagai produk, bukan hanya agentnya.
- nilai jadi dari sandbox + parallelism + reproducibility + triage.
- ini lebih dekat ke fuzzing atau CI security gate dalam hal skala dan eksplorasi, tapi bedanya hasilnya perlu penilaian semantik dan verifikasi manual.
- kalau orang baca thread ini hanya sebagai "AI security review bisa dilepas", itu risiko besar. versi yang lebih pas adalah: "AI bisa memperluas coverage, tapi manusia tetap penting untuk bukti dan keputusan."