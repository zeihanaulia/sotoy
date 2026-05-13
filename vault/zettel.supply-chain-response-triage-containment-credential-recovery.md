---
id: zettel.supply-chain-response-triage-containment-credential-recovery
title: "Respon supply-chain efektif adalah triage → containment → credential recovery"
desc: "Respons supply-chain harus dibagi menjadi triage artefak, containment persistence/network, dan credential recovery, bukan checklist tunggal."
updated: 1778645837051
created: 1778645837051
tags:
  - zettel
  - security
  - supply-chain
  - incident-response
---

Supply-chain response yang efektif mengikuti tiga layer.

1. Triage: verifikasi artefak, IOC, dan evidence execution.
2. Containment: putus persistence, batasi egress, dan blok path yang terpengaruh.
3. Credential recovery: anggap secret mungkin bocor dan pulihkan trust.

Checklist datar sering gagal karena mengaburkan urutan logis antara bukti, containment, dan recovery.
