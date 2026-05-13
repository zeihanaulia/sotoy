---
id: til.security.cooldown-is-delay-gate-not-freeze
title: "Coolingdown package baru itu delay gate, bukan freeze dependency update"
desc: "Minimum release age harus berbasis risk tier dan environment, bukan aturan satu ukuran untuk semua."
updated: 1778643457319
created: 1778643457319
tags:
  - til
  - security
  - supply-chain
  - dependency-management
---

TIL: coolingdown dalam konteks supply-chain modern bukan berarti berhenti update selamanya. Itu artinya: jangan jadi pengguna pertama yang mengeksekusi versi package baru di environment bernilai tinggi.

Yang masuk akal adalah risk-tiered minimum release age:
- default dependency biasa: 24–72 jam
- tooling sensitif / build/AI tooling: 3–7 hari
- package baru / maintainer baru / high-risk package: 7 hari+ plus review
- emergency security fix: exception lane dengan sandbox/testing

Jadi policy yang sehat adalah mengubah siapa yang boleh update, kapan, di mana, dan lewat jalur apa.
