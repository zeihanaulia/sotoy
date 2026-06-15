---
id: zettel.20260511124513
title: "Boundary SaaS ditentukan oleh apa tenant lihat"
desc: "Dalam SaaS, boundary utama adalah experience surface yang dilihat tenant, bukan lokasi atau provider resource."
updated: 1778454323379
created: 1778454154375
tags:
  - zettel
  - saas
  - boundary
---

Gue dapat insight penting: SaaS tetap valid selama dependency eksternal tersembunyi dari tenant dan tetap dikelola lewat pengalaman terpusat.
Kalau tenant mulai sadar atau mengelola infrastruktur belakang layar, boundary SaaS mulai pecah. Jadi fokusnya harus ke 'apa yang terlihat tenant', bukan 'di mana resource itu berada.'

Referensi: [[book-summaries.building-multi-tenant-saas-architectures.chapter-1.close-reading]]
