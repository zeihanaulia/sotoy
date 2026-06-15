---
id: zettel.1778772993736
title: "Bad Calculator → Correct Calculator → Samsa: progression pedagogis Rust-native"
desc: "Urutan contoh buku yang mulai dari anti-pattern, lalu adaptasi Rust, sampai pattern native Rust di arsitektur."
updated: 1778773151631
created: 1778773037195
tags:
  - zettel
  - rust
  - pedagogy
  - architecture
---

## Klaim

Progresi pembelajaran yang efektif untuk Rust design adalah: tunjukkan failure mode dulu, lalu translasi pattern lama, lalu sintesis Rust-native.

## Bukti

Preface menggunakan tiga project utama: Bad Calculator (diagnosis anti-pattern), Correct Calculator (translasi ownership-aware pattern), dan Samsa microservice (syntesis arsitektur Rust-native).

## Implikasi

- Membaca kode Rust sebaiknya dimulai dengan model salah sebelum melihat model benar.
- Design sense Rust tumbuh lebih baik ketika kita memahami why a design fails, bukan hanya what works.
- Proyek arsitektur Rust membutuhkan konteks lebih besar daripada contoh API satu fungsi.

## Hubungan

- [[zettel.literature.design-patterns-and-best-practices-in-rust]]
