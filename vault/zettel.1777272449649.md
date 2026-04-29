---
id: zettel.1777272449649
title: "Context engineering melebihi sekadar wording prompt"
desc: "Masalah praktis AI bukan hanya mengubah kata prompt, tapi memilih dan menyusun konteks yang tepat dalam context window."
updated: 1777349718863
created: 1777272449649
tags:
  - zettel
  - ai
  - context
  - the-developers-guide-to-ai
  - chapter-1
---

## Ide inti

Yang gue tangkap dari quote ini adalah bahwa context engineering adalah seni dan ilmu memilih apa yang masuk ke context window, bukan sekadar merangkai wording prompt. Ini adalah perbedaan antara memberi model instruksi dan memberi model pijakan yang benar.

## Quote baseline

> context engineering is the delicate art and science of filling the context window with just the right information...

## Kenapa ini core

Quote ini penting karena dia bisa jadi parent idea terbesar untuk Part II dan III. Di sini gue melihat bahwa prompt engineering saja sering tidak cukup; yang lebih penting adalah apa yang sebenarnya kita masukkan ke dalam window, bagaimana disusunnya, dan bagaimana itu memengaruhi trajectory output.

## Implikasi

- Ini membantu memetakan kapan prompt saja tidak cukup karena konteks yang dimasukkan tidak relevan atau tidak cukup.
- Ini menjelaskan kenapa RAG dan retrieval sering muncul sebagai langkah berikutnya: bukan karena prompt buruk, tapi karena konteks yang dipakai perlu diseleksi dan ditata.
- Ini memperkuat ide bahwa AI praktis adalah tentang system design: memilih data, struktur, format, dan batasan yang tepat untuk model.

## Sumber

- Chapter 1
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
