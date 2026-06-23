
## Pertanyaan yang dibuka

1. Mengapa planning dan solutioning harus dipisah?
2. Apa failure mode kalau keduanya dicampur dalam AI-native workflows?
3. Bagaimana pemisahan ini membantu konsistensi teknis?

## Klaim utama

Planning dan solutioning adalah dua jenis keputusan berbeda dengan failure mode berbeda. Planning menjawab "apa yang harus dibangun"; solutioning menjawab "bagaimana membangunnya." Pemisahan menjaga target dan jalur teknis tetap jelas.

## Peran masing-masing

* Planning: tujuan fitur, nilai bisnis, FR/NFR, acceptance criteria.
* Solutioning: pola arsitektur, boundary sistem, API style, state model, unit kerja teknis.

## Kenapa penting

Jika implementor/agent harus mengekstrak keputusan teknis langsung dari requirement bisnis, tim akan rentan terhadap:

* konflik lokal antara agent yang berbeda,
* asumsi teknis tersembunyi yang berubah-ubah,
* pilihan teknis inkonsisten seperti REST vs GraphQL, snake_case vs camelCase, state library apa.

Jika technical design dibahas terlalu dini, requirement bisnis bisa dibajak oleh asumsi teknis sebelum problem jelas.

## Implikasi

* Planning harus memberi context bisnis dan tujuan.
* Solutioning harus memberi basis teknis bersama untuk implementasi.
* Ini bukan formalitas; ini mekanisme untuk menjaga dua sudut pandang tetap terpisah tapi saling terhubung.

## Insight

Dengan pemisahan ini, backlog dan story lebih mungkin lahir setelah arsitektur dan keputusan teknis cukup jelas, sehingga work breakdown informed by architecture, bukan hanya oleh daftar fitur.

## Kesalahan umum

* Mengira planning yang bagus otomatis cukup untuk memulai implementasi.
* Mengira solutioning bisa digantikan oleh general prompt jika requirement cukup jelas.
* Mengaburkan planning dan solutioning menjadi satu dokumen yang membuat dual audience bingung.

## Lihat juga

* [[zettel.20260421171633]] — BMAD brainstorming memperjelas ide sebelum requirement
* [[zettel.20260421171457]] — BMAD analysis phase menghentikan ketidakjelasan sebelum berubah jadi PRD dan architecture
* [[zettel.20260421193303]] — BMAD duduk di lapisan methodology dan orchestration, bukan sekadar prompt atau persona
