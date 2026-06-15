---
id: zettel.1777272449644
title: "Output LLM dibangun lewat next-token prediction"
desc: "Respons model dihasilkan token demi token, jadi prompt menentukan trajectory output."
updated: 1777349975837
created: 1777272449633
tags:
  - zettel
  - ai
  - the-developers-guide-to-ai
  - chapter-1
---

## Ide inti

Yang gue tangkap dari quote ini adalah bahwa LLM menghasilkan perilaku kompleks dari mekanisme yang sangat sederhana: menebak token berikutnya berulang kali. Karena output dibangun token demi token, prompt bukan hanya instruksi—dia menentukan trajectory model dan mengubah cara model berpikir.

## Quote baseline

> The model predicts the word most likely to appear next in the sequence, over and over...

## Kenapa ini core

Quote ini penting karena dia menjelaskan banyak fenomena sekaligus:

- prompt sensitivity: sedikit perbedaan input bisa mengubah trajectory output secara drastis.
- hallucination: model bisa terdengar meyakinkan karena dia masih menebak kata paling mungkin, bukan karena dia punya pemahaman kebenaran.
- variability: output tidak deterministik karena ia memilih token satu per satu.
- reasoning as generated trajectory: apa yang kita panggil "reasoning" adalah lintasan token yang dibuat model, bukan proses internal yang terpisah.

## Sumber

- Chapter 1
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
