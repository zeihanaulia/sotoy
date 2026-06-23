
## Gagasan

Warm start itu berarti nggak perlu rebuild konteks dari nol.

## Mengapa Ini Penting

Itu juga alasan kenapa dokumen harus dipelihara, tidak cukup hanya sekali dibuat.

## Apa Maksud Warm Start

Warm start berarti sesi baru bisa mulai dengan context yang sudah terbangun—bukan dari keadaan kosong. Jadi alih-alih harus:

1. menjelaskan lagi mengapa kita memilih `BullMQ`,
2. mengulang constraint `email-only v1`,
3. atau mengingat bahwa `RetryQueue` sudah ditolak,

kita cukup membuka feature document yang berisi keputusan, alasan, open question, dan status implementasi.

## Contoh Nyata

- Sesi pertama membuat keputusan desain untuk fitur notifikasi.
- Feature document dibuat sebagai working record.
- Sesi kedua dimulai beberapa hari setelahnya.
- Alih-alih menelusuri kembali seluruh chat, AI dan developer membaca dokumen itu.
- Hasilnya: sesi baru langsung tahu kondisi sekarang dan bisa melanjutkan pekerjaan tanpa membangun ulang semua asumsi.

## Kenapa Dokumen Perlu Dipelihara

Kalau feature document hanya dibuat sekali dan tidak di-update, warm start jadi bohong. Dokumen yang sudah usang bisa menyesatkan AI sama seperti chat history yang kadung panjang.

Warm start efektif hanya bila dokumen itu terus mencerminkan keputusan terbaru dan status aktual dari feature.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 29.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 29
