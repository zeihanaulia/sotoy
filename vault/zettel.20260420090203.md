---
id: zettel.20260420090203
title: "Micro Frontends menunjukkan arsitektur juga soal koordinasi tim"
desc: "Fowler: memecah UI menjadi micro frontends bukan hanya soal pembagian teknis, tetapi soal memungkinkan banyak tim bergerak bersama dalam produk kompleks."
tags:
  - permanent-note
  - software-architecture
  - architecture
  - micro frontends
  - frontend
  - martin-fowler
---

> "Good frontend development is hard. Scaling frontend development so that many teams can work simultaneously on a large and complex product is even harder... This architecture can increase the effectiveness and efficiency of teams working on frontend code. As well as talking about the various benefits and costs, we'll cover some of the implementation options that are available..."
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Paragraf 18 memperluas decomposition ke frontend: bukan sekadar memecah UI, tetapi membuat banyak tim bisa bekerja bersama pada produk kompleks.
- Fowler menekankan bahwa pola utama sama: pecah monolith jadi bagian lebih kecil untuk efektivitas tim, tapi perhitungkan biaya dan option implementasi.
- Ini bukan soal trend frontend; ini soal arsitektur yang masuk akal secara koordinasi manusia.

Implikasi:

- Arsitektur frontend harus mempertimbangkan batas tim, ownership, dan cara kerja kolaboratif.
- Micro frontends bisa masuk akal bila tim dan produk memerlukan skalabilitas organisasi, bukan sekadar karena ingin memisah UI.
- Pemecahan teknis tanpa mempertimbangkan koordinasi manusia berisiko membuat state sharing, deployment, dan konsistensi jadi lebih sulit.

Hubungan:

- [[zettel.literature.software-architecture-guide]] — ringkasan halaman Software Architecture Guide
- [[zettel.20260420085349]] — keputusan arsitektural penting bergantung pada skala sistem
- [[zettel.20260420085507]] — boundary aplikasi adalah konstruksi sosial, bukan fakta alam
- [[zettel.20260420085834]] — microservices adalah trade-off machine, bukan arsitektur modern otomatis
