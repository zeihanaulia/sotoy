
## Gagasan

Code itu jejak hasil, bukan riwayat pertimbangan.

## Mengapa Ini Penting

Kalau hanya andal pada kode, kita kehilangan konteks penting untuk keputusan berikutnya.

Kode menunjukkan apa yang dibuat, bukan mengapa keputusan itu diambil. Dalam artikel "Context Anchoring" disebutkan bahwa AI bisa mengingat "kita pakai PostgreSQL", tapi lupa kenapa PostgreSQL dipilih ketimbang MongoDB—misalnya karena butuh JSONB, pengalaman tim, atau kebutuhan multi-tenant.

Artinya: AI mungkin masih menghasilkan kode yang secara teknis konsisten dengan keputusan eksplisit, tapi melanggar niat awal. Contoh nyata adalah AI yang membuat struktur yang cocok untuk document store, padahal proyek sebenarnya harus memaksimalkan relasional PostgreSQL.

## Contoh

- Kode hasil: `BullMQ` direct retry handler.
- Yang hilang di kode: `RetryQueue` pernah dipertimbangkan, tapi ditolak karena menambah kompleksitas tanpa keuntungan nyata.
- Yang hilang di kode: constraint v1 hanya email, jadi tidak boleh usul SMS/push.

## Kenapa Feature Document Penting di Sini

Feature document bertindak seperti external memory yang mencatat konteks ini. Ia menutup gap yang kode tidak bisa tutupi: alasan, alternatif yang ditolak, batasan, dan status keputusan. Ini membuat sesi AI baru bisa melanjutkan keputusan tanpa menebak-nebak sejarah yang hilang.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 18.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 18
