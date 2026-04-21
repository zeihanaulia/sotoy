---
id: zettel.20260421171457
title: "BMAD analysis phase menghentikan ketidakjelasan sebelum berubah jadi PRD dan architecture"
desc: "Analisis halaman BMAD Analysis Phase: mengapa phase ini penting, apa yang dilakukan, dan bagaimana ia mengubah cara berpikir engineer."
tags:
  - bmad
  - analysis-phase
  - ai-native
  - methodology
---

## Pertanyaan yang dibuka

1. Kenapa BMAD percaya analysis perlu ada sebelum planning?
2. Apa yang dilakukan BMAD di fase ini, tool per tool?
3. Dalam praktik nyata, hasil analysis itu mengubah apa?

## Klaim utama

BMAD analysis phase bukan fase untuk menambah dokumen. Ia adalah fase untuk mencegah ketidakjelasan naik level: sebelum PRD, sebelum architecture, sebelum story breakdown.

> Kalau ide kabur, PRD-nya ikut kabur. Kalau PRD kabur, architecture akan mengambil taruhan teknis yang salah.

## Mengapa analysis phase diperlukan sebelum planning?

Halaman BMAD Analysis Phase mengatakan sesuatu yang cukup tajam: PRD bukan tempat terbaik untuk berpikir dari nol. PRD adalah tempat untuk merapikan keputusan.

Kalau Anda langsung lompat ke PRD dari ide mentah, Anda sedang memberi AI bahan yang berpotensi sangat berbahaya. AI bisa merapikan sesuatu yang belum matang dengan tampilan profesional, tetapi itu tidak membuatnya benar. BMAD melihat itu sebagai risiko utama dalam AI-native engineering.

Jadi, phase ini hadir untuk menghentikan error sebelum error itu menjadi struktur. Ini bukan soal menunda sampai segalanya sempurna. Ini soal memastikan bahwa ide mentah diproses dulu menjadi insight, dan bukan diletakkan ke dalam requirement secara mentah.

## Apa yang BMAD lakukan di phase ini?

Halaman itu menawarkan beberapa tool: brainstorming, research, product brief, dan PRFAQ. Kreatifnya, BMAD tidak memberi nama-nama ini sebagai fitur tambahan. Mereka dijajarkan sebagai cara berbeda untuk mengerjakan ketidakjelasan.

### Brainstorming

Ini bukan sekadar memaksa AI menghasilkan daftar fitur. Brainstorming di BMAD dirancang sebagai sesi kreatif terstruktur yang membantu Anda mengeluarkan apa yang ada di kepala.

AI di fase ini bertindak lebih sebagai coach daripada pabrik ide. Ia membantu Anda menajamkan apa yang sebenarnya Anda rasakan, apa yang Anda asumsikan, dan apa yang Anda belum tahu. Tujuannya bukan untuk menggantikan pemikiran Anda, melainkan untuk membuat pemikiran itu lebih eksplisit.

Fungsi utamanya adalah menangkap wilayah "saya merasa ada sesuatu di sini, tapi belum kebentuk". Brainstorming adalah alat untuk membuat wilayah itu menjadi cukup jelas supaya Anda tidak langsung terkunci di requirement yang salah.

### Research

BMAD membagi research menjadi tiga domain: market, domain, dan technical.

Market research menguji realitas eksternal: siapa pemainnya, apa tren pasar, bagaimana user sekarang menyelesaikan masalah ini. Domain research menguji logika internal: istilah apa yang penting, apa constraint industri, bagaimana ahli domain bicara. Technical research menguji feasibility: apakah solusi ini bisa dibangun dengan trade-off yang wajar?

Ini bukan sekadar "kami perlu riset". Ini pengakuan bahwa satu jenis riset saja tidak cukup. Memahami hanya pasar tanpa domain memunculkan produk yang tidak relevan. Memahami hanya teknis tanpa pasar memunculkan solusi tanpa pembeli. BMAD memecah riset agar analysis dapat menangkap berbagai buta: pasar, domain, dan teknik.

### Product Brief

Product Brief adalah jalur yang lebih lembut menuju planning. Ini bukan media untuk menemukan ide dari nol. Ini alat untuk merapikan keyakinan yang sudah ada.

Jika Anda sudah cukup yakin tentang target customer dan masalah utamanya, Product Brief membantu mengeluarkan visi itu dengan jelas. Ia memaksa perbedaan antara "saya punya gagasan" dan "ini gagasan yang dapat dijelaskan secara strategis." Dalam konteks BMAD, brief adalah cara membuat ide yang belum perlu dipukul habis oleh adversarial questions tetap dapat ditransisi ke PRD.

### PRFAQ

PRFAQ adalah mode yang lebih keras. Ini adalah versi BMAD dari Amazon Working Backwards.

Alih-alih sekadar menerima deskripsi produk, BMAD memaksa Anda menulis press release seolah produk sudah jadi, lalu menjawab FAQ yang kritis. Ini adalah momen di mana elasticitas ide diuji: apakah nilai itu komunikatif? apakah solusi itu berbeda? apakah masalahnya jelas?

Di sini AI berperan bukan sebagai pembenaran, tetapi sebagai penantang. Jika ide Anda tidak bisa dijelaskan dengan bahasa yang meyakinkan, itu menandakan bahwa fase analysis belum selesai.

## Apa yang berubah setelah analysis?

Dalam BMAD, hasil analysis bukan sekadar lebih banyak dokumen. Ia mengubah kualitas input ke tahap berikutnya.

Secara praktis, analysis yang baik dapat membuat perbedaan ini:

* ide mentah berubah dari "invoice app" menjadi "accounts receivable assistant for freelancers yang mengurangi keterlambatan pembayaran";
* asumsi yang tersembunyi dikonversi menjadi risiko eksplisit;
* ruang lingkup yang awalnya luas disempitkan menjadi arah yang lebih tajam;
* keputusan teknis awal tidak lagi berdiri di atas tebakan.

Dengan kata lain, analysis phase adalah filter epistemik. Ia menyaring asumsi-asumsi kabur sebelum asumsi tersebut menjadi struktur yang lebih kuat, seperti PRD dan architecture.

## Simulasi: ide invoice app

Bayangkan Anda punya gagasan "aplikasi invoice untuk freelancer." Tanpa analysis, langkah pertama yang banyak diambil adalah langsung meminta AI membuat PRD atau fitur.

Dalam BMAD, langkah pertama adalah menguji apakah fokus masalah itu benar. Di sesi brainstorming, Anda akan didorong untuk menjawab: freelancer mana? masalah sebenarnya di mana? apakah ini soal pembuatan invoice atau soal penagihan dan visibilitas cashflow? Apakah targetnya freelancer lokal atau global? Apakah klien mereka lebih sering menunda atau lupa membayar?

Jika Anda lanjut ke market research, Anda akan menemukan apakah pasar ini sudah terang, apakah persaingan tinggi, dan di mana celahnya. Domain research akan memberitahu apakah ada regulasi atau pola administratif yang membuat solusi Anda berbeda. Technical research akan menguji apakah fitur pembeda seperti follow-up WhatsApp atau otomatisasi reminder memang layak dan dapat dibangun.

Jika Anda kemudian membuat Product Brief, Anda mungkin akan menuliskan bahwa produk Anda bukan sekadar invoice generator, tetapi alat yang membantu freelancer mengelola keterlambatan pembayaran dan cashflow. Jika Anda memilih PRFAQ, ide ini akan diuji keras: apakah pesan itu cukup jelas? apakah pengguna peduli? apakah solusi ini cukup berbeda dari software akuntansi yang sudah ada?

Dari sana, jika fase analysis berhasil, yang dibawa ke Planning bukan lagi sekadar keinginan untuk membuat invoice app. Ia menjadi konsep yang jauh lebih kuat dan berarah. Dan itu adalah nilai utama dari fase ini.

## Mengapa ini relevan untuk AI-native engineering?

BMAD analysis phase adalah jawaban atas bahaya yang muncul ketika AI diperlakukan sebagai mesin spontan. AI sangat baik dalam menstrukturkan hal yang belum matang. Itu justru bahayanya. BMAD mendesain analysis phase untuk mengambil langkah mundur dan berkata: sebelum kita memberi AI tugas membuat solusi, mari kita pastikan masalahnya sudah cukup jernih.

Dengan kata lain, phase ini bukan tentang menambah biaya proses. Ia tentang menambah kualitas proses sebelum mesin percepatan itu diaktifkan.

## Lihat juga

* [[zettel.20260421170812]] — BMAD Getting Started mengajarkan workflow awal AI-native engineering, bukan sekadar installasi
* [[zettel.20260421170516]] — BMAD adalah framework workflow AI-native engineering yang mengganti prompt chaos dengan peran dan fase terstruktur
* [[zettel.20260421171633]] — BMAD brainstorming memperjelas ide sebelum requirement
* [[zettel.20260421171634]] — BMAD market research menangkap realitas eksternal sebelum planning
* [[zettel.20260421171635]] — BMAD domain research memaksa pemahaman logika industri sebelum solusi
* [[zettel.20260421171636]] — BMAD technical research memvalidasi feasibility sebelum architecture
* [[zettel.20260421171637]] — BMAD product brief merapikan visi produk sebelum PRD
* [[zettel.20260421171638]] — BMAD PRFAQ menguji ide dengan pendekatan adversarial sebelum planning
* [[zettel.20260421171823]] — BMAD analysis phase sebagai epistemic filter sebelum PRD
* [[zettel.20260421171824]] — BMAD Product Brief vs PRFAQ: klarifikasi lembut versus pengujian adversarial
* [[zettel.20260421171825]] — Simulasi BMAD analysis phase: invoice app untuk freelancer
* [[zettel.moc.software-architecture]]
