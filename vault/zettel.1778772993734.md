---
id: zettel.1778772993734
title: "Think in Rust, not memorize Rust patterns"
desc: "Rust pattern harus dibaca dari problem desainnya, bukan dari label GoF atau padanan bahasa lain."
updated: 1778772993734
created: 1778772993734
tags:
  - zettel
  - rust
  - pattern
  - design
---

## Klaim

Belajar Rust pattern efektif ketika dimulai dari tension desain yang harus diselesaikan, bukan dari nama pattern.

## Bukti

Preface menekankan bahwa buku ini bukan katalog pattern. Pertanyaan yang lebih penting adalah: "Problem desain apa yang coba diselesaikan?" dan "Fitur Rust apa yang membuat solusi ini natural?"

## Implikasi

- Pattern seperti Factory, Strategy, Observer adalah label; yang relevan adalah problem di baliknya.
- Di Rust, pertanyaan desain bergeser ke ownership, boundary, state, dan type system.
- Membaca pattern dengan mindset OOP berisiko menghasilkan Rust code yang hanya "compile" tapi tidak idiomatic.

## Hubungan

- [[zettel.literature.design-patterns-and-best-practices-in-rust]]
