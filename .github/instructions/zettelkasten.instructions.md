---
applyTo: "vault/zettel.*.md"
description: "Konvensi dan aturan untuk semua file Zettel di vault ini"
---

## Aturan Zettel

Semua file yang cocok dengan pola `vault/zettel.*.md` mengikuti konvensi Zettelkasten berikut.

### Frontmatter Wajib

```yaml
---
id: zettel.YYYYMMDDHHMMSS       # untuk permanent Zettel
# atau
id: zettel.literature.slug      # untuk literature note
# atau
id: zettel.moc.topik            # untuk structure note / MOC

title: "[Klaim sebagai pernyataan]"
desc: "[Satu kalimat ringkasan]"
tags:
  - zettel
  - [topik-relevan]
---
```

### Prinsip Atomicity

Satu file = satu gagasan. Kalau ada dua gagasan berbeda dalam satu file, pecah menjadi dua file.

### Judul adalah Klaim

Judul bukan topik — judul adalah pernyataan yang bisa didukung atau dibantah.
- ❌ "Catatan dan Memori"
- ✅ "Otak manusia didesain untuk menghasilkan ide, bukan menyimpannya"

### Setiap Link Harus Punya Konteks

Jangan taruh link sendirian. Selalu jelaskan mengapa koneksi itu dibuat:
- ❌ `[[zettel.202604170001]]`
- ✅ `Gagasan ini **mendukung** [[zettel.202604170001]] karena keduanya berargumen bahwa ...`

### Bahasa Sendiri

Isi Zettel harus ditulis ulang dengan kata-kata sendiri. Quote boleh, tapi harus disertai interpretasi.

### Penamaan File

| Jenis | Pattern | Contoh |
|-------|---------|--------|
| Permanent | `zettel.YYYYMMDDHHMMSS` | `zettel.202604170930` |
| Literature Note | `zettel.literature.author-judul` | `zettel.literature.building-a-second-brain` |
| MOC | `zettel.moc.topik-kebab-case` | `zettel.moc.personal-knowledge-management` |
