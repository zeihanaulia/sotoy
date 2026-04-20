---
id: zettel.20260420131409
title: "Decision context harus menjadi external state, bukan jejak chat"
desc: "Decision context perlu jadi state eksplisit di luar percakapan."
tags:
  - zettel
  - ai-collaboration
  - knowledge-management
  - context-anchoring
---

## Gagasan

Konteks keputusan harus diperlakukan seperti state yang bisa diakses ulang, bukan jejak samar dalam chat.

## Mengapa Ini Penting

Ini nyerang langsung problem utama: chat tidak cukup karena bukan sistem penyimpanan.

Chat adalah medium sesi untuk berpikir. Itu bagus untuk eksplorasi, tapi setiap kali sesi berakhir, konteks yang penting sering hilang atau hanya tersisa sebagai jejak samar. Agar keputusan tetap bisa dipakai ulang, konteks harus dipindahkan ke bentuk yang eksplisit dan terstruktur: external state.

## Contoh

- tanpa external state: sesi awal memutuskan `pakai BullMQ`. Sesi berikutnya, AI mungkin hanya melihat "retry" dan mengusulkan kembali `RetryQueue`.
- dengan external state: dokumen fitur menyimpan `Decision: BullMQ`, `Why: low overhead, multi-tenant`, `Rejected: RetryQueue`. Sesi baru bisa mengakses state ini dan melanjutkan tanpa ulang logika.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 12

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 12.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 12
