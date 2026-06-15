---
id: notes.security.pii-agent-architecture.webpii
title: "WebPII: Visual PII Detection for Computer-Use Agents"
desc: "Deep dive WebPII: benchmark visual PII detection untuk screenshot UI dan agent automasi berbasis komputer."
updated: 1777874238048
created: 1777871776881
tags:
  - notes
  - security
  - pii
  - cv
  - agent
---

## Problem
WebPII menggarisbawahi bahwa privacy agent sering mengabaikan PII visual. Screenshot UI atau form filling dapat berisi nama, alamat, email, dan data sensitif lainnya yang tidak terlihat oleh filter teks biasa.

## Solution
Paper ini menyediakan benchmark 44.865 gambar UI e-commerce yang dilabeli PII secara visual. WebPII mendorong penggunaan OCR-aware PII detection, visual layout understanding, dan kontekstualisasi untuk mengenali data sensitif dalam screenshot.

## Real case implementation
Dalam implementasi nyata, agent screen-reading atau UI automation harus menambahkan lapisan sanitasi screenshot sebelum melakukan OCR atau analisis. Setelah PII terdeteksi secara visual, sistem dapat meredaksi atau memutuskan apakah screenshot boleh diproses lebih lanjut.

## Relevance
WebPII memperluas arsitektur PII filter ke pipeline visual. Untuk agent berbasis PC atau browser, itu berarti data layar dan form input harus dilindungi sama seriusnya dengan teks prompt.

Original paper: https://arxiv.org/abs/2603.17357

Link: [[notes.security.pii-agent-architecture]]
