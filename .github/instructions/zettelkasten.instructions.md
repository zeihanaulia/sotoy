---
applyTo: "vault/zettel.*.md"
description: "Konvensi penulisan dan struktur untuk semua Zettel di vault ini."
---

## Prinsip Zettelkasten untuk Vault Ini

Semua file yang cocok dengan pola `vault/zettel.*.md` mengikuti konvensi berikut.

Tujuan aturan ini bukan sekadar merapikan file, tapi menjaga agar setiap catatan:
- punya satu gagasan utama,
- dapat dirujuk dengan jelas,
- terhubung secara bermakna,
- dan berguna sebagai bagian dari jaringan pemikiran.

## Metadata Dasar

Setiap Zettel harus memiliki identifier yang unik dan stabil agar bisa dirujuk dan dihubungkan dari catatan lain.

Gunakan frontmatter berikut sebagai konvensi default:

```yaml
---
id: zettel.YYYYMMDDHHMMSS
title: "[Klaim atau gagasan utama]"
desc: "[Ringkasan satu kalimat]"
tags:
  - zettel
  - [topik-relevan]
---
```

Catatan:
- Untuk permanent note, gunakan `zettel.YYYYMMDDHHMMSS`
- Untuk literature note, gunakan `zettel.literature.slug`
- Untuk MOC, gunakan `zettel.moc.topik-kebab-case`

Tag bersifat pendukung. Hubungan utama antar catatan harus dibangun melalui link yang eksplisit dan bermakna.

## Atomicity

Usahakan satu file berfokus pada satu gagasan utama.

Jika satu catatan memuat beberapa gagasan yang dapat berdiri sendiri, dipertentangkan, diperluas, atau dihubungkan secara terpisah, pecah menjadi beberapa Zettel.

Tanda bahwa satu note terlalu padat:
- memiliki lebih dari satu klaim utama,
- mencampur ringkasan, opini, dan topik lain tanpa fokus,
- sulit diberi satu judul yang tajam,
- punya banyak paragraf yang sebenarnya bisa menjadi note terpisah.

## Judul sebagai Klaim atau Insight

Judul jangan berupa topik umum. Judul harus menyatakan:
- klaim,
- insight,
- posisi,
- atau hubungan yang bisa dijelaskan dan diuji.

Contoh:
- ❌ `Catatan dan Memori`
- ✅ `Otak manusia lebih cocok menghasilkan ide daripada menyimpannya`

- ❌ `Zettelkasten`
- ✅ `Zettelkasten bekerja lebih baik sebagai jaringan ide daripada arsip catatan`

Jika note belum bisa diberi judul berbentuk klaim atau insight, kemungkinan idenya belum cukup matang.

## Body Ditulis dengan Bahasa Sendiri

Isi Zettel harus ditulis ulang dengan kata-kata sendiri.

Aturan:
- jangan sekadar menyalin sumber atau input mentah,
- ringkas ulang gagasan dengan struktur yang lebih jelas,
- pertahankan inti makna,
- gunakan kutipan seperlunya,
- jika memakai kutipan, selalu tambahkan interpretasi, implikasi, atau hubungan ke note lain.

Pertanyaan yang harus bisa dijawab oleh body:
- sebenarnya note ini ingin mengatakan apa,
- mengapa ide ini penting,
- apa hubungannya dengan ide lain.

## Link Harus Bermakna

Jangan menaruh link sendirian.

Setiap link harus disertai konteks yang menjelaskan relasinya, misalnya:
- mendukung,
- mengontraskan,
- memperluas,
- memberi prasyarat,
- memberi contoh,
- membuka pertanyaan baru.

Contoh:

```md
❌ Buruk:
Lihat juga: [[zettel.202604170001]]

✅ Baik:
Gagasan ini menguatkan [[zettel.202604170001]] karena keduanya menunjukkan
bahwa sistem eksternal membantu membebaskan working memory untuk aktivitas
berpikir yang lebih kompleks.
```

Jika tidak ada hubungan yang jelas, lebih baik tidak menambahkan link.

## Literature Note

Untuk note yang berasal dari sumber eksternal:

- bedakan dengan jelas mana isi sumber dan mana interpretasi pribadi,
- jangan hanya membuat ringkasan pasif,
- tangkap ide yang penting untuk jaringan catatanmu,
- jika ada kutipan, hubungkan ke pemahaman atau pertanyaanmu sendiri.

Literature note harus tetap berguna sebagai batu loncatan ke note lain, bukan sekadar arsip bacaan.

## MOC / Structure Note

MOC dipakai sebagai entry point ke sekumpulan note yang saling terkait.

Gunakan MOC untuk:
- memetakan cluster gagasan,
- memberi jalur masuk ke topik,
- menghubungkan beberapa note yang sering dipakai bersama.

Jangan gunakan MOC sebagai pengganti linking organik antar Zettel. MOC adalah peta, bukan pusat tunggal organisasi.

## Konvensi Penamaan

Gunakan pola berikut:

| Jenis | Pattern | Contoh |
|------|---------|--------|
| Permanent | `zettel.YYYYMMDDHHMMSS` | `zettel.20260417093000` |
| Literature Note | `zettel.literature.slug` | `zettel.literature.building-a-second-brain` |
| MOC | `zettel.moc.topik-kebab-case` | `zettel.moc.personal-knowledge-management` |

Nama harus:
- stabil,
- mudah dirujuk,
- tidak ambigu,
- dan konsisten dengan jenis note.

## Kriteria Kualitas

Sebuah Zettel dianggap baik jika:

- hanya memuat satu gagasan utama,
- punya judul yang tajam,
- ditulis dengan bahasa sendiri,
- punya posisi yang jelas dalam jaringan catatan,
- dan jika memakai link, hubungan antar note dijelaskan dengan eksplisit.

## Checklist Sebelum Menyimpan

Sebelum note dianggap selesai, cek:

- Apakah note ini punya satu gagasan utama?
- Apakah judulnya berupa klaim atau insight?
- Apakah body ditulis ulang dengan jelas?
- Apakah metadata sudah benar?
- Apakah ada link yang bermakna?
- Jika ada link, apakah alasan relasinya dijelaskan?
- Apakah note ini menambah sesuatu ke jaringan pemikiran, bukan hanya mengulang?

## Template untuk Pertanyaan dan Jawaban Educational

Untuk membuat Zettel lebih educational dan jelas, tambahkan bagian pertanyaan dan jawaban di akhir note. Ini membantu menjelaskan gagasan utama secara terstruktur, dengan explanation yang mendidik.

Gunakan template berikut:

```md
## Pertanyaan yang Membentuk Note Ini

### 1. [Pertanyaan spesifik tentang gagasan utama]

[Jawaban jelas dan educational: Jelaskan konsep, berikan contoh, hubungkan ke konteks lebih luas, dan soroti implikasi. Pastikan explanation tidak sekadar jawab, tapi juga mendidik pembaca.]

### 2. [Pertanyaan berikutnya]

[Jawaban serupa: Fokus pada aspek berbeda, dengan explanation yang mendalam.]

Dan seterusnya (biasanya 3-5 pertanyaan).
```

Instruksi untuk jawaban:
- **Educational**: Jelaskan konsep dasar, seolah mengajar pembaca yang belum tahu.
- **Jelas**: Gunakan bahasa sederhana, analogi jika perlu, hindari jargon tanpa penjelasan.
- **Explanation mendalam**: Sertakan contoh konkret, implikasi praktis, dan hubungan ke ide lain.
- **Relevan**: Jawaban harus langsung menjawab pertanyaan dan mendukung gagasan utama note.
- **Singkat tapi lengkap**: Jangan terlalu panjang, tapi cukup untuk memahami.

Contoh:

```md
## Pertanyaan yang Membentuk Note Ini

### 1. Apa inti gagasan utama note ini?

Gagasan utama adalah bahwa matematika berkembang melalui abstraksi yang tepat. Contoh: Dari menghitung benda konkret seperti "fish, fish, fish" ke angka abstrak "six". Ini penting karena abstraksi memungkinkan generalisasi, seperti menggunakan angka untuk apa saja, bukan hanya ikan. Implikasinya, matematika bukan sekadar rumus, tapi cara berpikir yang efisien untuk pola dunia nyata.

### 2. Mengapa abstraksi ini penting?

Abstraksi menghemat pikiran dengan fokus ke kuantitas, bukan detail. Tanpa ini, kita akan terjebak dalam deskripsi panjang. Di dunia modern, ini seperti algoritma yang menggeneralisasi data, memungkinkan AI belajar pola umum dari contoh spesifik.
```

Dengan template ini, note menjadi lebih interaktif dan berguna untuk pembelajaran.

## Default Sikap Penulisan

Saat menulis Zettel:

- utamakan kejelasan daripada panjang,
- utamakan ketajaman daripada kelengkapan palsu,
- utamakan hubungan ide daripada sekadar pengelompokan topik,
- utamakan pemrosesan pemikiran daripada penyalinan informasi.
