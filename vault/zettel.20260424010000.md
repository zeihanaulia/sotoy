---
id: zettel.20260424010000
title: "Prompt engineering adalah lapisan kontrol pertama untuk LLM" 
desc: "Prompt adalah alat kontrol yang mengarahkan distribusi probabilitas output LLM, bukan sekadar teks biasa." 
updated: 1777253882236
created: 1776970133238
tags:
  - zettel
  - prompt-engineering
  - ai
  - control
---

Prompt engineering bukan hanya soal menulis kata-kata yang enak didengar oleh AI. Ini tentang mengarahkan distribusi kemungkinan output model dengan mendesain instruksi, konteks, contoh, query, dan format output.

- model tidak memahami maksud lo; ia hanya melihat token yang lo kirim
- prompt yang vague memberi ruang interpretasi terlalu besar
- prompt yang panjang tidak selalu lebih baik karena context window dan token cost
- prompt adalah artefak desain sistem, bukan sekadar teks perintah

## Relevansi

* [[book-summaries.the-developers-guide-to-ai]] — overview struktur dan level buku sebagai peta praktis AI engineering untuk developer
* [[zettel.moc.ai-native]] — MOC AI-native engineering
