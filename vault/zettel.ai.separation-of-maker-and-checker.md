---
id: "zettel.ai.separation-of-maker-and-checker"
title: "Pemisahan Maker dan Checker dalam Verifikasi AI"
description: "Prinsip bahwa entitas yang mengimplementasikan solusi tidak boleh menjadi entitas yang memvalidasi kebenarannya untuk menghindari self-justification."
tags:
  - ai-verification
  - engineering-discipline
  - testing
created: 1781158953088
updated: 1781161780979
---

## Konsep
Dalam pengembangan software menggunakan AI, terdapat risiko besar bernama **self-justification**, di mana AI yang menulis kode juga menulis test-nya. Hasilnya, AI cenderung membuat test yang hanya memvalidasi bahwa kodenya "jalan" (pass), bukan memvalidasi bahwa kodenya "benar" sesuai behavior domain.

## Prinsip Utama
Untuk mendapatkan verifikasi yang valid, harus ada pemisahan tegas antara **Maker** (yang mengimplementasikan) dan **Checker** (yang memvalidasi).

1. **Maker**: AI yang mengimplementasikan fitur/komponen.
2. **Checker**: Manusia (atau sistem deterministik/model judge yang berbeda) yang menentukan kriteria keberhasilan.

## Implementasi Praktis
- **TDD dengan AI**: Manusia menulis test (Checker) $\rightarrow$ AI menulis kode (Maker) $\rightarrow$ Test memverifikasi.
- **Deterministic First**: Gunakan validator JSON, test suite, atau OpenAPI spec sebelum menggunakan model judge.
- **Boundary Control**: Test harus fokus pada behavior domain (apa yang dilakukan), bukan detail implementasi (bagaimana itu dilakukan).

## Relasi
- [[notes.ai-engineering.allen-holub-approach]]: Implementasi keras dari prinsip ini dengan melarang AI menulis test.
- [[notes.ai-engineering.loop-engineering]]: Kebutuhan akan verifier dalam loop untuk menghindari loop abadi atau hasil sampah.
