---
id: notes.security.pii-agent-architecture.camp
title: "CAMP: Cross-Turn PII Protection for LLM Conversations"
desc: "Deep dive CAMP: framework pengaman PII yang mempertimbangkan akumulasi informasi lintas percakapan agent." 
updated: 1777948651875
created: 1777871749375
tags:
  - notes
  - security
  - pii
  - agent
  - llm
---

## Problem
Paper ini menegaskan bahwa proteksi PII untuk agentic multi-turn masih terlalu stateless. Sistem seperti Presidio, PAPILLON, dan adaptive masking lain sering memeriksa satu pesan per turn, lalu hasilnya hilang begitu saja. Padahal history percakapan yang terus dikirim ulang ke LLM bisa menggabungkan potongan-potongan kecil menjadi profil yang cukup kuat untuk re-identification.

## Three-question lens
Paper ini sebenarnya dibangun dari tiga pertanyaan berurutan:
- apa yang salah dengan per-turn masking?
- apa yang baru dari Cumulative PII Exposure (CPE)?
- apa yang baru dari CAMP sebagai solusi?

Kalau lo paham tiga ini, lo bisa menilai apakah CAMP cuma "masking baru" atau benar-benar perubahan unit analisis dari message-level ke session-level.

Untuk pembahasan mendalam soal per-turn masking, lihat [[notes.security.pii-agent-architecture.camp.per-turn-masking]].
Untuk pembahasan mendalam soal CPE, lihat [[notes.security.pii-agent-architecture.camp.cpe]].
Untuk pembahasan mendalam soal solusi CAMP, lihat [[notes.security.pii-agent-architecture.camp.why-camp]].
Untuk pembahasan indexed masking / tokenized pseudonymization, lihat [[notes.security.pii-agent-architecture.camp.indexed-masking]].

## Cumulative PII Exposure (CPE)
CAMP memperkenalkan CPE sebagai metrik session-level. Prinsipnya:
- bukan hanya apakah satu message mengandung PII,
- tetapi apakah kombinasi entitas yang terkumpul sepanjang session sudah berisiko.

Setiap tipe entitas diberi bobot sensitivitas berbeda: SSN/credit card 1.0, date of birth 0.9, medical 0.85, email 0.8, phone 0.75, person/salary 0.6, location/IP 0.5, organization 0.3.

Lalu paper menambahkan co-occurrence graph:
- node = tipe entitas yang muncul di session,
- edge = dua tipe entitas muncul bersama dalam session.

Karena risiko tidak linear, entity baru bisa menaikkan skor lebih besar jika dia terhubung ke banyak entity lain. Formula yang dipakai mirip:

CPE = Σ weight(v) × (1 + α × degree(v))

Jadi satu entity yang "terhubung" ke banyak entitas lain memberi amplifikasi risiko.

## CAMP architecture
Solusi CAMP bekerja sebagai middleware antara user dan external LLM. Komponennya:

- **Per-turn PII extractor**: masih deteksi PII seperti sistem lama, tetapi hasilnya disimpan.
- **Session registry**: menyimpan semua entitas PII yang pernah muncul, lengkap dengan tipe, nilai asli, dan turn pertama.
- **Co-occurrence graph + CPE scorer**: menghitung risiko kombinasi antar entitas sepanjang session.
- **Hard block rules**: tipe sangat sensitif (SSN, kartu kredit, bank account) langsung diblokir sejak awal.
- **Retroactive pseudonymization**: ketika threshold terlampaui, tulis ulang seluruh history dengan pseudonym yang konsisten.
- **De-masking layer**: setelah LLM menjawab, ganti synthetic values kembali ke nilai asli sebelum ditampilkan ke user.

Contoh efeknya:
- history asli: "Nama gue Andi", "Gue tinggal di Bandung", "Gue kerja di Tokopedia", "Gaji gue 28 juta"
- history pseudo: "Nama gue Budi", "Gue tinggal di Surabaya", "Gue kerja di Acme Corp", "Gaji gue 21 juta"

External LLM hanya melihat history pseudo. User tetap mendapat jawaban personal setelah de-masking.

## Threshold dan trade-off
CAMP punya knob privasi: threshold CPE.
- threshold rendah = proteksi lebih cepat, context lebih sering dipseudonymize,
- threshold tinggi = lebih banyak konteks asli lewat, tapi risiko terlambat proteksi.

Domain seperti healthcare dan finance harus lebih konservatif. General assistant bisa pakai threshold lebih longgar.

## Why this matters
Untuk security agent design, paper ini mengubah perspektif dari "masking per pesan" ke "mengelola risiko PII pada level sesi".

Implikasinya:
- agent harus punya stateful PII registry,
- proteksi harus sadar __cumulative exposure__, bukan hanya __current message content__,
- retroactive rewriting bisa jadi mekanisme penting ketika seluruh history sudah melewati batas risiko.

## Limitations
- CAMP bergantung pada kualitas deteksi PII. Implicit disclosure atau phrasing yang tidak eksplisit masih bisa lolos.
- Eksperimennya synthetic dan belum diuji pada percakapan nyata yang noisy.
- Bobot entitas dan parameter α masih bersifat heuristic.
- Pseudonymization bisa mengganggu semantics untuk kasus tertentu jika tidak preserve meaning dengan hati-hati.
- De-masking sulit jika model memparafrase nilai synthetic secara tidak terduga.

## Related zettel
- [[zettel.1777875390302]]

Original paper: https://arxiv.org/abs/2604.16521

Link: [[notes.security.pii-agent-architecture]]
