---
id: notes.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering
title: 'Andrej Karpathy: From Vibe Coding to Agentic Engineering'
desc: >-
  Ringkasan talk YouTube Karpathy tentang pergeseran dari vibe coding ke agentic
  engineering dan Software 3.0.
updated: 1778122369000
created: 1778122369000
tags:
  - book-summary
  - youtube
  - karpathy
  - agentic-engineering
  - software-3-0
---

Link: <https://www.youtube.com/watch?v=96jN2OCOfLs&t=1s>

## Summary

Yang gue tangkap dari talk ini adalah bahwa Karpathy enggak sekadar ngomong soal AI bikin coding lebih cepat. Dia sedang mencoba memberi kata lain untuk perubahan cara kerja programmer: **vibe coding** untuk produktivitas dan eksperimen, lalu **agentic engineering** untuk menjaga standar kualitas profesional.

Kalimat yang paling nempel buat gue adalah: "You can outsource your thinking but you can’t outsource your understanding." Itu bukan sekadar soundbite. Itu menegaskan batas antara apa yang bisa diserahkan ke agent dan apa yang harus tetap ada dalam kepala manusia.

Gue juga catet bahwa talk April 2026 merujuk pada fase shift yang Karpathy lihat di akhir **Desember 2025**. Business Insider dan sumber lain menguatkan bahwa perubahan workflow tersebut sudah terasa sebelum talk dan bukan sekadar framing pasca-event.

## Highlights

- **Vibe coding** muncul ketika model mulai memberikan kode yang "langsung benar" cukup sering. Bukan karena AI sempurna, tapi karena trust threshold manusia terlewati. Awalnya agent bantu potongan kode, lalu berubah jadi workflow di mana manusia hanya mengalirkan intent.
- **Software 3.0** adalah perubahan paradigma komputasi. Karpathy membagi era software menjadi 1.0 (kode eksplisit), 2.0 (neural network dilatih), dan 3.0 (prompt + context window). Dalam era ini, context window menjadi instruksi operasional utama.
- Contoh praktisnya adalah Menugen, eksperimen Karpathy untuk bikin app foto menu restoran yang mengubah teks menu jadi gambar makanan. Versi lama pakai pipeline upload foto, OCR, generate gambar, render UI, deploy. Versi Software 3.0 cukup beri input foto ke model lalu minta overlay visual langsung. Kesimpulannya: beberapa app lama mungkin artefak paradigma lama.
- **Verifiability** jadi kunci. Model kuat pada domain yang outputnya bisa diperiksa: math, code, tests, security, benchmark. Tapi ia masih "jagged": bisa refactor codebase besar, tapi bisa salah dalam reasoning sehari-hari.
- **LLM knowledge base** bukan sekadar RAG atau vector DB. Karpathy melihatnya sebagai cara agar LLM mengambil dokumen mentah dan mengompilasinya ulang menjadi struktur yang membantu pemahaman manusia—wiki, outline, Q&A, dan reframing informasi—bukan hanya menyajikan potongan jawaban.
- **RL circuits matter.** Jika use case lo berada di area yang masuk training/RL loop, lo bisa "fly." Kalau keluar dari distribusi itu, lo akan struggle dan perlu fine-tuning sendiri.
- **Vibe coding menaikkan floor, agentic engineering menaikkan ceiling.** Vibe coding memudahkan banyak orang masuk ke software. Agentic engineering memastikan pekerjaan profesional tetap punya quality bar: secure, maintainable, testable, observability jelas.
- **Skill manusia yang naik nilainya** adalah judgment, taste, spec, dan oversight. Agent bisa isi detail, tapi manusia harus menjaga invariants sistem, misalnya user identity harus persistent ID, bukan cocok-cocokan email.
- Karpathy bilang detail API bisa dilupakan—detail `keepdims`, `axis`, `reshape` bisa ditangani agent—tapi **fundamental** seperti tensor view, storage, memory copy, efisiensi tetap harus dipahami.

## Atomic ideas

1. Trust threshold mengubah workflow coding: ketika output AI cukup sering benar, manusia mulai mengubah cara berpikir, bukan sekadar cara mengetik.
2. Vibe coding adalah mode eksplorasi cepat yang berguna untuk prototyping, bukan pengganti disiplin quality assurance.
3. Dalam Software 3.0, prompt dan context window menjadi source code sementara untuk interpreter LLM.
4. Agent bisa menggantikan sebagian scripting eksplisit dengan instruksi adaptif yang melihat environment dan debug sendiri.
5. LLM knowledge base bisa membuat dokumen mentah direcompile menjadi struktur pemahaman baru—wiki, outline, Q&A, timeline—sehingga manusia dapat insight, bukan hanya jawaban.
6. Dokumentasi operasi bisa berubah fungsi menjadi input executable-ish untuk agent.
7. Beberapa aplikasi lama bisa menjadi artefak paradigma lama, karena model sekarang dapat menelan pipeline yang sebelumnya diperlukan.
8. Peluang terbesar ada pada hal yang tidak mungkin dilakukan sebelumnya, bukan sekadar mempercepat workflow lama.
9. Verifikasi adalah bahan bakar otomasi LLM; capability model sering puncak di domain yang bisa diverifikasi.
10. LLM capability itu jagged, bukan merata, sehingga manusia harus tetap berada dalam loop dan menggunakan model sebagai alat.
11. Agentic engineering menjaga quality bar profesional sambil memanfaatkan kecepatan AI.
12. Skill manusia yang paling penting adalah taste, judgment, spec, oversight, dan maintenance of system invariants.
12. AI bisa mengambil alih hafalan detail API, tapi tidak bisa menggantikan pemahaman fundamental.
13. Kode yang jalan tidak sama dengan kode yang baik: simplification dan taste masih butuh evaluasi manusia karena tidak selalu muncul dalam RL circuits.
14. LLM bukan animal intelligence; lebih tepat dipahami sebagai statistical simulation circuits plus RL.
15. Infrastruktur saat ini masih human-native; masa depan agent-native butuh docs, API, permissions, sensor, dan actuator yang legible untuk agent.
16. Agent bisa menjadi lapisan representasi sosial-operasional yang memungkinkan agen orang/organisasi berinteraksi.
17. Understanding adalah bottleneck terakhir: thinking bisa didelegasikan, understanding tidak.

## Timeline note

### 00:47–02:27

Karpathy cerita transisinya dari merasa alat AI hanya bantu potongan kode, ke fase di mana model sering benar sehingga dia mulai nge-work dalam mode vibe coding. Ini asal-usul istilahnya.

### 02:28–04:50

Karpathy jelasin era Software 1.0, 2.0, dan 3.0. Di era 3.0, programming berubah jadi menulis prompt dan context yang jadi leverage atas LLM sebagai interpreter.

Dia memberi contoh OpenClaw: bukannya menulis shell script kompleks lintas platform, paradigma baru adalah menulis teks untuk dicopy-paste ke agent dan membiarkan agent melihat environment, mengecek, dan debugging sendiri.

### 04:54–07:36

Contoh Menugen: eksperimen app foto menu restoran yang awalnya pakai pipeline upload foto, OCR, generate gambar, dan render ulang menu. Aplikasi lama ini bisa jadi spurious kalau model sekarang bisa langsung handle input mentah dan render output. Ini bukan cuma percepatan, tapi juga revisit eksistensi aplikasi.

### 09:41–13:36

Verifiability jadi pembeda utama. Model kuat di domain yang bisa diverifikasi, kurang stabil di reasoning yang tidak jelas reward-nya. Karena frontier labs melatih model dengan RL reward, kemampuan model sering puncak di area verifiable dan stagnan di area non-verifiable.

Karpathy juga memberi contoh jaggedness: model bisa refactor 100.000 baris kode tapi masih menyarankan jalan kaki ke car wash 50 meter jauhnya. Itu menunjukkan pentingnya tetap berada di loop dan menganggap model sebagai alat.

### 13:37–15:09

Founder advice: domain yang bisa diverifikasi tetap menarik meski lab besar sudah fokus di math dan coding. Jika lo bisa membangun RL environment atau dataset khusus sendiri, itu memberi leverage untuk fine-tuning dan custom automation.

### 15:46–17:18

Beda vibe coding dan agentic engineering: floor vs ceiling. Vibe coding menghasilkan karya cepat, agentic engineering menjamin kualitas profesional tetap hidup.

Karpathy menyebut agent sebagai entitas spiky, fable, stochastic: powerful tapi perlu dikordinasi dengan benar agar tidak menurunkan quality bar.

### 17:19–19:28

AI-native engineer terlihat dari kemampuan memaksimalkan tool, setup sendiri, dan membangun proyek besar, bukan sekadar mengerjakan puzzle coding kecil. Karpathy menyarankan hiring process beralih ke proyek besar plus stress test dengan agent lain.

### 19:29–22:12

Agent masih butuh oversight. Contoh Menugen: agent nyoba cross-correlate user via email Stripe dan email Google. Ini terlihat logis, tapi melanggar invariant desain identitas user.

### 21:02–22:12

Karpathy menjelaskan bahwa detail API bisa dilupakan—agent punya recall kuat—tapi fundamental seperti tensor view, storage, dan memory copy tetap harus dipahami. Ini membuat manusia lebih fokus pada desain, taste, dan sistem, bukan hafalan permukaan.

### 22:14–23:30

Taste dan judgment belum jadi reward utama. Model sering menghasilkan kode bloaty, copy-paste, awkward abstractions, dan sulit menyederhanakan kode karena simplification belum menjadi bagian dari RL circuits. Karpathy menyebutkan proyek microGPT sebagai contoh: minta model menyederhanakan kode, dan model terasa seperti luar dari RL circuits—perlu usaha tarik gigi.

### 23:31–25:15

LLM bukan animal intelligence. Karpathy menekankan mereka adalah statistical simulation circuits dengan pretraining plus RL bolted on. Mindset ini membantu kita tetap skeptis dan tidak memberi mereka motivasi manusiawi.

### 25:18–27:37

Infrastruktur saat ini masih ditulis untuk manusia. Karpathy bilang masa depan harus agent-native: docs, API, dan workflow yang bisa langsung dimakan agent, bukan cuma manusia.

Dia membayangkan dunia di mana agent memiliki representasi untuk orang/organisasi, lalu agen saling bicara untuk mengatur detail meeting atau tugas rutin.

## Takeaways

- Talk ini bukan argumen bahwa programming sudah mati. Ini tentang pergeseran peran: dari penulis detail ke desainer sistem kerja.
- Biar agent bisa bantu, manusia harus tetap pegang understanding. Tanpa itu, output agent cuma sekilas "jalan" tapi bisa punya masalah serius.
- Ide AI production-ready bukan sekadar mempercepat coding, tapi menjaga spec, verifikasi, keamanan, dan observability.
- Untuk startup: domain yang bisa diverifikasi dan punya feedback loop spesifik adalah area yang paling menjanjikan.

## Related notes

- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.senior-judgement-to-harness]]
- [[notes.agentic-engineering.single-verification-entrypoint]]
- [[notes.agentic-engineering.openclaw.personal-agent-orchestration]]
- [[notes.agentic-engineering.next-wave-cloud-agents]]
- [[zettel.literature.karpathy-from-vibe-coding-to-agentic-engineering]]
- [[zettel.moc.agentic-engineering]]
