---
id: zettel.cache-as-trust-boundary
title: "Cache CI adalah trust boundary, bukan hanya optimisasi performa"
desc: "CI cache yang direstore di workflow resmi bisa menjadi jalur serangan jika isinya dikontrol oleh kode untrusted."
updated: 1778645837051
created: 1778645837051
tags:
  - zettel
  - security
  - supply-chain
  - ci
---

Cache dalam CI tidak semata-mata accelerasi. Jika cache restore mempengaruhi execution path workflow resmi, maka isi cache adalah bagian dari trust boundary.

Cache poisoning dapat menyalurkan payload dari PR untrusted ke workflow main yang trusted, menjadikan cache sebuah kendaraan eksekusi lintas boundary.
