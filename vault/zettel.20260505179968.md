---
id: zettel.20260505179968
title: "Workstation trust boundary adalah attack surface utama di era AI-native engineering"
desc: "Developer workstation menyimpan secret dan process sensitif, jadi trust boundary lokal harus dipindai bersama codebase."
updated: 1777991678277
created: 1777991678277
tags:
  - zettel
  - workstation
  - trust-boundary
  - security
---

Tidak cukup hanya mencari secret di repo. Perlu juga memetakan siapa/apa yang dapat mengakses secret itu di lingkungan developer: extensions, processes, shell history, container, dan config lokal.

Hubungkan ide ini dengan:
- [[notes.security.overtrust]]
- [[notes.security.agentic-coding-permission-boundary]]
