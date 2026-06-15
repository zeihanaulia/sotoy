---
id: zettel.20260505180230
title: "Hitung biaya coding agent berdasarkan total task cost, bukan hanya harga per token"
desc: "Dalam agent workflows, model murah bisa kalah jika loop dan retries membuat total token usage melonjak."
updated: 1777985390759
created: 1777983870896
tags:
  - zettel
  - economics
  - agent
  - llm
---

Untuk coding agent, biaya terbaik bukan cuma tarif per token. Yang penting adalah berapa token total yang digunakan sampai task selesai.

Sehingga model murah bisa kalah jika:

- loopnya panjang,
- outputnya besar,
- prompt perlu banyak retry,
- agent sering menyala ulang konteks.

Dalam banyak kasus, model yang sedikit lebih mahal per token tapi dapat menyelesaikan task dengan lebih sedikit step akan lebih murah secara total.
