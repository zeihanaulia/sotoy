---
id: notes.rust.ecosystem-tool-mapping
title: "Rust ecosystem tool mapping: apa dan seberapa umum"
description: "Bedah item Rust populer per domain, menjelaskan apa tool-nya dan apakah termasuk yang sering dipakai atau lebih niche."
tags:
  - rust
  - ecosystem
  - tools
  - backend
  - frontend
  - desktop
  - gamedev
  - analytics
status: published
---

## Arti catatan ini

Ini bukan daftar "tool default semua developer".
Ini bedah satu-satu item Rust dari post yang sedang dibahas, dan jawab dua hal:
1. Ini sebenarnya tool apa?
2. Apakah ini termasuk yang paling sering dipakai di domainnya, atau cuma ada di ekosistem Rust?

Kesimpulan singkat: **tidak semua item di post itu paling sering dipakai**. Ada yang fondasi penting, ada yang populer di komunitas Rust, dan ada juga yang lebih niche atau domain-specific.

---

## Web backend / microservice / API / network service

### Tokio ([tokio.rs](https://tokio.rs/))
- Apa: async runtime Rust untuk I/O, networking, scheduling, timer, dan concurrency.
- Seberapa umum: **sangat umum** di domain Rust backend. Ini fondasi hampir semua aplikasi async/networked Rust.

### Axum ([crates.io/crates/axum](https://crates.io/crates/axum))
- Apa: HTTP request routing / service framework yang fokus ergonomics dan modularity.
- Seberapa umum: **sangat populer** sekarang. Termasuk arus utama modern di komunitas Rust backend.

### Actix Web ([actix.rs](https://actix.rs/))
- Apa: web framework yang sangat cepat dengan model actor/async.
- Seberapa umum: **masih relevan dan populer**, meski posisi momentum-nya sedikit di bawah Axum saat ini.

### SQLx ([crates.io/crates/sqlx](https://crates.io/crates/sqlx))
- Apa: async SQL crate dengan compile-time checked queries tanpa DSL berat.
- Seberapa umum: **sangat umum** di Rust async backend. Ini sering muncul di microservice async modern.

### Diesel ([diesel.rs](https://diesel.rs/))
- Apa: ORM/query builder tipe-safe dan composable.
- Seberapa umum: **penting**, tapi bukan satu-satunya default. Lebih cocok untuk tim yang ingin query builder/ORM kuat.

> Ringkas: untuk backend Rust modern, stack yang paling sering diasosiasikan adalah **Tokio + Axum + SQLx**. Actix tetap besar; Diesel masih penting di niche ORM/query builder.

---

## Frontend web / browser apps

### WebAssembly ([webassembly.org](https://webassembly.org/))
- Apa: target/teknologi runtime untuk menjalankan kode non-JS di browser.
- Seberapa umum: **bukan tool pengembang frontend umum**. Ini adalah jalur teknis untuk Rust di browser, tapi bukan mainstream frontend industry.

### Yew ([yew.rs](https://yew.rs/))
- Apa: framework frontend komponen untuk aplikasi Rust via WebAssembly.
- Seberapa umum: **valid dan dicintai komunitas Rust/WASM**, tapi **niche** dibanding JS/TS framework.

> Ringkas: Yew adalah opsi Rust/WASM yang sah untuk web frontend, tetapi bukan tool paling umum di dunia frontend luas.

---

## Desktop apps

### Tauri ([v2.tauri.app](https://v2.tauri.app/))
- Apa: toolkit cross-platform untuk desktop app dengan frontend webview dan backend Rust.
- Seberapa umum: **sangat penting di komunitas desktop Rust**. Namun secara industri luas, bukan pesaing langsung Electron/Qt/native SDK dominan.

### egui ([egui.rs](https://egui.rs/))
- Apa: immediate-mode GUI murni Rust, cocok untuk tools dan internal UI.
- Seberapa umum: **cukup populer di komunitas Rust**, terutama untuk tooling, internal app, dan visualisasi. Tapi masih **niche** dibanding framework desktop global.

> Ringkas: Tauri dan egui adalah jalur desktop yang masuk akal untuk Rust, tapi kategori mereka lebih ke Rust-native desktop daripada mainstream desktop development.

---

## Game development / graphics / GPU

### Bevy ([bevy.org](https://bevy.org/))
- Apa: game engine Rust data-driven.
- Seberapa umum: **sangat menonjol di dunia Rust gamedev**. Namun dalam industri game global, masih jauh dari Unity/Unreal/Godot.

### wgpu ([github.com/gfx-rs/wgpu](https://github.com/gfx-rs/wgpu))
- Apa: graphics API/library portable Rust berbasis WebGPU untuk rendering dan compute.
- Seberapa umum: **penting di ekosistem Rust graphics** dan digunakan sebagai fondasi oleh banyak proyek. Tapi ini lebih domain-specific.

> Ringkas: Bevy dan wgpu kuat di gamedev Rust/graphics Rust, tapi bukan dominasi industri game umum.

---

## Embedded / firmware / kernel / systems

### Embedded Rust ([docs.rust-embedded.org/book](https://docs.rust-embedded.org/book/))
- Apa: domain/tooling komunitas untuk Rust di bare-metal, microcontroller, dan IoT.
- Seberapa umum: **sangat penting di embedded Rust**, tapi jelas **domain khusus** dibanding developer umum.

### Rust for Linux ([rust-for-linux.com](https://rust-for-linux.com/))
- Apa: proyek resmi untuk mendukung penulisan modul kernel Linux dengan Rust.
- Seberapa umum: **strategis penting**, tapi bukan tool harian kebanyakan developer. Ini lebih ke bukti penetrasi Rust di systems programming.

> Ringkas: keduanya penting secara strategis, tetapi kategori ini adalah domain spesialis, bukan opsi default bagi mayoritas developer.

---

## Data processing / analytics

### Polars ([pola.rs](https://pola.rs/))
- Apa: DataFrame/query engine Rust modern yang memakai Apache Arrow memory format.
- Seberapa umum: **cukup menonjol di data/analytics Rust modern**. Bukan tool harian semua engineer, tapi penting di domainnya.

### Apache Arrow ([arrow.apache.org](https://arrow.apache.org/))
- Apa: format columnar memory lintas bahasa untuk analitik cepat dan interoperabilitas.
- Seberapa umum: **sangat penting sebagai fondasi**. Sering dipakai secara tidak langsung oleh tool lain.

> Ringkas: Polars sangat bernilai untuk data engineering di Rust. Arrow adalah substrate yang penting, tetapi lebih sering tersembunyi di bawah tool lain.

---

## Bagaimana membaca post ini

Post itu lebih tepat dibaca sebagai **peta jangkauan ekosistem Rust**, bukan daftar "tool default semua developer".

- Ada jalur yang memang banyak dipakai di domain Rust tertentu.
- Ada juga item yang lebih populer di komunitas Rust, tapi tidak mainstream di industri luas.
- Item-item domain-specific valid, tapi jangan disamakan dengan dominance global.

---

## Level yang perlu dibedakan

1. **Ada jalurnya**
2. **Populer di komunitas Rust**
3. **Mainstream di industri luas**

Contoh:
- Tokio: mendekati level 2-3 di Rust backend.
- Axum: kuat di level 2, sedang tumbuh.
- Yew / egui / Bevy: level 1-2.
- Embedded Rust / Rust for Linux: level 1 (strategis, domain-specific).

---

## Jika ingin lebih lanjut

Kalau ingin, saya bisa buat peta rekomendasi stack Rust per domain:
- web/API: apa yang dipilih sekarang,
- desktop: pilihan Tauri vs egui,
- data: pilihan Polars vs stack lain,
- embedded/system: apa yang layak dipakai.
