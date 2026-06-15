---
id: zettel.1777272449643
title: "LLM adalah model pretrained, bukan sihir"
desc: "LLM kuat karena pretraining skala besar atas data tekstual masif, bukan karena reasoning manusiawi atau aturan eksplisit."
updated: 1777349975838
created: 1777272449633
tags:
  - zettel
  - ai
  - the-developers-guide-to-ai
  - chapter-1
---

## Ide inti

Yang gue tangkap dari quote ini adalah bahwa LLM bukan sekadar sistem yang kita program dengan aturan khusus. Dia adalah model statistik besar yang memperoleh kemampuan bahasa dan knowledge umum dari pretraining skala besar atas data teks masif. Kekuatan LLM datang dari data dan skala, bukan dari logika rule-based atau reasoning manusiawi.

## Quote baseline

> Large language models (LLMs) are very large, deep learning models that are pretrained on vast amounts of data.

## Kenapa ini core

Quote ini mendirikan fondasi ontologis buku. Dari sini lo bisa jelaskan mengapa LLM bisa fasih, mengapa ia bisa menghasilkan generalisasi, kenapa ia bisa halusinasi, dan kenapa ia tidak otomatis tahu domain privat kita. Dengan memahami definisi ini, hampir semua keputusan buku jadi masuk akal: prompt, RAG, fine-tuning, dan agents semua muncul sebagai cara untuk mengarahkan atau melengkapi model pretrained tersebut.

## Implikasi

- "very large" menunjukkan kapasitas besar untuk menangkap pola bahasa kompleks, sekaligus menandai biaya dan trade-off.
- "deep learning models" menegaskan bahwa LLM adalah learned behavior, bukan rule-based software.
- "pretrained" menegaskan bahwa developer memulai dari capability yang sudah ada, bukan dari nol.
- "vast amounts of data" menjelaskan bahwa kemampuan model berasal dari exposure ke banyak pola, bukan dari pemahaman manusiawi.

## Sumber

- Chapter 1
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
