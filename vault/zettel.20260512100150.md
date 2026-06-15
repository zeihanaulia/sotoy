---
id: zettel.20260512100150
title: "Closed-loop agent workflow perlu intake, grooming, verification, dan audit"
desc: "Saya menyimpulkan bahwa AI code workflow aman hanya kalau ada loop tertutup yang jelas antara input, fix plan, patch, verifikasi, dan audit." 
updated: 1778604764488
created: 1778604126513
tags:
  - zettel
  - ai
  - workflow
  - governance
---

Dari studi workflow ini, saya dapat bahwa agent AI seharusnya tidak langsung mengubah kode dari ticket. Workflow yang sehat mirip pabrik: intake → canonical backlog → grooming → fix queue → isolated execution → verifier terpisah → publish → reconcile.

Yang membuatnya aman adalah rantai evidence. Kalau patch dibuat, hasilnya harus diverifikasi secara independen dan dicatat dengan run ID, diff, test output, dan final status.

Kalau salah satu rantai ini putus, sistem seharusnya berhenti atau kembali ke manusia. Itu perbedaan antara automation yang tahan dan automation yang rapuh.
