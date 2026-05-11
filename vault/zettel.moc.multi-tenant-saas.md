---
id: zettel.moc.multi-tenant-saas
title: "MOC: Multi-Tenant SaaS Architecture"
desc: "Peta konten untuk ide dan zettel tentang multi-tenant SaaS, layanan operasional, dan boundary SaaS vs MSP."
updated: 1778454257024
created: 1778454257024
tags:
  - structure-note
  - moc
  - saas
---

## Tentang Topik Ini

Topik ini berfokus pada bagaimana multi-tenant SaaS seharusnya dilihat sebagai service model operasional terpadu, bukan hanya sekadar shared infrastructure. MOC ini mengumpulkan gagasan dari Tod Golding dan catatan Chapter 1 yang menyorot same-version discipline, boundary tenant, dan perbedaan antara SaaS, MSP, dan installed software.

## Entry Point — Mulai dari Sini

- [[book-summaries.building-multi-tenant-saas-architectures]] — ringkasan buku dan navigasi utama
- [[book-summaries.building-multi-tenant-saas-architectures.chapter-1]] — ringkasan Chapter 1
- [[book-summaries.building-multi-tenant-saas-architectures.chapter-1.close-reading]] — close reading paragraf-per-paragraf

---

## Klaster Gagasan

### Definisi SaaS dan Multi-Tenancy

- [[zettel.20260511124500]] — SaaS sebagai unified operational service model, bukan label infrastruktur
- [[zettel.20260511124502]] — SaaS adalah business and delivery model
- [[zettel.20260511124509]] — Multi-tenancy SaaS = unified tenant experience
- [[zettel.20260511124508]] — Classic multi-tenancy terlalu sempit
- [[zettel.20260511124514]] — SaaS berbeda dengan MSP

### Variasi dan Discipline

- [[zettel.20260511124503]] — Installed software pain adalah customer variation
- [[zettel.20260511124504]] — Pain terbesar model lama adalah hilangnya agility
- [[zettel.20260511124505]] — Unified model adalah jawaban terhadap fragmentasi
- [[zettel.20260511124506]] — Same-version sebagai litmus test SaaS
- [[zettel.20260511124511]] — Dedicated infra belum tentu anti-SaaS
- [[zettel.20260511124510]] — Shared and dedicated resources bisa berdampingan dalam SaaS

### Terminologi dan Mindset

- [[zettel.20260511124501]] — SaaS bukan technology-first mindset
- [[zettel.20260511124515]] — SaaS adalah service, bukan product saja
- [[zettel.20260511124512]] — Hindari istilah single-tenant dalam konteks SaaS
- [[zettel.20260511124513]] — Boundary SaaS ditentukan oleh apa tenant lihat
- [[zettel.20260511124507]] — Cross-cutting capabilities adalah fondasi SaaS

---

## Catatan Kaitan

- [[notes.saas.product-vs-service]] — contoh publik perbandingan product vs service
