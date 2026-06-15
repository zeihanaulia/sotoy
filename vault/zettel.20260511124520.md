---
id: zettel.20260511124520
title: "Rewrite sistem low-level hanya sah jika terukur lebih baik secara performa, memori, dan stabilitas"
desc: "Klaim bahwa porting runtime sistem ke bahasa lain harus dinilai oleh kriteria metrik nyata, bukan sekadar fitur bahasa atau design promise."
updated: 1778468084908
created: 1778466472250
tags:
  - zettel
  - software-architechture
  - rust
  - zig
  - bun
  - x
  - twitter
---

Cabang thread Jared Sumner menegaskan klaim atomik ini:

Kalau kamu tidak bisa menunjukkan Rust port sistem runtime lebih baik secara terukur pada performa, penggunaan memori, dan stabilitas, maka rewrite itu belum layak di-merge.

Itu bukan sekadar "Rust lebih aman". Itu adalah standar pembuktian yang menuntut:

- benchmark nyata,
- test suite evidence,
- dan pada akhirnya exposure lapangan untuk membuktikan stabilitas.

Referensi: [[notes.software-architechture.bun-rust-porting]]
