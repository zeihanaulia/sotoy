---
id: zettel.20260507102600
title: "Agent-native infrastructure needs agent-legible docs, APIs, and actuators"
desc: "Karpathy: banyak friction AI datang dari lingkungan kerja yang masih ditulis untuk manusia, bukan agent."
updated: 1778127555000
created: 1778127555000
tags:
  - zettel
  - infrastructure
  - agentic-engineering
  - tooling
---

Claim: Agent-native infrastructure membutuhkan docs, APIs, permissions, state, sensor, dan actuator yang legible untuk agent, bukan hanya manusia.

Evidence:
- Karpathy: "Everything is still fundamentally written for humans... What is the thing I should copy paste to my agent?"
- Contoh Menugen deployment ke Vercel: kesulitan bukan karena coding, tapi karena menghubungkan layanan, settings, DNS, dan menu UI.

Why it matters:
- Menyoroti bahwa friction agent sering berada di tingkat environment dan tooling.
- Mendorong desain system yang memperlakukan agent sebagai first-class consumer.

See also:
- [[notes.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]
- [[zettel.moc.agentic-engineering]]
- [[notes.agentic-engineering.openclaw-personal-agent-orchestration]]
