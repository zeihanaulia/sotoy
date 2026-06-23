
## Masalah Utama

Selama lo mikirnya "fitur apa aja yang harus ada", otak akan cenderung bikin **daftar komponen**. Hasilnya produk terasa kayak tempelan: ada tombol, ada form, ada modul, ada dashboard, tapi pengalaman pakainya gak mengalir.

**Inventory thinking** bertanya: "fitur apa yang belum ada?"
**Journey thinking** bertanya: "orang ini sedang mencoba menyelesaikan apa, dalam kondisi apa, dan hambatannya di mana?"

Service sense lahir dari journey thinking, bukan dari feature checklist. Makanya produk yang fiturnya sedikit bisa terasa smooth kalau alurnya mengikuti niat user. Sebaliknya, produk yang fiturnya banyak bisa terasa berat kalau tiap fitur berdiri sendiri tanpa cerita penggunaan.

---

## 5 Lapis Pertanyaan untuk Menumbuhkan Service Sense

Ini cara paksa otak pindah dari "fitur" ke "pengalaman".

### Lapis 1 — Situasi User

Jangan mulai dari "user butuh dashboard." Mulai dari: **"dia lagi di kondisi apa?"**

Contoh produk SaaS: PO habis meeting dengan stakeholder, catatan masih berantakan, deadline PRD besok, dev team butuh task yang jelas, dan dia takut requirement salah nangkep.

Dari sini kelihatan bahwa pain-nya bukan "belum ada generator PRD." Pain-nya adalah **ketidakpastian berubah jadi dokumen yang bisa dipercaya**.

### Lapis 2 — Momen Pertama Value

Tanya: **"dalam 5–10 menit pertama, apa yang harus user rasakan supaya dia bilang: oh, ini berguna?"**

Bisa jadi momen value pertama bukan full PRD sempurna, tapi: "catatan meeting gue dirapikan jadi struktur problem, scope, user story, open questions." Itu sudah bikin user merasa dibantu.

### Lapis 3 — Friction Map

Tanya: **"bagian mana yang bikin user berhenti?"**

Contoh titik friction:
- Login / setup workspace
- Upload file / bingung pilih template
- Output terlalu panjang atau tidak relevan
- Harus copy-paste manual
- Tidak tahu status proses
- Tidak tahu output bisa dipercaya atau enggak

Service sense tumbuh waktu lo mulai sensitif terhadap titik-titik kecil ini.

### Lapis 4 — Trust Loop

Tanya: **"apa yang bikin user percaya hasilnya?"**

Untuk AI product ini krusial. Output bagus belum cukup. User perlu tahu:
- sumbernya dari mana
- asumsi apa yang dipakai
- bagian mana yang masih perlu review
- apa confidence-nya
- bisa edit dengan mudah atau enggak

### Lapis 5 — Return Path

Tanya: **"kenapa user balik lagi besok?"**

Banyak MVP gagal karena cuma mikir first use. Service yang baik mikir ritual: setiap sprint planning, setiap grooming, setiap meeting, setiap PR review, setiap incident — user punya alasan balik.

---

## Framework: Moment → Promise → Path → Proof → Loop

Pakai ini setiap kali mau desain service dari awal.

| Komponen | Pertanyaan | Contoh (produk SaaS) |
|---|---|---|
| **Moment** | User sedang di momen apa? | PO baru selesai meeting, catatan berantakan |
| **Promise** | Service lo menjanjikan perubahan apa? | Dalam 5 menit, catatan mentah jadi draft requirement yang bisa direview |
| **Path** | Langkah minimal dari masuk sampai value? | Paste note → pilih artifact → generate → review missing info → export |
| **Proof** | Apa bukti bahwa output bisa dipercaya? | Trace ke source note, highlight assumption, confidence, open questions |
| **Loop** | Apa alasan user balik? | Setiap meeting baru, setiap sprint planning, setiap change request |

Kalau lo desain dari framework ini, fitur akan muncul natural:
- Paste note muncul karena **Moment**
- Generate draft muncul karena **Promise**
- Review missing info muncul karena **Proof**
- History dan template muncul karena **Loop**
- Export muncul karena **Path**

Fitur bukan ditempel. Fitur lahir dari kebutuhan perjalanan.

---

## Kriteria Pain Point yang Layak Dikejar

Pain point yang bagus biasanya punya minimal salah satu dari ini:

| Kriteria | Pertanyaan | Contoh |
|---|---|---|
| **Frequent** | Terjadi seberapa sering? | PO setiap minggu harus merapikan requirement meeting |
| **Expensive** | Kalau salah, biayanya mahal? | Requirement salah bikin sprint kebuang |
| **Urgent** | Orang butuh selesai sekarang? | Proposal harus dikirim besok |
| **Annoying** | Kecil tapi nyebelin terus-menerus? | Copy-paste dari meeting notes ke Jira task |
| **Status-related** | Bikin orang terlihat bodoh/lambat/tidak siap? | PO ditanya dev "acceptance criteria-nya mana?" dan belum siap |

Kalau pain tidak punya salah satu dari ini, biasanya produknya susah "ketarik" pasar.

---

## Dari Feature Backlog ke Service Backlog

**Feature-only thinking** menghasilkan:
```
generate PRD, generate FSD, generate TSD,
Jira integration, GitLab integration, Confluence export
```

**Service thinking** menghasilkan:
```
dari meeting note mentah
→ jadi draft PRD pertama dalam 5 menit
→ highlight missing info
→ minta user jawab 3 pertanyaan
→ generate task Jira
→ simpan traceability
→ user bisa lihat kenapa task itu muncul
```

Yang kedua punya aliran. Ada cerita. Ada progress. Ada trust.

---

## Contoh Service Flow yang Smooth

User masuk bukan disambut dashboard kosong, tapi ditanya:
> *"Lo mau mulai dari meeting notes, existing PRD, Jira issue, atau repo?"*

Kalau pilih meeting notes → user paste text.

Sistem tidak langsung "generate semua dokumen". Dia lebih dulu membuat **Requirement Brief**: problem, actors, scope, ambiguity, suggested next questions.

Lalu sistem menawarkan:
> *"Gue butuh 3 jawaban untuk bikin PRD ini lebih solid."*

Setelah user jawab → generate PRD. Setelah PRD jadi, sistem tidak berhenti:
- "Breakdown ke user stories?"
- "Push ke Jira?"
- "Bikin technical implications?"
- "Cek missing non-functional requirements?"

**Product-only**: *"Ini fitur generate PRD."*
**Service**: *"Gue bantu lo dari catatan mentah sampai siap masuk backlog."*

---

## Kenapa Lo Susah Menemukan Pain Point

Kemungkinan penyebabnya:

**Builder brain dominan** — cepat bertanya "bisa dibuat gak?" padahal harus tanya "siapa yang cukup peduli sampai mau berubah kebiasaan?"

**Domain terlalu luas** — "SDLC" terlalu besar. "Software team butuh produktif" terlalu besar. Tapi "PO kesulitan mengubah meeting note jadi Jira-ready user stories" cukup tajam.

**Kurang mengamati workaround** — pain point sering muncul bukan dari orang bilang "gue butuh produk X", tapi dari orang bikin workaround jelek: spreadsheet aneh, copy-paste manual, template Notion, screenshot bolak-balik, reminder di chat, meeting tambahan.

**Cari pain yang terlalu besar** — produk cepat sering mulai dari pain kecil tapi sering. Tiny recurring pain bisa jadi bisnis kalau cukup banyak orang mengalaminya dan solusinya smooth.

---

## Latihan: Pain Point Template

Format kalimat untuk mendeskripsikan pain point:

> "Ketika **[persona]** sedang **[situasi]**, dia harus **[aksi menyebalkan]** supaya bisa **[tujuan]**. Masalahnya **[biaya/friction/risiko]**."

Contoh:
> "Ketika PO selesai meeting requirement, dia harus membaca ulang chat dan notes supaya bisa bikin Jira ticket. Masalahnya banyak ambiguity tidak terlihat sampai dev mulai tanya di sprint planning."

Dari satu kalimat ini saja, lo bisa bikin 5 ide fitur — dan karena dimulai dari momen, fiturnya lebih kohesif.

**Latihan seminggu**: catat 10 momen kerja yang bikin orang melakukan copy-paste, reformat, menunggu approval, mencari ulang info, atau bertanya hal yang sama berulang kali. Jangan tulis solusi. Tulis momen sakitnya.

---

## Tiga Ritual sebagai Tulang Belakang

Untuk produk SaaS, sense service bisa mulai dari 3 ritual utama, bukan dari 30 fitur:

1. **Setelah requirement meeting** — meeting note → structured requirement
2. **Sebelum sprint planning** — requirement → task breakdown + review
3. **Saat dev mulai implementasi** — butuh konteks + acceptance criteria jelas

Kalau tiga ritual ini smooth, produk terasa punya tulang belakang. Setelah itu baru tambah fitur.

---

## Insight Kunci

> Service sense itu sering muncul dari satu pertanyaan sederhana: **"habis ini user ngapain?"**
> Fitur tempelan biasanya gagal menjawab pertanyaan itu.
>
> Smoothness bukan berarti UI cantik. Smoothness berarti **niat user mengalir tanpa harus mikir terlalu keras**.

> Maker cepat biasanya bukan karena mereka mengerjakan lebih banyak fitur.
> Mereka cepat karena mereka **memotong ruang masalah** dengan agresif: satu pain kecil, satu persona jelas, satu output bernilai, satu distribusi awal.
>
> Scope kecil harus dipilih dari pain yang tajam. Kalau scope kecil tapi pain-nya lemah → toy. Kalau pain tajam tapi scope terlalu besar → tidak pernah launch.

> Agent/LLM bukan produknya. Produk sebenarnya adalah **workflow yang dibantu AI sampai selesai**.

---

## One-Prompt Test

Untuk setiap ide produk, tanya satu pertanyaan ini dulu:

> *"Dalam 10 menit pertama, user dari kondisi buruk apa berubah ke kondisi lebih baik apa?"*

Kalau tidak bisa dijawab dengan konkret, idenya belum jadi service.

---

## Referensi

- Pieter Levels, [12 Startups in 12 Months](https://levels.io/tag/12-startups-in-12-months/)
- WIRED, [This Guy Is Launching 12 Startups in 12 Months](https://www.wired.com/2014/08/12-startups-in-12-months) (2014)

## Lihat Juga

- [[handbook.product-thinking.from-feature-to-service-design]] — learning path buku untuk keluar dari build trap
- [[notes.saas.product-vs-service]] — konteks penerapan di produk SaaS
