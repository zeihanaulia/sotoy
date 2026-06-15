---
id: "zettel.ai.behavior-coverage-vs-code-coverage"
title: "Behavior Coverage vs Code Coverage"
description: "Perbedaan antara mengukur eksekusi baris kode (code coverage) dengan mengukur pemenuhan skenario domain (behavior coverage)."
tags:
  - testing
  - ai-coding
  - quality-assurance
---

## Konsep
Dalam pengembangan software, sering terjadi miskonsepsi bahwa **Code Coverage** yang tinggi (misal 100%) menjamin kualitas software. Namun, code coverage hanya mengukur *execution path*, bukan *correctness*.

**Behavior Coverage** mengukur sejauh mana skenario-skenario penting dalam domain bisnis/teknis telah dipin (fixed) dalam test suite.

## Perbandingan

| Dimensi | Code Coverage | Behavior Coverage |
|---|---|---|
| **Pertanyaan Utama** | "Apakah baris ini pernah dijalankan?" | "Apakah behavior X untuk input Y sudah benar?" |
| **Metrik** | Persentase baris/branch yang terlewati. | Daftar skenario domain yang terverifikasi. |
| **Kelemahan** | Bisa 100% tapi output salah (missing assertions). | Lebih sulit diukur secara otomatis (butuh domain knowledge). |
| **Konteks AI** | AI bisa dengan mudah mencapai 100% coverage. | AI butuh Oracle untuk tahu behavior apa yang harus dicover. |

## Implikasi dalam AI Coding
Agent bisa menghasilkan ribuan test yang memberikan code coverage tinggi, tetapi test tersebut bisa jadi dangkal (tidak mengecek edge case domain). Oleh karena itu, fokus engineer harus bergeser dari mengejar angka coverage ke mendesain **behavioral oracles**.

## Relasi
- [[notes.ai-engineering.loop-driven-development]]: LDD menggunakan behavior coverage sebagai indikator 'Done'.
- [[zettel.ai.the-oracle-problem]]: Menentukan behavior coverage membutuhkan oracle yang valid.
