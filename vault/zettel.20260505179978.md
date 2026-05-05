---
id: zettel.20260505179978
title: "CI security gate butuh threshold dan baseline, bukan fail-on-any-finding"
desc: "Pakai scanning di CI dengan ambang severity dan baseline exception agar tidak gagal karena noise."
updated: 1777991678277
created: 1777991678277
tags:
  - zettel
  - security
  - ci
  - workflow
---

Scanner keamanan di CI tidak harus diperlakukan sebagai gate biner kecuali temuan jelas critical/high dan low-noise. Praktik yang lebih baik adalah gagal hanya pada issue kritis, gunakan baseline untuk risiko lama, dan export report untuk triage.

Hubungkan ide ini dengan:
- [[notes.security.deepsec-docs]]
- [[notes.security.overtrust]]
