
## Gagasan

Auto compaction cenderung menjaga apa yang terjadi, tapi bukan kenapa itu terjadi.

## Mengapa Ini Penting

Itu berarti tool memory otomatis bisa bikin kita percaya konteks aman, padahal reasoning sudah hilang.

Ringkasan otomatis biasanya fokus pada "what" karena itu paling mudah diekstrak: keputusan akhir, aksi, hasil. Alasan, asumsi, dan trade-off sering disingkat atau dihilangkan karena terlalu verbose dan tidak selalu tampak eksplisit.

## Simulasi

Bayangkan sesi chat coding seperti ini:

1. Chat: "Kita akan pakai BullMQ, bukan RetryQueue, karena kita butuh minimal overhead dan cross-tenant isolation." 
2. Chat: "Kalau pakai RetryQueue, implementasinya akan butuh state manager tambahan dan mengganggu scaling multi-tenant." 
3. Chat: "Kita setuju untuk langsung panggil BullMQ dalam service saja." 

Kalau tool ringkas otomatis, outputnya mungkin jadi:

- Keputusan: pakai BullMQ.
- Next step: implement retry di service.

Yang hilang:

- kenapa BullMQ? (overhead rendah, cocok multi-tenant)
- alasan tolak RetryQueue (state manager, scaling problem)
- asumsi penting (jangan buat wrapper ekstra untuk fase pertama)

Karena itu, ringkasan bisa terlihat lengkap padahal reasoning sudah lenyap. Maka nilai external memory bukan hanya menyimpan hasil, tapi juga menyimpan "kenapa".

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 9.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 9
