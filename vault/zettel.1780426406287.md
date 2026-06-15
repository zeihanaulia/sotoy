---
id: zettel.1780426406287
title: "Stateful agent memory perlu workspace-peer-session-observation"
desc: "Pisahkan ruang kerja, identitas jangka panjang, episode interaksi, dan perspektif agar state agent tidak bocor atau terlalu sempit."
updated: 1780426664141
created: 1780426406287
tags:
  - zettel
  - agentic-engineering
---

Kalau session dan peer dicampur, agent bisa salah nyimpen konteks sementara sebagai identitas permanen. Honcho yang gue baca menekankan: workspace untuk isolasi domain, peer untuk identitas lintas sesi, session untuk episode aktif, observation untuk siapa yang melihat apa. Ini penting supaya memori tetap berguna tanpa jadi omniscient atau terlalu fragmentasi.

Related:
- [[notes.agentic-engineering.hermes-agent.memory-providers|Hermes Agent memory providers]]
- [[notes.agentic-engineering.honcho.architecture|Honcho architecture]]
- [[zettel.moc.agentic-engineering]]
