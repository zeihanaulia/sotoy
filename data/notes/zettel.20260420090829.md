
> "One of the most common ways to modularize an information-rich program is to separate it into three broad layers: presentation (UI), domain logic (aka business logic), and data access."
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Paragraf 21 menyajikan presentation-domain-data layering sebagai pattern modularisasi klasik.
- Meski basic, Fowler menempatkannya di tengah guide modern untuk menunjukkan bahwa fondasi ini masih penting.
- Sebelum lompat ke decomposition fancy, pahami dulu pemisahan tanggung jawab yang paling fundamental.

Contoh tanggung jawab:
- Presentation: menangani rendering UI, validasi input pengguna, navigasi, dan state presentasi seperti dialog terbuka atau halaman aktif.
- Domain logic: menerapkan aturan bisnis, perhitungan keputusan, workflow, dan kondisi validasi yang tidak terkait langsung dengan tampilan.
- Data access: berkomunikasi dengan database atau service eksternal, memetakan model persistensi, dan mengelola query atau persisten data.

Implikasi:

- Layering bukan kuno; ia adalah baseline agar perubahan lokal tetap lokal.
- Dengan layering yang jelas, tim bisa memodifikasi UI, domain, atau data access tanpa efek samping besar.
- Arsitektur modern seharusnya dibangun di atas prinsip-prinsip sederhana ini, bukan sebaliknya.

Hubungan:

- [[zettel.literature.software-architecture-guide]] — ringkasan halaman Software Architecture Guide
- [[zettel.20260420090327]] — GUI Architectures: pattern harus diikuti prinsip, bukan label familiar
- [[zettel.20260420085349]] — keputusan arsitektural penting bergantung pada skala sistem
- [[zettel.20260420061530]] — Architecture adalah seni memilah keputusan penting
