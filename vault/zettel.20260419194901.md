---
id: zettel.20260419194901
title: "Tacit knowledge senior diubah jadi artefak operasional untuk AI dan tim"
desc: "Tacit knowledge senior diekstrak lewat kasus nyata, dijabarkan jadi aturan, dan diterjemahkan ke custom instruction, skill, dan checklist."
tags:
  - permanent-note
  - tacit-knowledge
  - copilot
  - governance
  - workflow
---

> Tacit knowledge senior bukan sekadar pengalaman umum; ia adalah judgement konkret yang aktif saat melihat kasus nyata, dan nilai terbaiknya muncul ketika diubah menjadi artefak operasional.

## Pertanyaan yang dijawab

1. Bagaimana jenis tacit knowledge senior yang bisa diekstrak?
2. Bagaimana cara mengambilnya dari kepala senior secara sistematis?
3. Bagaimana menjadikannya artefak yang bisa dipakai oleh AI dan developer lain?
4. Bagaimana kaitannya dengan custom instructions, skills, dan agent behavior?

## Definisi penting

- **Tacit knowledge**: pengetahuan yang dipakai lewat insting dan pengalaman, tapi belum tertulis jelas. Biasanya muncul sebagai judgement cepat terhadap PR, debugging, atau desain.
- **Explicit knowledge**: pengetahuan yang sudah dituliskan secara gamblang, bisa dibaca orang lain, dan bisa diikuti langsung. Contoh: aturan kode, instruksi, checklist, dokumentasi.
- **Tribal knowledge**: pengetahuan tim yang hidup sebagai kebiasaan atau budaya bersama. Lebih sempit dari tacit, karena berhubungan dengan cara kerja kelompok tertentu.

Contoh perbedaan:

- tacit: "gue tahu service ini terlalu banyak tanggung jawab"
- explicit: "controller tidak boleh mengandung business rule; pindahkan ke service layer"
- tribal: "di tim ini, perubahan API harus selalu didiskusikan di standup sebelum di-merge"

## Inti klaim

Tacit knowledge senior paling efektif diambil lewat **case-based decision mining**: gunakan PR, bug, incident, atau desain nyata sebagai pemicu, lalu bongkar judgement senior menjadi:

- rule operasional
- smell detection
- severity/prioritas
- exception dan batas penggunaan
- verification yang bisa diuji

Setelah itu, artefak ini bisa dipindahkan ke custom instructions, skill workflow, atau review rubric.

## Langkah ekstraksi yang praktis

### 1. Mulai dari kasus nyata

Pilih sesuatu yang konkret:

- PR yang ditolak atau direview ketat
- bug yang lolos ke production
- flaky test yang sulit direproduksi
- desain arsitektur yang diperdebatkan
- incident postmortem

Ini memaksa proses pola menjadi jelas, karena senior beroperasi dalam mode pattern recognition.

### 2. Tanyakan terhadap bukti, bukan teori

Daripada bertanya "apa best practice?", tanyakan:

- apa yang pertama membuat lo pause?
- masalah apa yang lo lihat?
- kenapa ini berisiko?
- kapan ini harus ditolak?
- kapan ini boleh dilanggar?
- bukti minimalnya apa?

### 3. Uraikan jawaban jadi unit kecil

Jangan simpan sebagai narasi panjang. Ubah menjadi:

- **Rule**: keputusan yang bisa diikuti
- **Smell**: tanda awal masalah
- **Verify**: bukti bahwa aturan sudah dipatuhi
- **Exception**: kapan aturan tidak berlaku
- **Severity**: blocking / important / suggestion

### 4. Kalibrasi lewat perbandingan kasus

Bandingkan aturan dengan beberapa situasi lain agar tidak menjadi terlalu kaku atau generik.

Contoh:

- apakah aturan ini berlaku untuk endpoint internal dan public?
- apakah ini berlaku untuk service kecil dan arsitektur monolit?
- apakah ini masih masuk ketika dependency berubah?

### 5. Turunkan menjadi artifact operasional

Artifact yang ideal:

- `custom instructions` untuk aturan yang konsisten
- `skills` untuk workflow investigasi/debugging
- `AGENTS.md` untuk agent behavior dan eskalasi
- `review rubric` atau checklist untuk reviewer manusia
- `onboarding docs` untuk mental model tim

## Contoh hasil ekstraksi

Jika senior bilang tentang PR API:

- controller terlalu gemuk
- auth tidak eksplisit
- response contract berubah tanpa diskusi
- test hanya happy path

Maka hasil ekstraksinya bisa menjadi:

- Rule: authorization eksplisit wajib untuk endpoint state-changing
- Smell: auth bergantung ke middleware implicit
- Verify: tunjukkan jalur auth dan contract impact
- Exception: boleh skip untuk endpoint public terdokumentasi
- Severity: missing auth = blocking

## Mengapa ini penting untuk AI

AI dan Copilot bisa menjawab lebih konsisten ketika tacit knowledge senior tidak lagi tersimpan hanya di kepala, melainkan tersusun sebagai artefak yang bisa dibaca dan dieksekusi.

Ini sejalan dengan praktik di:

- [[zettel.20260419192040]] — executable governance di Copilot
- [[zettel.20260419192541]] — instruksi standar tim untuk AI: role, konteks, prioritas, output
- [[zettel.literature.encoding-team-standards]] — konsep executable AI instruction sebagai prasyarat konsistensi tim
- [[notes.copilot.custom-instructions-best-practices]] — jenis file instruksi dan struktur yang efektif
- [[notes.copilot.tacit-knowledge-extraction]] — dokumentasi praktis untuk ekstraksi tacit knowledge senior

## Implisit yang harus digarisbawahi

- Tacit knowledge jarang bisa ditangkap lewat “tolong tulis best practice”.
- Ia keluar paling baik lewat diskusi langsung tentang kasus nyata.
- Artefak yang baik tidak hanya menulis aturan; ia juga menulis kapan aturan boleh dilanggar dan bagaimana membuktikannya.

## Langkah berikutnya

- Buat `decision mining` session untuk satu PR atau bug nyata.
- Ubah hasilnya langsung menjadi `custom instructions` dan `skill checklist`.
- Validasi artefak tersebut dengan developer lain atau agent AI.
