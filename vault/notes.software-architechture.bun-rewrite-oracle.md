---
id: notes.software-architechture.bun-rewrite-oracle
title: "Bun rewrite Zig → Rust: oracle test dan validasi independen"
desc: "Catatan thread Rhys Sullivan tentang pentingnya test suite independen sebagai sumber kebenaran saat melakukan rewrite Bun dari Zig ke Rust."
updated: 1778468084907
created: 1778467612733
tags:
  - notes
  - software-architechture
  - rust
  - zig
  - bun
  - testing
  - x
  - twitter
---

## Konteks

Thread Rhys Sullivan ini masih sangat nyambung ke diskusi Bun rewrite.
Bukan lagi soal arsitektur porting, atau syarat merge, tetapi soal epistemologi rewrite: bagaimana kita tahu bahwa port itu benar?

- Tweet: https://x.com/RhysSullivan/status/2053238350648406378

## Klaim utama Rhys

Rhys menempatkan nilai tes sebagai sumber kebenaran yang lebih independen daripada implementasi.
Intinya:

- rewrite Zig → Rust harus divalidasi oleh tests yang tidak ikut ditulis ulang bersama implementasinya.
- itu membuat tes berfungsi sebagai oracle eksternal.
- tanpa oracle itu, rewrite bisa terasa "lulus" hanya karena kode dan tes tumbuh bersama.

## Kenapa ini penting buat Bun port?

Ini langsung nyambung ke Bun karena portnya bukan refactor kecil. Kalau implementasi baru dan test sama-sama ikut berubah, kita tidak punya basis perbandingan yang kuat.

Rhys memberi satu jawaban sederhana:

- kalau test suite tetap, maka kita punya referensi behavior yang relatif lebih netral,
- kalau test suite ikut berubah, kita hanya punya narasi internal implementasi.

Itu penting untuk cabang B sebelumnya: measurable better.
Tanpa oracle independen, "lebih baik" bisa jadi sekadar wishful thinking.

## Reply yang paling penting

### David Fowler
Dia menambahkan bahwa test harus "really good".
Kalau tests dangkal, agent atau implementasi baru bisa membohongi kita.
Jadi bukan hanya "tests terpisah", tetapi "tests terpisah yang susah digame".

### Yeyito
Dia merumuskannya dengan tajam:

> if the agent rewrites implementation and the oracle in the same mental language, you don't get verification, you get a very confident pact between two bugs.

Ini penting karena dia menggarisbawahi risiko co-adaptation antara implementasi dan tes.

### lifcc
Menurutnya yang utama adalah behavior, bukan bahasa atau struktur internal.
Tests harus mengunci perilaku, bukan representasi implementasi.

### Nathan Oyler
Dia menggarisbawahi nilai dari memiliki implementasi lama yang tetap bisa dijalankan sebagai baseline hidup.
Itu memberi dua jenis oracle: test suite dan runtime legacy.

## Debat utama

Debat sejatinya adalah:

- apakah test harus ditulis di bahasa/metode yang berbeda? (heuristik Rhys)
- atau yang lebih penting adalah apakah test mengunci **behavior eksternal**?

Dari thread, jawaban tertumpu ke arah kedua:

- bahasa berbeda membantu,
- tetapi yang lebih kuat adalah tests yang menguji behavior, bukan internals.

Kalau tests bergantung pada shape internal, mereka bisa rusak saat implementasi diganti.

## Arah diskusi

Diskusinya mengarah ke epistemologi rewrite:

- rewrite perlu oracle eksternal,
- oracle itu bisa berupa test suite independen,
- tapi test harus berkualitas dan sulit dipuaskan oleh implementasi palsu,
- dan legacy implementation yang masih jalan bisa menjadi oracle tambahan.

Dengan kata lain, thread ini menempatkan testing bukan sebagai ritual, tetapi sebagai salah satu cara kita tahu bahwa port Bun benar-benar berhasil.

## Insight besar

Rhys mempertegas satu hal penting:
**rewrite besar harus dinilai bukan hanya dari apakah implementasi baru lulus tests, tetapi dari apakah tests itu tetap berfungsi sebagai guru eksternal.**

Kalau implementasi dan tests sama-sama "direwrite", kita kehilangan sudut pandang verifikasi.

> Ini bukan soal bahasa berbeda. Ini soal membedakan antara implementasi yang berubah dan oracle yang bertahan.

## Kaitan

- [[notes.software-architechture.bun-rust-porting]]
- [[zettel.20260511124520]]
- [[zettel.20260511124521]]
