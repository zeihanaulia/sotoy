---
id: zettel.20260611120001
title: "Deterministic Verification > Model Judge"
desc: "Dalam sistem loop AI, verifikasi deterministik (test, schema) harus mendahului verifikasi berbasis model untuk efisiensi dan reliabilitas."
updated: 1781147932584
created: 1781147932530
tags:
  - zettel
  - ai-verification
---

Verifikasi dalam loop AI tidak boleh hanya mengandalkan *model judge* (AI yang mengecek AI). Model judge adalah layer termahal dan paling rentan terhadap bias.

Strategi verifikasi yang sehat adalah bertingkat:
1. **Deterministic Checks**: Menggunakan JSON schema, menjalankan unit test, atau validasi contract. Jika ini gagal, tidak perlu memanggil model judge.
2. **Model Judge**: Digunakan hanya untuk aspek semantik atau kualitas yang tidak bisa diukur secara biner.

Relasi: [[notes.ai-agents.loop-engineering]]
