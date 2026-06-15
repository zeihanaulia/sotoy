---
id: zettel.1777272449641
title: "LLM membutuhkan grounding untuk bisa berguna"
desc: "Grounding adalah membuat output model terikat pada konteks nyata dan relevan, bukan hanya pada pola bahasa umum."
updated: 1777282015599
created: 1777272449633
tags:
  - zettel
  - ai
  - grounding
  - the-developers-guide-to-ai
  - part-i
---

## Ide inti

Yang gue tangkap dari quote “It worked—sort of” adalah bahwa LLM generik memang sering memberi proof of possibility: cukup fasih untuk bikin eksperimen terasa bermakna, tapi belum cukup grounded untuk bisa dipercaya sebagai solusi nyata. Grounding itu bukan soal gaya bahasa, tapi soal apakah jawaban itu punya pijakan pada konteks dan fakta domain yang relevan.

## Quote baseline

> It worked—sort of.

## Kenapa ini core

Quote ini penting karena dia memecah ilusi “AI langsung beresin masalah” tanpa mematikan optimisme. Di titik ini saya mulai sadar bahwa adopsi LLM punya dua lapisan: model bisa dipanggil dan menghasilkan bahasa bagus; tapi outputnya juga harus diikat ke realitas produk dan domain.

## Apa itu grounding?

Grounding adalah proses membuat jawaban model terikat pada konteks nyata: dokumen, database, source of truth, atau hasil tool yang relevan. Ini yang membuat jawaban model lebih dari sekadar fluent: dia harus grounded.

## Kenapa grounding penting

Tanpa grounding, model bisa terdengar pintar tapi tetap salah karena dia hanya mengandalkan pola bahasa umum. Ini sebabnya LLM tanpa grounding sering:

- terlalu generik,
- salah produk,
- salah prosedur,
- atau mengarang halusinasi.

Itu juga alasan mengapa buku menulis:

> "it obviously knew nothing about the team’s product."

## Grounding vs prompt engineering

Prompt engineering fokus pada cara memberi instruksi dan struktur output. Grounding fokus pada sumber yang dipakai model sebagai pijakan. Model bisa punya prompt yang rapi, tetapi tetap salah kalau konteksnya tidak grounded.

## Grounding bukan jaminan truth absolut

Grounding meningkatkan peluang jawaban benar, tapi tidak menghapus kemungkinan error. Anda masih butuh:

- sumber yang relevan,
- retrieval yang benar,
- prompt yang jelas,
- dan batasan yang tegas.

Grounding hanya mengurangi ruang bagi model untuk sekadar mengarang.

## Implikasi

- "Worked" menunjukkan bahwa LLM bisa menghasilkan bahasa yang wajar.
- "Sort of" menunjukkan bahwa fluency tidak sama dengan usefulness.
- Bottleneck berpindah dari "bagaimana panggil model" ke "bagaimana memberi model konteks yang benar." 
- Pola ini berulang sepanjang buku: solusi awal cukup menjanjikan, lalu limit berikutnya baru ketemu setelah dipakai.

## Sumber

- Part I
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
