---
id: zettel.20260505179946
title: "Workstation trust boundary jadi serangan utama di era agentic coding"
desc: "Agentic coding tools memperluas attack surface lokal, sehingga scanner lokal harus memetakan permission boundary dan not just secrets."
updated: 1777991468912
created: 1777991468912
tags:
  - zettel
  - security
  - agentic-coding
  - workstation
---

Insight: Risiko utama di era agentic coding bukan hanya apakah kode punya bug, tetapi apakah lingkungan kerja developer memberi terlalu banyak trust kepada process, extension, dan config lokal yang dapat menyentuh credentials.

Karena banyak developer menjalankan tools dengan akses filesystem dan shell, keamanan workstation perlu dipindai sebagai trust boundary: siapa/apa yang dapat membaca `.env`, `~/.aws/credentials`, `~/.kube/config`, atau shell history, dan apakah agentic tool itu sendiri adalah jalur eksfiltrasi potensial.
