
Reply Jarred Sumner menunjukkan satu model kerja hand-porting besar:

- port breadth-first, bukan depth-first,
- tulis semua kode terlebih dahulu,
- jangan langsung mencoba incremental-fix satu-satu.

Strategi ini membantu menjaga kerangka sistem tetap utuh dan mengurangi beban kognitif saat memindahkan runtime besar dari satu bahasa ke bahasa lain.

Referensi: [[notes.software-architechture.bun-rust-porting]]
