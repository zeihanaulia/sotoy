
Gue pakai arti ini: **Context Layers L0/L1/L2 di OpenViking adalah tiga tingkat representasi konteks untuk satu resource/memory/skill**. Ini bukan layer neural network, bukan level permission. Ini strategi loading supaya agent tidak langsung menelan semua isi dokumen ke prompt.

## 1. Pertanyaan kunci yang gue pegang

1. Kenapa OpenViking butuh L0/L1/L2?
2. Apa fungsi L0?
3. Apa fungsi L1?
4. Apa fungsi L2?
5. Bagaimana L0/L1 dibuat?
6. Bagaimana layer ini muncul dalam struktur folder?
7. Kapan agent harus pakai L0, L1, atau L2?

## 2. Kenapa harus ada L0/L1/L2?

Masalah utama agent adalah context budget. Kalaupun data banyak dan relevan, prompt tidak bisa menampung semua. Kalau lo langsung masukin:

- dokumen panjang,
- chat history,
- memory user,
- codebase,
- skill docs,
- tool output,

maka prompt jadi bengkak, mahal, noisy, dan rawan salah fokus.

OpenViking bilang: konteks harus dimuat bertahap.

> OpenViking uses a three-layer information model to balance retrieval efficiency and content completeness.

Intinya:

- `L0` untuk mencari cepat,
- `L1` untuk memahami scope,
- `L2` untuk baca detail.

## 3. L0: Abstract

L0 adalah representasi paling pendek.

- Nama: Abstract
- File: `.abstract.md`
- Token: sekitar 100 token
- Tujuan: vector search, quick filtering

L0 dipakai untuk menjawab: “Apakah item ini relevan atau tidak?”

Contoh L0:

> API authentication guide covering OAuth 2.0, JWT tokens, and API keys for secure access.

L0 bukan bukti detail. Dia lebih seperti label semantik.

Analogi:

- `L0` = judul + abstrak super pendek di kartu katalog perpustakaan.

## 4. L1: Overview

L1 adalah ringkasan menengah yang benar-benar membantu navigasi.

- Nama: Overview
- File: `.overview.md`
- Token: sekitar 1–2 ribu token
- Tujuan: rerank, content navigation

L1 menjawab: “Isi area ini apa saja? Bagian mana relevan? File mana yang harus dibuka?”

Contoh L1:

> This guide covers three authentication methods for the API:
> - **OAuth 2.0** (L2: oauth.md): Complete OAuth flow with code examples
> - **JWT Tokens** (L2: jwt.md): Token generation and validation
> - **API Keys** (L2: api-keys.md): Simple key-based authentication

L1 bukan sekadar ringkasan. L1 adalah peta navigasi.

Ini yang membuat L1 biasanya cukup untuk membangun context LLM.

## 5. L2: Detail

L2 adalah konten lengkap.

- Nama: Detail
- File: original files/subdirs
- Token: unlimited/full content
- Tujuan: full content, on-demand loading

L2 menjawab: “Apa isi lengkapnya? Mana bukti/detail teknis?”

Contoh L2:

- `read("viking://resources/docs/auth/oauth.md")`
- `read("viking://resources/docs/auth/jwt.md")`

Tapi L2 tidak boleh dibuka otomatis. L2 hanya dibuka jika L0/L1 sudah menunjukkan bahwa detailnya memang perlu.

## 6. Mekanisme pembuatan L0/L1

L0/L1 dibuat saat resource baru ditambahkan dan saat session history dikompresi.

Flow resource ingestion:

- Input dokumen
- Parser membuat struktur file/directory
- SemanticQueue generate L0/L1 async
- Vector Index dibangun dari URI + metadata

Flow session archive:

- Chat/session history lama
- SessionCompressor
- Generate L0/L1 untuk history segment

Jadi L0/L1 bukan cuma untuk dokumen statis. History percakapan lama pun bisa dibangun menjadi layer yang bisa dicari.

## 7. Bottom-up generation

OpenViking membuat layer dari bawah ke atas:

- leaf nodes → parent directories → root

Contoh:

- buat L0/L1 untuk `oauth.md`
- buat L0/L1 untuk `jwt.md`
- buat L0/L1 untuk `api-keys.md`
- gabungkan ringkasan child menjadi overview folder `auth/`

Parent directory overview dibangun dari abstrak child-nya. Jadi folder tahu isi anak-anaknya.

## 8. Struktur folder dan file

Setiap directory bisa punya struktur seperti:

```
viking://resources/docs/auth/
├── .abstract.md
├── .overview.md
├── .relations.json
├── oauth.md
├── jwt.md
└── api-keys.md
```

L0 dan L1 adalah file nyata di folder. L2 adalah file asli atau subdirectory.

## 9. On-demand loading

On-demand loading berarti L2 tidak dibaca otomatis. Agent harus sudah yakin relevan sebelum membuka detail penuh.

Pattern ideal:

- Lihat L0 dulu
- Buka L1 untuk navigasi
- Kalau perlu, baca L2

Kalau langsung ke L2, konteks akan boros dan noisy.

## 10. Kapan pakai L0, L1, L2?

- `L0`: quick relevance check.
- `L1`: pahami content scope dan cari bagian penting.
- `L2`: baca detail asli untuk bukti/gambar/konfigurasi.

Untuk banyak jawaban, L1 biasanya sudah cukup. L2 dipakai kalau user minta kutipan, nilai teknis, atau detail lengkap.

## 11. Kaitan dengan retrieval

Flow retrieval ideal OpenViking:

- Query → L0 candidate search
- L1 navigation/rerank
- Select URI
- L2 read if needed

Ini berbeda dari RAG flat yang langsung pakai top-k chunks.

## 12. Contoh sederhana

Query: “Untuk user-facing app, auth method yang direkomendasikan apa?”

- L0 auth: temukan folder auth
- L1 auth: lihat rekomendasi OAuth 2.0
- Bisa jawab tanpa L2

Query: “Flow OAuth step-by-step gimana?”

- L0 auth: temukan folder auth
- L1 auth: lihat bahwa oauth.md ada
- buka L2 oauth.md untuk detail

## 13. Insight penutup

Context Layers di OpenViking itu cara agent membaca: L0 = "apa ini?", L1 = "bagian mana yang harus dibaca?", L2 = "baca lengkapnya".

Kalau agent ingin pintar, dia tidak langsung mengunyah semua konten. Dia triage dulu.

## Related documents

- [[notes.agentic-engineering.openviking.context-database]]
- [[notes.agentic-engineering.openviking.architecture]]
- [[notes.agentic-engineering.openviking.storage-architecture]]
- [[notes.agentic-engineering.openviking.context-extraction]]
- [[notes.agentic-engineering.openviking.context-types]]
- [[vault/daily.journal.2026.06.03|Daily 2026-06-03]]
