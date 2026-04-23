# .github — Panduan Agent & Instruksi

Folder ini berisi konfigurasi agent, instruction, dan workflow yang dipakai di VS Code Copilot untuk vault ini.

---

## Struktur

```
.github/
├── agents/
│   ├── vault-curator.agent.md    ← agent untuk kurasi knowledge ke vault
│   └── zettel-scribe.agent.md    ← agent untuk nulis dan hubungkan Zettel
├── instructions/
│   ├── knowledge-taxonomy.instructions.md   ← definisi tiap category knowledge
│   ├── zettelkasten.instructions.md         ← konvensi penulisan Zettel
│   ├── dendron-journal.instructions.md      ← konvensi daily journal
│   ├── gue-elo-style.instructions.md        ← gaya bahasa output
│   └── nextjs-template.instructions.md      ← konvensi frontend theme
└── workflows/
    └── publish.yml                           ← CI/CD untuk publish site
```

---

## Cara Pakai di VS Code

### 1. Buka Chat Panel

Tekan `⌘+⌥+I` (Mac) atau `Ctrl+Alt+I` (Windows/Linux) untuk buka Copilot Chat.

### 2. Pilih Mode Agent

Klik dropdown di pojok kiri bawah chat panel. Pilih **Agent**.

Setelah mode Agent aktif, kamu bisa pilih agent spesifik:

| Agent | Kapan dipakai |
|---|---|
| **Vault Curator** | Baru selesai baca buku, artikel, nonton video, punya opini, best practice, atau catatan mentah yang mau disimpen ke vault |
| **Zettel Scribe** | Punya ide mentah, mau buat Zettel, atau mau hubungkan insight ke catatan yang sudah ada |

### 3. Cara Memilih Agent

Ketik `@` di chat input untuk memunculkan daftar agent, lalu pilih yang sesuai.

Atau klik nama agent di dropdown seperti yang terlihat di screenshot:

```
⌘/ Agent
    Vault Curator
    Zettel Scribe
    Configure Custom Agents...
```

---

## Agent: Vault Curator

Dipakai ketika kamu membawa **konten dari luar** (buku, artikel, video, best practice) dan mau disimpan ke vault dengan kategori yang tepat.

Agent ini akan:
- mengklasifikasikan input ke category yang paling cocok (Book Summaries / Daily / Handbook / Notes / TIL)
- memverifikasi pemahaman kamu terhadap sumber
- menulis ulang dengan voice kamu, tapi lebih rapi
- membuat file Dendron dengan naming dan frontmatter yang benar
- mengevaluasi apakah ada insight yang layak jadi Zettel

### Contoh Query

**Setelah baca buku:**
```
gue baru selesai baca bab 3 Building a Second Brain. Intinya ada 4 kekuatan second brain —
bikin ide lebih jelas, tarik benang merah, tabungan ide, dan pertajam perspektif. Simpenin dong.
```

**Dari artikel:**
```
tadi baca artikel soal The Twelve-Factor App. Yang paling ngena buat gue adalah soal
stateless processes — aplikasi harus bisa di-scale horizontal tanpa nyimpen state di memory.
Gue mau simpen ini.
```

**Best practice atau tutorial:**
```
gue mau dokumntasiin cara setup CI/CD golang yang gue pakai selama ini:
1. build dengan docker
2. run test di pipeline
3. push image ke registry
Ini udah terbukti works dan mau gue jadiin handbook.
```

**TIL cepat:**
```
baru tau kalau di Go, kalau lo return error dari goroutine, lo harus pakai channel
karena goroutine nggak bisa langsung return ke caller. Simpenin sebagai TIL.
```

**Opini harian:**
```
hari ini gue baca tentang trunk-based development vs GitFlow.
Menurut gue GitFlow terlalu kompleks untuk tim kecil, tapi masih makes sense
untuk enterprise yang punya banyak versi aktif. Mau simpen sebagai daily.
```

---

## Agent: Zettel Scribe

Dipakai ketika kamu punya **ide di kepala** — bisa mentah, berantakan, belum selesai — dan mau diubah jadi Zettel yang atomic dan terhubung.

Agent ini akan:
- membantu menemukan gagasan utama dari curahan pikiran
- memecah ide yang terlalu padat jadi beberapa Zettel
- cek apakah perlu permanent note, literature note, atau MOC dulu
- cari relasi ke Zettel yang sudah ada
- tulis file dengan konvensi Zettelkasten yang benar

### Contoh Query

**Curahan pikiran mentah:**
```
gue ngerasa ada pola menarik — setiap kali tim gue gagal deliver, bukan karena
kurang skill tapi karena scope nggak jelas di awal. Tapi gue juga pernah lihat
tim dengan scope jelas tapi tetap gagal karena komunikasi ancur. Mau gue jadiin zettel.
```

**Dari buku yang baru dibaca:**
```
dari buku An Elegant Puzzle, ada satu ide yang menempel di gue:
"systems thinking is more valuable than heroism". Maksudnya solusi sistemik
lebih sustainable daripada bergantung pada orang-orang paling talented.
Jadiin literature note dan permanent note dong.
```

**Mau hubungkan beberapa ide:**
```
gue punya zettel soal "second brain" dan zettel soal "externalizing memory".
Kayaknya ada hubungan yang belum gue tulis eksplisit. Bantu gue formulasiin relasi-nya.
```

**Pertanyaan permanen:**
```
gue terus kepikiran pertanyaan ini: kapan sebuah tim harus pilih
autonomy vs alignment? Mau gue simpen sebagai pertanyaan yang terus gue cari jawabannya.
```

---

## Instructions

Instructions adalah konteks dan aturan yang diload agent saat bekerja. Kamu tidak perlu memanggil instruction secara manual — agent sudah dikonfigurasi untuk menggunakan instruction yang relevan.

| Instruction | Berlaku untuk | Isi |
|---|---|---|
| `knowledge-taxonomy` | semua vault note | definisi tiap category, aturan routing, aturan promosi |
| `zettelkasten` | `vault/zettel.*.md` | konvensi atomic note, naming, linking bermakna |
| `dendron-journal` | `vault2/daily.journal.*.md` | naming convention dan template Five Minute Journal |
| `gue-elo-style` | semua output | gaya bahasa santai gue-elo, tajam, tidak korporat |
| `nextjs-template` | `nextjs-template/**` | konvensi frontend — tidak relevan untuk vault |

---

## Simulasi Lengkap

### Skenario 1 — Baru Selesai Baca Buku

**User:**
```
@Vault Curator

gue baru selesai baca bab pertama Team Topologies. Intinya Conway's Law bilang
bahwa struktur organisasi bakal nentuin arsitektur sistem yang dibuat. Jadi kalau
lo mau arsitektur yang modular, lo harus susun timnya juga modular.
Gue setuju sama ini karena gue pernah ngalamin sendiri — waktu tim gue digabung
jadi satu, codebase-nya juga jadi monolith berantakan.
```

**Apa yang akan dilakukan agent:**
1. Classifier → Book Summaries (cerita tentang bab buku, ada interpretasi personal)
2. Verifier → cek apakah Conway's Law dijelaskan dengan benar
3. Shaper → rapikan dengan gaya naratif, pertahankan voice user
4. Buat file `vault/book-summaries.team-topologies.md` dengan frontmatter yang benar
5. Zettel Projector → identifikasi kandidat: "Conway's Law sebagai cermin antara struktur org dan arsitektur sistem"

---

### Skenario 2 — TIL Cepat

**User:**
```
@Vault Curator

baru tau, di Kubernetes kalau lo set resource limit terlalu rendah untuk Java app,
JVM-nya bisa langsung OOMKilled karena metaspace-nya nggak keitung di resource limit biasa.
Harus pake -XX:MaxMetaspaceSize juga.
```

**Apa yang akan dilakukan agent:**
1. Classifier → Today I Learned (satu temuan atomic, teknikal, singkat)
2. Buat file `vault/til.devops.kubernetes-jvm-metaspace-oomkilled.md`
3. Evaluasi → cukup tajam untuk jadi zettel: "Resource limit di Kubernetes tidak otomatis menutup JVM metaspace"

---

### Skenario 3 — Ide Mentah ke Zettel

**User:**
```
@Zettel Scribe

gue lagi mikirin sesuatu. Kayaknya ada bedanya antara "belajar untuk tahu"
dan "belajar untuk bisa". Yang pertama itu kayak baca wikipedia — lo nambah fakta
tapi belum tentu bisa ngerjain apapun. Yang kedua itu lo langsung praktek.
Dan yang menarik, kebanyakan sekolah itu fokus ke yang pertama.
Gue belum tau mau ke mana ini, tapi kayaknya penting.
```

**Apa yang akan dilakukan agent:**
1. Pecah jadi dua kandidat zettel:
   - "Belajar deklaratif (tahu) vs belajar prosedural (bisa) punya output yang berbeda"
   - "Sistem pendidikan formal cenderung mengoptimalkan untuk pengetahuan deklaratif"
2. Cek apakah MOC `zettel.moc.learning` sudah ada — jika belum, buat dulu
3. Tulis permanent note `vault/zettel.20260423HHMMSS.md` untuk tiap ide
4. Link antar note dengan relasi yang eksplisit

---

## Tips

- **Jangan terlalu rapikan input sebelum kirim ke agent.** Curahan mentah justru lebih baik — agent akan merapikannya sambil mempertahankan voice kamu.
- **Sebutkan konteks sumber jika ada.** Misalnya nama buku, judul artikel, atau dari mana ide itu datang. Ini bantu agent memverifikasi pemahaman.
- **Kalau ragu masuk category apa**, tulis aja dulu ke agent. Agent yang akan klasifikasiin.
- **Satu input bisa menghasilkan beberapa file** — misalnya book summary sekaligus beberapa Zettel. Itu normal dan memang by design.
