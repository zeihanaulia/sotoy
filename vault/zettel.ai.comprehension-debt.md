---
id: "zettel.ai.comprehension-debt"
title: "Comprehension Debt dalam AI-Driven Development"
description: "Hutang pemahaman yang muncul ketika volume kode yang dihasilkan AI melampaui kapasitas manusia untuk memahami arsitektur dan alasan di balik setiap keputusan."
tags:
  - cognitive-load
  - ai-coding
  - software-architecture
created: 1781158975599
updated: 1781161780988
---

## Konsep
**Comprehension Debt** adalah kondisi di mana codebase tumbuh dengan cepat berkat AI, tetapi mental model engineer terhadap sistem tersebut tidak tumbuh dengan kecepatan yang sama.

## Mekanisme Terjadinya
1. **High Volume Output**: AI menghasilkan ratusan baris kode dalam hitungan detik.
2. **Cognitive Surrender**: Engineer melakukan merge karena test hijau, tanpa benar-benar memahami *mengapa* solusi tersebut dipilih atau bagaimana itu mempengaruhi bagian lain.
3. **Loss of Intent**: Alasan arsitektural di balik sebuah implementasi hilang karena tidak ada proses desain manual yang mendahuluinya.

## Dampak
- **Fragility**: Engineer takut mengubah kode karena tidak paham efek sampingnya.
- **Architectural Drift**: Sistem perlahan kehilangan koherensi karena AI membuat keputusan lokal yang tidak align dengan visi global.
- **Dependency on AI**: Engineer menjadi tidak mampu memperbaiki bug kompleks tanpa bantuan AI karena sudah kehilangan pemahaman dasar.

## Mitigasi
- **Small Batches**: Membatasi jumlah kode yang di-generate dalam satu iterasi.
- **Human-Led Design**: Menetapkan arsitektur sebelum implementasi.
- **Ritual Review**: Audit architectural diff secara berkala untuk menyinkronkan kembali mental model manusia dengan state codebase.
