---
id: zettel.20260421193300
title: "Model dan agent adalah fungsi berbeda dalam AI-native engineering"
desc: "Memisahkan model reasoning dari agent eksekusi adalah kunci untuk mendiagnosis kegagalan AI-native dengan benar." 
tags:
  - ai-native
  - model
  - agent
  - orchestration
---

## Pertanyaan yang dibuka

1. Apa bedanya model dengan agent dalam AI-native engineering?
2. Kenapa pemisahan ini penting untuk diagnosis kegagalan?
3. Bagaimana satu agent bisa memakai beberapa model?

## Klaim utama

Model dan agent bukan dua istilah yang bisa ditukar. Model adalah kapasitas reasoning dan pengetahuan. Agent adalah lapisan eksekusi yang memakai model itu untuk bergerak di lingkungan kerja.

> Kalau model adalah otak, agent adalah tubuh yang melakukan tindakan berdasarkan pemikiran itu.

## Perbedaan fungsi

* Model: memproses konteks, menghasilkan inferensi, teks, kode, ringkasan, atau analisis.
* Agent: menjelajah repo, menjalankan command, mengubah file, memanggil tool, dan mengeksekusi workflow.

## Mengapa pemisahan ini penting

Ketika hasil AI buruk, diagnosisnya tidak bisa berhenti pada "agent ini jelek". Ada beberapa kemungkinan lain:

* model tidak cocok untuk task tertentu,
* context tidak cukup jelas,
* methodology tidak mengarahkan workflow dengan benar,
* atau agent tidak diberi toolset yang sesuai.

Agent bisa tampak gagal padahal model bagus. Sebaliknya, model pintar bisa salah arah jika agent tidak punya workflow atau context yang tepat.

## Implikasi

* Satu agent dapat memakai banyak model untuk fungsi berbeda: code reasoning, test generation, documentation synthesis.
* Pertanyaan yang lebih matang adalah bukan "agent ini pakai model apa?" melainkan "aktivitas ini butuh model apa, dan bagaimana agent mengorkestrasi perpindahan model?"

## Kesalahan umum

* Menganggap agent adalah produk utuh yang otomatis lebih pintar.
* Mengukur keberhasilan hanya dari kualitas agent, bukan dari kombinasi model, context, dan methodology.
* Saling menyalahkan agent ketika masalah sebenarnya ada pada model atau guardrail.

## Lihat juga

* [[zettel.20260421161001]] — AI-native adalah jargon strategi yang menandai asumsi desain AI sebagai fondasi, bukan sekadar fitur tambahan
* [[zettel.20260421172636]] — BMAD activation flow dan customization: menyusun agent dari template, konteks, dan kebiasaan tim
* [[zettel.20260421193544]] — Agent eksplorasi codebase harus struktural, bukan sekadar search random
