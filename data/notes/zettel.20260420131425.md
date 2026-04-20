
## Gagasan

Struktur minimal yang baik membuat catatan fitur gampang dibaca ulang dan di-update.

## Struktur Minimal

Struktur minimal berarti hanya menyimpan konteks yang langsung membantu keputusan dan tindakan selanjutnya. Dalam konteks fitur, struktur minimal idealnya mencakup:

- `Goal / Outcome` — apa hasil yang dicari.
- `Decision / What` — apa yang diputuskan untuk dibangun.
- `Why` — alasan utama di balik keputusan.
- `Constraints` — batasan atau asumsi yang harus dijaga.
- `Rejected alternatives` — alternatif penting yang sudah ditolak dan kenapa.
- `Open questions` — pertanyaan belum terjawab yang memengaruhi kelanjutan.
- `State / Status` — apakah catatan ini masih valid, sudah diimplementasi, atau sedang dipertimbangkan.

## Contoh Struktur Good

Sebuah catatan fitur yang baik biasanya ringkas dan terstruktur seperti ini:

- `Goal`: memperbaiki onboarding sehingga pengguna baru bisa menyelesaikan setup dalam 3 menit.
- `Decision`: tambahkan wizard setup satu halaman di aplikasi.
- `Why`: data menunjukkan 40% drop-off saat konfigurasi manual, dan wizard mengurangi friction.
- `Constraints`: hanya gunakan data yang sudah tersedia, tidak membuat API baru untuk fase 1.
- `Rejected alternatives`: opsi 1 = tetap form multi-step; ditolak karena terlalu banyak klik. Opsi 2 = training modal; ditolak karena tidak menyelesaikan masalah discovery.
- `Open questions`: apa metrik keberhasilan yang akan kita pakai? Bagaimana fallback bila user melewatkan langkah?
- `State`: konseptual, butuh review tim produk.

Struktur ini efektif karena semua informasi penting ada dalam 1–2 layar, dan orang tidak perlu membaca seluruh latar belakang untuk tahu apa selanjutnya.

## Contoh Struktur Bad

Catatan fitur yang buruk biasanya terlihat seperti dokumen panjang, misalnya:

- banyak paragraf cerita latar belakang, riset full-user interview, dan sejarah opsi yang pernah dibahas.
- tidak jelas apa keputusan sekarang; jadi pembaca harus menebak apakah ini masih open atau sudah disetujui.
- tidak ada ringkasan outcome, hanya daftar fitur dan requirement teknis.
- semua opsi dipaparkan tanpa indicate mana yang dipilih dan kenapa.

Contoh buruk: sebuah doc 5 halaman yang memulai dengan "masalah pengguna" lalu langsung masuk ke detail implementasi, flow alternatif, ukuran tim, roadmap, dan meeting notes. Pembaca akan merasa: "ini dokumen formal, bukan hal yang bisa saya gunakan sekarang."

## Mengapa Ini Penting

Struktur minimal membantu mengurangi friction karena:

- mempermudah session restart; orang baru atau yang kembali ke topik cepat paham status.
- mencegah context drift; hanya konteks relevan yang tersimpan, bukan seluruh sejarah diskusi.
- membuat catatan lebih mudah di-update ketika keputusan berubah.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 28.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 28
- Artikel asli: https://martinfowler.com/articles/reduce-friction-ai/context-anchoring.html
- Architectural Decision Records (ADRs): https://adr.github.io/
- Martin Fowler — Architecture Decision Records: https://martinfowler.com/articles/architecture-decision-records.html
- Wikipedia — Architecture decision record: https://en.wikipedia.org/wiki/Architecture_decision_record
