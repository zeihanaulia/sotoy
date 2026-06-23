
## Klaim

Borrow checker Rust seharusnya dipahami sebagai feedback desain, bukan hanya penghalang syntax.

## Bukti

Dari Preface: banyak desain yang terlihat masuk akal di bahasa lain ditolak oleh borrow checker. Itu berarti masalahnya bukan "Rust sulit", melainkan desain ownership dan boundary yang belum jelas.

## Implikasi

- Kesalahan Rust sering muncul di compile time sebelum runtime, sehingga debugging desain dimulai lebih awal.
- Setiap borrow-check failure adalah kesempatan untuk mengevaluasi siapa pemilik data, siapa borrower, dan berapa lama data hidup.
- Desain yang jelas di Rust mempromosikan explicit ownership boundaries.

## Hubungan

- [[zettel.literature.design-patterns-and-best-practices-in-rust]]
