
> "Serverless architectures are application designs that incorporate third-party 'Backend as a Service' (BaaS) services, and/or that include custom code run in managed, ephemeral containers on a 'Functions as a Service' (FaaS) platform... Serverless architectures may benefit from significantly reduced operational cost, complexity, and engineering lead time, at a cost of increased reliance on vendor dependencies and comparatively immature supporting services."
>
> Sumber: https://martinfowler.com/architecture/

Catatan gue:

- Paragraf 20 ringkas serverless sebagai pengurangan kebutuhan server tradisional via BaaS atau FaaS.
- Benefit serverless: biaya operasional turun, kompleksitas berkurang, engineering lead time lebih cepat.
- Biaya serverless: ketergantungan vendor meningkat dan layanan pendukung bisa belum matang.

Implikasi:

- Setiap simplifikasi di satu sisi biasanya memindahkan kompleksitas ke sisi lain.
- Serverless mengurangi beberapa beban operasional, tetapi menambah ketergantungan platform dan risiko vendor lock-in.
- Evaluasi serverless harus memperhitungkan kesiapan ekosistem dan biaya jangka panjang terhadap ketergantungan.

Hubungan:

- [[zettel.literature.software-architecture-guide]] — ringkasan halaman Software Architecture Guide
- [[zettel.20260420085834]] — microservices adalah trade-off machine, bukan arsitektur modern otomatis
- [[zettel.20260420085349]] — keputusan arsitektural penting bergantung pada skala sistem
- [[zettel.20260420085714]] — aplikasi tetap ada karena boundary adalah unit sosial dan ekonomi
