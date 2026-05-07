---
id: zettel.20260507100600
title: "Agent-native infrastructure needs agent-legible sensors and actuators"
desc: "Karpathy: banyak tooling masih human-native, sementara agent-native memerlukan docs, state, permissions, dan actuator yang bisa dipahami model."
updated: 1778127060000
created: 1778127060000
tags:
  - zettel
  - infrastructure
  - agentic-engineering
  - tooling
---

Claim: Friksi agent bukan hanya di model, tetapi juga di lingkungan kerja yang masih ditulis untuk manusia; agent-native infrastructure membutuhkan sensors, actuators, permissions, dan state yang legible untuk agent.

Evidence:
- Karpathy: "Everything is still fundamentally written for humans... What is the thing I should copy paste to my agent?"
- Contoh deploy Menugen ke Vercel yang sulit karena harus menghubungkan layanan, settings, DNS, dan UI.

Why it matters:
- Menarik perhatian ke sisi infrastructure dan tooling, bukan hanya model.
- Mendorong desain system yang mempertimbangkan agent sebagai first-class consumer.

See also:
- [[book-summaries.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]
