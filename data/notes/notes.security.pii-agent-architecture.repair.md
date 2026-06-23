
## Problem
RePAIR melihat bahwa PII kadang sudah sampai ke model sebelum akhirnya muncul di output. Di banyak pipeline, sanitization input tidak lengkap dan model masih bisa mengeluarkan informasi sensitif saat menjawab.

## Solution
Solusinya adalah model-aware redaction pada output. RePAIR melatih sistem untuk mendeteksi personal information dalam respons dan meredaksinya sebelum ditampilkan kepada pengguna. Ini memberi lapisan mitigasi terakhir ketika PII sudah sampai ke tahap generation.

## Real case implementation
Implementasi nyata adalah menambahkan output filter di akhir pipeline LLM. Setelah model menghasilkan respons, sistem memeriksa PII dan menggantinya atau menghapusnya sesuai policy. Ini terutama berguna ketika input sanitization sudah ada, tetapi masih ada kemungkinan leak di keluaran model.

## Relevance
RePAIR cocok sebagai safety net untuk PII leakage, bukan sebagai solusi utama. Untuk user-supplied PII, desain arsitektur terbaik tetap mencegah eksposur awal, dengan RePAIR sebagai cadangan jika kebocoran terjadi.

Original paper: https://arxiv.org/abs/2604.12820

Link: [[notes.security.pii-agent-architecture]]
