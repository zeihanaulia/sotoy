---
id: zettel.20260505180211
title: "API pricing ditentukan oleh active parameter dan optimisasi provider, bukan usia model"
desc: "Model tua bisa lebih mahal daripada model baru jika serving-nya kurang efisien."
updated: 1777983786427
created: 1777983786427
tags:
  - zettel
  - pricing
  - llm
  - qwen
---

Model API tidak selalu lebih murah hanya karena lebih tua. Faktor penentu harga termasuk:

- active parameter per token,
- optimisasi kernel/quantization di provider,
- demand dan strategi pricing,
- konteks panjang yang didukung.

Contoh: `Qwen3-235B-A22B` bisa lebih murah daripada `Qwen2.5-72B` karena ia hanya mengaktifkan sekitar 22B parameter per token pada arsitektur MoE.
