---
id: zettel.dependency-installer-initial-access
title: "Installer dependency bisa menjadi initial access di supply-chain dev"
desc: "Dalam serangan supply-chain modern, tindakan install dependency dapat menjadi titik masuk awal yang memicu payload dan memungkinkan persistence di workflow developer."
updated: 1778645837051
created: 1778645837051
tags:
  - zettel
  - security
  - supply-chain
  - dependency-management
---

Install dependency seperti `npm install`, `pnpm install`, atau `pip install` dapat mengeksekusi lifecycle script dan hook yang jahat. Itu membuat installer dependency menjadi vector initial access, bukan sekadar cara mengambil paket.

Jika payload juga menulis file persistence di `.claude/` atau `.vscode/`, maka host atau repo dapat tetap terinfeksi setelah dependency itu dihapus.
