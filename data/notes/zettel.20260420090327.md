
> "Graphical User Interfaces provide a rich interaction between the user and a software system. Such richness is complex to manage, so it's important to contain that complexity with a thoughtful architecture... MVC is one of the most misunderstood architectural patterns around, and systems using that name display a range of important differences... The best way to think of MVC is as set of principles including the separation of presentation from domain logic and synchronizing presentation state through events."
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Paragraf 19 menyorot bahwa UI kompleks perlu arsitektur untuk menahan kompleksitas.
- Fowler mengingatkan bahwa nama pattern seperti MVC kadang menipu karena dipahami berbeda-beda oleh orang.
- Fokus yang benar adalah prinsip: pisahkan presentation dari domain logic, dan sinkronkan state dengan mekanisme yang jelas.

Implikasi:

- Jangan memilih arsitektur frontend hanya karena nama pattern terasa familiar.
- Pastikan tim memahami prinsip di balik pattern, bukan sekadar memakai label seperti MVC, MVP, MVVM, atau label frontend lain yang populer.
- Arsitektur GUI harus membuat interaksi kompleks mudah diikuti, bukan sekadar memindahkan kompleksitas ke layer lain.

Hubungan:

- [[zettel.literature.software-architecture-guide]] — ringkasan halaman Software Architecture Guide
- [[zettel.20260420090203]] — Micro Frontends menunjukkan arsitektur juga soal koordinasi tim
- [[zettel.20260420085349]] — keputusan arsitektural penting bergantung pada skala sistem
