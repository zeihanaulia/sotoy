---
id: zettel.1777272449642
title: "LLM kuat bahasa tapi lemah truth domain privat"
desc: "Kefasihan LLM bukan jaminan bahwa ia punya pengetahuan produk atau domain privat yang relevan."
updated: 1777281495813
created: 1777272449642
tags:
  - zettel
  - ai
  - grounding
  - the-developers-guide-to-ai
  - part-i
---

## Ide inti

Yang gue tangkap dari quote “It obviously knew nothing about the team’s product” adalah bahwa LLM bisa fasih banget secara bahasa, tapi itu tidak berarti dia tahu apa pun tentang domain privat kita. Model generik mungkin tahu support tone dan troubleshooting umum, tapi itu bukan sama dengan tahu flow, fitur, dan istilah produk kita.

## Quote baseline

> It obviously knew nothing about the team’s product.

## Kenapa ini core

Quote ini adalah diagnosis pertama yang menunjukkan batas nyata dari eksperimen awal. Setelah integrasi API dan percobaan pertama, tim menyadari bahwa masalah utama bukan lagi "bagaimana memanggil model", tapi "model ini tidak terikat ke pengetahuan produk kami." Itu adalah origin point bagi kebutuhan grounding.

## Apa yang dimaksud “knew nothing”

Kalau dibaca hati-hati, ini bukan mengatakan model bodoh secara absolut. Yang dimaksud adalah:

- model tidak tahu produk tim itu,
- model tidak tahu alur login atau help flow produk itu,
- model tidak tahu nama menu, fitur, atau istilah internal mereka,
- model tidak tahu batasan dan kebijakan support mereka.

Jadi "nothing" di sini berarti "nothing relevant to this domain." Itu perbedaan penting.

## Kenapa ini penting

Quote ini memotong ilusi bahwa fluency otomatis sama dengan usefulness. Di dunia nyata, model support yang berguna harus bisa melakukan lebih dari sekadar bicara dengan baik. Dia harus:

- tahu produk yang didukung,
- tahu prosedur yang benar,
- tahu kapan dirinya tidak tahu,
- dan tahu kapan perlu fallback ke manusia.

Itu adalah standar domain usefulness, bukan hanya standar bahasa alami.

## Impikasi untuk arsitektur

Quote ini membantu kita mengidentifikasi kapan masalah tidak selesai dengan prompt yang lebih baik saja. Jika model benar-benar tidak punya pengetahuan domain dasar, maka solusi pertama bukan fine-tuning; solusi pertama adalah grounding: memberi model akses ke sumber pengetahuan yang relevan.

Dengan kata lain, ini adalah transisi dari:

- "mencari model lebih pintar"

ke:

- "membangun sistem yang menghubungkan model ke product knowledge."

## Sumber

- Part I
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
