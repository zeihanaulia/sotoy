
## Gagasan

Project context dan feature context bukan dua nama untuk hal yang sama.

## Mengapa Ini Penting

Ini penting supaya kita nggak salah pakai satu solusi untuk dua problem yang beda.

Project context memberi dasar stabil: bahasa proyek, stack, pola arsitektur, konvensi coding, dan aturan umum yang berlaku di seluruh repositori. Feature context memberi rekaman hidup dari keputusan spesifik, constraint, alternatif yang ditolak, dan titik terbuka untuk satu fitur atau saga kerja tertentu.

## Perbedaannya

- Project context:
  - stabil dan relatif jarang berubah
  - dibaca oleh banyak sesi/fitur
  - menjawab pertanyaan seperti “apa framework utama?”, “bagaimana middleware ditangani?”, “apakah proyek ini monorepo atau single repo?”
  - contoh: `Project uses Fastify, Postgres with JSONB, tenant-aware middleware, no GraphQL for v1`

- Feature context:
  - cepat berubah dan berkembang selama pengembangan
  - hanya relevan untuk satu fitur atau satu perjalanan keputusan
  - menjawab pertanyaan seperti “kenapa kita pilih BullMQ langsung?”, “apa yang sudah dipertimbangkan dan ditolak?”, “apa yang belum selesai?”
  - contoh: `Decision: BullMQ direct retry; Rejected: RetryQueue wrapper due to unnecessary indirection; Open question: rate limiting approach`

## Use case

- Project context use case:
  - memulai sesi AI baru untuk proyek lama.
  - memperkenalkan karakteristik umum proyek ke AI tanpa mengulang seluruh sejarah fitur.
  - mempercepat onboarding atau warm start: “project context says we use Fastify and tenant-aware auth, so start suggestions within that frame.”

- Feature context use case:
  - melanjutkan pengembangan feature yang berlangsung beberapa sesi.
  - menghindari AI mengulang ide yang sudah ditolak di sesi sebelumnya.
  - membuat sesi baru menjadi warm start dengan state: “feature doc says Email-only v1, no retry abstraction, keep existing auth middleware.”

## Kenapa jangan disamakan

Kalau kita mengandalkan satu dokumen saja, dua risiko muncul:
1. project context jadi terlalu kabur untuk keputusan mikro — AI tahu stack, tapi tidak tahu apakah `RetryQueue` sudah ditolak;
2. feature context jadi terlalu berat jika diperlakukan seperti dokumentasi proyek — terlalu banyak detail sesi, cepat usang, dan sulit dikelola.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 13.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 13
