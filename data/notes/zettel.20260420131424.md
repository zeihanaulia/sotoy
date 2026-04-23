
## Gagasan

Jika dokumen terlalu tebal, orang bakal ngerasa itu cuma dokumentasi formal lagi.

Dalam praktik, thresholdnya biasanya sekitar 1–2 halaman atau sekitar 300–800 kata. Kalau sebuah feature document membutuhkan lebih dari itu untuk dipahami, besar kemungkinan orang akan menganggapnya sebagai dokumentasi berat dan enggan membacanya.

## Mengapa Ini Penting

Jadi nilai efektif feature document ada di kegunaan, bukan panjangnya.

Feature document yang efektif punya dua ciri utama:

- langsung jawab "apa yang harus dibangun" dan "kenapa" tanpa harus menggali berlembar-lembar latar belakang;
- mudah di-update dan dipakai tim saat keputusan berubah.

Kalau dokumen panjangnya hanya untuk menampilkan kompleksitas, itu biasanya menjadi beban baca dan berhenti jadi sumber kebenaran.

## Contoh

### Efektif
- Satu halaman ringkas yang berisi masalah pengguna, tujuan bisnis, batasan utama, dan kriteria berhasil.
- Contoh: issue atau PR yang punya "Goal", "What", "Why", "Out of Scope", dan "Open Questions".
- Itu cukup untuk tim sadar apa yang harus dilanjutkan dan mengapa keputusan dibuat.

### Kurang efektif
- Dokumen 5 halaman yang memuat semua alternatif solusi, sejarah diskusi panjang, dan output riset mendetail.
- Orang sering baca setengah, lalu menyerah karena "ini terlalu banyak untuk segera diputuskan".
- Akhirnya, konteks berantakan dan tim kembali ke chat atau meeting untuk klarifikasi.

### Intinya
- Dokumentasi formal yang tebal membuat dokumen berubah status dari "alat kolaborasi" menjadi "arsip pasif".
- Lebih baik sedikit informasi yang operasional dan bisa langsung dipakai, daripada banyak informasi yang cuma membuat orang bingung.

## Level Koneksi Konteks

Artikel "Context Anchoring" membedakan beberapa lapisan konteks yang berbeda:

- `Project-level` / priming document: konteks stabil proyek — tech stack, arsitektur umum, naming convention, pola integrasi. Ini adalah foundation yang jarang berubah dan dibagikan ke semua fitur dan sesi.
- `Feature-level` / feature document: konteks spesifik fitur — keputusan yang dibuat, alasan, constraint, alternatif yang ditolak, open questions, dan status implementasi. Ini bersifat dinamis dan diperbarui setiap sesi atau setiap kali keputusan penting diambil.
- `Session-level`: percakapan AI itu sendiri. Berguna untuk berpikir dan eksplorasi, tapi rapuh karena konteksnya hilang saat sesi ditutup. Itulah yang harus ditambatkan ke dokumen jika harus menjadi permanen.

Pada praktiknya:

- project-level membantu AI memahami "bagaimana proyek bekerja" sebelum sesi dimulai.
- feature-level menjelaskan "di mana fitur ini sekarang dan kenapa kita memilih jalur ini".
- session-level adalah tempat berpikir sementara; keputusan penting harus keluar dari sini dan masuk ke feature document.

Ini membantu menjelaskan mengapa dokumen yang efisien itu tidak hanya ringkas, tapi juga berada di level yang tepat. Kelebihan 5 halaman biasanya terjadi ketika dokumen mencoba menutupi semua level sekaligus — mulai dari latar belakang proyek sampai detail sesi — sehingga kehilangan fokus operasional.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 27.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 27
