---
id: zettel.20260611110003
title: "Separation of Implementer and Verifier in AI Loops"
desc: "Pentingnya memisahkan agent yang menulis kode dengan agent yang mengecek kode untuk menghindari bias self-grading."
updated: 1781147645961
created: 1781147645925
tags:
  - zettel
  - ai-workflow
---

Dalam desain loop AI, memisahkan peran antara *Implementer* (yang menulis kode) dan *Verifier* (yang mengecek kode) adalah krusial. 

Model AI cenderung terlalu optimis dan "ramah" terhadap hasil karyanya sendiri (*self-grading bias*). Dengan menggunakan sub-agent berbeda (atau bahkan model berbeda) sebagai reviewer, sistem dapat menciptakan filter kualitas yang lebih objektif, mirip dengan proses peer-review dalam tim engineering manusia.

Relasi: [[notes.ai-agents.loop-engineering]]
