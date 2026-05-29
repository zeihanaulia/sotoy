---
id: zettel.20260529150409
title: "Sandbox OS tidak menyembunyikan environment variable yang diwariskan"
desc: "Seatbelt membatasi file dan network access, tapi env var tetap bisa diwariskan dari parent shell ke proses sandbox."
updated: 1780041829450
created: 1780041829450
tags:
  - zettel
  - security
  - sandbox
  - environment
---

Sandbox local di macOS bisa mencegah akses file atau network di luar boundary, tapi ia tidak membersihkan environment variable. Jika terminal induk sudah memiliki secret seperti `AWS_ACCESS_KEY_ID` atau `OPENAI_API_KEY`, proses yang berjalan dalam sandbox masih bisa membacanya kecuali env dibersihkan.

Lihat juga: [[notes.agentic-engineering.codex-macos-sandboxing]].
