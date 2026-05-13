---
id: til.security.socket-recommended-action-layers
title: "Recommended actions supply-chain harus dibaca sebagai triage → containment → credential recovery"
desc: "Socket menyarankan respons insiden supply-chain dalam tiga layer: cek artefak, batasi persistence/network, lalu anggap secret mungkin bocor."
updated: 1778643255851
created: 1778643255851
tags:
  - til
  - security
  - supply-chain
  - incident-response
---

TIL: daftar rekomendasi Socket untuk serangan Mini Shai-Hulud bukan checklist datar. Lebih tepat dibaca sebagai:

1. triage artefak dan bukti eksekusi
2. containment persistence dan network path
3. credential recovery dan trust rebuild

Kalau hanya clone repo dan belum install, prioritas utama adalah triage artefak, bukan rotasi secret.
