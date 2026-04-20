---
id: zettel.20260420131405
title: "Kalau medium lupa, pindahkan memori ke luar medium itu"
desc: "Kalau chat nggak bisa nyimpen konteks, keluarkan konteks itu dari chat."
tags:
  - zettel
  - ai-collaboration
  - knowledge-management
  - context-anchoring
---

## Gagasan

Kalau mediumnya nggak andal buat ingat, jangan harap konteks bisa bertahan di situ.

## Mengapa Ini Penting

Ini membuatnya jelas: solusi bukan memperbaiki chat, tapi memindahkan konteks dari chat ke tempat lain.

## Contoh Medium Handal vs Tidak Handal

### Medium tidak handal
- `Chat AI session` saat diskusi berlangsung. Berguna untuk berpikir, eksplorasi, dan membuat keputusan sementara. Tidak handal untuk menyimpan keputusan jangka panjang karena context window terbatas dan struktur token membuat alasan panjang mudah tergerus.
- `Long conversation history` dalam chat. Walau tersimpan, posisi informasi di tengah mudah hilang, ringkasan otomatis bisa mengabaikan nuance, dan menutup sesi biasanya berarti kehilangan reasoning.

### Medium handal
- `Feature document / living decision note`: dokumen bersama yang mencatat keputusan, alasan, alternatif yang ditolak, constraint, open questions, dan status. Ini memindahkan konteks keluar dari medium rapuh dan menjadikannya external memory.
- `Project priming document`: dokumen stabil untuk konteks proyek (stack, pola, konvensi). Tidak menggantikan feature document, tetapi memberi AI fondasi yang lebih tahan lama.
- `ADR atau decision log ringan`: jika keputusan penting perlu dicatat, ADR hidup atau note keputusan ringan memberi media yang dapat direferensikan ulang tanpa bergantung pada sesi chat.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 8.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 8
