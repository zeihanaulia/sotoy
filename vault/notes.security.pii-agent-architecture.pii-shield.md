---
id: notes.security.pii-agent-architecture.pii-shield
title: "PII Shield: Browser Overlay for Personal Data Management"
desc: "Deep dive PII Shield: front-end overlay untuk deteksi PII dan kontrol pengguna sebelum prompt dikirim ke model." 
updated: 1777874223937
created: 1777871769530
tags:
  - notes
  - security
  - pii
  - browser
  - agent
---

## Problem
PII Shield mengangkat masalah browser-based agents: prompt sering berisi PII sebelum sampai ke model cloud. Tanpa lapisan depan, data sensitif dari teks, form, atau clipboard bisa dikirim tanpa kontrol pengguna.

## Solution
Solusi paper ini adalah browser overlay yang mendeteksi entitas personal secara lokal dan menggantinya dengan placeholder atau versi yang disetujui pengguna. Selain itu, sistem menerapkan smokescreen untuk mengurangi risiko profiling dan tracking dari interaksi asli.

## Real case implementation
Implementasinya berupa ekstensi browser atau UI-layer yang menganalisis prompt sebelum submit. Ketika ditemukan PII, pengguna diberi opsi untuk menghapus atau mengganti data tersebut, sementara model hanya menerima versi anonim atau disingkat. Ini cocok untuk agent personal assistant yang beroperasi langsung dari browser dan menggabungkan teks serta data form.

## Relevance
PII Shield menunjukkan bahwa privacy boundary terbaik untuk user-facing agents adalah di sisi klien. Local redaction dan user transparency menjadi lapisan awal yang penting sebelum request memasuki model cloud.

Original paper: https://arxiv.org/abs/2603.24895

Link: [[notes.security.pii-agent-architecture]]
