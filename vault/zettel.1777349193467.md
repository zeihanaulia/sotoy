---
id: zettel.1777349193467
title: "Nilai model dibatasi oleh distribusi data latihnya"
desc: "Keterbatasan LLM sering berasal dari data latih yang digunakan, bukan hanya arsitektur atau penyedia model."
updated: 1777349975837
created: 1777349205612
tags:
  - zettel
  - ai
  - data
  - grounding
  - the-developers-guide-to-ai
  - part-i
---

## Ide inti

Yang gue tangkap dari quote “A model is only as good as the data it was trained on” adalah bahwa batasan LLM sering lebih berasal dari distribusi data latih daripada dari jumlah parameter, provider, atau hype. Model bisa fasih dan impresif, tetapi jika training-nya tidak mewakili domain yang mau kita pakai, ia akan sering meleset.

## Quote baseline

> A model is only as good as the data it was trained on.

## Kenapa ini core

Quote ini penting karena dia menempatkan problem AI bukan hanya di level model, tetapi pada asal-usul knowledge model itu sendiri. Itu jadi node induk untuk isu seperti hallucination, bias, stale knowledge, dan kenapa grounding domain diperlukan.

## Implikasi

- Kalau model dilatih dengan distribusi data yang salah, outputnya bisa generik, bias, atau tidak relevan.
- Ini membantu menjelaskan kenapa model besar tidak otomatis berarti cocok untuk semua use case.
- Ini juga menegaskan bahwa domain grounding dan retrieval bukan pelengkap saja, tapi respon terhadap batasan training distribution.
- Dalam konteks buku, ini memperkuat argumentasi bahwa adopsi AI praktis perlu fokus pada data dan konteks, bukan hanya model terbaik.

## Sumber

- Part I
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
