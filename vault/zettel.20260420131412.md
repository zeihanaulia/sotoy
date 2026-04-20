---
id: zettel.20260420131412
title: "Feature document adalah memori dinamis level pekerjaan yang sedang berlangsung"
desc: "Feature document menyimpan keputusan dan status yang berubah cepat."
tags:
  - zettel
  - ai-collaboration
  - knowledge-management
  - context-anchoring
---

## Gagasan

Feature document itu tempat kerja yang nyimpen konteks fitur selama proses berlangsung.

> Catatan ini dimaksudkan sebagai anchor permanen untuk konsep feature document dalam konteks AI-collaboration dan context anchoring.

## Apa itu Feature Document

Feature document adalah dokumen hidup untuk satu fitur atau pekerjaan yang sedang berjalan. Ia mencatat keputusan, alasan di baliknya, alternatif yang ditolak, batasan yang berlaku, dan apa yang masih terbuka. Tujuannya bukan membuat spesifikasi final, tetapi menjaga konteks sesi agar dapat diakses ulang di sesi berikutnya.

Contoh isi feature document:
- Decision: gunakan BullMQ langsung untuk retry handling
- Why: lebih sederhana, lebih mudah dipahami, cukup untuk v1
- Rejected: `RetryQueue` wrapper karena menambah indirection tanpa benefit nyata
- Constraints: all queries must include `tenantId`, email-only v1, jangan ubah auth middleware
- Open questions: rate limiting strategy, monitoring alert thresholds
- State: design approved, handler + renderer implementasi selesai, delivery tracker belum

## Contoh Use Case

Sesi pertama membuat keputusan desain untuk notifikasi v1. Sesi kedua dimulai dengan feature document, sehingga AI tidak lagi menebak apakah `RetryQueue` sudah dipertimbangkan atau apakah feature masih menerima SMS. Sesi baru bisa langsung membaca konteks: keputusan sudah dibuat, alasan sudah tercatat, dan hanya menyelesaikan item yang belum tuntas.

## Contoh Implementasi Nyata

Martin Fowler menulis kasus nyata di artikel "Context Anchoring" tentang fitur Notification Service v1. Di sana, dokumen fitur yang berisi keputusan `BullMQ langsung`, `Email-only v1`, dan `state` implementasi disimpan sebagai working record sepanjang beberapa sesi. Dokumen itu singkat—sekitar 50 baris—dan diperbarui di akhir setiap momen keputusan penting.

Praktik ini setara dengan:
- menaruh file live di repo, misalnya `docs/feature-context/notification-service-v1.md`
- memperbarui section `Decisions`, `Constraints`, `Open Questions`, dan `State`
- menggunakan dokumen itu sebagai sumber otoritatif saat memulai sesi AI baru

Ini bukan PRD final. Ini lebih mirip ADR yang hidup, tapi fokusnya pada fitur berjalan dan konteks sesi.

## Artikel Tambahan dan Referensi

- `Martin Fowler, "Context Anchoring"` — real case feature document dan alasan mengapa konteks harus keluar dari chat
  https://martinfowler.com/articles/reduce-friction-ai/context-anchoring.html
- `Martin Fowler, "Knowledge Priming"` — pola praktis untuk membangun proyek context sebagai infrastructure
  https://martinfowler.com/articles/reduce-friction-ai/knowledge-priming.html
- `Michael Nygard, "Documenting Architecture Decisions"` — akar sejarah ADR dan kenapa keputusan perlu dicatat singkat
  https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions.html
- `ADR.org` — template dan tooling untuk decision record yang bisa diadaptasi jadi feature document
  https://adr.github.io/
- `Open Practice Library, Architectural Decision Records (ADR)` — praktik umum untuk membuat keputusan arsitektur yang mudah dibaca dan dikelola
  https://openpracticelibrary.com/practice/architectural-decision-records-adr/

## Apakah Ini Sama dengan PRD/FSD/TSD/RFC?

Tidak persis.

- PRD (Product Requirements Document) fokus pada "apa" dan "kenapa" dari perspektif produk. Ia biasanya lebih luas, mencakup kebutuhan pengguna, value proposition, dan batasan bisnis.
- FSD (Functional Specification Document) sering menjelaskan "bagaimana" fungsi akan bekerja dari sudut pandang fungsional, termasuk alur pengguna, input/output, dan behavior.
- TSD (Technical Specification Document) biasanya mendetailkan implementasi teknis: arsitektur, API, data flow, dan komponen.
- RFC (Request for Comments) adalah proposal formal untuk perubahan atau penambahan, biasanya dipakai untuk diskusi dan persetujuan sebelum implementasi.

Feature document berbeda karena:
- sifatnya lebih ringan dan iteratif;
- ditulis selama proses, bukan sebagai dokumen akhir;
- fokusnya pada konteks keputusan dan keadaan saat ini, bukan proposal formal;
- ia menjadi external memory untuk sesi AI dan tim, bukan hanya dokumentasi internal.

## Mengapa Ini Penting

Ini bikin productivity lebih aman, karena konteks fitur nggak lagi terjebak di chat.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 15.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 15
