---
id: zettel.20260427000000
title: "Prompt engineering sebagai pola komposisi, bukan prompt sakti"
desc: "Prompt engineering adalah kumpulan teknik yang bisa dikombinasikan, bukan sekadar mencari satu prompt ajaib."
updated: 1777253883716
created: 1777253388017
tags:
  - zettel
  - prompt-engineering
  - ai-engineering
---

Prompt engineering paling berguna kalau dipandang sebagai sistem pola: instruction prompting, persona prompting, in-context learning (zero/one/few-shot), delimiters, chain-of-thought, dan prompt chaining.

Model tidak hanya butuh instruksi yang jelas; ia butuh framing, contoh, struktur, reasoning, dan komposisi langkah. Teknik-teknik ini saling melengkapi dan hasilnya bergantung pada model, data, dan task.

Konsekuensi praktisnya:

- jangan cari "prompt sakti";
- treat prompt as code: versioning, testing, iterasi;
- gunakan prompt chaining untuk pecah workflow kompleks;
- gunakan persona untuk framing implicit;
- gunakan delimiters untuk arsitektur informasi dalam prompt;
- gunakan chain-of-thought hanya jika task reasoning multi-step benar-benar perlu.

Ini menjembatani prompt engineering dengan software engineering: modularity, contracts, debugging, reuse, dan regression testing.