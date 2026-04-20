
> While application architecture concentrates on the architecture within some form of notional application boundary, enterprise architecture looks architecture across a large enterprise. Such an organization is usually too large to group all its software in any kind of cohesive grouping, thus requiring coordination across teams with many codebases, that have developed in isolation from each other, with funding and users that operate independently of each other.
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Ketika skala naik, masalah arsitektur bukan lagi sekadar "bagaimana menyusun kode".
- Masalahnya menjadi "bagaimana banyak sistem dan banyak tim bisa tetap bergerak tanpa saling menghambat".
- Enterprise architecture membutuhkan koordinasi lintas tim, banyak codebase yang berkembang isolasi, sumber pendanaan yang berbeda, dan grup pengguna yang terpisah.

Implikasi:

- Pendekatan yang efektif di level aplikasi tidak otomatis cocok di level enterprise.
- Enterprise architecture lebih dekat ke manajemen kompleksitas organisasi dan koordinasi daripada ke desain modular internal.
- Desain arsitektural di level enterprise harus menyadari biaya koordinasi dan peluang otonomi lokal.

Hubungan:

- [[zettel.literature.software-architecture-guide]]
- [[zettel.literature.enterprise-architecture-coordination-cost]] — mendukung pengertian bahwa EA adalah tentang koordinasi antar sistem dan tim
- [[zettel.20260420085349]] — skala sistem mengubah apa yang dianggap penting dalam arsitektur
