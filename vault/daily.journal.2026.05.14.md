---
id: daily.journal.2026.05.14
title: '2026-05-14'
desc: "Refleksi pembacaan buku Rust pattern dan mental model design Rust dibanding OOP."
updated: 1778769784651
created: 1778769784651
tags:
  - daily
  - rust
  - design-patterns
---

## Baca buku Rust tentang design pattern

Hari ini gue baca daftar isi dan struktur buku *Design Patterns and Best Practices in Rust*. Yang paling nyantol adalah penekanannya: ini bukan buku yang ngajarin pattern klasik satu per satu, tapi buku yang ngajarin cara mikir ulang desain agar selaras dengan Rust.

Gue mulai melihat tiga layer yang berbeda:

- mental model Rust dulu,
- lalu terjemahan pattern lama ke idiom Rust,
- baru akhirnya pattern yang benar-benar native Rust.

## Insight yang gue tangkap

- Kalau lo pindah dari Java/C#, kebiasaan membuat class hierarchy dan object-oriented design biasanya jadi jebakan.
- `Clone` dan `Rc` sering dipakai sebagai pelarian ketika borrow checker menolak, padahal itu bisa jadi tanda desain ownership yang kabur.
- Borrow checker bukan musuh; dia feedback sistem desain. Kalau dia nggak terima, berarti lo harus jawab siapa pemilik data, siapa boleh baca, siapa boleh ubah.
- Di Rust, pattern penting bukan karena namanya, tapi karena problem yang dia selesaikan dan apakah dia bisa di-encode di level type system.

## Apa yang mau gue lakukan selanjutnya

- Baca Part 1 pelan-pelan untuk benar-benar memetakan mental model Rust.
- Saat masuk Part 2, fokus ke problem → Rust-native alternative → trade-off, bukan cuma nama pattern.
- Ambil catatan khusus tentang pola ownership, type-driven design, dan kapan functional idiom lebih pas.
