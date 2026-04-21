---
id: zettel.20260421193302
title: "Context engineering adalah menyusun constraint lokal, bukan sekadar menambahkan informasi"
desc: "Menjelaskan context engineering sebagai praktik memilih dan menyuntikkan pengetahuan lokal yang bersifat membatasi untuk AI agents." 
tags:
  - ai-native
  - context-engineering
  - constraint
  - agent
---

## Pertanyaan yang dibuka

1. Apa itu context engineering dalam AI-native workflows?
2. Kenapa context bukan sekadar informasi tambahan?
3. Bagaimana context menjadi constraint system untuk agent?

## Klaim utama

Context engineering bukan hanya memberi AI lebih banyak data. Ia adalah praktik memilih pengetahuan lokal yang relevan, unobvious, dan membatasi, agar agent bekerja selaras dengan lingkungan spesifik.

## Perbedaan konteks dan informasi

* Informasi tambahan bisa berupa data luas tanpa struktur.
* Context engineering memilih hal-hal yang membuat keputusan agent berbeda dari inferensi generik.

## Kenapa ini penting

Tanpa context, AI cenderung:

* default ke best practice generik,
* atau inferensi dari potongan kode terbatas,
* sehingga solusi jadi salah arah untuk proyek tertentu.

Context engineering menjawab: "bagaimana perubahan ini harus dibangun di lingkungan ini?" bukan hanya "apa yang sedang dikerjakan?"

## Context sebagai constraint system

Context yang baik bersifat:

* terpilih, bukan semua informasi,
* relevan untuk keputusan lokal,
* membatasi perilaku agent,
* menghindari inference generik yang salah.

Ini termasuk:

* stack dan versi spesifik,
* naming convention dan pola helper,
* security guardrails,
* architecture-specific rules,
* feature flags dan tooling lokal.

## Kesalahan umum

* Mengira context semakin bagus kalau semakin banyak.
* Menambahkan konteks yang terlalu umum atau tidak relevan.
* Mengabaikan bahwa context yang tidak selektif bisa mencemari fokus model.

## Implikasi

* Context engineering adalah dasar agar agent tidak berubah jadi "fitur AI generik".
* Ia penting untuk menskalakan AI dalam repo nyata dan brownfield.
* Ia menempatkan knowledge institusional ke dalam ruang kerja agent.

## Lihat juga

* [[zettel.20260421172800]] — BMAD project context adalah konstitusi implementasi untuk AI agents, bukan dokumentasi biasa
* [[zettel.20260419193544]] — Agent eksplorasi codebase harus struktural, bukan sekadar search random
* [[zettel.20260421193301]] — Methodology wajib ada supaya AI-assisted development tidak jadi chaos yang efisien
