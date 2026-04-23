
## Pertanyaan yang dibuka

1. Bagaimana metode ini mengubah cara artefak diperiksa?
2. Apa asumsi tersembunyi yang biasanya terbuka dengan cara ini?
3. Kapan metode ini cocok dipakai dalam workflow AI-native?

## Klaim utama

Constraint removal membantu membedakan constraint nyata dari asumsi arbitrer, sehingga desain tidak terperangkap oleh batasan yang tidak perlu.

## Penjelasan

Metode ini meminta model menulis ulang solusi tanpa beberapa constraint, lalu menilai kembali apakah constraint tersebut memang wajib atau bisa dilonggarkan.

## Contoh

Untuk sebuah desain MVP, constraint removal dapat menunjukkan bahwa fitur tertentu hanya dibatasi oleh asumsi resource, bukan oleh kebutuhan pengguna nyata.

## Implikasi

* Menghindari overengineering yang muncul akibat asumsi batasan semu.
* Membuka ruang untuk desain yang lebih elegan dan lebih fokus pada kebutuhan nyata.

## Lihat juga

* [[zettel.20260421184757]] — Advanced Elicitation memaksa model menggunakan lensa berpikir eksplisit untuk reconsider output
* [[zettel.literature.bmad-advanced-elicitation]] — literature note BMAD Advanced Elicitation
