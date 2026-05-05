---
id: zettel.20260505179935
title: "Agentic coding perlu permission boundary setara process lokal"
desc: "Kerentanan agentic coding lebih sering muncul dari permission boundary dan filesystem access ketimbang dari model AI itu sendiri."
updated: 1777991358371
created: 1777991358371
tags:
  - zettel
  - security
  - agentic-coding
  - permission-boundary
---

Agentic coding tools bukan sekadar chatbot. Kalau mereka diberi akses filesystem dan shell di mesin developer, maka mereka harus diperlakukan seperti process lokal dengan permission boundary yang jelas.

Karena developer workstation menyimpan lebih dari source code — secret file, AWS/Azure/K8s creds, shell history, editor session, extention state — keamanan agentic coding bergantung pada seberapa ketat boundary itu.

Intinya: pertanyaan yang paling relevan bukan "model apa yang digunakan?" tetapi "agent ini punya akses ke file/path apa, perintah apa yang bisa dijalankan, dan data apa yang bisa keluar ke network?"