---
id: zettel.20260420131429
title: "Feature document mengompresi hari kerja menjadi konteks yang bisa diakses ulang cepat"
desc: "Dokumen membuat beberapa hari kerja bisa dimengerti dalam beberapa menit."
tags:
  - zettel
  - ai-collaboration
  - knowledge-management
  - context-anchoring
---

## Gagasan

Ini penting buat orang baru atau sesi AI baru yang masuk ke fitur itu.

## Mengapa Ini Penting

Bukan cuma buat arsip, tapi buat nyambungin ritme kerja tim.

## Apa Maksudnya

Kalimat ini menekankan bahwa feature document berfungsi sebagai ringkasan kontekstual dari beberapa hari kerja. Bukan berarti kita menulis `MEMORY.md` baru setiap hari. Yang dimaksud adalah:

- beberapa sesi pengembangan yang tersebar dalam beberapa hari bisa disambungkan oleh satu dokumen feature;
- dokumen itu menampung keputusan penting, alasan, batasan, dan kondisi saat ini;
- orang baru atau sesi AI baru bisa membaca dokumen itu dan langsung paham apa yang sudah terjadi tanpa menelusuri seluruh chat atau riwayat implementasi.

## Bukan `MEMORY.md` Harian

Ini bukan pendekatan harian seperti jurnal kerja. Kalau kita membuat `MEMORY.md` per hari, itu lebih mirip catatan aktivitas harian atau diary. Feature document yang dimaksud oleh artikel adalah dokumen yang tetap relevan sepanjang feature itu berjalan.

Prinsipnya:
- buat satu dokument `feature-context` untuk fitur tertentu,
- update ketika ada keputusan baru atau status berubah,
- gunakan dokumen itu sebagai sumber warm start untuk sesinya berikutnya.

Jadi bukan `MEMORY.md` per hari; lebih tepatnya `feature-context.md` yang hidup terus sampai fitur selesai.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 32.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 32
