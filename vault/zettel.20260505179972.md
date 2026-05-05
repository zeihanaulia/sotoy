---
id: zettel.20260505179972
title: "Secret exposure bisa terjadi tanpa commit Git"
desc: "Kebocoran secret sering terjadi lewat proses lokal, extension, dan akses environment, bukan hanya commit repositori."
updated: 1777991678277
created: 1777991678277
tags:
  - zettel
  - security
  - secrets
---

Secret exposure bukan cuma soal token yang ke-commit ke Git. Secret juga bisa bocor karena tool lokal, shell history, editor extension, atau build script yang membaca atau mengirim secret dari workstation.

Artinya, pemeriksaan keamanan harus mencakup scanning repo dan audit trust boundary lokal.

Hubungkan ide ini dengan:
- [[notes.security.overtrust]]
- [[notes.security.agentic-coding-permission-boundary]]
