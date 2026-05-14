---
id: notes.agentic-coding.what-is-code
title: "What Is Code? — code sebagai vocabulary dan model konsep"
desc: "Analisis artikel Unmesh Joshi tentang code sebagai instruksi mesin dan model konseptual yang dibaca manusia, tim, dan LLM."
updated: 1778775198969
created: 1778774761762
tags:
  - notes
  - ai
  - agentic-coding
  - vocabulary
  - cognitive-debt
---

## Apa yang gue tangkap dari "What Is Code?"

Gue baca artikel Unmesh Joshi di Martin Fowler: https://martinfowler.com/articles/what-is-code.html. Dia ngajak gue mikir ulang apa makna code di era LLM.

Unmesh pakai definisi code dua lapis:

1. code sebagai instruksi mesin,
2. code sebagai model konseptual domain.

### Dua aspek utama code

**Pertama, code sebagai instruksi mesin.**

Ini jawaban untuk "mesin harus ngapain". Code memberi tahu komputer apa yang harus dilakukan: menghitung, menyimpan data, memanggil API, mengubah status, mengirim response. Kalau instruksinya valid, program bisa jalan. Di era LLM, bagian ini makin dikomoditisasi.

**Kedua, code sebagai model konseptual domain.**

Ini jawaban untuk "sistem ini memahami dunia seperti apa". Code tidak sekadar menyimpan logika. Dia juga membangun vocabulary dan boundary: `Customer`, `Cart`, `Order`, `Payment`, `Shipment`, `Refund`, `Inventory`. Tidak sekadar nama bagus; setiap konsep membawa makna dan aturan lokal.

Contoh konkret: `Cart` bukan `Order`, `PaymentAuthorized` bukan `PaymentCaptured`, `Shipment` bukan `Delivery`.

Kalau kita cuma fokus ke lapis pertama, LLM sudah bisa bantu banyak. Syntax, boilerplate, endpoint, dan adapter bisa dihasilkan cepat. Tapi lapis kedua itulah yang paling menentukan apakah codebase masih bisa dipahami, dipelihara, dan dikembangkan.

## Kenapa vocabulary codebase penting

Artikel ini menekankan: codebase yang baik adalah representasi vocabulary tertentu.

Vocabulary/domain language di sini bukan sekadar nama variabel enak dibaca. Ini adalah kumpulan istilah yang dipakai codebase untuk memodelkan domain.

Kata seperti `Order`, `Invoice`, `Settlement`, `Refund`, `Catalog`, `SKU`, `Customer`, `Repository`, `TransactionLog`, `Policy`, `Workflow` membawa makna, aturan, boundary, dan ekspektasi perilaku.

Vocabulary penting karena codebase bukan cuma kumpulan instruksi. Codebase adalah bahasa bersama.

Kalau bahasanya jelas, manusia dan LLM bisa bekerja di atas model yang sama. Kalau bahasanya kacau, semua orang menebak — termasuk LLM.

Contoh e-commerce yang nempel:

- `Cart` adalah niat membeli yang belum final.
- `Order` adalah komitmen pembelian.
- `Invoice` adalah dokumen/tagihan finansial.

Kalau codebase pake semua itu sebagai `data`, `item`, `record`, atau `transaction`, domain-nya jadi kabur. Mesin mungkin tetap jalan, tapi manusia susah memahami apa yang sebenarnya terjadi.

Vocabulary juga membuat makna domain jadi eksplisit.

`PaymentCaptured` langsung memberitahu: uang sudah benar-benar ditangkap/settled.
`PaymentAuthorized` memberitahu: uang belum tentu sudah masuk.

Bandingkan dengan `payment_status = "success"`. "Success" itu apa? Authorized? Captured? Settled? Verified? Reconciled?

Vocabulary juga menjaga boundary.

`Customer` di billing bisa berarti legal entity yang menerima invoice.
`Customer` di support bisa berarti orang yang membuka tiket.
`Customer` di e-commerce bisa berarti buyer account.

Kalau semua dipaksa pakai satu model `Customer`, codebase bisa jadi kacau. Domain language yang baik membantu kita sadar: ini harus dipisah bounded context-nya.

Vocabulary menentukan kualitas abstraction. Contoh bagus:

- `RefundPolicy` menunjukkan ada aturan refund yang bisa berubah dan diuji.
- `RefundRequest`, `RefundApproval`, `RefundSettlement` menunjukkan lifecycle refund yang eksplisit.

Kalau hanya `processRefund()`, semua aturan bisa numpuk di satu tempat.

Tapi hati-hati: terlalu banyak vocabulary palsu juga berbahaya. LLM kerap bikin istilah seperti `Manager`, `Handler`, `Factory`, `Orchestrator`, `Coordinator` tanpa domain yang jelas. Kelihatan rapi, tapi maknanya kosong.

Di sinilah cognitive debt muncul: code punya banyak istilah, tapi tim tidak benar-benar paham artinya.

Jadi vocabulary yang baik harus memenuhi dua syarat:

1. mencerminkan domain nyata.
2. dipahami bersama oleh tim.

Kalau cuma terdengar keren tapi tidak dipahami, itu bukan domain language. Itu kabut.

Contoh yang nempel di gue:

- `TransactionLog` biasanya diasosiasikan dengan append-only, ordering, durability, replay.
- `Cache` biasanya berarti data bisa stale dan harus diinvalidate.
- `Repository` biasanya berarti abstraction terhadap persistence.

Jadi vocabulary bukan kosmetik. Itu adalah medium diskusi antara manusia dan mesin.

## Bounded context dan arti lokal kata

Unmesh kasih pelajaran bahwa satu kata bisa beda arti di konteks yang berbeda.

`Customer` di e-commerce beda dengan `Customer` di CRM atau di support system. Karena itu bounded context penting: batasan di mana vocabulary tertentu valid.

Kalau codebase tidak punya bounded context yang jelas, LLM akan mengandalkan asosiasi umum dari internet. Hasilnya bisa terlihat wajar, tapi tidak cocok dengan model lokal perusahaan.

## Programming language sebagai alat berpikir

Artikelnya juga nyanggah klaim "natural language aja cukup".

Programming language bukan sekadar alat untuk merekam desain yang sudah jadi. Bahasa pemrograman ikut membentuk desain itu.

- Go mendorong pola concurrency dan channel.
- Java mendorong object model dan interface.
- Rust memaksa ownership dan boundary safety.
- FP mendorong komposisi dan immutability.

Jadi kalau kita cuma pakai LLM untuk generate code tanpa ikut berpikir lewat bahasa pemrograman, kita melewatkan proses discovery yang penting.

## Cognitive debt di era LLM

Ini yang paling nyeremin.

Unmesh bilang code bisa compile dan tests bisa pass, tapi jika tim tidak paham model konseptual di belakang struktur itu, codebase menambah vocabulary tanpa shared understanding.

LLM bisa mempercepat pemasukan vocabulary baru: `Service`, `Repository`, `Factory`, `EventBus`, `CommandHandler`, `ConsensusModule`. Semua terdengar keren. Tapi apakah tim paham kenapa abstraction itu ada? Apakah namanya sesuai kebutuhan lokal? Apakah boundary-nya benar?

Kalau tidak, hasilnya bukan technical debt biasa. Itu menjadi cognitive debt.

## Kenapa codebase yang bagus adalah context dan harness untuk LLM

Unmesh menempatkan codebase sebagai konteks utama untuk LLM. Bukan hanya prompt, tetapi struktur code sendiri:

- nama-nama yang konsisten,
- abstraction yang jelas,
- tests yang mendefinisikan behavior,
- types yang membatasi kesalahan,
- invariant yang eksplisit,
- boundary yang bersih.

Itu adalah harness dan signal permanen buat LLM.

Kalau codebase kacau, prompt apa pun cuma menambal sebentar.

## Hubungan ke artikel lain

Artikel ini nyambung ke apa yang gue baca sebelumnya:

- [[notes.prompt-engineering.interrogatory-llm]] — Fowler: LLM sebagai pewawancara konteks.
- [[notes.prompt-engineering.harper-llm-codegen-workflow]] — Harper: konteks itu dijadikan spec, plan, dan eksekusi bertahap.
- [[notes.agentic-coding.is-a-trap]] — agentic coding bisa memicu cognitive debt kalau kita melewatkan proses berpikir sendiri.

Dari ketiganya, gue nangkep rangkaian utama:

1. gali konteks,
2. bentuk spec dan plan,
3. eksekusi incremental,
4. jaga vocabulary dan model konseptual.

Kalau berhenti di "kode jalan", elo belum sampai ke inti engineering.

## Pertanyaan yang gue bawa pulang

- Apakah vocabulary baru yang LLM tambahkan di codebase benar-benar sesuai bounded context?
- Apakah tim paham model konseptual di balik abstraction itu?
- Apakah code ini memperjelas domain atau cuma menambah jargon?
- Apakah kita membuat codebase sebagai medium komunikasi, bukan sekadar container instruksi mesin?
