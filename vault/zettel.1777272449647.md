---
id: zettel.1777272449647
title: "Hallucination adalah konsekuensi arsitektural LLM"
desc: "Hallucination terjadi saat LLM menghasilkan jawaban yang terdengar meyakinkan tetapi tidak didukung oleh konteks/TIDAK grounded."
updated: 1777357541533
created: 1777272449633
tags:
  - zettel
  - ai
  - hallucination
  - grounding
  - the-developers-guide-to-ai
  - chapter-1
---

## Ide inti

Yang gue tangkap dari quote “This is referred to as a hallucination” adalah bahwa hallucination adalah produk alami dari LLM yang tetap memprediksi token berikutnya meski konteks relevan lemah. Model bisa terdengar meyakinkan, tapi kalau jawaban itu tidak didukung fakta atau konteks yang benar, itu bukan informasi benar — itu hallucination.

## Quote baseline

> This is referred to as a hallucination.

## Kenapa ini core

Quote ini penting karena dia memberi definisi yang jelas tentang failure mode AI yang sering disalahpahami. Hallucination bukan sekadar error biasa; dia adalah akibat langsung dari arsitektur probabilistik LLM yang terus menghasilkan output, bahkan ketika pengetahuan yang relevan tidak ada.

## Apa itu hallucination?

Menurut gue, hallucination adalah ketika LLM mengisi celah dengan pola bahasa yang plausible, bukan dengan fakta atau konteks yang ter-ground. Dia mirip dengan orang yang setengah tahu topik, tapi tetap jawab dengan percaya diri. Model tidak "berbohong" secara moral; dia hanya menebak jawaban yang paling cocok menurut pola bahasa yang dia pelajari.

## Kenapa ini penting

Hallucination adalah konsekuensi dari kombinasi:

- pengetahuan relevan yang kurang atau tidak ada,
- model yang dirancang untuk melanjutkan teks,
- dan kemampuan bahasa yang sangat kuat.

Karena itu, solusi yang tepat biasanya bukan mencari model yang tidak pernah halu. Solusi yang lebih tepat adalah:

- grounding,
- retrieval,
- prompt constraints,
- tool use,
- dan human review.

## Hallucination vs error biasa

Tidak semua jawaban salah = hallucination. Hallucination biasanya melibatkan:

- fabrikasi detail yang plausible,
- rujukan fiktif,
- atau langkah teknis yang terdengar masuk akal tetapi salah.

Sedangkan error biasa bisa muncul dari reasoning keliru, context misunderstanding, atau retrieval yang buruk.

## Implikasi untuk sistem

Hallucination menunjukkan bahwa plausibility ≠ truth. Ini membuat kita paham kenapa:

- prompt yang rapi tidak otomatis berarti jawaban benar,
- human-in-the-loop kadang wajib,
- citations dan source visibility penting,
- risk mitigation lebih penting daripada sekadar capability.

## Sumber

- Chapter 1
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
