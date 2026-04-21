---
id: zettel.20260421170516
title: "BMAD adalah framework workflow AI-native engineering yang mengganti prompt chaos dengan peran dan fase terstruktur"
desc: "BMAD Method menjelaskan cara kerja AI-driven software delivery lewat agent peran, guided workflows, planning track, dan konteks proyek."
tags:
  - bmad
  - ai-native
  - methodology
  - software-engineering
---

## Pertanyaan yang dibuka

1. BMAD itu sebenarnya apa?
2. Dia menyelesaikan problem apa dalam AI-assisted / AI-native engineering?
3. Cara kerjanya bagaimana?
4. Cocok dipakai untuk use case seperti apa, dan kapan tidak cocok?

## Klaim utama

BMAD bukan model AI dan bukan sekadar template prompt. BMAD adalah kerangka kerja tim buatan untuk AI-native engineering: ia memaksa interaksi AI menjadi workflow berperan, berfase, dan terikat konteks.

## Apa itu BMAD?

BMAD singkatan dari **Build More Architect Dreams**. Menurut dokumentasi, BMAD adalah AI-driven development framework yang membimbing software development dari ideation sampai implementasi.

Secara sederhana:

* BMAD adalah sistem kerja untuk membuat AI ikut menjalankan proses software development end-to-end.
* BMAD mengasumsikan software engineering perlu dipecah menjadi fase disiplin: analysis, planning, solutioning, implementation.
* BMAD mengisi bagian "methodology" dalam tumpukan AI-native engineering.

## Problem yang diselesaikan BMAD

BMAD dirancang untuk menangani failure mode khas AI-assisted engineering:

* AI loncat ke coding sebelum masalah jelas.
* requirement kabur.
* desain belum matang.
* arsitektur tidak dipikir.
* AI menulis kode yang kelihatan bagus tapi melenceng konteks.
* agent muter-muter revisi tanpa arah.
* hasil akhir sulit direview dan diaudit.

Atomic insight:

> BMAD memaksa AI untuk "berpikir seperti tim", bukan bertindak seperti chatbot serba bisa.

## Cara kerja BMAD

### 1. Role-based agents

BMAD memakai specialized AI agents / personas.

Peran-peran ini bukan manusia berbeda, tetapi pola kerja lain yang dikomunikasikan ke AI:

* analyst
* planner
* architect
* developer
* tester
* reviewer

Setiap peran punya fokus berbeda. Ini mencegah satu prompt tunggal memaksa AI menyelesaikan semua fungsi sekaligus.

### 2. Guided workflows

BMAD membangun alur kerja eksplisit dari fase-fase:

* Analysis (optional)
* Planning (required)
* Solutioning (BMad Method / Enterprise)
* Implementation

Dokumentasi BMAD menekankan penggunaan `bmad-help` sebagai pemandu cerdas yang tahu apa yang harus dilakukan selanjutnya.

Workflow juga dibagi menurut kompleksitas proyek:

* Quick Flow — bug fix, fitur sederhana, ruang lingkup jelas.
* BMad Method — produk, platform, fitur kompleks.
* Enterprise — compliance, multi-tenant, security, DevOps.

### 3. Intelligent planning + context

BMAD menekankan plan dan project context sebagai artefak pertama.

Dokumentasi menyebut:

* `project-context.md`
* `PRD.md`
* `architecture.md`
* epics/stories
* `sprint-status.yaml`

Context proyek membantu AI tetap sesuai aturan tim, arsitektur, dan implementation policy.

### 4. Fresh chat dan skill invocation

BMAD merekomendasikan setiap workflow dijalankan di chat baru. Ini menghindari masalah batas konteks dan membuat setiap langkah fokus.

Contoh skill / workflow:

* `bmad-help`
* `bmad-create-prd`
* `bmad-create-architecture`
* `bmad-generate-project-context`
* `bmad-sprint-planning`
* `bmad-create-story`
* `bmad-dev-story`
* `bmad-code-review`
* `bmad-retrospective`

## Use case yang cocok

### Greenfield project

BMAD berguna untuk:

* mengubah ide mentah jadi requirement
* membangun perencanaan yang disiplin
* memberikan struktur untuk produk baru atau MVP

### Brownfield / existing project

BMAD juga cocok untuk:

* memahami codebase sebelum mengubahnya
* menjaga perubahan sesuai arsitektur lawas
* memecah perubahan besar jadi langkah terkendali

### Team onboarding dan knowledge transfer

BMAD membantu mengeksternalisasi reasoning tim melalui dokumentasi fase dan peran.

### Delivery fitur terstruktur

BMAD masih bisa dipakai untuk quick dev atau feature kecil asalkan scope tidak terlalu remeh.

## Kapan BMAD tidak cocok?

BMAD kurang cocok bila:

* task-nya sangat kecil dan jelas (misalnya mengganti warna tombol atau typo)
* tim butuh eksperimen ultra cepat tanpa struktur
* tim belum siap disiplin menulis context/spec
* project terlalu kecil untuk dibebani proses berfase

Atomic insight:

> BMAD menambah struktur. Jika biaya misal arah lebih rendah dari biaya proses, BMAD bisa terasa overkill.

## BMAD dan Thoughtworks

BMAD mengisi blok **methodology** pada kerangka Thoughtworks AI-native engineering.

Dalam praktek:

* agent = peran BMAD (developer, architect, PM, dsb.)
* model = komponen reasoning di balik tiap agent
* methodology = BMAD workflow dan track
* spec = PRD, story, project context
* context = project-context dan artefak planning

Jadi BMAD bukan saingan agent atau model. BMAD adalah cara mengoperasikan stack AI-native.

## Contoh output BMAD

Setelah langkah awal, proyek BMAD biasanya menghasilkan:

* `_bmad/` — konfigurasi, agent, workflow, task
* `_bmad-output/` — planning artifacts, implementation artifacts, project context
* `PRD.md`
* `architecture.md`
* epic/story files
* `sprint-status.yaml`

## Lihat juga

* [[zettel.20260421163750]] — Thoughtworks: AI-native engineering adalah operating model untuk mengorkestrasikan AI, bukan sekadar AI coding
* [[zettel.moc.software-architecture]]
