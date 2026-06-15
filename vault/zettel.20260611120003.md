---
id: zettel.20260611120003
title: "AI Loop as an Attack Surface"
desc: "Loop AI yang mengonsumsi input eksternal mewarisi attack surface manusia dan rentan terhadap prompt injection."
updated: 1781147970395
created: 1781147970360
tags:
  - zettel
  - ai-security
---

Loop AI yang membaca data dari sumber eksternal (GitHub issues, web, Slack) secara otomatis mewarisi *attack surface* dari sumber tersebut. Setiap input eksternal adalah potensi *injection point* yang bisa memanipulasi instruksi agent.

Keamanan loop tidak bisa hanya mengandalkan "prompt yang kuat", tetapi harus menggunakan arsitektur keamanan: permission minimal, sandbox eksekusi, dan approval boundary untuk aksi yang berdampak tinggi.

Relasi: [[notes.ai-agents.loop-engineering]]
