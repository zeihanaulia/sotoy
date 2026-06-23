
## Gagasan

Priming document itu buat ingat aturan main proyek, bukan keputusan fitur lokal.

## Apa itu Priming Document

Priming document adalah dokumen yang menjelaskan konteks proyek yang relatif stabil dan berlaku di banyak fitur. Ini bukan daftar keputusan sesi, melainkan fondasi bersama yang membantu AI dan manusia memahami cara kerja proyek secara keseluruhan.

Contoh isinya:
- stack utama: Fastify, Postgres, Redis
- pola arsitektur: microservice + event-driven
- konvensi API: snake_case di database, camelCase di klien
- batasan umum: hanya email di v1, tidak pakai GraphQL
- prinsip tim: hindari wrapper abstraksi yang tidak perlu

## Mengapa Ini Penting

Kalau salah ngejelasin peran ini, kita bisa salah taruh semua konteks di satu dokumen.

Priming document harus stabil dan reusable. Kalau kita pakai priming document untuk semua keputusan fitur lokal, dokumen ini akan cepat usang, penuh detail sesi, dan jadi sulit dikelola. Sebaliknya, kalau kita menaruh aturan proyek di feature doc, maka aturan itu tidak dibagikan secara konsisten ke semua sesi.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 14.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 14
