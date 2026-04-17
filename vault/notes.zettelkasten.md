---
id: notes.zettelkasten
title: "Zettelkasten di Dendron — Panduan Implementasi"
desc: "Cara mengadaptasi metode Zettelkasten ke dalam workflow Dendron di vault ini"
tags:
  - zettelkasten
  - knowledge-management
  - dendron
---

## Apa itu Zettelkasten?

Zettelkasten (bahasa Jerman: "kotak catatan") adalah sistem pencatatan yang dikembangkan oleh sosiolog Niklas Luhmann. Dia menerbitkan **50 buku dan 600+ artikel** dengan bantuan sistem ini. Intinya bukan sekedar menyimpan catatan, tapi **membangun jaring gagasan yang hidup**.

Tiga prinsip utama:

1. **Atomicity** — satu catatan = satu gagasan. Bukan satu bab, bukan satu topik besar.
2. **Connectivity** — setiap catatan baru harus dihubungkan ke catatan lain yang sudah ada.
3. **Own words** — tulis ulang dengan kata-katamu sendiri, bukan copy-paste.

> "A Zettelkasten is a personal tool for thinking and writing. The difference to other systems is that you create a **web of thoughts** instead of notes of arbitrary size, and emphasize **connection**, not a collection."

---

## Tiga Jenis Catatan

### 1. Fleeting Note (Catatan Kilat)
Tangkap dulu, proses nanti. Bisa dari ide yang tiba-tiba muncul, highlight saat membaca, atau pertanyaan dari diskusi.

- **Tempat**: `vault2/` (private inbox) atau daily journal
- **Umur**: sementara — harus diproses dalam 1-2 hari
- **Template**: `templates.zettel.fleeting`

### 2. Literature Note (Catatan Sumber)
Catatan yang diambil dari sumber (buku, artikel, video, podcast). Ditulis **dengan kata-katamu sendiri**, bukan summary bab per bab.

- **Tempat**: `vault/zettel.literature.*`
- **Tujuan**: jembatan antara sumber eksternal dan Zettel permanenmu
- **Template**: `templates.zettel.literature`

### 3. Permanent Zettel (Catatan Permanen)
Ini inti dari sistem. Satu Zettel = satu gagasan yang dinyatakan sebagai **klaim/pernyataan**, bukan sekadar topik.

- **Tempat**: `vault/zettel.YYYYMMDDHHMMSS.*`
- **Nama file**: timestamp 12-digit + slug pendek (contoh: `zettel.202604170001.ide-tanpa-catatan-sama-dengan-tidak-ada`)
- **Template**: `templates.zettel.permanent`

### 4. Structure Note / MOC
Meta-catatan yang menjadi "peta" dari kumpulan Zettel. Bukan berisi konten, tapi **daftar link** ke Zettel yang saling berhubungan dalam satu tema.

- **Tempat**: `vault/zettel.moc.*`
- **Template**: `templates.zettel.moc`

---

## Mapping ke Hierarki Dendron

```
vault/
├── zettel.md                          ← root index
├── zettel.YYYYMMDDHHMMSS.slug.md      ← permanent Zettel
├── zettel.literature.source-slug.md   ← literature note
└── zettel.moc.topic-slug.md           ← structure note / MOC
```

Catatan yang sudah ada (`book-summaries.*`) tetap bisa dipakai sebagai **literature note kasar** yang perlu diekstrak menjadi Zettel-Zettel individual.

---

## Workflow End-to-End

```
Baca buku/artikel
      ↓
[Fleeting Note] — highlight & pertanyaan cepat
      ↓
[Literature Note] — proses: tulis ulang di kata-katamu sendiri
      ↓
[Permanent Zettel] — ekstrak 1 gagasan per Zettel, beri ID timestamp
      ↓
Hubungkan ke Zettel lain yang sudah ada (dengan menjelaskan MENGAPA dihubungkan)
      ↓
[Structure Note / MOC] — buat peta dari klaster Zettel yang terbentuk
```

---

## Aturan Emas Linking

Saat membuat link ke Zettel lain, **selalu tulis mengapa** link itu dibuat. Bukan hanya `[[zettel.xxx]]`, tapi:

```
Second brain memperpanjang working memory kita [[zettel.202604170001]] karena
ia memindahkan beban penyimpanan dari otak ke sistem eksternal, mirip dengan
prinsip yang dibahas di [[zettel.202604170003]].
```

Link tanpa konteks = tidak ada pengetahuan yang diciptakan.

---

## Konvensi Penamaan

| Jenis | Pola | Contoh |
|-------|------|--------|
| Permanent Zettel | `zettel.YYYYMMDDHHMMSS` | `zettel.202604170001` |
| Literature Note | `zettel.literature.author-judul` | `zettel.literature.building-a-second-brain` |
| MOC | `zettel.moc.topik` | `zettel.moc.personal-knowledge-management` |

---

## Contoh Konkret

Lihat contoh mini-web Zettelkasten yang sudah dibuat di vault ini:

- [[zettel.moc.personal-knowledge-management]] — peta topik PKM
- [[zettel.literature.building-a-second-brain]] — literature note dari BASB
- [[zettel.202604170001]] — "Second brain perluasan kapasitas berpikir"
- [[zettel.202604170002]] — "Ide yang tak ditulis = ide yang tidak ada"
- [[zettel.202604170003]] — "Koneksi lebih bernilai dari koleksi"

---

## Perbedaan dari Cara Lama

| Cara Lama (book-summaries) | Cara Zettelkasten |
|---------------------------|-------------------|
| Satu file per buku | Satu file per **gagasan** |
| Ringkasan bab per bab | Klaim yang bisa dibantah/dibuktikan |
| Pasif — disimpan, jarang dibuka | Aktif — selalu dihubungkan saat menulis |
| Koleksi informasi | Jaring pengetahuan |

---

## Referensi

- [Introduction to the Zettelkasten Method](https://zettelkasten.de/introduction/)
- [Zettelkasten Overview & Principles](https://zettelkasten.de/posts/overview/)
