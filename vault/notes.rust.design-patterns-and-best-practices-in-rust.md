---
id: notes.rust.design-patterns-and-best-practices-in-rust
title: "Design Patterns and Best Practices in Rust"
desc: "Catatan teknis tentang bagaimana pola desain tradisional diterjemahkan ke idiom Rust."
updated: 1778769784651
created: 1778769784651
tags:
  - notes
  - rust
  - design-patterns
---

## Ringkasan pendek

Buku ini kelihatan menempatkan Rust sebagai bahasa dengan mental model sendiri: bukan kelas yang dikaitkan ke OOP, tapi ownership, borrowing, tipe, dan flow data. Pattern lama dipakai bukan sebagai aturan baku, melainkan sebagai contoh problem yang harus diterjemahkan ulang.

## Preface: frame baca buku

Preface tidak lagi bicara tentang cara nulis syntax Rust. Ini tentang transformasi filosofi desain software di Rust. Kalimat pentingnya:

> "Truly effective Rust development requires a transformation in how you approach software design itself."

Itu berarti menguasai `struct`, `trait`, `enum`, `match`, `Result`, ownership, borrowing, dan lifetime belum cukup. Yang mau dibongkar buku ini adalah bagaimana kita mendesain relasi antar komponen.

Beberapa hal penting dari Preface:

- Ini adalah kontrak pembelajaran buku.
- Problem utama yang diangkat bukan "Rust sulit", tapi developer sering membawa desain dari bahasa lain ke Rust.
- Rust memaksa desain kelihatan: ownership kabur, dependency berantakan, atau mutability terlalu bebas akan muncul sebagai compile error.
- Compiler Rust bertindak sebagai reviewer desain.
- Transformasi yang dituju: dari memaksa Rust mengikuti desain lama menjadi membiarkan constraint Rust membentuk desain baru.

Preface juga mengidentifikasi dua escape hatch yang sering muncul saat frustrasi:

- `clone()` bertebaran untuk mengatasi ownership sulit.
- `Rc<RefCell<T>>` dipakai untuk mengembalikan shared mutable state.

Keduanya bisa valid, tapi jika dipakai sebagai pelarian dari desain ownership, mereka berubah jadi anti-pattern.

Bagian berikutnya adalah thesis utama Preface:

> “Internalizing Rust's philosophy and allowing it to shape your thinking matters more than any individual pattern or technique.”

Intinya: jangan baca buku ini sebagai katalog pattern. Jangan mikir, “oh di Rust Factory Pattern begini, Strategy Pattern begini, Observer Pattern begini.” Yang penting adalah filosofi Rust yang membentuk cara lo memilih pattern.

Di OOP klasik, lo mungkin bertanya:

- Class apa yang perlu dibuat?
- Interface-nya apa?
- Inheritance tree-nya gimana?
- Object mana yang punya method apa?

Di Rust, pertanyaannya berubah:

- Data ini dimiliki siapa?
- Mutation terjadi di boundary mana?
- Behavior ini lebih cocok trait, enum, generic, atau closure?
- State ilegal bisa dicegah lewat type system gak?
- Apakah polymorphism perlu runtime atau cukup compile time?

Kalau lo baca bab creational/structural/behavioral pattern dengan mindset OOP, lo akan cuma cari padanan. Kalau lo baca dengan mindset Rust, lo akan cari problem desain di balik pattern, dan bertanya: “Rust punya cara lebih natural gak?”

Buku ini pakai tiga project sebagai progression:

- Bad Calculator: sengaja dibuat buruk untuk Chapter 1–4. Ini adalah cermin kesalahan, bukan app yang bagus. Tujuannya adalah melihat apa yang terjadi kalau desain Java/C++ dipaksa masuk Rust.
- Correct Calculator: untuk Chapter 5–8. Ini versi rebuilding. Problem yang sama dibangun ulang dengan pattern yang lebih cocok dengan ownership model dan type system Rust.
- Samsa microservice: untuk Chapter 9–12. Ini naik level dari calculator ke arsitektur aplikasi. Di sini pattern Rust-native mulai muncul: type system untuk compile-time safety, functional idioms, dan architectural advantage dari ownership.

Progressionnya seperti ini:

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

Scope buku ini juga jelas: fokus pada design pattern, architecture decision, dan idiomatic Rust, bukan testing, benchmarking, CI/CD, deployment, atau async runtime.

## Layer desain yang gue lihat

1. Thinking in Rust
   - Fokus ke ownership clarity.
   - `Clone` dan `Rc` bukan solusi utama; mereka bisa jadi indikator desain yang belum jelas.
   - Borrow checker sebagai feedback desain.

2. Replacing traditional patterns
   - Creational: associated function, builder, dan explicit initialization menggantikan Factory/Prototype.
   - Structural: trait, newtype, enum dispatch, dan composition menggantikan inheritance.
   - Behavioral: closure, enum state machine, iterator, trait, dan channel menggantikan Strategy/Observer/State/Command.

3. New Rust-native patterns
   - Type-driven design: encode state valid/invalid di level tipe.
   - Functional idioms: `Option`, `Result`, iterator, combinator.
   - Core Rust features: RAII, lifetimes, pattern matching, typestate.

## Part 1: Thinking in Rust

- Di banyak bahasa, design pattern lahir karena keterbatasan bahasa itu sendiri: object, inheritance, interface, mutability, lifecycle, dependency, dan runtime polymorphism. Tapi Rust punya alat desain yang berbeda: ownership, borrowing, lifetimes, traits, enums, generics, pattern matching, dan compile-time guarantees.
- Kalau lo datang ke Rust dengan mindset "gue mau bikin class hierarchy yang rapi", lo akan cepat frustasi.
- Borrow checker kelihatan seperti musuh. `clone()` dan `Rc` terasa seperti jalan pintas. Masalahnya bukan borrow checker, melainkan desain lo yang memaksa Rust jadi Java.
- `Why Is Rust Different?` seharusnya bukan sekadar menjelaskan syntax. Ini tentang model desain: memory safety, ownership, dan type system memengaruhi cara lo membagi tanggung jawab antar komponen.
- `Anti-Pattern: Designing for Object Orientation` menyorot bahwa OOP bukan selalu salah, tapi desain yang terlalu memaksa inheritance, mutable shared state, dan class-like abstraction bisa bikin kode kaku di Rust.
- `Anti-Pattern: Using Clone and Rc Everywhere` adalah alarm: kalau borrow checker marah, jangan langsung `clone()` atau `Rc`-in. Itu sering menutupi desain ownership yang kabur.
- `Don’t Fight the Borrow Checker` merangkum Part 1: borrow checker adalah feedback dan indikator bahwa aliran kepemilikan data belum jelas.

## Part 2: Replacing Traditional Design Patterns

- Chapter 5: Creational Patterns. Di OOP kita kenal Factory, Builder, Singleton, Prototype. Di Rust, beberapa pattern berubah bentuk. Builder relevan untuk struct dengan banyak field optional. Singleton harus dipikir ulang karena global mutable state bukan natural. Rust mendorong ownership dan initialization yang eksplisit.
- Chapter 6: Structural Patterns. Di OOP ada Adapter, Decorator, Facade, Composite, Proxy. Di Rust, itu bisa muncul lewat traits, generics, newtype, composition, enum dispatch, atau trait objects. Bukan "class A extends class B", tapi "type ini mengimplementasikan behavior tertentu" atau "struct ini membungkus dependency tertentu." 
- Chapter 7 & 8: Behavioral Patterns. Karena luas, mungkin dibagi menjadi "Taking Action" dan "Keeping Track." Rust sering menggeser behavioral pattern ke function, closure, enum, trait, iterator, channel, atau state yang di-encode di tipe.
- Value Part 2: bukan sekadar syntax translation. Pattern klasik dipreteli dulu, problem aslinya ditemukan, kemudian dipilih bentuk Rust-native yang sesuai.
- Trade-off penting: trait object memberi runtime fleksibilitas, generic lebih kuat di compile-time tapi bisa membuat binary membesar dan API lebih kompleks.

## Part 3: New Patterns for Rust

- Chapter 9: Architectural Patterns. Fokusnya ke desain sistem yang lebih besar dan boundary. Di Rust, arsitektur bukan cuma soal pattern микро, tapi juga ownership boundary antar module, error boundary, concurrency boundary, dan dependency flow.
- Chapter 10: Patterns That Leverage the Type System. Type system Rust bisa mengunci invariant dan memisahkan state valid/invalid pada level tipe, bukan boolean runtime check.
- Chapter 11: Patterns from Functional Programming. Ini bisa melibatkan function, closure, iterator, combinator, `Option`, `Result`, immutability, dan composition.
- Chapter 12: Patterns Emerging from Rust’s Core Features. Pattern native dari Rust seperti ownership, borrowing, lifetimes, RAII, `Drop`, smart pointers, pattern matching, typestate, dan zero-cost abstractions.
- Chapter 13: Leaning into Rust. Jangan melawan Rust; gunakan constraint Rust sebagai alat desain.
- Ide penting: setelah mental model dan terjemahan pattern lama, Part 3 memperkenalkan pola yang memang lahir dari Rust.

## Logic path buku ini

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

## Cara baca buku ini

- Cara baca buku pattern yang benar adalah mulai dari problem, bukan nama pattern.
- Nama pattern itu label belakangan. Intinya adalah gaya menyelesaikan tension desain.
- Di Rust, tension paling utama biasanya: ownership, mutability, lifetime, abstraction boundary, dan error handling.
- Kalau lo cuma hafal “Factory, Adapter, Strategy”, lo akan mengulang pola lama.
- Kalau lo paham “kenapa pattern itu ada”, lo bisa menemukan bentuk Rust-native-nya.

## Roadmap belajar

1. Baca Part 1 pelan-pelan terlebih dahulu. Ini paling penting karena menentukan cara baca bab berikutnya.
2. Cari atomic idea dari tiap chapter, seperti “ownership as design boundary”, “borrow checker as design feedback”, “clone as hidden cost”, dan “Rc as shared ownership trade-off”.
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

4. Di Part 3, ambil ide yang bisa dipakai ke proyek nyata. Contoh: SDLC Studio atau agent architecture, refleksikan apakah pattern ini relevan untuk agent runtime, scheduler, parser, atau CLI.

## Mapping tradisional → Rust-native

- Factory
  - Problem: membuat objek tanpa expose detail konstruksi.
  - Rust: associated function, `new`, builder.
  - Trade-off: simple constructor vs konfigurasi eksplisit.

- Singleton
  - Problem: global shared instance.
  - Rust: hindari global mutable state, gunakan dependency injection dan scope ownership.
  - Trade-off: global mudah tapi menutup batasan ownership.

- Adapter / Facade
  - Problem: menyamakan interface atau menyederhanakan subsistem.
  - Rust: wrapper type, newtype, atau trait implementation.
  - Trade-off: fleksibilitas runtime vs compile-time clarity.

- Strategy
  - Problem: mengganti behavior.
  - Rust: trait/generic parameter, closure, enum dispatch.
  - Trade-off: runtime fleksibel vs compile-time optimasi.

- State
  - Problem: objek berubah perilaku berdasarkan state.
  - Rust: enum state machine, typestate.
  - Trade-off: kode lebih ketat tapi lebih aman dibanding flag mutable.

## Trade-off penting

- Trait object (`dyn Trait`) memberi runtime polymorphism, tapi kehilangan beberapa cek compile-time.
- Generic lebih kuat di compile-time dan sering lebih efisien, tapi bisa bikin API lebih kompleks dan compile time lebih lama.
- `Rc`/`Arc` cocok untuk shared ownership, tapi bisa memblur ownership boundary.
- `Clone` cocok untuk value yang murah disalin, namun bisa menyimpan biaya tersembunyi ketika dipakai sebagai shortcut.

## Design tool di Rust

- `cargo fmt` / `rustfmt`: menjaga format konsisten sehingga desain API dan boundary lebih mudah dibaca.
- `cargo clippy`: cek idiomatik Rust dan biasanya memberi rekomendasi desain yang lebih "Rusty".
- `cargo check`: validasi ownership/lifetime tanpa build penuh, berguna untuk iterasi desain tipe.
- `cargo audit` / `cargo deny`: deteksi dependency insecure atau license issue sebelum desain dilepas.
- `rust-analyzer`: bantu refactor trait, enum, dan lifetime; bagus kalau lo lagi ubah desain ownership.
- `cargo tree`: visualisasi dependency graph untuk lihat boundary dan coupling.
- `cargo expand`: lihat macro-expanded code, berguna untuk memastikan abstraction tidak menyembunyikan terlalu banyak complexity.
- `miri`: debug undefined behavior dan interpreter-level ownership bug di desain unsafe.

## Ide yang mau gue susun lagi nanti

- Apa artinya "lean into Rust" dalam kode nyata? Bukan hanya mematok fitur Rust, tapi memformalisasi invariant dan ownership boundary.
- Bagaimana pattern arsitektural di Rust berbeda ketika konteksnya sistem backend, CLI, atau runtime agent?
- Kapan type system lebih baik dibanding runtime check di codebase Rust intensif performa?
