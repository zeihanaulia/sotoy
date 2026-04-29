---
id: zettel.1777272449646
title: "LLM probabilistik; kode tradisional deterministik"
desc: "Software tradisional mengeksekusi aturan deterministik, sementara LLM memilih output berdasarkan probabilitas pola yang dipelajari."
updated: 1777350556088
created: 1777272449646
tags:
  - zettel
  - ai
  - probabilistic
  - deterministic
  - the-developers-guide-to-ai
  - chapter-1
---

## Ide inti

Yang gue tangkap dari quote ini adalah bahwa perbedaan paling fundamental antara software tradisional dan LLM bukan sekadar performa atau fitur, tapi mode komputasinya. Software tradisional menjalankan aturan eksplisit secara deterministik, sedangkan LLM menghasilkan output berdasarkan estimasi probabilistik terhadap pola yang dipelajarinya.

## Quote baseline

> Traditional programming is based on Boolean logic. It’s deterministic. / The results you get with any given input are probabilistic.

## Kenapa ini core

Quote ini penting karena dia menjelaskan kenapa AI terasa powerful sekaligus weird bagi engineer: karena AI bukan software biasa yang bisa diprediksi 100%, dia beroperasi di ruang kemungkinan. Itu membuat prompt menjadi kontrol penting, output bisa beragam, dan hallucination menjadi konsekuensi logis.

## Implikasi

- Software tradisional cocok untuk logika pasti, validasi, dan aturan bisnis tetap.
- LLM cocok untuk tugas-tugas fuzzy seperti bahasa alami, generalisasi, dan interpretasi.
- Perbedaan ini menjelaskan kenapa output LLM bisa berubah meski prompt serupa, dan kenapa ia bisa salah dengan cara yang meyakinkan.
- Karena sifat probabilistik ini, manusia sering perlu berada di loop untuk menangani kegagalan, validasi, dan kejadian edge-case.
- Ini juga border penting untuk memutuskan kapan gunakan code deterministic dan kapan tambahkan LLM sebagai komponen yang lebih fleksibel.

## Sumber

- Chapter 1
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
