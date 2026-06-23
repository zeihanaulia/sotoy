
## Konsep
**The Oracle Problem** muncul ketika kemampuan AI untuk menghasilkan implementasi dan test scaffolding melampaui kemampuan manusia (atau sistem) untuk menentukan apakah output tersebut benar-benar benar secara domain.

Dalam TDD tradisional, manusia adalah oracle. Dalam AI-driven development, jika AI menulis kode sekaligus menulis test-nya, terjadi *self-justification* (AI membuat test yang membenarkan kodenya sendiri).

## Solusi: Oracle-Driven Feedback
Untuk memecahkan masalah ini, feedback dalam loop AI harus berasal dari sumber yang:
1. **Independen**: Tidak berasal dari agent yang menulis kode.
2. **Deterministic**: Input yang sama selalu menghasilkan output yang sama.
3. **Queryable**: Bisa ditanya untuk input baru secara spesifik.

## Bentuk Oracle
- **Sistem Referensi (Mimicry)**: Menggunakan software yang sudah mapan sebagai sumber kebenaran (misal: menggunakan real Postgres untuk memvalidasi parser SQL baru).
- **Conformance Suites**: Menggunakan kumpulan test standar industri (misal: Test262 untuk JS).
- **Human-Defined Behavior**: Manusia menentukan output spesifik untuk edge case krusial.

## Relasi
- [[notes.ai-engineering.loop-driven-development]]: LDD adalah metodologi untuk mengelola oracle problem.
- [[zettel.ai.separation-of-maker-and-checker]]: Solusi fundamental untuk menghindari self-justification.
