---
id: zettel.20260506180000
title: "verify.sh is a verification entrypoint, not a sensor"
desc: "Klaim bahwa verify.sh hanya menjalankan sensor yang ada, bukan mendeteksi masalah sendiri."
updated: 1778002954773
created: 1778002954773
tags:
  - zettel
  - agentic-engineering
  - verification
  - harness
---

`verify.sh` bukan sensor otomatis. Ia adalah single verification entrypoint: satu command stabil yang menjalankan check yang sudah disiapkan tim.

Karena itu:
- kalau `verify.sh` hanya berisi `lint`, `typecheck`, dan `test`, ia tidak akan otomatis menemukan N+1.
- ia hanya akan mendeteksi N+1 jika sensor N+1 sudah ditambahkan ke dalamnya, seperti Semgrep rule, query-count regression test, atau runtime query profiler.

Intinya: `verify.sh` membuat definition of done executable, bukan membuat definition of done sendiri.

Related: [[notes.agentic-engineering.single-verification-entrypoint]]
