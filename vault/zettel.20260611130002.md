---
id: zettel.20260611130002
title: "Loop Plumbing vs. Skill Assets"
desc: "Loop adalah infrastruktur (plumbing), sedangkan nilai jangka panjang berada pada reusable skills yang dipanggil oleh loop tersebut."
updated: 1781148280325
created: 1781148280286
tags:
  - zettel
  - ai-skills
---

Dalam arsitektur Loop Engineering, terdapat pemisahan antara *plumbing* (infrastruktur loop) dan *assets* (skills).

Loop (automation, state, orchestration) adalah pipa yang mengalirkan kerja. Namun, efektivitas loop sangat bergantung pada *named skills* yang dipanggilnya. Loop tanpa reusable skills hanya akan mengulang proses "perkenalan" dengan proyek di setiap run. Sebaliknya, loop yang menggunakan library skill yang matang dapat melakukan *compounding* pengetahuan proyek lintas waktu.

Relasi: [[notes.ai-agents.loop-engineering]]
