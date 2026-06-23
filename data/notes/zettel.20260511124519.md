
Thread Jarred Sumner menunjukkan klaim berikut:

Kalau lo punya sistem performa-sensitif dan heavily interconnected yang tumbuh organik di Zig, porting ke Rust modular bukan soal syntax. Itu soal:

- memutus cyclic dependency dengan crate boundary,
- memutus konsep tagged pointer / dynamic interface dengan trait/object/enum,
- menegosiasi ulang apakah heterogeneity dibayar di runtime atau compile-time.

Jangan anggap Rust port sebagai sekadar refactor. Anggap itu sebagai redesign arsitektur dengan trade-off baru.

Referensi: [[notes.software-architechture.bun-rust-porting]]
