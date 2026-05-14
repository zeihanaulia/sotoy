---
id: zettel.literature.design-patterns-and-best-practices-in-rust
title: "Rust-native design lebih dari sekadar pattern"
desc: "Preface menegaskan bahwa efektifitas Rust berasal dari transformasi cara berpikir desain, bukan hanya penerapan pola." 
updated: 1778772857433
created: 1778772857433
tags:
  - zettel
  - literature-note
  - rust
  - software-architecture
---

## Klaim utama

- Effective Rust development is a design transformation, not a pattern checklist.
- Rust design should begin with ownership, state, boundary, and invariants, not with object hierarchies.
- `clone()` dan `Rc<RefCell<T>>` are useful escape hatches but become anti-patterns when they mask unclear ownership.
- The Rust compiler acts as a design reviewer: borrow-check failures are signals about boundary clarity.
- The book’s pedagogical progression intentionally uses failure modes first, then translation, then Rust-native synthesis.

## Evidence dari Preface

- The thesis line is: “Internalizing Rust's philosophy and allowing it to shape your thinking matters more than any individual pattern or technique.”
- Preface contrasts the appeal of Rust’s guarantees with the frustration of borrow checker rejection for seemingly reasonable designs.
- The text explicitly says the book is not a catalog of Rust pattern implementations.
- It distinguishes between asking OOP-style questions (“Class apa yang perlu dibuat?”) and Rust-style questions (“Data ini dimiliki siapa?”).
- The examples of `clone()` everywhere and `Rc<RefCell<T>>` everywhere are presented as symptoms of unclear ownership or forced shared mutable state.

## Implikasi desain

- When evaluating a Rust pattern, ask which design tension it resolves rather than what GoF label it matches.
- Compiler errors should be treated as feedback on ownership and lifetime boundaries.
- A good Rust design prefers explicit ownership and compile-time invariants over runtime workaround.
- Pedagogical examples should include bad designs to expose failure modes before showing idiomatic alternatives.

## Relevansi

- Link ke software architecture: Rust-native design is a decision layer about data flow and boundary, not just syntax or API shape.
- This note is useful for comparing pattern-driven learning with constraint-driven learning.
- It supports a reading strategy that prioritizes problem → Rust feature → trade-off over pattern name.
