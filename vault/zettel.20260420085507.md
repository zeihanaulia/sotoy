---
id: zettel.20260420085507
title: "Boundary aplikasi adalah konstruksi sosial, bukan fakta alam"
desc: "Fowler: aplikasi didefinisikan oleh cara orang mengelompokkan kode, fungsi, dan biaya, sehingga boundary aplikasinya kabur."
tags:
  - permanent-note
  - software-architecture
  - architecture
  - application-architecture
  - martin-fowler
---

> "The first problem with defining application architecture is that there's no clear definition of what an application is. My view is that applications are a social construction: a body of code that's seen by developers as a single unit, a group of functionality that business customers see as a single unit, and an initiative that those with the money see as a single budget."
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Fowler menempatkan masalah application architecture pertama kali pada ketidakjelasan definisi "application".
- Aplikasi bukan fakta alam; dia muncul dari cara developer, bisnis, dan pemegang anggaran mengelompokkan sebuah unit.
- Karena definisi unitnya berbeda, debat batas sistem sering macet meski orang merasa membahas hal yang sama.

Implikasi:

- Diskusi arsitektur harus diawali dengan klarifikasi konteks: apa yang dianggap sebagai satu aplikasi oleh setiap pihak.
- Boundary aplikasi perlu dilihat sebagai hasil konsensus sosial, bukan kriteria teknis tunggal.
- Pilihan arsitektural seperti microservices atau monolith harus mempertimbangkan perspektif pengelompokan kerja, fungsi, dan biaya.

Hubungan:

- [[zettel.literature.application-boundary-social-construction]] — literature note tentang ide aplikasi sebagai social construction
- [[zettel.literature.software-architecture-guide]] — ringkasan halaman Software Architecture Guide
- [[zettel.20260420085349]] — keputusan arsitektural penting bergantung pada skala sistem
