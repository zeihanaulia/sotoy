---
id: zettel.moc.software-architecture
title: "MOC: Software Architecture"
desc: "Peta konten untuk Zettel dan catatan seputar software architecture, trade-off, dan decision log."
tags:
  - structure-note
  - moc
  - software-architecture
---

## Tentang Topik Ini

Software architecture adalah tentang keputusan yang mempertimbangkan trade-off antara kualitas, tim, dan bisnis. MOC ini menghubungkan gagasan tentang bagaimana arsitektur dicatat, dinilai, dan dipelihara.

## Entry Point — Mulai dari Sini

- [[zettel.20260420055738]] — Software architecture adalah jaringan keputusan trade-off, bukan sekadar diagram
- [[zettel.literature.architecture-decision-records]] — Martin Fowler tentang Architecture Decision Record
- [[zettel.literature.software-architecture-guide]] — Martin Fowler: Software Architecture Guide sebagai peta keputusan arsitektur

---

## Klaster Gagasan

### Keputusan Arsitektur

- [[zettel.20260420055413]] — ADR adalah decision log yang merekam alasan, bukan dokumentasi desain
- [[zettel.20260420055414]] — Satu keputusan per ADR menjaga batasan dan riwayat yang bersih
- [[zettel.20260420055415]] — ADR accepted harus disupersede, bukan diedit ulang
- [[zettel.20260420055619]] — ADR sehat memaksa maintainer mengubah perilaku, bukan sekadar menambah dokumen

### Trade-off dan dokumentasi

- [[notes.software-architechture.software-architechture-tradeoff]] — praktek trade-off dalam software architecture
- [[notes.software-architechture.C4]] — model C4 untuk dokumentasi arsitektur
- [[notes.microservice]] — catatan terkait desain layanan dan arsitektur terdistribusi

### Praktik dan standar

- [[zettel.literature.encoding-team-standards]] — executable AI instruction sebagai prasyarat konsistensi tim
- [[zettel.literature.building-a-second-brain]] — bagaimana jaringan gagasan membantu arsitektur diingat dan digunakan
- [[zettel.literature.architecture-important-stuff]] — arsitektur sebagai keputusan mahal bila salah
- [[zettel.literature.architecture-not-a-blueprint]] — arsitektur yang tidak terpisah dari programming
- [[zettel.literature.internal-quality-is-speed]] — internal quality sebagai kecepatan delivery
- [[zettel.literature.application-boundary-social-construction]] — aplikasi sebagai konstruksi sosial
- [[zettel.literature.enterprise-architecture-coordination-cost]] — enterprise architecture sebagai biaya koordinasi
- [[zettel.20260420060847]] — arsitektur adalah penentu biaya perubahan masa depan
- [[zettel.20260420060928]] — arsitektur bukan kasta; dia harus hidup bersama kode
- [[zettel.20260420061007]] — halaman ini adalah peta keputusan, bukan tutorial implementasi
- [[zettel.20260420061232]] — Fowler memulai definisi arsitektur dengan kritik terhadap ‘fundamental organization’
- [[zettel.20260420061259]] — arsitektur nyata adalah shared understanding expert developer
- [[zettel.20260420061356]] — arsitektur bukan sekadar keputusan awal proyek
- [[zettel.20260420085349]] — keputusan arsitektural penting bergantung pada skala sistem
- [[zettel.20260420091306]] — enterprise architecture bergeser ke koordinasi antar-pulau
- [[zettel.20260420085507]] — boundary aplikasi adalah konstruksi sosial, bukan fakta alam
- [[zettel.20260420085714]] — aplikasi tetap ada karena boundary adalah unit sosial dan ekonomi
- [[zettel.20260420085834]] — microservices adalah trade-off machine, bukan arsitektur modern otomatis
- [[zettel.20260420090203]] — micro frontends menunjukkan arsitektur juga soal koordinasi tim
- [[zettel.20260420090627]] — serverless mengurangi operasi tapi menambah ketergantungan platform
- [[zettel.20260420091101]] — aplikasi juga arsitektur delivery, consistency, dan frontend structure
- [[zettel.20260420091825]] — enterprise architecture adalah soal apakah biaya koordinasi pusat layak
- [[zettel.20260420092459]] — otonomi tanpa koordinasi di EA berubah jadi fragmentasi mahal
- [[zettel.20260420092652]] — fowler condong ke desentralisasi tetapi tetap waspada terhadap chaos
- [[zettel.20260420092900]] — enterprise architects lebih efektif ketika ikut masuk ke tim pengembangan
- [[zettel.20260420092901]] — enterprise architecture fowler: organisasi, funding, komunikasi, dan learning system
- [[zettel.20260420092009]] — sentralisasi total di EA melambatkan keputusan dan kehilangan konteks lokal
- [[zettel.20260420090327]] — gui architectures: pattern harus diikuti prinsip, bukan label familiar
- [[zettel.20260420090829]] — presentation domain data layering adalah baseline, bukan arsitektur kuno
- [[zettel.20260420090017]] — modernisasi yang matang adalah displacement bertahap, bukan rewrite besar
- [[zettel.20260420061530]] — architecture adalah seni memilah keputusan penting
- [[zettel.20260420062120]] — cruft adalah utang kebingungan yang memperlambat perubahan
- [[zettel.20260420062331]] — internal quality adalah infrastruktur kecepatan delivery
- [[zettel.20260420085220]] — shortcut kualitas adalah pinjaman dari masa depan

---

## Sumber Utama

- [[zettel.literature.architecture-decision-records]]
- [[notes.software-architechture.software-architechture-tradeoff]]
- [[notes.software-architechture.C4]]

## Pertanyaan Terbuka

- Kapan sebuah keputusan layak diperlakukan sebagai "arsitektur" dan bukan hanya "implementasi"?
- Bagaimana menjaga dokumentasi arsitektur tetap hidup bersama review dan PR?
- Apa mekanisme paling efektif untuk menghubungkan ADR dengan diagram dan kode?

## MOC Terkait

- [[zettel.moc.personal-knowledge-management]]
