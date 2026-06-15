---
id: zettel.1778772993733
title: "clone() dan Rc<RefCell<T>> adalah sinyal ownership flow yang belum jelas"
desc: "Penggunaan clone atau Rc<RefCell> secara luas sering menunjukkan bahwa desain ownership belum diekspresikan secara eksplisit."
updated: 1778773151605
created: 1778773016077
tags:
  - zettel
  - rust
  - ownership
  - design
---

## Klaim

`clone()` yang tersebar dan `Rc<RefCell<T>>` yang berulang kali digunakan adalah sinyal desain ownership yang kabur, bukan bukti desain Rust yang solid.

## Bukti

Preface menggambarkan kedua pola ini sebagai escape hatch yang valid, tapi berbahaya jika dijadikan default untuk menghindari pemikiran ownership.

## Implikasi

- `clone()` dapat menyelesaikan compile error tetapi menyembunyikan alur data dan biaya runtime.
- `Rc<RefCell<T>>` bisa membuat shared mutable state kembali seperti gaya OOP, sehingga menurunkan keuntungan compile-time safety Rust.
- Desain Rust yang baik menggunakannya sebagai alat khusus, bukan sebagai arsitektur utama.

## Hubungan

- [[zettel.literature.design-patterns-and-best-practices-in-rust]]
