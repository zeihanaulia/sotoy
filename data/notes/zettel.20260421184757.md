
## Pertanyaan yang dibuka

1. Mengapa "try again" sering tidak cukup untuk output AI yang terlihat cukup baik?
2. Bagaimana memilih lensa berpikir tertentu mengubah kualitas reconsideration model?
3. Apa perbedaan antara kritik reviewer dan metode rencana ulang model?

## Klaim utama

Advanced Elicitation bukan sekadar second pass. Ini adalah second pass dengan epistemic lens yang dipilih untuk memaksa model memikirkan ulang outputnya secara terstruktur.

Alih-alih meminta model "improve this" secara kabur, BMAD memaksa model menjalankan metode berpikir tertentu seperti pre-mortem, first principles, inversion, stakeholder mapping, atau socratic questioning.

## Penjelasan

Dalam BMAD, proses Advanced Elicitation terdiri dari tiga komponen:

* model menghasilkan output awal,
* manusia memilih metode berpikir yang relevan,
* model menerapkan metode itu pada outputnya sendiri,
* manusia lalu memutuskan apakah hasil kedua lebih baik.

Jenis metode yang disebutkan termasuk:

* pre-mortem analysis untuk melihat kegagalan potensial,
* first principles thinking untuk menggali asumsi dasar,
* inversion untuk mencari jalur gagalnya,
* red team vs blue team untuk menyerang dan membela argumen,
* socratic questioning untuk menantang klaim,
* stakeholder mapping untuk melihat berbagai perspektif,
* constraint removal untuk melepas asumsi arbitrer.

## Built-in Methods

* [[zettel.20260421184801]] — Pre-mortem analysis: asumsi gagal dulu supaya risiko tersembunyi muncul.
* [[zettel.20260421184812]] — First principles thinking: uji asumsi dasar dan hindari solusi templated.
* [[zettel.20260421184823]] — Inversion: temukan jalur gagal untuk memperjelas risiko.
* [[zettel.20260421184834]] — Red team vs blue team: serang dan bela argumen untuk menguji ketahanan.
* [[zettel.20260421184845]] — Socratic questioning: tantang klaim dan buat bukti asumsi eksplisit.
* [[zettel.20260421184856]] — Stakeholder mapping: nilai artefak dari banyak perspektif.
* [[zettel.20260421184907]] — Constraint removal: cek apakah batasan itu nyata atau sekadar asumsi.

Setiap metode adalah lensa berpikir tersendiri; pilih yang paling pas untuk objek yang sedang direconsider.

## Implikasi

* Advanced Elicitation paling berguna ketika output awal terlihat masuk akal tetapi masih dapat menipu.
* Ini berguna untuk artefak high-stakes: spec, plan, architecture, dan draft review.
* Metode yang dipilih harus cocok dengan jenis artefak; tidak ada satu cara yang benar untuk semua.
* Hasil rerun tetap harus dievaluasi manusia; pass kedua adalah alternatif, bukan kebenaran otomatis.

## Lihat juga

* [[zettel.20260421184439]] — Adversarial Review memaksa reviewer beralih dari rasa aman ke pencarian kelemahan
* [[zettel.literature.bmad-adversarial-review]] — literature note BMAD Adversarial Review
* [[zettel.literature.bmad-quick-dev]] — literature note BMAD Quick Dev
* [[zettel.moc.ai-native]] — MOC AI-native engineering
