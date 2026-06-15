---
id: zettel.20260511124516
title: "Markdown sebagai source of truth, HTML sebagai human-facing surface"
desc: "Dalam workflow agent, Markdown idealnya menyimpan knowledge, sementara HTML idealnya menyajikan atau mengoperasikan knowledge untuk manusia."
updated: 1778468084906
created: 1778464338603
tags:
  - zettel
  - prompt-engineering
  - markdown
  - html
  - representation
---

Thread Markdown vs HTML untuk LLM menunjukkan satu klaim atomik yang berguna:

Markdown lebih cocok sebagai canonical source of truth dan medium reasoning, sedangkan HTML lebih cocok sebagai rendered surface untuk review, prototype, dan interaksi manusia.

Kalau lo mencampur kedua fungsi ini, lo berisiko membuat format yang terlalu verbose untuk model, atau terlalu sulit dipelihara untuk dokumentasi.

Referensi: [[notes.prompt-engineering.markdown-vs-html-llm]]
