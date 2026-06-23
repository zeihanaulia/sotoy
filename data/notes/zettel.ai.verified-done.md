
## Konsep
Dalam workflow tradisional, seorang developer merasa selesai ketika implementasi fitur telah ditulis. Namun, dalam AI-driven development, kecepatan generate kode membuat "penulisan" menjadi trivial.

**Verified Done** adalah standar di mana sebuah tugas dianggap selesai hanya jika:
1. Implementasi telah ditulis.
2. Seluruh check (tests, linter, typecheck) telah dijalankan dalam session tersebut.
3. Output verifikasi menunjukkan status 'Pass'.

## Mengapa Ini Penting?
Tanpa definisi ini, agent cenderung mengalami "hallucination of completion"—merasa sudah selesai karena kodenya terlihat benar secara sintaksis, padahal secara behavior gagal.

## Implementasi
- **Stop Hooks**: Memaksa eksekusi verifikasi tepat sebelum agent bisa mengirim pesan "Done".
- **Evidence-Based Reporting**: Mewajibkan agent melampirkan output terminal sebagai bukti verifikasi.

## Relasi
- [[notes.ai-engineering.claude-code-loop-setup]]: Implementasi praktis menggunakan hooks di Claude Code.
- [[zettel.ai.separation-of-maker-and-checker]]: Memastikan verifikasi dilakukan oleh checker yang independen.
