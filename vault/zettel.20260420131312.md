---
id: zettel.20260420131312
title: "AI memory tools sekarang kebanyakan project-level, bukan feature-level"
desc: "Persistent memory AI sekarang cenderung ingat proyek, bukan keputusan fitur spesifik."
tags:
  - zettel
  - ai-collaboration
  - knowledge-management
  - context-anchoring
---

## Gagasan

Banyak AI coding assistant menawarkan persistent memory, tetapi itu biasanya di level proyek: stack, pola, dan konvensi umum.

AI memory tools seperti Claude project memory, Cursor rules files, dan Copilot workspace indexing cenderung mengingat konteks yang stabil untuk seluruh proyek. Mereka bisa mengingat bahwa proyek menggunakan Fastify, bahwa tim punya style guide tertentu, atau bahwa API ditulis dengan GraphQL. Mereka kurang baik mengingat konteks fitur spesifik, seperti bahwa sesi kemarin menolak abstraksi `RetryQueue` karena overhead dan koordinasi tenant.

## Level Koneksi Konteks

Artikel "Context Anchoring" membedakan beberapa level konteks yang berbeda:

- `Project-level` / priming document: konteks stabil proyek. Contoh: tech stack, arsitektur umum, konvensi naming, standar integrasi, dan pola desain yang berlaku. Ini jarang berubah, bisa di-update kuartalan atau setiap perubahan arsitektur besar.
- `Feature-level` / feature document: konteks fitur spesifik. Contoh: keputusan apa yang diambil, alasan di baliknya, constraint yang menahan pilihan, alternatif yang ditolak, pertanyaan terbuka, dan status implementasi. Ini berubah cepat, bisa diperbarui setiap sesi atau setiap keputusan penting.
- `Session-level`: percakapan AI atau chat history. Ini medium berpikir sementara, bukan tempat penyimpanan keputusan durabel. Jika konteks penting hanya ada di sini, maka menutup sesi akan membuat orang cemas karena kehilangan reasoning.
- `Code-level`: juga penting, tapi hanya outcome. Kode memberi tahu apa yang sudah dibangun, bukan mengapa atau apa yang sempat dipertimbangkan.

## Mengapa Ini Penting

Kehilangan konteks fitur bukan sekadar kehilangan fakta. Ini adalah kehilangan reasoning yang bikin keputusan relevan.

Project-level memory membantu AI bermakna dalam konteks proyek, tetapi tidak bisa menggantikan feature-level memory ketika tim bekerja pada keputusan spesifik. Tanpa konteks fitur, AI mungkin masih tahu "pakai PostgreSQL", tapi lupa bahwa alasan utamanya adalah dukungan JSONB, pengalaman operasional, dan multi-tenancy.

## Contoh

- Project-level: AI ingat bahwa proyek menggunakan Fastify dan bahwa tim lebih suka functional services.
- Feature-level: AI perlu tahu bahwa fitur ini harus memakai BullMQ langsung untuk retry, bukan wrapper, karena wrapper menambah kompleksitas dan delay.
- Session-level: diskusi chat yang berakhir setelah 40 menit kerja; jika konteks penting tidak di-eksternalisasi, maka sesi baru harus mengulang ulang.
- Code-level: repo bisa menunjukkan bahwa ada implementasi retry, tapi tidak menunjukkan bahwa `RetryQueue` ditolak karena cross-tenant risk.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 2.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 2
