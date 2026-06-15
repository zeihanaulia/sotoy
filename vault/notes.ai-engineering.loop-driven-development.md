---
id: "notes.ai-engineering.loop-driven-development"
title: "Loop Driven Development (LDD): Solving the Oracle Problem"
description: "Pendekatan membangun software di era agent dengan fokus pada desain sumber feedback (Oracle) yang independen, deterministic, dan queryable."
tags:
  - ai-coding
  - ldd
  - testing
  - oracle-problem
---

## Inti Pemikiran

Dalam era coding agent, biaya untuk menulis kode implementasi dan scaffolding test sudah menjadi sangat murah (hampir gratis). Namun, muncul bottleneck baru yang disebut **The Oracle Problem**: mengetahui apa jawaban yang benar untuk input tertentu.

**Loop Driven Development (LDD)** adalah paradigma di mana fokus utama engineer bergeser dari "menulis kode" menjadi "mendesain sumber feedback (Oracle)" yang berkualitas tinggi, sehingga agent bisa melakukan looping perbaikan implementasi secara mandiri dan akurat.

## The Oracle Problem & Feedback Quality

Kualitas sebuah loop ditentukan oleh kualitas sumber feedback-nya. Nuno Campos membagi kualitas feedback berdasarkan dua dimensi: **Independence** (independen dari kode yang diuji) dan **Queryability** (bisa ditanya untuk input baru).

### Ranking Sumber Feedback (Terlemah $\rightarrow$ Terkuat)

1. **In-thread Review (Self-Review)**: Agent menilai kodenya sendiri. Sangat lemah karena cenderung terjadi *self-justification*.
2. **Standards/RFC Text**: Independen tapi statis. Terlalu banyak interpretasi, tidak bisa menjawab edge case spesifik secara otomatis.
3. **Off-thread Review**: Evaluator agent yang berbeda. Lebih baik, tapi tetap berupa opini/judgment, bukan pengukuran objektif.
4. **High-quality Test Suites**: Independen dan executable, tapi statis. Hanya bisa menjawab apa yang sudah ditulis dalam test.
5. **Oracle to Mimic (The Gold Standard)**: Sistem nyata yang sudah ada (misal: real Excel untuk membuat Excel-compatible engine). Independen, deterministic, dan queryable.

## Behavior Coverage vs Code Coverage

LDD menekankan perbedaan antara dua jenis coverage:
- **Code Coverage**: Menjawab "apakah baris ini pernah dieksekusi?". Bisa 100% tapi sistem tetap salah.
- **Behavior Coverage**: Menjawab "apakah skenario domain yang penting sudah dipin dalam test?". Inilah yang menentukan kebenaran sistem.

## Teknik Praktis LDD

### 1. Mining High-Quality Open-Source Test Suites
Menggunakan test suite dari project open-source lain sebagai spesifikasi behavior. Agent digunakan untuk mem-port atau mengadaptasi test tersebut ke implementasi kita.
- **Prinsip**: Test harus mem-pin behavior (output), bukan detail implementasi (internal).

### 2. Programmatic Oracle Querying
Membangun pipeline untuk mengambil jawaban dari oracle nyata secara otomatis:
`Live Oracle` $\rightarrow$ `Capture Output` $\rightarrow$ `Freeze as Snapshot` $\rightarrow$ `CI Assert against Snapshot`.
- **Keuntungan**: CI tetap cepat karena menggunakan snapshot beku, sementara developer bisa me-refresh snapshot dari oracle asli.

## Peran Manusia dalam LDD

Kreativitas engineer berpindah ke empat area keputusan:
1. **Which Oracle**: Memilih sumber kebenaran yang tepat.
2. **Which Properties to Pin**: Menentukan output mana yang harus divalidasi (menghindari *brittle tests*).
3. **Shape of Comparison**: Menentukan metode perbandingan (Equality, Distance, Tolerance).
4. **Definition of Done**: Menentukan kapan loop berhenti (behavior dimension tercakup, snapshot reproducible).

## Sintesis dengan Paradigma Lain

| Paradigma | Fokus Utama | Kontribusi terhadap Loop |
|---|---|---|
| **Loop Engineering** | Orkestrasi & Sistem | Menyediakan "mesin" looping dan infrastruktur. |
| **Engineering Discipline** | Arsitektur & Boundary | Menyediakan "rem" dan struktur agar loop tidak chaos. |
| **LDD** | Feedback & Oracle | Menyediakan "kompas" (sumber kebenaran) agar loop terarah. |

## Referensi
- Thread X: https://x.com/nfcampos/status/2064746971944956299
