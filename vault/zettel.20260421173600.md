---
id: zettel.20260421173600
title: "Simulasi BMAD brainstorming: dari keresahan tim kecil AI coding tools ke problem definition"
desc: "Contoh konkret bagaimana bmad-brainstorming mengubah keresahan awal menjadi problem statement, arah solusi, dan langkah validasi." 
tags:
  - bmad
  - brainstorming
  - simulation
  - ai-native
---

## Pertanyaan yang dibuka

1. Bagaimana `bmad-brainstorming` bekerja ketika input awal masih kabur?
2. Apa yang berubah setelah sesi setup, facilitation, dan organize?
3. Bagaimana output brainstorming menjadi bahan valid untuk fase berikutnya?

## Klaim utama

BMAD brainstorming terbaik sukses ketika ia mengubah "gue punya keresahan" menjadi:

* problem inti yang terdefinisi,
* kandidat arah solusi yang relevan,
* langkah validasi berikutnya.

Ukuran suksesnya bukan jumlah ide, tapi kejernihan yang keluar dari sesi.

## Simulasi: kasus tim kecil yang pakai AI coding tools

### Input awal

"Gue pengen bikin sesuatu buat bantu tim kecil yang pakai AI coding tools, soalnya workflow mereka kelihatan cepat tapi sering berantakan."

Dari kalimat ini, BMAD tidak langsung membuat daftar fitur. Ia mulai dengan setup.

### 1. Setup

BMAD menanyakan:

* siapa tim kecil itu? (ukuran, peran, cara kerja)
* apa arti "berantakan" di sini? (konteks hilang, review lemah, ownership tidak jelas)
* apa tujuan sesi ini? (cari problem paling bernilai, arah produk awal, atau validasi feel)
* apa constraint utama? (target user 2–10 engineer, validasi cepat, avoid enterprise-heavy)

Hasil setup:

* topik: workflow tim software kecil yang memakai AI coding tools
* tujuan: menemukan problem paling bernilai untuk arah produk awal
* constraint: tim 2–10 engineer, produk harus bisa divalidasi cepat, solusi sederhana lebih diutamakan

Setup ini bukan mematikan kreativitas. Ia memberi batas yang membuat semua ide yang muncul bisa dibandingkan.

### 2. Choose approach

Dengan input masih kabur, BMAD cenderung memilih pendekatan eksploratif.

AI sebagai fasilitator menawarkan teknik yang membantu user menggali bentuk masalah, misalnya:

* pertanyaan probing,
* reframing situasi,
* breakdown masalah,
* verifikasi asumsi awal.

Tujuannya adalah menemukan nama untuk nyeri yang belum jelas, bukan langsung menghasilkan solusi teknis.

### 3. Facilitation

Fasilitasi BMAD memaksa pertanyaan-pertanyaan seperti:

* dimana berantakannya? Quality? komunikasi? review? konteks? ownership?
* siapa yang paling merasakan sakitnya?
* kapan masalah ini muncul? saat coding, review, atau lintas agen AI?
* apa akibat paling mahal dari kekacauan ini?
* kalau AI dihapus, apakah masalah masih ada?

Dari percakapan, user mungkin menemukan bahwa masalah utamanya adalah:

* konteks keputusan tidak tertangkap,
* alasan perubahan tersebar,
* review hanya melihat output kode, bukan reasoning,
* arsitektur drift pelan tapi nyata.

Ini bukan ide baru. Ini adalah cara memberi nama pada rasa sakit yang tadi masih kabur.

### 4. Organize

Setelah fasilitasi, BMAD mengelompokkan hasilnya ke cluster:

* context retention — menangkap keputusan dan alasan di balik perubahan,
* review quality — membuat review melihat niat, trade-off, dan intent,
* agent coordination — menjaga benang merah ketika banyak alat AI dipakai bersamaan.

Lalu prioritas ditentukan berdasarkan:

* mana yang paling sakit,
* mana yang paling khas untuk tim kecil,
* mana yang paling feasible divalidasi cepat.

Dalam simulasi ini, fokus awal yang muncul adalah:

**alat untuk menangkap dan menyusun konteks perubahan saat menggunakan AI coding workflows.**

### 5. Action

Agar tidak berhenti pada insight, BMAD menutup sesi dengan output tindakan:

* validasi masalah ke engineer atau tech lead yang pakai AI coding tools,
* identifikasi cara mereka sekarang menyimpan keputusan: PR description, commit message, docs, issue tracker, atau tidak sama sekali,
* definisikan hipotesis MVP: context capture, review-ready change summary, atau decision log,
* putuskan apakah sesi berikutnya masuk Product Brief atau PRFAQ.

## Hasil sesi

Jika sesi berjalan benar, outputnya bukan daftar 20 ide. Outputnya adalah narasi yang lebih jelas:

> Tim software kecil yang menggunakan AI coding tools sering kehilangan konteks keputusan dan alasan perubahan. Masalah inti bukan kualitas kode semata, tetapi arsitektur drift dan review yang lemah karena reasoning tidak tercatat. Arah solusi awal yang paling menjanjikan adalah produk untuk menangkap dan menyusun konteks perubahan agar tim bisa melanjutkan kerja tanpa kehilangan reasoning.

Hasil seperti ini sudah masuk ke fase berikutnya karena ia:

* memberikan problem statement yang lebih spesifik,
* menempatkan solusi di domain context retention,
* menyisakan ruang untuk validasi dan fokus MVP.

## Kenapa simulasi ini penting

Simulasi ini menunjukkan bahwa BMAD brainstorming bukan sekadar eksplorasi bebas. Ia adalah proses yang:

* memecah kabut awal,
* memberi nama pada nyeri pengguna,
* membuat opsi menjadi lebih terarah,
* menjaga hasilnya agar bisa dilanjutkan ke Product Brief atau PRFAQ.

Jika brainstorming hanya menghasilkan banyak ide, kemungkinan besar tidak ada yang terpakai. BMAD menilai sukses dari kejernihan sesudah sesi.

## Hubungan ke analysis phase

Brainstorming adalah titik awal dalam BMAD analysis phase. Outputnya bukan final solution, tetapi bahan mentah berpikir yang lebih mapan.

Product Brief akan mengambil fokus yang sudah jelas dan merumuskan:

* target user,
* value proposition,
* scope awal.

PRFAQ akan menguji apakah arah tersebut tahan terhadap pertanyaan kritis.

## Lihat juga

* [[zettel.20260421171633]] — BMAD brainstorming memperjelas ide sebelum requirement
* [[zettel.20260421171825]] — Simulasi BMAD analysis phase: invoice app untuk freelancer
* [[zettel.20260421171457]] — BMAD analysis phase menghentikan ketidakjelasan sebelum berubah jadi PRD dan architecture
* [[zettel.20260421173427]] — AI brainstorming terbaik adalah fasilitasi kondisi insight, bukan generator ide
