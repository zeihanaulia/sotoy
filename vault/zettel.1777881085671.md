---
id: zettel.1777881085671
title: "Threshold-based session privacy still leaves pre-trigger exposure"
desc: "Dalam agentic privacy, retroactive masking hanya mencegah kebocoran di sesi berikutnya; data yang sudah dikirim sebelum trigger tetap menjadi risiko." 
tags:
  - zettel
  - privacy
  - pii
  - agent
  - threshold
created: 1777881101021
updated: 1777948653344
---

> Threshold-triggered privacy intervention tidak bisa menghapus apa yang sudah dikirim ke external LLM sebelum trigger.

Catatan gue:

- Sistem seperti CAMP melakukan pseudonymization retroactive saat cumulative risk melewati threshold.
- Namun jika history asli sudah pernah dikirim sebelum threshold tercapai, request log eksternal masih bisa menyimpan data asli.
- Artinya proteksi ini hanya mencegah eksposur berulang di masa depan, bukan membatalkan eksposur masa lalu.

Implikasi:

- alignment klaim privacy harus jelas: ini mitigasi cumulative future exposure, bukan jaminan zero exposure.
- untuk threat model yang menganggap adversary punya access ke request logs, pre-trigger data harus dihitung sebagai bocor.
- desain sistem yang kuat perlu kombinasi: threshold-based action + early masking/minimization untuk entitas yang jelas sensitif.

Hubungan:

- [[notes.security.pii-agent-architecture.camp.indexed-masking]]
- [[notes.security.pii-agent-architecture.camp.why-camp]]
- [[notes.security.pii-agent-architecture.camp]]
- [[notes.security.pii-agent-architecture]]
