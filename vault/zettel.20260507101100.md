---
id: zettel.20260507101100
title: Agent instructions replace deterministic scripting in variable environments
desc: >-
  Karpathy: dalam Software 3.0, agent dapat menyesuaikan detail operasional
  sehingga tidak perlu menulis semua cabang logika eksplisit.
updated: 1778127121000
created: 1778127121000
tags:
  - zettel
  - agentic-engineering
  - software-3-0
  - automation
---

Claim: Instruksi untuk agent menggantikan sebagian scripting deterministik, terutama dalam workflow yang memiliki banyak variasi environment.

Evidence:
- Karpathy: "you don't have to precisely spell out all the individual details of that setup." saat menjelaskan OpenClaw install yang biasanya butuh shell script kompleks.
- Dalam Software 3.0, programmer menulis intensi dan constraint, lalu agent menyesuaikan detail operasional.

Why it matters:
- Menandai pergeseran dari menulis cabang logika eksplisit ke mendesain intent dan environment-aware guidance.
- Mengurangi beban engineering pada variasi platform dan konfigurasi, sambil tetap menjaga tanggung jawab atas hasil.

See also:
- [[notes.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]
- [[zettel.20260507101000]]
- [[zettel.moc.agentic-engineering]]
- [[notes.agentic-engineering.openclaw.personal-agent-orchestration]]
