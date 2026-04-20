---
id: zettel.20260420092009
title: "Sentralisasi total di EA melambatkan keputusan dan kehilangan konteks lokal"
desc: "Fowler: central architecture group yang harus menyetujui semua keputusan memperlambat delivery dan tidak bisa memahami isu di seluruh portofolio sistem."
tags:
  - permanent-note
  - software-architecture
  - enterprise-architecture
  - governance
  - coordination
  - martin-fowler
---

> At one extreme is a central architecture group that must approve all architectural decision for every software system in the enterprise. Such groups slow down decision making and cannot truly understand the issues across such a wide portfolio of systems, leading to poor decision-making.
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Ekstrem pertama yang dibahas Fowler adalah kelompok arsitektur pusat yang harus menyetujui semua keputusan.
- Model ini melambatkan pengambilan keputusan dan kehilangan konteks lokal yang penting.
- Kritiknya langsung ke governance yang jauh dari realitas delivery.

Implikasi:

- Sentralisasi total gagal karena informasi lokal terlalu kaya untuk diringkas ke meja approval pusat.
- Central architecture group berisiko menjadi bottleneck dan membuat keputusan buruk karena jarak dari tim pelaksana.
- Enterprise architecture harus mempertimbangkan mekanisme lain selain approval pusat untuk menjaga kecepatan dan pemahaman domain.

Hubungan:

- [[zettel.literature.software-architecture-guide]]
- [[zettel.20260420091825]] — evaluasi biaya koordinasi pusat vs otonomi lokal
- [[zettel.literature.enterprise-architecture-coordination-cost]] — kritik terhadap sentralisasi total sebagai opsi koordinasi
- [[zettel.20260420091306]] — pergeseran fokus arsitektur aplikasi ke enterprise coordination
