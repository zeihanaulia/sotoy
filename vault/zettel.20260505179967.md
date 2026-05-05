---
id: zettel.20260505179967
title: "Agentic coding tools adalah process dengan permission, bukan autocomplete"
desc: "Pengingat bahwa agentic coding memiliki akses filesystem, shell, dan config, sehingga harus diperlakukan sebagai process lokal yang punya boundary izin."
updated: 1777991678277
created: 1777991678277
tags:
  - zettel
  - agentic-coding
  - security
---

Agentic coding tools bukan sekadar chat interface. Mereka adalah process yang bisa membaca file, menjalankan command, memodifikasi workspace, dan berinteraksi dengan lingkungan lokal.

Karena itu, pertanyaan paling relevan adalah: "Agent ini diberikan izin apa?" bukan hanya "apa jawabannya benar?".

Hubungkan ide ini dengan:
- [[notes.security.agentic-coding-permission-boundary]]
- [[notes.security.deepsec-harness]]
- [[notes.security.deepsec-challenges]]
