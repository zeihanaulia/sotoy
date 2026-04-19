---
id: notes.copilot.tacit-knowledge-extraction
title: "Ekstraksi Tacit Knowledge Senior untuk AI dan Tim"
desc: "Dokumentasi praktis untuk mengekstrak judgement senior dan mengubahnya jadi artefak Copilot yang bisa dieksekusi." 
tags:
  - copilot
  - tacit-knowledge
  - workflow
  - documentation
---

## Tujuan

Panduan ini menjelaskan bagaimana mengambil tacit knowledge senior dari kasus nyata, lalu mentransformasikannya menjadi artefak operasional untuk:

- custom instructions (`.github/copilot-instructions.md`, `.github/instructions/*.instructions.md`)
- skills (`.github/skills/*/SKILL.md`)
- agent behavior (`AGENTS.md`)
- review rubric dan checklist tim

Dokumentasi ini fokus pada proses, format, dan contoh penerapan yang bisa langsung dipakai tim dan agent.

## Mengapa ini penting

Tacit knowledge senior sering berupa judgement cepat yang baru bisa dijelaskan setelah melihat contoh konkret.

Jika tidak diambil dengan benar, pengetahuan ini akan tetap:

- hanya di kepala senior,
- dijelaskan secara terlalu umum,
- atau diubah jadi "best practice" yang sulit dipakai.

Tujuan dokumen ini adalah menjadikan tacit knowledge senior:

1. lebih mudah ditangkap,
2. lebih mudah dipakai oleh developer lain,
3. lebih mudah dijadikan petunjuk untuk AI/agent.

## Kapan gunakan proses ini

Gunakan metodologi ini ketika tim ingin:

- membuat custom instruction tim dari pengalaman review nyata,
- mengubah feedback senior menjadi rule yang bisa dijalankan,
- menulis skill debugging berdasarkan pola senior,
- mendokumentasikan batas penggunaan dan pengecualian suatu aturan.

## Proses ekstraksi

### 1. Pilih kasus nyata sebagai sumber

Ambil sumber dari contoh konkret, seperti:

- PR yang ditolak atau dikomentari ketat
- bug atau incident nyata
- test flaky atau issue yang sulit direproduksi
- desain arsitektur yang diperdebatkan
- postmortem setelah produksi

Jangan mulai dari pertanyaan abstrak seperti "apa best practice?".

### 2. Tanyakan bukti, bukan teori

Strukturkan sesi menggunakan pertanyaan berikut:

- Apa yang pertama membuat kamu pause?
- Masalah apa yang segera terlihat?
- Kenapa ini berisiko?
- Apa failure mode utamanya?
- Kapan ini harus ditolak?
- Kapan ini boleh dilanggar?
- Bukti minimalnya apa untuk menunjukkan aturan ini dipenuhi?

### 3. Ubah jawaban jadi unit kecil

Ambil jawaban senior dan pisahkan menjadi unit yang bisa dipakai ulang:

- **Rule**: aturan operasional yang bisa diikuti.
- **Smell**: sinyal awal bahwa sesuatu mungkin salah.
- **Severity**: blocking / important / suggestion.
- **Exception**: kapan aturan tidak berlaku.
- **Verification**: bukti yang harus ada untuk membuktikan kepatuhan.

Contoh:

- Rule: authorization eksplisit wajib pada endpoint yang mengubah state.
- Smell: auth hanya bergantung pada middleware implisit.
- Severity: blocking.
- Exception: endpoint public yang sudah terdokumentasi dengan jelas.
- Verification: diagram jalur auth atau explicit code path.

### 4. Kalibrasi dengan beberapa kasus

Uji kembali aturan dengan situasi lain:

- endpoint public vs internal
- service kecil vs komponen domain
- refactor kecil vs perubahan besar
- legacy code vs kode baru

Tujuannya adalah memastikan aturan tidak terlalu kaku dan tidak terlalu longgar.

### 5. Terjemahkan ke artefak operasional

Gunakan hasil ekstraksi untuk membuat atau memperbarui:

- `custom instructions` untuk kebijakan yang konsisten
- `skills` untuk workflow investigasi atau debugging
- `AGENTS.md` untuk agent behavior dan eskalasi
- review rubric atau checklist untuk reviewer manusia
- onboarding docs untuk mental model tim

## Use case yang paling cocok

Metode ini paling efektif pada situasi di mana AI output bergantung pada judgement, bukan sekadar kemampuan teknis:

- **Code generation fitur baru**
  - Ketika tim sering membuat endpoint/service baru dan output awal harus selaras dengan pola arsitektur, auth, error handling, dan testing tim.
- **Refactoring yang berisiko jadi liar**
  - Saat perubahan perlu terjaga kontrak publik, limited scope, dan tidak boleh menambah abstraksi prematur.
- **Security review yang team-specific**
  - Saat threat model tim berbeda dari checklist generik dan aturan autorisasi, multi-tenant, atau audit harus tertanam dalam standar.
- **Code review dengan severity konsisten**
  - Saat review harus memisahkan blocking/important/suggestion agar AI tidak memberi komentar acak.
- **Onboarding developer dan agent**
  - Saat konteks repo besar atau domain kompleks, sehingga dokumentasi saja tidak cukup; harus ada artefak yang bisa dipakai langsung.
- **Bug investigation / systematic debugging**
  - Saat masalah memerlukan urutan diagnosis yang konsisten dan bukan sekadar patch cepat.

### 6. Menghubungkan ke sumber dan bukti praktik

Beberapa catatan penting tentang sumber:

- Artikel *Encoding Team Standards* memberi kerangka konsep dan contoh ilustratif, bukan demo publik end-to-end.
- Bagian ini lebih berupa praktik yang disarankan dan anekdot, terutama tentang bagaimana tim bisa memindahkan judgement senior ke artefak.
- GitHub Docs mendukung model ini dengan fitur custom instructions, path-specific instructions, code review customization, dan agent skills.
- Komunitas `awesome-copilot` menunjukkan banyak contoh nyata penggunaan instruction dan skill, walaupun bukan demo dari narasumber asli.

Referensi yang langsung mendukung use case ini:

- GitHub Docs: **Repository Custom Instructions**
- GitHub Docs: **Custom instructions for code review**
- GitHub Docs: **Agent skills and workflows**
- GitHub `awesome-copilot` examples

## Format sesi decision mining

Gunakan template ini untuk menjalankan sesi dengan senior:

```md
# Tacit Knowledge Extraction Session

## Context
- Area: [API / review / debugging / testing / architecture]
- Case: [PR / bug / incident / design change]
- Senior: [name]
- Facilitator: [name]

## 1. Trigger
- Apa yang pertama membuat kamu pause?
- Sinyal apa yang terlihat "salah"?

## 2. Diagnosis
- Masalah ini masuk kategori apa?
- Failure mode utamanya apa?

## 3. Severity
- Blocking / Important / Suggestion?
- Kenapa?

## 4. Rule extraction
- Jika ini dijadikan aturan tim, bunyinya apa?
- Apakah ini hard rule atau default heuristic?

## 5. Exceptions
- Kapan aturan ini boleh dilanggar?
- Apa syaratnya?

## 6. Verification
- Evidence minimum apa yang menunjukkan aturan ini dipatuhi?
- Test/check apa yang wajib ada?

## 7. Artifact mapping
- custom instruction:
- skill/workflow:
- review rubric:
- onboarding doc:
```

## Contoh konkret

### Kasus: PR endpoint update profile

Senior komentar:

- controller terlalu gemuk
- auth tidak eksplisit
- response contract berubah tanpa diskusi
- test hanya happy path

Hasil ekstraksi:

- Rule: authorization eksplisit wajib untuk state-changing endpoint.
- Smell: auth tersembunyi lewat middleware implisit.
- Severity: blocking.
- Exception: public endpoint yang terdokumentasi jelas.
- Verification: dokumentasi jalur auth dan hasil test failure path.

Artefak operasional:

- custom instruction: `Authorization harus eksplisit pada endpoint state-changing.`
- review rubric: `Periksa apakah auth path jelas dan contract response tidak berubah diam-diam.`
- onboarding note: `Mengapa auth implicit berbahaya di API.`

### Kasus: debugging flaky test

Senior workflow:

- pastikan reproduksi stabil dulu
- sempitkan layer sebelum edit code
- cari bukti sebelum membuat hipotesis
- hindari perubahan ganda

Hasil ekstraksi:

- Rule: mulai dari reproduksi, bukan refactor.
- Smell: symptom berubah-ubah dan dependent async/shared state.
- Verification: proof of concept kecil yang menegaskan hipotesis.

Artefak operasional:

- skill: `systematic-debugging` untuk investigative workflow.
- AGENTS.md: `Stop and ask if blast radius terlalu besar atau ketika kontrak publik berubah.`

## Hubungan ke artefak lain

- [[zettel.20260419192040]] — executable governance di Copilot
- [[zettel.20260419194901]] — tacit knowledge senior jadi artefak operasional
- [[zettel.20260419192541]] — instruksi standar tim untuk AI: role, konteks, prioritas, output
- [[notes.copilot.custom-instructions-best-practices]] — struktur dan jenis file instruksi Copilot
- [[zettel.literature.encoding-team-standards]] — literatur dasar executable AI instruction

## Langkah berikutnya

1. Pilih satu kasus nyata dari PR atau bug.
2. Jalankan sesi decision mining dengan senior.
3. Tuliskan hasilnya sebagai aturan kecil.
4. Terapkan langsung ke `custom instructions` atau `skill`.
5. Validasi dengan developer lain atau agent.

## Referensi dan bukti praktik

- Artikel *Encoding Team Standards* memberi kerangka dan ilustrasi use case; bukan demo publik end-to-end.
- GitHub Docs mendukung penerapan ini melalui custom instructions, path-specific instructions, code review customization, dan agent skills.
- Repository `github/awesome-copilot` menunjukkan praktik nyata custom instructions dan skills, walau bukan demo dari penulis artikel.

Sumber penting:

- https://martinfowler.com/articles/reduce-friction-ai/encoding-team-standards.html
- https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions
- https://docs.github.com/en/copilot/tutorials/customize-code-review
- https://github.com/github/awesome-copilot
