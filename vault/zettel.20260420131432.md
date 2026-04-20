---
id: zettel.20260420131432
title: "Nilai anchoring ditentukan oleh overhead dokumentasi versus biaya kehilangan konteks"
desc: "Trade-off ini yang menentukan kapan anchoring worth it."
tags:
  - zettel
  - ai-collaboration
  - knowledge-management
  - context-anchoring
---

## Gagasan

Kalau bikin dokumen lebih mahal daripada nge-rebuild sesi, itu tanda belum cocok.

## Mengapa Ini Penting

Ini jadi alat evaluasi praktis, bukan prinsip dogmatis.

## Maksud Overhead Dokumentasi

Overhead dokumentasi berarti biaya tambahan yang muncul karena membuat, memperbarui, dan memelihara dokumentasi feature. Ini bisa berupa:

- waktu menulis ringkasan keputusan,
- usaha menyinkronkan dokumen dengan kode dan status nyata,
- review dan percobaan agar dokumen tetap akurat.

Jika fitur sangat kecil atau hanya butuh satu sesi, biaya ini bisa lebih besar daripada cuma mengulang sedikit konteks di chat.

## Biaya Kehilangan Konteks

Biaya kehilangan konteks terjadi ketika sesi baru harus membangun ulang semua asumsi. Ini nyata dalam bentuk:

- waktu yang terbuang menjelaskan lagi keputusan sebelumnya,
- AI yang mengulang alternatif yang sudah ditolak,
- kesalahan karena alasan keputusan tidak lagi terlihat,
- sesi panjang yang dipaksa bertahan supaya konteks tidak hilang.

Contoh praktis: jika sebuah fitur butuh diskusi multi-hari, tanpa feature document maka setiap sesi akan butuh rekap ulang, dan risiko AI lupa alasan `RetryQueue` ditolak atau constraint `email-only` semakin besar.

## Kapan Enggak Worth It

- task eksplorasi sekali jalan yang selesai dalam satu jam,
- bug fix kecil dengan konteks jelas dari kode yang ada,
- sesion proof-of-concept yang tidak akan dilanjutkan.

Dalam kasus ini, membuat dokumentasi feature adalah overhead yang tidak sebanding.

## Kapan Worth It

- fitur yang tersebar beberapa sesi,
- keputusan arsitektur yang kompleks,
- tim atau AI session berganti-ganti,
- ketika kehilangan konteks berpotensi menyebabkan ratusan menit rework.

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 35.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 35
