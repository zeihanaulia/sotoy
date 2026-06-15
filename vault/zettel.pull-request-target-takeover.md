---
id: zettel.pull-request-target-takeover
title: "pull_request_target bisa menjadi jalur takeover PR sebelum merge"
desc: "Action GitHub `pull_request_target` dapat mengeksekusi PR code dalam konteks base repo, memungkinkan PR berbahaya mempengaruhi pipeline resmi tanpa perlu di-merge."
updated: 1778647444179
created: 1778647244697
tags:
  - zettel
  - security
  - github-actions
  - supply-chain
---

`pull_request_target` berjalan di konteks base repo, bukan di konteks fork contributor. Jika workflow tersebut checkout hasil merge PR dan menjalankan build/install PR code, maka trigger trusted bisa menjadi jalur eksekusi untuk code untrusted.

Ini membuat PR takeover mungkin sebelum merge: attacker membuka PR dari fork, trusted workflow jalan, dan PR dapat memengaruhi pipeline resmi secara langsung. Ini adalah bentuk "pwn request".
