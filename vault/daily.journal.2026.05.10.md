---
id: daily.journal.2026.05.10
title: '2026-05-10'
desc: "Refleksi awal tentang struktur buku Building Multi-Tenant SaaS Architectures dan insight desain SaaS multi-tenant."
updated: 1778453920934
created: 1778383634485
tags:
  - daily
  - saas
  - multi-tenancy
  - architecture
---

## Baca hari ini: Building Multi-Tenant SaaS Architectures
Hari ini gue mulai baca overview dan daftar isi buku Tod Golding, *Building Multi-Tenant SaaS Architectures*. Dari apa yang gue tangkap, buku ini nggak sekadar bahas fitur SaaS atau login, tapi lebih ke cara pikir arsitek SaaS yang harus memikirkan banyak tenant sekaligus.

Yang paling nempel adalah struktur bukunya: dia bergerak dari mindset ke prinsip multi-tenant, lalu ke keputusan teknis, dan akhirnya ke operasi dan strategi. Pada akhirnya, gambarnya bukan sekadar "shared infrastructure", tapi "single product, many customers, controlled variation." Itu yang bikin dia terasa layak dibaca sebagai peta arsitektur, bukan cuma kumpulan pattern.

## Insight utama
- Tenant identity resolution adalah lapisan paling awal dan paling krusial. Kalau platform nggak tahu request ini milik tenant siapa, semua hal setelahnya bisa rusak.
- Data partitioning, isolation, dan service design bukan masalah terpisah. Mereka saling mengunci.
- Deployment model (Kubernetes vs serverless) datang belakangan. Prinsipnya dulu, toolingnya belakangan.
- Operasional tenant-aware sering lebih sulit daripada desain awal.
- Tiering bukan cuma soal harga. Tiering bisa ngefek ke model isolation, fitur, dan deployment.

## Rencana lanjut
Lanjut ke Chapter 1: *The SaaS Mindset* untuk ngebangun fondasi konteks. Yang gue pengin jelas dulu adalah: apa yang lo anggap sebagai unit masalah di SaaS, dan bagaimana itu memengaruhi pilihan desain di layer berikutnya.

Kalau lo butuh roadmap baca lanjutan per chapter, ada catatan tambahan yang bikin Golding jadi hub dan buku lain jadi zoom lens: [[notes.saas.multi-tenant-saas-reading-roadmap]].

Kalau lo mau masuk ke Preface dulu, gue sudah ringkas kontrak intelektualnya di: [[book-summaries.building-multi-tenant-saas-architectures.preface]].

Kalau mau lanjut langsung ke ringkasan Chapter 1, ada di: [[book-summaries.building-multi-tenant-saas-architectures.chapter-1]].

Link catatan: [[book-summaries.building-multi-tenant-saas-architectures]]
