---
id: zettel.literature.application-boundary-social-construction
title: "Application boundary adalah konstruksi sosial"
desc: "Fowler: aplikasi bukan fakta alam, melainkan cara tim, bisnis, dan budget mengelompokkan sebuah unit kerja."
tags:
  - literature-note
  - software-architecture
  - application-architecture
  - martin-fowler
source: https://martinfowler.com/architecture/
---

## Klaim

Application architecture bergantung pada batasan aplikasi yang bersifat sosial: developer, pelanggan bisnis, dan pemegang anggaran melihat unit yang berbeda.

## Catatan

- Fowler menegaskan bahwa definisi "application" tidak jelas dan sering berbeda antar pemangku kepentingan.
- Dia menyebut aplikasi sebagai social construction yang bisa berarti:
  - satu body of code bagi developer
  - satu kelompok fungsi bagi business
  - satu budget bagi pemegang uang
- Ukuran aplikasi menurut Fowler paling berguna diukur dari jumlah orang yang terlibat.

## Implikasi

- Debat batas aplikasi sering gagal karena lawan bicara menggunakan unit analisis yang berbeda.
- Application architecture harus memperhitungkan faktor sosial, kegunaan, dan pembiayaan, bukan hanya teknis.
- Memahami batas aplikasi penting sebelum memilih pola seperti microservices atau monolith.

## Hubungan

- [[zettel.literature.software-architecture-guide]]
- [[zettel.literature.architecture-important-stuff]]
