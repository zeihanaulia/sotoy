---
id: zettel.literature.enterprise-architecture-coordination-cost
title: "Enterprise architecture adalah soal biaya koordinasi, bukan kontrol total"
desc: "Fowler: EA sehat menyeimbangkan keputusan lokal dan mekanisme koordinasi pusat untuk mencegah fragmentasi atau bottleneck."
tags:
  - literature-note
  - software-architecture
  - enterprise-architecture
  - martin-fowler
source: https://martinfowler.com/architecture/
---

## Klaim

Enterprise architecture berfokus pada organisasi besar yang membutuhkan koordinasi antar tim dan sistem, bukan hanya desain teknis satu aplikasi.

## Catatan

- Di level enterprise, masalah utama adalah banyak tim, banyak codebase, dan banyak kepentingan.
- Koordinasi pusat memiliki biaya; pertanyaannya adalah apa yang layak diatur secara bersama dan apa yang bisa dibiarkan lokal.
- Dua ekstrema yang harus dihindari:
  - sentralisasi total yang melambatkan keputusan dan kehilangan konteks lokal
  - nol koordinasi yang menyebabkan duplikasi, integrasi buruk, dan hilangnya pembelajaran bersama

## Implikasi

- EA terbaik bukan policing, tetapi mekanisme untuk interoperabilitas, pembelajaran, dan arah bersama.
- Enterprise architect idealnya dekat dengan tim delivery, bukan terisolasi di menara kontrol.
- Desentralisasi dengan kontrol yang tepat lebih kuat daripada kontrol ketat tanpa konteks.

## Hubungan

- [[zettel.literature.software-architecture-guide]]
- [[zettel.literature.architecture-not-a-blueprint]]
