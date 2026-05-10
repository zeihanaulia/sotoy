---
id: zettel.20260510123819
title: "SaaS architecture is business-shaped architecture"
desc: "SaaS technical design must align dengan tujuan ekonomi dan operasi, bukan hanya praktik teknis atau deployment environment."
updated: 1778384559597
created: 1778384559597
tags:
  - zettel
  - saas
  - architecture
---

SaaS architecture bukan lapisan netral yang bisa dipilih secara terpisah dari model bisnis.

Karakteristik teknis yang dipilih di multi-tenant SaaS harus cocok dengan target ekonomi, operasi, dan tenant growth model. Pilihan seperti shared infrastructure, isolation level, dan deployment model adalah konsekuensi dari target bisnis yang berbeda.

Dengan kata lain, cloud, Kubernetes, atau serverless boleh jadi kendaraan untuk SaaS, tetapi mereka bukan definisi SaaS itu sendiri.

Referensi: [[book-summaries.building-multi-tenant-saas-architectures.preface]]
