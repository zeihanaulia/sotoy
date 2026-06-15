---
id: notes.agentic-coding-is-a-trap
title: "Agentic Coding Is a Trap"
description: "Analisis argumentasi Lars Faye tentang risiko agentic coding, parahnya supervision paradox, dan posisi sehat AI dalam workflow developer."
tags:
  - ai
  - coding
  - automation
  - skill
  - workflow
status: published
created: 1778553560226
updated: 1778554950395
---

## Overview

Gue baca artikel Lars Faye sebagai peringatan, bukan penolakan terhadap AI. Yang gue tangkep adalah bahwa dia sedang menyerang model kerja tertentu: **agentic coding**, di mana AI mengambil alih inti problem solving sementara manusia cuma ngarahin, ngawasin, dan merevisi.

Inti argumennya buat gue jelas: menulis code bukan cuma produksi syntax; itu medium berpikir. Kalau manusia melepas loop implementasi, yang hilang bukan cuma output, tapi juga proses membangun mental model.

---

## 6 Pertanyaan Kunci

### 1. Target kritik

Buat gue, targetnya bukan AI-assisted coding secara umum. Dia melawan hype yang bilang manusia cukup menulis plan/spec lalu mundur dari code-writing.

### 2. Kenapa agentic coding "trap"?

Untuk gue, trap-nya ada di tiga lapis:
- psikologis: terasa seperti jadi "director", padahal pemahaman makin kabur.
- teknis: non-determinism AI memaksa ekosistem tambahan untuk spesifikasi, review, guardrail, retry.
- ekonomi: vendor dependency dan biaya token jadi sulit diprediksi.

### 3. Agentic workflow vs cognitive debt

Agentic workflow memotong friction produktif yang biasa memaksa developer untuk:
- memecah masalah,
- bikin hipotesis,
- mengetes,
- debugging,
- ngerasain konsekuensi desain.

Tanpa friction itu, output bisa muncul. Tapi pemahaman yang biasanya ikut tumbuh jadi lemah.

### 4. Kenapa ini bukan abstraction layer baru?

Menurut gue, analogi klasik compiler/framework salah tempat.

Abstraction sehat itu mengurangi detail sambil tetap menjaga kontrol.
LLM agentic malah mengurangi kontak langsung sekaligus nambah ambiguitas.

Kata kunci yang gue suka: **"a higher level of ambiguity is not a higher level of abstraction."**

### 5. Kontradiksi human orchestrator

Kalau seseorang cuma jadi “human orchestrator”, itu terdengar elite. Tapi praktiknya, posisi itu butuh kompetensi yang cuma tumbuh dari implementasi langsung.

Review code saja gak cukup untuk membentuk kemampuan itu.

### 6. Posisi sehat AI

Buat gue, AI paling sehat kalau jadi bantuan sekunder:
- bantu bikin spec dan plan,
- tetap pegang implementasi sendiri sampai paham,
- pakai pseudocode supaya jarak niat-ke-code tetap dekat,
- review output hanya dalam batas yang bisa diawasi dalam satu sitting,
- jangan minta AI kerjakan sesuatu yang lo sendiri nggak bisa lakukan.

---

## Struktur Argumen

Gue menangkap struktur argumennya seperti ini:
1. Agentic coding menjauhkan manusia dari implementasi.
2. Jarak itu mengurangi friction produktif.
3. Hilangnya friction melemahkan mental model dan critical thinking.
4. Critical thinking diperlukan untuk mengawasi output AI.
5. Makin sering coding diserahkan ke AI, makin lemah kemampuan supervisi.
6. Skill internal turun, ketergantungan vendor naik.
7. Permukaan terlihat cepat, tapi sistem jadi rapuh.

Formula ini bikin artikelnya terasa bukan sekadar keluhan. Dia membangun pola:

> speed without intimacy → weaker understanding → weaker supervision → more dependence → more fragility

---

## Prinsip Kunci

- **Coding adalah medium berpikir.** Bukan sekadar langkah terakhir setelah planning.
- **Higher ambiguity ≠ higher abstraction.** LLM bisa bikin kamu ngomong lebih tinggi level tapi justru nambah ambiguitas.
- **Friction produktif itu aset.** Debugging dan kegagalan langsung melatih mental model.
- **Review tanpa produksi tidak cukup.** Jadi editor tanpa pernah nulis panjang sendiri membuat kemampuan design jadi dangkal.
- **AI harus diturunkan statusnya.** Jadi tool bantu, bukan aktor utama.
- **Vendor lock-in lebih dari dependency.** Ini soal erosi kapasitas independen dan habitus kerja.

---

## Contoh Praktis

Kalau lo pakai pola *"biarkan AI generate code, dan manusia cukup review"*, indikatornya biasanya:
- banyak prompt tuning,
- banyak retry,
- banyak guardrail,
- output yang tampak benar tapi nggak dipahami,
- review yang jadi beban.

Alternatif yang gue anggap lebih sehat:
- AI bantu bikin outline, pembagian tugas, atau pseudocode.
- developer tetap implementasi sebagian sendiri.
- AI jadi asisten interaktif untuk eksplorasi, bukan agen eksekusi.

---

## Alert: Junior dan Supervision Paradox

Menurut gue, junior paling rentan karena belum punya stok friction historis. Mereka bisa langsung terseret ke workflow "spec writer + agent reviewer" tanpa pernah bangun pengalaman teknis dari nol.

Review code gak bisa menggantikan pengalaman membangun, debugging, dan discovery failure mode.

---

## Relevansi

Gue melihat artikel ini paling dekat dengan konsep **automation complacency** di penerbangan dan operasi sistem:
- automation meningkatkan throughput,
- manusia jadi operator pengawas,
- skill manual menurun,
- saat edge case datang, pilot/operator kurang siap.

Dalam konteks coding, degradasi skill sering lebih samar. AI output bisa tampak berjalan sementara, sampai sistem makin besar dan sulit di-debug.

---

## Takeaway

Jangan biarkan AI mengambil alih bagian kerja yang justru menjaga ketajaman berpikir teknismu.

Kalimat yang gue pegang:
- Kalau lo masih bisa jawab konkret dalam 10 menit pertama: *"user dari kondisi buruk apa berubah ke kondisi lebih baik apa?"* — berarti service atau workflow itu mungkin sehat.

Di coding, kalau lo gak bisa menjawab: *"apa yang lo perlu pahami setelah nulis baris ini?"*, berarti lo mungkin lagi melewatkan medium berpikir.

---

## Lihat Juga

- [[notes.agentic-coding-is-a-trap]] — note analisis ini.
- [[vault2/daily.journal.2026.05.12]] — refleksi harian atas artikel Lars Faye.
