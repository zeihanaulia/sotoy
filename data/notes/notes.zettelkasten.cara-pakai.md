
## TL;DR

Ada dua cara memakai sistem Zettelkasten di project ini:

1. **Manual** — buat file sendiri mengikuti konvensi di bawah
2. **Pakai agent** — mention `@Zettel Scribe` di chat Copilot, ceritakan pikiranmu, agent yang urus sisanya

---

## Cara 1: Manual

### Langkah-langkah

**1. Tentukan jenis Zettel yang kamu butuhkan:**

| Situasi | Jenis | Contoh nama file |
|---------|-------|-----------------|
| Pikiran sendiri, satu klaim jelas | **Permanent Zettel** | `zettel.202604171430.md` |
| Sedang baca buku/artikel, mau catat | **Literature Note** | `zettel.literature.nama-buku.md` |
| Ide masih kasar, belum bisa dirumuskan | **Fleeting Note** | di `vault2/` atau daily journal |
| Mau buat peta dari banyak Zettel | **MOC** | `zettel.moc.topik-saya.md` |

**2. Generate ID timestamp:**

```bash
date +%Y%m%d%H%M%S
```

Gunakan hasilnya sebagai nama file. Contoh: `zettel.202604171430.md`

**3. Buat file menggunakan template:**

| Template | File |
|----------|------|
| Permanent Zettel | `seeds/dendron.templates/templates/templates.zettel.permanent.md` |
| Literature Note | `seeds/dendron.templates/templates/templates.zettel.literature.md` |
| MOC | `seeds/dendron.templates/templates/templates.zettel.moc.md` |
| Fleeting Note | `seeds/dendron.templates/templates/templates.zettel.fleeting.md` |

**4. Isi konten:**
- Judul = klaim/pernyataan (bukan topik)
- Body = tulis dengan kata-katamu sendiri
- Selalu cari dan tambahkan link ke Zettel yang sudah ada
- Selalu jelaskan *mengapa* sebuah link dibuat

**5. Update index:**
- Buka `vault/zettel.md` → tambahkan entry baru
- Jika ada MOC yang relevan → tambahkan link di sana juga

---

## Cara 2: Pakai Zettel Scribe Agent

### Setup

Agent sudah tersedia di `.github/agents/zettel-scribe.agent.md`. Tidak perlu konfigurasi tambahan.

### Cara Menggunakan

1. Buka **Copilot Chat** di VS Code (`⌃⌘I` / `Ctrl+Alt+I`)
2. Klik dropdown agent di kiri bawah chat input → pilih **"Zettel Scribe"**
3. Ceritakan pikiranmu — **bebas, tidak perlu rapi**

Contoh input yang valid:

```
gue baru baca artikel tentang bagaimana para programmer bisa burn out karena
terus-terusan belajar hal baru tanpa ada waktu untuk mengintegrasikan pengetahuan.
kayaknya ini berhubungan sama konsep deliberate practice yang pernah gue baca
di somewhere, intinya belajar tanpa refleksi itu tidak efektif.
```

Agent akan:
1. Menganalisis ada berapa gagasan di input kamu
2. Menentukan jenis Zettel yang tepat
3. Mencari Zettel yang sudah ada dan relevan
4. Menulis ulang menjadi Zettel yang proper (klaim atomik, bahasa jelas)
5. Membuat file dengan ID timestamp yang benar
6. Menghubungkan ke Zettel yang sudah ada beserta konteks mengapa
7. Update index/MOC yang relevan
8. Melaporkan hasilnya ke kamu

### Contoh Output Agent

```
✅ Dibuat: vault/zettel.202604171430.md
   Judul: "Belajar tanpa refleksi tidak mengintegrasikan pengetahuan baru ke skema yang ada"
   Jenis: Permanent Zettel

🔗 Koneksi yang dibuat:
   → [[zettel.202604170002]] — karena keduanya berargumen bahwa tanpa proses
     elaborasi aktif (menulis/refleksi), informasi baru tidak berubah menjadi
     pengetahuan yang bisa digunakan
   → [[zettel.202604170003]] — gagasan ini memperkuat argumen bahwa koneksi
     antar ide (bukan koleksi) adalah kunci pembelajaran efektif

📍 Diindeks di:
   → vault/zettel.md
   → vault/zettel.moc.personal-knowledge-management.md (klaster "Prinsip Belajar Efektif")

💡 Saran langkah berikutnya:
   Apakah kamu mau membuat Zettel tentang apa itu "deliberate practice" 
   dan kenapa ia berbeda dari sekedar latihan berulang?
```

---

## Konvensi Penamaan

```
vault/
├── zettel.md                                    ← root index, update setiap ada Zettel baru
├── zettel.202604170001.md                       ← permanent Zettel (ID = timestamp)
├── zettel.202604171430.md                       ← permanent Zettel lain
├── zettel.literature.building-a-second-brain.md ← literature note
├── zettel.literature.nama-buku-lain.md
└── zettel.moc.personal-knowledge-management.md  ← MOC / peta topik
```

---

## Aturan Emas

### 1. Judul = Klaim, Bukan Topik

| ❌ Topik (hindari) | ✅ Klaim (pakai ini) |
|-------------------|---------------------|
| "Pair Programming" | "Pair programming menemukan bug 15x lebih cepat dibanding code review async" |
| "Motivasi" | "Motivasi eksternal merusak motivasi intrinsik jangka panjang" |
| "Tidur" | "Tidur cukup meningkatkan konsolidasi memori lebih dari latihan tambahan" |

### 2. Satu Zettel = Satu Gagasan

Jika kamu menulis dua paragraf yang membahas dua hal berbeda → dua Zettel.

### 3. Link = Konteks + Mengapa

```markdown
❌ Buruk:
Lihat juga: [[zettel.202604170001]]

✅ Baik:
Gagasan ini **menguatkan** [[zettel.202604170001]] karena keduanya berargumen
bahwa sistem eksternal membebaskan working memory untuk tugas yang lebih penting
daripada sekadar mengingat fakta.
```

### 4. Tulis Ulang, Jangan Copy-Paste

Selalu tulis dengan kata-katamu sendiri. Boleh ada quote, tapi harus ada interpretasimu setelah itu.

---

## Pertanyaan yang Sering Muncul

**Q: Zettel saya sudah ada, boleh diedit?**
Boleh, tapi hindari mengubah klaim utama. Tambahkan koneksi baru atau klarifikasi sesuai perkembangan pemikiran. Jangan hapus konten lama — Zettel adalah rekam jejak berpikir.

**Q: Apa bedanya sama `book-summaries.*` yang sudah ada?**
`book-summaries.*` adalah ringkasan bab per bab — berguna sebagai catatan awal. Tapi untuk Zettelkasten, kamu perlu mengekstrak gagasan-gagasan individual menjadi Zettel terpisah. Anggap `book-summaries.*` sebagai *fleeting note* yang perlu diproses.

**Q: Berapa ideal jumlah Zettel?**
Tidak ada target jumlah. Yang penting: setiap Zettel baru **terhubung** ke yang sudah ada. Mulai terasa berguna setelah 50-100 Zettel saling terhubung.

**Q: Bahasa Indonesia atau Inggris?**
Bebas — gunakan bahasa sesuai sumber atau pikiranmu. Agent akan mengikuti bahasa inputmu.

---

## Lihat Juga

- [[notes.zettelkasten]] — panduan konsep Zettelkasten (mengapa dan apa)
- [[zettel]] — root index semua Zettel di vault ini
- [[zettel.moc.personal-knowledge-management]] — contoh MOC
- [[zettel.literature.building-a-second-brain]] — contoh literature note
- [[zettel.202604170001]] — contoh permanent Zettel
