
## Gagasan

Chat AI itu cuma ruang berpikir sementara. Keputusan penting yang cuma hidup di chat cepat memudar begitu sesi memanjang, dan tidak ada yang bertahan setelah sesi berakhir.

## Mengapa Ini Penting

AI-assisted development bukan cuma soal ngoding. Ini soal gimana desain, asumsi, dan alasan keputusan bisa dilanjutkan ke sesi-sesi berikutnya tanpa bolak-balik nanya lagi.

## Penjelasan

Percakapan dengan model besar itu efektif buat nyetak ide: cepat, iteratif, dan fleksibel. Masalahnya, banyak keputusan dan alasan (the why) yang muncul cuma hidup di alur chat — dan itu rentan hilang:

- Context window yang terbatas dan pergantian topik bikin informasi penting sulit direkonstruksi.
- Chat jarang menyimpan metadata: siapa bilang apa, asumsi apa yang dipakai, atau referensi ke file/issue.
- Tanpa ringkasan persisten, keputusan bisa terabaikan atau ter-revert karena alasan aslinya nggak terdokumentasi.

## Contoh Kasus

- Desainer memutuskan perubahan UX di sesi brainstorming; implementor bingung karena gak ada alasan tertulis, akhirnya revert.
- Arsitek memilih trade-off performa vs maintainability dalam chat; evaluasi berikutnya sulit karena alasan awal tidak terdokumentasi.

## Implikasi Praktis

- Terapkan "context-anchoring": sebelum menutup sesi, minta ringkasan 2–3 baris berisi keputusan, alasan singkat, dan referensi (file/issue).
- Standarisasi format ringkasan supaya mudah diotomasi (contoh: satu baris YAML/frontmatter kecil, atau template yang bisa diparsing).

## Pertanyaan Untuk Ditindaklanjuti

1. Kriteria apa yang membuat keputusan layak dipromosikan ke Zettel permanent? (impact, scope, lifetime)
2. Siapa bertanggung jawab memindahkan ringkasan sesi ke penyimpanan persisten?
3. Bisakah dibuat tooling kecil (template/shortcut) yang memaksa ringkasan sebelum menutup sesi chat?

## Hubungan ke Zettel Lain

 - Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 0.
 - Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen (relevan karena membahas proses transfer konteks).
 - Terkait: [[zettel.20260420131312]] — praktik membuat ringkasan keputusan otomatis.

## Sumber

 - [[zettel.literature.context-anchoring]] — Paragraf 0
