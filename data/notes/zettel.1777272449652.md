
## Ide inti

Dalam aplikasi berbasis LLM, rasa responsif tidak hanya ditentukan oleh seberapa cepat jawaban selesai, tetapi juga oleh apakah user melihat sistem memberi umpan balik progres terus-menerus.

## Quote baseline

> The cool typing effect ... makes it feel responsive.

## Kenapa ini core

Quote ini penting karena dia menekankan perbedaan antara actual latency dan perceived latency. Typing effect tidak selalu membuat model lebih cepat, tetapi dia membuat user merasa sistem sedang aktif dan bergerak.

## Apa yang bikin ini penting

- Kata kunci di sini adalah "feel responsive" — bukan "is responsive." User experience dibentuk oleh bagaimana sistem berkomunikasi selama proses menunggu.
- Typing effect adalah progres indicator yang paling natural untuk interaksi teks/percakapan.
- Tanpa umpan balik seperti ini, waiting time terasa diam, lambat, dan rawan ditafsirkan sebagai error.
- Dengan tampilan responsif, model yang sama bisa terasa jauh lebih usable meski actual latency belum turun banyak.

## Implikasi

- Perceived responsiveness bisa sangat menentukan apakah aplikasi AI terasa usable.
- Progress feedback membuat user lebih sabar dan percaya bahwa request mereka sedang diproses.
- UI adalah bagian dari kualitas sistem AI, bukan sekadar lapisan tipis di atas model.
- Streaming harus dilihat sebagai arsitektur end-to-end: backend incremental, transport incremental, UI incremental.
- Typing effect efektif ketika actual latency masih dalam batas wajar; dia bukan pengganti performance engineering.

## Hubungan

- [[zettel.1777272449641]] — grounding dan kegunaan jawaban yang relevan
- [[zettel.1777272449652]] — streaming sebagai UX yang mengubah perceived latency
- [[zettel.1777272449645]] — inference time vs training time, karena ini adalah intervensi runtime
- [[zettel.1777272449651]] — local model sebagai medium belajar integrasi LLM

## Sumber

- Chapter 2
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
