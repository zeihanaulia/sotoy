---
id: zettel.20260507102200
title: "Agent can fill in details, but humans must maintain invariant system design"
desc: "Karpathy: agent sering gagal di domain model dan invariant sistem; manusia harus tetap mengontrol spec dan oversight."
updated: 1778775926045
created: 1778127549838
tags:
  - zettel
  - ai
  - system-design
  - oversight
---

Claim: Agent dapat mengisi detail implementasi, tetapi manusia harus menjaga invariant desain sistem seperti identity stability.

Evidence:
- Karpathy: agent di Menugen mencoba mengaitkan Stripe email dengan Google email, padahal user identity harus pakai persistent ID.

Why it matters:
- Menunjukkan bahwa kegagalan AI sering berada di level domain model, bukan syntax.
- Mempertegas peran manusia sebagai penjaga invariant sistem.

See also:
- [[notes.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]
