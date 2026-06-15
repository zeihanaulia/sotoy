---
id: book-summaries.design-patterns-and-best-practices-in-rust
title: "Design Patterns and Best Practices in Rust"
desc: "Ringkasan buku tentang cara berpikir ulang design pattern klasik untuk idiom Rust."
updated: 1778806126299
created: 1778769830967
tags:
  - book-summary
  - rust
  - design-patterns
---

Dari daftar isi yang gue baca, buku ini bukan sekadar "buku design pattern versi Rust". Logika besarnya lebih tajam: buku ini ngajarin cara berhenti membawa kebiasaan OOP dan pattern tradisional mentah-mentah ke Rust, lalu pelan-pelan mengganti cara mikir lo dengan cara Rust.

## Preface: frame baca buku

Preface bukan ngajarin syntax Rust. Dia lagi menyetel frame baca: buku ini tentang transformasi cara desain software di Rust. Kalimat pentingnya adalah:

> "Truly effective Rust development requires a transformation in how you approach software design itself."

Artinya, menguasai `struct`, `trait`, `enum`, `match`, `Result`, ownership, borrowing, dan lifetime secara dasar belum cukup. Buku ini mau membongkar cara lo mendesain relasi antar komponen, bukan cuma gimana bikin kode Rust compile.

Preface memberi beberapa sinyal penting:

- Ini bukan basa-basi; ini adalah kontrak pembelajaran buku.
- Problem utama bukan "Rust sulit", tapi developer sering membawa desain dari bahasa lain ke Rust.
- Rust memaksa desain kelihatan. Ownership kabur, dependency berantakan, atau mutability terlalu bebas akan segera memberi sinyal compile-time.
- Compiler Rust adalah reviewer desain, bukan sekadar penjaga syntax.
- Buku ini ingin menggeser kita dari "memaksa Rust mengikuti desain lama" menjadi "membiarkan constraint Rust membentuk desain baru".

Buku ini membuka dengan dua sisi pengalaman Rust: janji safety, concurrency, zero-cost abstraction, dan reputasi "kalau compile, biasanya jalan", lalu frustrasi ketika borrow checker menolak desain yang "seemingly reasonable" dari bahasa lain. Itu bukan tanda Rust jelek — itu tanda desain lama tidak cocok.

Preface juga menegaskan dua escape hatch yang sering muncul saat developer frustrasi: `clone()` dan `Rc<RefCell<T>>`. Keduanya bukan dosa, tapi jika dipakai untuk menghindari berpikir tentang ownership, mereka berubah jadi anti-pattern.

Bagian berikutnya adalah thesis utama Preface:

> “Internalizing Rust's philosophy and allowing it to shape your thinking matters more than any individual pattern or technique.”

Ini kuat. Penulis sedang bilang: jangan baca buku ini sebagai katalog pattern. Jangan mikir, “oh di Rust Factory Pattern begini, Strategy Pattern begini, Observer Pattern begini.” Yang lebih penting adalah filosofi Rust membentuk cara lo memilih pattern.

Di OOP klasik, lo mungkin bertanya:

- Class apa yang perlu dibuat?
- Interface-nya apa?
- Inheritance tree-nya gimana?
- Object mana yang punya method apa?

Di Rust, pertanyaannya berubah menjadi:

- Data ini dimiliki siapa?
- Mutation terjadi di boundary mana?
- Behavior ini lebih cocok trait, enum, generic, atau closure?
- State ilegal bisa dicegah lewat type system gak?
- Apakah polymorphism perlu runtime atau cukup compile time?

Ini pergeseran besar. Preface menaruh ini di depan supaya lo tidak salah cara baca bab berikutnya.

Kalau lo baca bab creational/structural/behavioral pattern dengan mindset OOP, lo akan cuma cari padanan. Tapi kalau lo baca dengan mindset Rust, lo akan cari problem desain di balik pattern, lalu bertanya: “Rust punya cara lebih natural gak?”

Buku ini menggunakan tiga project sebagai jalur pedagogis:

- Bad Calculator: sengaja dibuat buruk. Fungsinya bukan menghasilkan app bagus, tapi menjadi "cermin kesalahan". Kita akan lihat apa yang terjadi kalau desain Java/C++ dipaksa masuk Rust.
- Correct Calculator: versi rebuilding untuk Chapter 5–8. Problem yang sama dibangun ulang dengan pattern yang lebih cocok dengan ownership model dan type system Rust.
- Samsa microservice: publish/subscribe microservice untuk Chapter 9–12. Ini naik level dari calculator ke arsitektur aplikasi. Di sini pattern Rust-native mulai muncul: type system untuk compile-time safety, functional idioms, architectural advantage dari ownership, dan sebagainya.

Kalau dibuat sebagai progression:

Bad Calculator
    ↓
Belajar melihat anti-pattern

Correct Calculator
    ↓
Belajar menerjemahkan pattern klasik ke Rust

Samsa microservice
    ↓
Belajar memakai pattern yang lahir dari Rust sendiri

Ini urutan pedagogis yang bagus. Buku ini tidak langsung memberi "best practice". Dia mulai dari desain yang salah dulu, karena di Rust, memahami failure mode itu penting.

Kenapa? Karena banyak kesalahan Rust bukan kesalahan syntax, tapi kesalahan mental model.

★ Insight

- Bad Calculator adalah alat diagnosis. Lo diajak melihat bau desain sebelum melihat solusi.
- Correct Calculator adalah alat translasi. Pattern lama tidak dibuang semua, tapi diadaptasi.
- Samsa adalah alat sintesis. Setelah mental model berubah, baru lo bisa melihat pattern Rust-native di aplikasi lebih realistis.
- Urutan ini bagus karena belajar Rust design tidak bisa hanya dari contoh final yang bersih.
- Lo perlu melihat "kenapa desain tertentu gagal" supaya tahu kapan solusi tertentu masuk akal.

Dan scope buku ini jelas: bukan buku lengkap tentang testing, benchmarking, CI/CD, deployment, atau async runtime. Fokusnya adalah design pattern, architectural decision, dan idiomatic Rust.

Buku ini ditujukan untuk pembaca yang sudah mengerti dasar Rust, tapi belum tentu sudah paham design pattern. Itu membuatnya cocok sebagai bahan transformasi cara berpikir.

Buku ini terbagi dalam tiga gerakan besar:

- Part 1: Thinking in Rust. Ini fondasi mental. Sebelum belajar pattern, lo dipaksa ngerti dulu kenapa Rust beda.
- Part 2: Replacing Traditional Design Patterns. Ini bagian transisi. Pattern klasik seperti creational, structural, behavioral dibahas bukan untuk ditiru mentah-mentah, tapi untuk dilihat ulang dari sudut pandang Rust.
- Part 3: New Patterns for Rust. Ini bagian naik level. Setelah lo tidak lagi melawan Rust, baru muncul pattern yang benar-benar lahir dari ownership, borrowing, traits, enum, pattern matching, dan type system kuat.

## Kenapa ini bukan buku pattern biasa

Gue menangkap bahwa buku ini tidak mulai dari "Factory Pattern", "Strategy Pattern", atau "Observer Pattern". Rust bukan bahasa OOP klasik, sehingga pattern yang sama bisa jadi salah kalau mental model-nya salah.

Part 1 bekerja sebagai unlearning layer: lo diminta melepas kebiasaan Java/C#/Python OOP. Part 2 adalah translation layer: pattern lama diterjemahkan ke idiom Rust. Part 3 adalah native layer: pattern yang muncul karena Rust punya fitur sendiri.

Intuisi paling penting: di banyak bahasa, design pattern muncul karena bahasa itu punya keterbatasan. Tapi Rust punya alat desain yang berbeda: ownership, borrowing, lifetimes, traits, enums, generics, pattern matching, dan compile-time guarantees. Di Rust, problem desain seringkali bisa diselesaikan dengan ownership, borrowing, lifetimes, traits, enums, generics, dan compile-time guarantees. Jadi kalau lo datang ke Rust dengan mindset "gue mau bikin class hierarchy yang rapi", lo bakal cepat frustasi.

## Apa yang paling nempel dari setiap part

### Part 1: Thinking in Rust

- Rust bukan cuma syntax beda. Model desainnya beda.
- Memory safety, ownership, dan type system bukan sekadar fitur teknis; mereka memengaruhi cara lo membagi tanggung jawab antar komponen.
- Anti-pattern umum: mendesain untuk object orientation, menggunakan `Clone` dan `Rc` sebagai jalan pintas, dan melawan borrow checker.
- Borrow checker lebih tepat dilihat sebagai sistem feedback desain: kalau dia nolak, sering kali itu karena aliran kepemilikan data lo belum jelas.

### Part 2: Replacing Traditional Design Patterns

- Creational Patterns: buku ini kemungkinan membahas cara membuat object/data tanpa mengikuti kreasi OOP secara literal. Builder masih relevan untuk struct dengan banyak field optional, tetapi Singleton harus dipikirkan ulang karena global mutable state bukan natural di Rust. Rust mendorong desain yang eksplisit soal ownership dan initialization.
- Structural Patterns: bukan lagi "class A extends class B". Di Rust, struktur komponen muncul lewat traits, generics, newtype pattern, composition, enum dispatch, atau trait objects. Ini lebih ke "type ini mengimplementasikan behavior tertentu" atau "struct ini membungkus dependency tertentu".
- Behavioral Patterns: karena luas, bab ini mungkin dibagi dua. Rust sering memindahkan behavioral pattern ke function, closure, enum, trait, iterator, channel, atau state yang di-encode di tipe. Kemungkinan ada bab untuk "Taking Action" dan bab lain untuk "Keeping Track".
- Intinya: Part 2 bukan ngajarin pattern klasik masih sama dengan syntax Rust. Value-nya ada di proses translasi: pattern klasik dipreteli, problem aslinya dicari, lalu solusi Rust-native dipilih.
- Trade-off penting: trait object lebih fleksibel runtime, generics lebih kuat compile-time tetapi bisa bikin binary lebih besar dan API lebih kompleks.

### Part 3: New Patterns for Rust

- Bab ini fokus ke pattern yang lahir dari Rust sendiri: arsitektur, type-driven design, functional idiom, dan core feature Rust.
- Chapter 9: Architectural Patterns. Ini kemungkinan membahas desain sistem yang lebih besar, terutama boundary antar module, ownership antar layer, error handling, concurrency, dan dependency flow. Rust sering dipakai untuk backend service, CLI, embedded, infra tools, blockchain, runtime, dan sistem high-performance, jadi arsitektur di Rust harus memperjelas boundary lebih dari sekadar memilih pattern.
- Chapter 10: Patterns That Leverage the Type System. Rust type system bisa dipakai untuk mengunci invariant dengan lebih kuat. State valid vs invalid bisa dibedakan oleh type, bukan dicek manual pakai boolean. Ini adalah type-driven design: jangan biarkan object masuk state ilegal sejak awal.
- Chapter 11: Patterns from Functional Programming. Ini kemungkinan membahas function, closure, iterator, combinator, `Option`, `Result`, immutability, dan composition. Rust bukan bahasa functional murni, tapi banyak idiomnya dekat dengan functional programming.
- Chapter 12: Patterns Emerging from Rust’s Core Features. Pattern yang muncul dari fitur inti Rust seperti ownership, borrowing, lifetimes, RAII, `Drop`, smart pointers, pattern matching, mungkin typestate, dan zero-cost abstractions.
- Chapter 13: Leaning into Rust. Ini penutup konseptual: jangan melawan Rust, tapi gunakan constraint Rust sebagai alat desain.
- Logika Part 3: setelah lo paham kenapa Rust beda dan bisa menerjemahkan pola lama, barulah lo siap memikirkan Rust sebagai bahasa yang punya pattern sendiri.
- Semakin Rust-native desain lo, semakin sedikit lo merasa borrow checker sebagai musuh.

## Takeaway inti

Buku ini ngajarin bahwa design pattern di Rust bukan soal menghafal pola lama, tapi soal membentuk desain yang selaras dengan ownership, type system, dan compile-time guarantees.

Kalau kita ambil logic path buku ini, urutannya kira-kira begini:

1. Rust berbeda
   ↓
2. Karena berbeda, kebiasaan OOP bisa jadi anti-pattern
   ↓
3. Jalan pintas seperti `Clone`/`Rc` sering menutupi desain ownership yang kabur
   ↓
4. Borrow checker harus dibaca sebagai feedback desain
   ↓
5. Setelah mental model benar, pattern klasik bisa diterjemahkan ulang
   ↓
6. Pattern creational/structural/behavioral punya bentuk Rust-native
   ↓
7. Setelah itu baru masuk ke pattern yang lahir dari Rust sendiri
   ↓
8. Type system, FP style, ownership, dan core features menjadi fondasi desain
   ↓
9. Akhirnya lo “lean into Rust”, bukan memaksa Rust jadi bahasa lain

Kalau lo baca buku ini, cara bacanya jangan seperti katalog pattern. Jangan masuk dengan pertanyaan: “Factory pattern di Rust gimana?” Lebih bagus pakai pertanyaan seperti:

- “Problem desain apa yang pattern ini coba selesaikan?”
- “Di Rust, constraint apa yang bikin solusi lamanya kurang cocok?”
- “Fitur Rust mana yang bisa menyelesaikan problem itu lebih natural?”
- “Apakah solusi ini memperjelas ownership, atau malah menyamarkannya?”
- “Apakah invariants bisa dipindahkan dari runtime check ke type system?”

## Pertanyaan baca yang bagus

Saat baca buku ini, lebih bagus pakai pertanyaan seperti:

- Problem desain apa yang pattern ini coba selesaikan?
- Di Rust, constraint apa yang bikin solusi lamanya kurang cocok?
- Fitur Rust mana yang bisa menyelesaikan problem itu lebih natural?
- Apakah solusi ini memperjelas ownership, atau malah menyamarkannya?
- Apakah invariants bisa dipindahkan dari runtime check ke type system?

## Roadmap belajar

1. Baca Part 1 pelan-pelan. Ini paling penting karena akan menentukan cara baca bab berikutnya.
2. Cari atomic idea dari setiap chapter, misalnya “ownership as design boundary”, “borrow checker as design feedback”, “clone as hidden cost”, dan “Rc as shared ownership trade-off”.
3. Saat masuk Part 2, jangan cuma rangkum pattern. Buat mapping:

Traditional Pattern → Problem yang diselesaikan → Rust-native alternative → Trade-off

Contoh:

- Factory
  → problem: membuat object tanpa expose detail konstruksi
  → Rust alternative: associated function, builder, trait-based constructor
  → trade-off: simple constructor vs flexible builder

- Strategy
  → problem: mengganti behavior
  → Rust alternative: trait, generic parameter, closure, enum dispatch
  → trade-off: runtime flexibility vs compile-time optimization

- State
  → problem: object berubah behavior berdasarkan state
  → Rust alternative: enum state machine atau typestate pattern
  → trade-off: mudah dibaca vs lebih strict secara type-level

4. Di Part 3, ambil ide yang bisa dipakai ke proyek nyata. Contoh: untuk produk SaaS atau agent architecture, refleksikan pola yang relevan untuk agent runtime, scheduler, parser, atau CLI.

## Dari OOP ke Rust Native

Buku ini sebenarnya membantu perjalanan dari "Thinking like an OOP developer writing Rust" menuju "Thinking like a Rust developer designing software". Yang pertama biasanya menghasilkan kode yang berhasil compile setelah dilawan. Yang kedua menghasilkan kode yang desainnya memang cocok dengan constraint Rust dari awal.
