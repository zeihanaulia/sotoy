---
id: zettel.20260511124511
title: "Dedicated infra belum tentu anti-SaaS"
desc: "Dedicated resource dapat tetap menjadi bagian dari SaaS selama pengelolaan tenant tetap terpusat dan versi tetap seragam."
updated: 1778453643251
created: 1778453643251
tags:
  - zettel
  - saas
  - architecture
---

Satu insight yang gue ambil: dedicated compute/storage tidak otomatis mengeluarkan sistem dari kategori SaaS. Selama tenant tetap on-boarded, deployed, managed, dan operated dengan cara yang sama, sistem itu tetap bisa masuk multi-tenant SaaS.
Ini bikin gue lebih hati-hati saat melihat label "single-tenant" pada arsitektur yang sebenarnya masih punya service plane bersama.

Referensi: [[book-summaries.building-multi-tenant-saas-architectures.chapter-1.close-reading]]
