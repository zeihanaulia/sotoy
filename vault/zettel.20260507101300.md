---
id: zettel.20260507101300
title: "Future agentic systems may be AI-hosted with classical tools as co-processors"
desc: "Karpathy: neural net bisa menjadi host process sementara CPU/tools menjadi co-processor untuk deterministic tasks."
updated: 1778127412000
created: 1778127412000
tags:
  - zettel
  - ai
  - architecture
  - agentic-engineering
---

Claim: Dalam masa depan agentic system, neural net/LLM bisa menjadi host process yang mengorchestrasi pekerjaan, sementara CPU dan tools deterministik berperan sebagai co-processor.

Evidence:
- Karpathy: "the neural net becomes kind of like the host process and the CPUs become kind of like the co-processor."
- Dia menggambarkan kemungkinan arsitektur di mana AI process menjalankan sebagian besar beban, dan tools klasik dipakai untuk tugas yang memerlukan determinisme.

Why it matters:
- Mengubah mental model arsitektur sistem: bukan app dengan AI feature, tapi AI process dengan tool feature.
- Menarik perhatian pada desain agentic infrastructure dan pembagian kerja antara probabilistic model dan deterministic subsystem.

See also:
- [[book-summaries.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]
- [[zettel.literature.karpathy-from-vibe-coding-to-agentic-engineering]]
