
## Pertanyaan yang dibuka

1. Apa yang membuat Spec Kit relevan di tengah BMAD dan workflow AI-native lainnya?
2. Di mana titik tumpu Spec Kit dalam alur antara intent dan implementasi?
3. Kapan Spec Kit pantas dipakai, dan kapan cukup mengambil prinsipnya saja?

## Klaim utama

Spec Kit masih relevan karena ia fokus pada satu problem yang tidak hilang dengan munculnya BMAD atau framework AI-native lain: AI perlu artefak spesifikasi yang cukup kuat agar tidak bekerja dari prompt mentah.

> Spesifikasi bukan sekadar dokumen. Ia adalah boundary operasional antara niat manusia dan aksi agent.

## Apa yang Spec Kit tawarkan

Spec Kit memberikan pipeline spesifikasi yang eksplisit dan terikat ke artefak:

* define — capture intent dan requirement,
* specify — buat boundary dan acceptance criteria,
* kit — siapkan task-level artefak dan implementasi yang dapat dieksekusi.

Dalam praktiknya, ini setara dengan pipeline Constitution → Specify → Plan → Task → Implement yang membuat proses planning dan solutioning lebih konkret.

Ini melengkapi AI-native engineering dengan prinsip yang sama: lawan vibe coding dengan struktur yang bisa dieksekusi.

## Mengapa relevan di era AI-native

Karena kemampuan AI menulis kode tidak menghilangkan kebutuhan untuk:

* menjelaskan apa yang harus dibangun,
* menetapkan batas eksekusi,
* memecah pekerjaan menjadi artefak yang bisa diverifikasi.

Tanpa lapisan ini, AI cenderung mengisi celah dengan tebakan generik, drift dari tujuan, atau menghasilkan output yang plausible tetapi tidak tepat.

## Hubungan dengan BMAD

BMAD dan Spec Kit bukan dua pilihan yang saling eksklusif. Mereka berdiri di poros yang sama:

* BMAD lebih kuat sebagai operating model dan fase workflow,
* Spec Kit lebih kuat sebagai pipeline artefak spesifikasi.

Spec Kit bisa dilihat sebagai salah satu cara untuk membuat fase planning dan solutioning BMAD lebih konkret dan terukur.

## Kesalahan umum

* Mengira Spec Kit hanya untuk tim yang butuh dokumentasi berat.
* Mengira Spec Kit menandakan "lebih banyak proses" daripada yang diperlukan.
* Mengira Spec Kit kalah relevan karena "BMAD sudah punya workflow." Faktanya, kunci yang sama—spesifikasi kuat—masih valid.

## Kapan Spec Kit pantas dipakai

Spec Kit paling layak ketika:

* task punya blast radius menengah sampai besar,
* ada banyak aspek cross-cutting (API, security, data schema),
* output harus konsisten dengan artefak lain,
* ada beberapa agent atau orang yang perlu berbagi pemahaman.

## Kapan cukup ambil prinsipnya saja

Spec Kit bisa terlalu berat untuk task kecil, lokal, atau sangat jelas. Dalam situasi seperti itu, prinsipnya tetap berguna: tuliskan boundary yang cukup jelas, pilih artefak yang bisa diverifikasi, tapi jangan paksa pipeline penuh.

## Lihat juga

* [[zettel.20260421161001]] — AI-native adalah jargon strategi yang menandai asumsi desain AI sebagai fondasi, bukan sekadar fitur tambahan
* [[zettel.20260421162310]] — AI-native Software Engineering memindahkan gravitasi kerja engineering ke orkestrasi dan verifikasi AI
* [[zettel.20260421192951]] — Spec semakin penting ketika AI bisa menulis kode, bukan hanya karena kode lebih murah
* [[zettel.moc.ai-native]]
