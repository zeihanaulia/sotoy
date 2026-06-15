---
id: zettel.20260511124521
title: "Hand-porting besar lebih efektif jika breadth-first dan tulis semua dulu"
desc: "Untuk port besar yang bootstrap line-for-line, strategi kerja yang lebih baik adalah membentuk seluruh kerangka port terlebih dahulu, lalu memperbaiki dan mengoptimalkan."
updated: 1778468084907
created: 1778467171409
tags:
  - zettel
  - software-architechture
  - porting
  - rust
  - zig
  - bun
  - x
  - twitter
---

Reply Jarred Sumner menunjukkan satu model kerja hand-porting besar:

- port breadth-first, bukan depth-first,
- tulis semua kode terlebih dahulu,
- jangan langsung mencoba incremental-fix satu-satu.

Strategi ini membantu menjaga kerangka sistem tetap utuh dan mengurangi beban kognitif saat memindahkan runtime besar dari satu bahasa ke bahasa lain.

Referensi: [[notes.software-architechture.bun-rust-porting]]
