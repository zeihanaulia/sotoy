
> Paragraf 22 memberi sinyal bahwa "application architecture" di halaman ini bukan cuma soal backend; dia meliputi decomposition, delivery, consistency, dan frontend structure.

Catatan gue:

- Distributed systems mengingatkan bahwa begitu data tersebar, isu sinkronisasi dan node yang tidak andal menjadi pusat perhatian.
- Feature toggles menunjukkan bahwa teknik delivery juga berdampak arsitektural karena mereka menambah kompleksitas operasi dan state.
- Modularizing React menegaskan bahwa layering dan UI patterns tetap relevan di stack modern, jadi frontend adalah bagian dari arsitektur aplikasi.

Implikasi:

- Arsitektur aplikasi bukan sekadar struktur backend; dia harus mempertimbangkan bagaimana sistem diberi nilai lewat delivery, bagaimana konsistensi dijaga, dan bagaimana frontend dipecah.
- Simplifikasi di satu area dapat memunculkan kompleksitas di area lain, misalnya pengelolaan state terdistribusi atau deployment pipeline.
- Tim arsitektur harus memikirkan koordinasi antar domain: data, delivery, dan frontend.

Hubungan:

- [[zettel.literature.software-architecture-guide]] — ringkasan halaman Software Architecture Guide
- [[zettel.20260420085834]] — microservices adalah trade-off machine, bukan arsitektur modern otomatis
- [[zettel.20260420090627]] — serverless mengurangi operasi tapi menambah ketergantungan platform
- [[zettel.20260420090203]] — micro frontends menunjukkan arsitektur juga soal koordinasi tim
