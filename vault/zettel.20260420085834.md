---
id: zettel.20260420085834
title: "Microservices adalah trade-off machine, bukan arsitektur modern otomatis"
desc: "Fowler: microservices memberi deployment otonomi dan business capability, tetapi juga menambah kompleksitas distribusi, konsistensi, dan kebutuhan operasional."
tags:
  - permanent-note
  - software-architecture
  - architecture
  - microservices
  - martin-fowler
---

> "The microservice architectural pattern is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms... There is a bare minimum of centralized management of these services... While their advantages have made them very fashionable in the last few years, they come with the costs of increasing distribution, weakened consistency and require maturity in operational management."
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Paragraf 16 menjelaskan microservices sebagai sebuah aplikasi yang terdiri dari service kecil dengan proses terpisah, komunikasi ringan, dan fokus pada business capability.
- Fowler mengimbangi euforia dengan menyatakan biaya nyata: distribusi lebih tinggi, konsistensi melemah, dan kebutuhan operasional meningkat.
- Ini menegaskan microservices sebagai trade-off machine, bukan arsitektur yang otomatis lebih baik.

Implikasi:

- Otonomi deployment bukan gratis; dia menukar kompleksitas distribusi dan koordinasi antar layanan.
- Organizasi harus menilai kesiapan operasional sebelum memilih microservices sebagai strategi arsitektural.
- Microservices cocok ketika benefit otonomi dan kemampuan perubahan lebih besar daripada biaya integrasi, konsistensi, dan operasional.

Hubungan:

- [[zettel.literature.software-architecture-guide]] — ringkasan halaman Software Architecture Guide
- [[zettel.literature.application-boundary-social-construction]] — memahami batas aplikasi sebelum memilih microservices
- [[zettel.20260420085349]] — keputusan arsitektural penting bergantung pada skala sistem
- [[zettel.20260420085507]] — boundary aplikasi adalah konstruksi sosial, bukan fakta alam
