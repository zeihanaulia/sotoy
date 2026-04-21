---
id: zettel.20260421170812
title: "BMAD Getting Started mengajarkan workflow awal AI-native engineering, bukan sekadar installasi"
desc: "Analisis halaman BMAD Getting Started: fase awal, logika track, peran bmad-help, dan implikasi untuk AI-native engineering."
tags:
  - bmad
  - ai-native
  - workflow
  - methodology
---

## Pertanyaan yang dibuka

1. Sebenarnya halaman “Getting Started” ini sedang mengajarkan apa?
2. Kenapa BMAD menyusun prosesnya dalam fase-fase?
3. Apa fungsi `bmad-help` dalam keseluruhan sistem?
4. Apa arti tiga track: Quick Flow, BMad Method, dan Enterprise?
5. Dari semua ini, apa insight paling penting buat praktik engineering nyata?

## Klaim utama

Halaman BMAD Getting Started bukan tutorial installasi biasa. Dari awal dia sedang mencoba menanamkan satu keyakinan besar: **AI coding harus dimulai dari proses kerja, bukan dari prompt spontan.**

Di permukaan, halaman ini memang membahas hal-hal praktis seperti instalasi, perintah `bmad-help`, dan langkah-langkah build. Namun jika kita membaca lebih dalam, BMAD sebenarnya sedang menawarkan sebuah model kerja. Model ini menuntun engineer untuk mengubah interaksi dengan AI dari percakapan bebas menjadi workflow yang bisa diulang.

## 1. Apa yang diajarkan halaman ini?

Jika Anda mengikuti halaman ini sebagai pengguna biasa, Anda mungkin merasa sedang diajarkan cara memasang alat dan menjalankan perintah. Tetapi keseluruhan struktur halaman mengisyaratkan tujuan yang lebih dalam. BMAD ingin agar engineer tidak langsung menuntut kode dari AI. Sebaliknya, ia ingin engineer membangun artefak-artefak awal — seperti komponen bisnis, dokumen requirement, dan konteks proyek — yang kemudian menjadi dasar untuk implementasi.

Itu sebabnya Getting Started memosisikan output awal bukan sebagai kode, melainkan sebagai artefak proses. Dokumen seperti PRD dan architecture bukan sekadar dokumentasi tambahan. Mereka adalah alat untuk membuat niat manusia bisa diterjemahkan dengan lebih aman dan lebih konsisten oleh AI. Dalam praktiknya, BMAD mengajarkan satu hal yang radikal bagi banyak pengguna AI: sebelum Anda bertanya pada AI untuk membuat sesuatu, pastikan dulu Anda sudah punya proses kerja yang jelas.

## 2. Kenapa BMAD membagi proses ke fase?

Halaman ini membagi alur menjadi empat fase: Analysis, Planning, Solutioning, dan Implementation. Itu tampak seperti garis besar SDLC tradisional, tetapi pembagian ini menjalankan fungsi yang jauh lebih spesifik di konteks AI.

Fase Analysis diletakkan sebagai opsional bukan tanpa alasan. BMAD mengakui bahwa tidak semua proyek dimulai dari ketidakjelasan total. Namun dengan menempatkan Analysis sebagai fase yang tersedia, BMAD mengirim pesan penting: ada kondisi di mana masalah sebenarnya belum cukup matang untuk ditangani oleh agent. Pada tahap ini, AI diajak membantu menentukan apakah ide layak dibangun, memahami domain, dan menguji value proposition. Ini adalah rem epistemik, sebuah usaha untuk mencegah AI melompat ke implementasi sebelum tujuan bisnis benar-benar dipahami.

Setelah itu Planning hadir sebagai fase wajib. Di BMAD, requirement bukan lagi sesuatu yang bisa ditunda sampai nanti. Ia dijadikan fondasi minimum. Terutama di track BMad Method dan Enterprise, output seperti PRD dianggap wajib. Alasan desain ini mencerminkan asumsi sentral BMAD: kegagalan AI-native engineering bukan sekadar karena AI tidak mampu menulis kode. Kegagalan jauh lebih mungkin terjadi karena requirement tidak cukup jelas. Karena itu, Planning diposisikan sebagai quality gate pertama yang harus dilalui sebelum implementasi dipertimbangkan.

Kemudian datang Solutioning, fase yang menarik karena BMAD dengan sengaja memisahkan requirement dari solusi teknis. Artinya BMAD tidak menerima praktik umum di mana orang langsung menerjemahkan kebutuhan ke desain, lalu langsung ke kode. Di sinilah architecture ditempatkan sebagai konteks yang memberi makna pada backlog. Hanya setelah architecture jelas, epics dan stories dapat dibuat dengan hati-hati. Sikap ini menunjukkan bahwa BMAD percaya backlog yang baik harus lahir dari keputusan arsitektural, bukan sebaliknya.

Akhirnya Implementation. Ketika BMAD sampai pada tahap ini, ia tidak menyerahkannya pada improvisasi. Implementasi dipecah menjadi ritme teratur: sprint planning, penulisan story, implementasi story, code review, dan retrospective. Ini menegaskan bahwa dalam model BMAD, coding bukanlah ledakan satu kali, tetapi rangkaian unit kerja yang sengaja dikendalikan.

## 3. Apa fungsi `bmad-help`?

Jika Anda bertanya mengapa BMAD menempatkan `bmad-help` di pintu masuk, jawabannya ada pada masalah yang jauh lebih besar daripada daftar perintah. `bmad-help` diposisikan sebagai navigator proyek, bukan sebagai manual biasa. Ia menginspeksi kondisi proyek, membaca modul yang terpasang, mengetahui apa yang sudah selesai, dan memberi tahu langkah selanjutnya. Dalam istilah desain sistem, ia adalah dispatcher proses.

Fungsi ini penting karena BMAD menghadapi masalah disorientasi yang khas bagi pengguna AI. Ketika ada terlalu banyak fase, terlalu banyak agen, dan terlalu banyak pilihan, user cenderung tersesat. Tanpa seorang pemandu yang bisa merutekan alur, banyak orang akan kembali ke improvisasi. `bmad-help` mencoba memotong kebiasaan itu. Dengan menekankan bahwa ia aktif di akhir setiap workflow, BMAD juga mengurangi jeda antara satu langkah dan langkah berikutnya. Ini mencegah celah di mana pengguna berhenti dan mulai menebak-nebak.

Kesimpulannya, `bmad-help` bukan hanya helper; ia adalah mekanisme pengurangi disorientasi sekaligus penegak kontinuitas workflow.

## 4. Apa arti tiga track?

Halaman BMAD Getting Started menjelaskan tiga track perencanaan: Quick Flow, BMad Method, dan Enterprise. Perbedaan di antara ketiganya bukan soal label yang keren. Mereka merepresentasikan cara BMAD menyesuaikan tingkat formalitas dengan kompleksitas proyek.

Quick Flow diperuntukkan bagi pekerjaan yang jelas dan kecil, seperti bug fix atau fitur sederhana. Di sini BMAD mengakui bahwa tidak semua pekerjaan perlu birokrasi berat. Untuk kasus seperti ini, cukup ada tech-spec untuk menjaga agar agent tetap mendapat arah tanpa harus memaksa pembuatan PRD dan architecture.

BMad Method berada di tengah: untuk produk, platform, atau fitur kompleks yang tidak seberat enterprise, namun sudah cukup besar untuk membutuhkan pemisahan yang jelas antara kebutuhan, desain, dan implementasi. Di track ini, PRD dan architecture menjadi artefak penting karena mereka menahan kompleksitas agar tidak meledak menjadi kerja yang salah arah.

Enterprise menambahkan lapisan formalitas lagi. Project dengan compliance, multi-tenant system, atau persyaratan governance tinggi tidak hanya butuh architecture; mereka butuh security dan DevOps explicit. Di level ini, BMAD mengakui bahwa biaya kesalahan sangat tinggi, sehingga artefak dan quality gate juga harus lebih banyak.

Track-track ini pada akhirnya menyampaikan satu pesan: struktur jangan dipaksa sama untuk semua skenario. Semakin besar risiko, semakin banyak struktur yang diperlukan. Tetapi struktur itu juga tidak harus dipaksakan pada task kecil yang jelas.

## 5. Insight paling penting untuk praktik engineering nyata

Meski terdengar seperti tutorial, halaman ini sedang membahas ide yang jauh lebih besar. Intinya adalah bahwa AI-native engineering harus dimulai dari proses, bukan prompt. BMAD Getting Started bukan sekadar memberi tahu Anda command mana yang harus dijalankan. Ia memberi tahu Anda bahwa caranya membangun software dengan AI harus melewati tahapan, artefak, dan perpindahan konteks yang sengaja diatur.

Implikasinya untuk praktik engineering adalah nyata. Pertama, jangan gunakan AI untuk langsung membuat kode dari ide yang kabur. Kedua, gunakan fase Planning untuk memastikan masalah dan kebutuhan tertulis dengan jelas. Ketiga, pisahkan Solutioning agar arsitektur ditempatkan sebelum backlog dibuat. Keempat, pakai `bmad-help` sebagai navigator agar workflow tidak tercerai-beraikan. Kelima, pilih track yang sesuai, karena bukan semua task layak diperlambat oleh proses enterprise. Dan keenam, mulai setiap workflow di chat baru agar konteks model tetap bersih.

Secara lebih luas, halaman ini menegaskan bahwa AI-native engineering bukan tentang model atau prompt yang lebih canggih. Ia tentang bagaimana menempatkan AI dalam proses delivery yang bisa dipercaya. Itu juga alasan mengapa artefak seperti PRD, architecture, epics, dan project context bukan sekadar dokumentasi. Mereka adalah medium transmisi niat dan aturan antara manusia dan AI.

## Hubungan dengan AI-native engineering

Jika dibandingkan dengan kerangka sekali pakai lain, BMAD Getting Started mengarahkan kita pada pemahaman yang sama dengan artikel Thoughtworks: AI harus diperlakukan sebagai bagian dari engineering stack, bukan sebagai chatbot improvisasi. Specialized agents di BMAD adalah lapisan agent, Planning dan Solutioning adalah methodology, artefak adalah spec discipline, project context adalah context engineering, dan fresh chats adalah pengakuan atas keterbatasan konteks model.

Dengan demikian, BMAD Getting Started bukan hanya onboarding software. Ia adalah onboarding ke sebuah model kerja AI-native engineering yang menempatkan proses lebih dulu sebelum prompt.

## Lihat juga

* [[zettel.20260421170516]] — BMAD adalah framework workflow AI-native engineering yang mengganti prompt chaos dengan peran dan fase terstruktur
* [[zettel.20260421163750]] — Thoughtworks: AI-native engineering adalah operating model untuk mengorkestrasikan AI, bukan sekadar AI coding
* [[zettel.moc.software-architecture]]
