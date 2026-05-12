---
id: handbook.product-thinking.from-feature-to-service-design
title: "Learning Path: Dari Feature Checklist ke Service Design Thinking"
description: "Urutan belajar untuk keluar dari build trap, menemukan pain point yang tajam, dan membangun service experience yang smooth."
tags:
  - product-thinking
  - service-design
  - learning-path
  - customer-discovery
  - build-trap
status: published
---

## Konteks

Problem yang mau diselesaikan learning path ini ada 3 lapis:

1. Keluar dari **feature checklist thinking** — ukuran sukses bukan lagi "fitur jadi", tapi "problem customer terselesaikan"
2. Bisa nemu **pain point yang tajam** — bukan asumsi builder, tapi perilaku nyata customer
3. Bisa ngebentuk **service experience** yang smooth — bukan sekadar produk yang "secara fungsi jalan"

> Kalau langsung belajar "UX" atau "startup" secara umum, bisa terlalu melebar.
> Masalah ini lebih spesifik: perlu membangun otot untuk melihat **momen sakit → opportunity → service journey → MVP kecil**.
> Jadi urutan belajarnya harus dari anti-build-trap dulu, baru customer discovery, baru service design, baru product operating model.

---

## Urutan Prioritas Baca

### 1. Escaping the Build Trap — Melissa Perri

Paling kena untuk kondisi "selama ini gue fokus ke fitur apa aja." Buku ini membahas jebakan organisasi yang *cranking out features* tapi tidak membangun value customer. Perusahaan yang hidup-mati dari output sering jatuh ke "build trap" — terus mengirim fitur sesuai jadwal alih-alih kebutuhan customer. ([Google Books](https://books.google.com/books/about/Escaping_the_Build_Trap.html?id=PQ8dMQAACAAJ))

Ada chapter "Projects Versus Products Versus Services" yang nyambung langsung ke diskusi product vs service. ([O'Reilly](https://www.oreilly.com/library/view/escaping-the-build/9781491973783/))

**Kalau cuma satu buku dulu, mulai dari ini.**

---

### 2. The Mom Test — Rob Fitzpatrick

Untuk masalah "susah nemu pain point." Fokus ke cara ngobrol dengan customer tanpa ketipu validasi palsu. Handbook untuk mendapat learning dari customer conversation, bahkan ketika orang "berbohong" atau terlalu sopan. ([The Mom Test](https://www.momtestbook.com/))

Banyak founder gagal bukan karena gak nanya customer, tapi karena nanyanya salah. Misal: *"menurut lo ide gue bagus gak?"* — itu hampir pasti bias. Yang benar: gali perilaku masa lalu, bukan opini terhadap ide.

Contoh pertanyaan yang benar:
> *"Terakhir kali lo bikin PRD dari meeting note, prosesnya gimana? Bagian mana yang paling makan waktu? Workaround lo apa?"*

Kecil, praktis, sangat cocok untuk engineer yang mau belajar discovery tanpa jadi PM formal.

---

### 3. Continuous Discovery Habits — Teresa Torres

Kalau The Mom Test ngajarin **cara ngobrol**, buku ini ngajarin **cara menjadikan discovery sebagai kebiasaan sistematis**. Structured and sustainable approach agar tim bisa menemukan produk yang customer mau sekaligus memberi hasil bisnis. ([Apple Books](https://books.apple.com/us/book/continuous-discovery-habits/id1567317892))

Yang paling penting: **Opportunity Solution Tree** — berhenti lompat dari "pain" langsung ke "fitur".

```
Business Outcome
       |
User Opportunity / Pain
       |
Possible Solutions
       |
Assumption Tests
```

Contoh untuk SDLC Studio:

```
Outcome:
Reduce time from meeting note to sprint-ready backlog

Opportunity:
PO takut requirement ambigu dan dev banyak tanya ulang

Solutions:
AI brief generator
Missing-question detector
Jira user story exporter

Tests:
Kasih 5 PO sample meeting notes
Lihat apakah mereka merasa output-nya bisa dipakai dalam planning
```

Ini bikin fitur lahir dari opportunity, bukan dari imajinasi builder.

---

### 4. Good Services — Lou Downe

Ringkas dan tajam untuk prinsip service yang bagus. Lou Downe adalah eks Director of Design di UK Government. ([Good Services](https://good.services/about))

Cocok dipakai sebagai checklist evaluasi:
- Apakah user tahu langkah berikutnya?
- Apakah service membantu user menyelesaikan tujuan?
- Apakah ada dead-end?
- Apakah bahasa sistem jelas?
- Apakah transisi antar step smooth?

---

### 5. This is Service Design Doing — Marc Stickdorn dkk.

Toolkit lengkap: 33 case studies, 96 co-authors, 205 contributors, library 54 metode service design. ([This is Service Design Doing](https://www.thisisservicedesigndoing.com/)) ([Open Library](https://openlibrary.org/books/OL27227533M/This_is_service_design_doing))

Ngajarin melihat service sebagai sistem interaksi, bukan layar aplikasi. Jadi mulai sensitif ke onboarding, handoff, backstage process, failure recovery, support, dan momen sebelum/sesudah user memakai software.

Kalau sering merasa "fiturnya ada tapi feel-nya gak smooth" — ini yang melatih mata lo.

---

### 6. The Lean Product Playbook — Dan Olsen

Bagus kalau butuh proses runtut untuk product-market fit. Lebih terasa sebagai playbook dibanding *Inspired*. Cocok setelah lo sudah punya daftar pain/opportunity dan ingin mengubahnya jadi MVP, value proposition, dan testable product.

---

### 7. Inspired — Marty Cagan

Bagus untuk product culture dan cara product team yang kuat bekerja. Tapi ditaruh di urutan akhir karena: kalau belum punya otot pain discovery, terasa terlalu high-level. Baca setelah fondasi dari Perri, Fitzpatrick, dan Torres sudah ada.

---

## Minimum Viable Reading List

Kalau waktu terbatas, kombinasi paling minimum:

**Escaping the Build Trap + The Mom Test + Continuous Discovery Habits**

Tiga itu cukup untuk mengubah pertanyaan dari:

> *"Fitur apa yang harus gue bikin?"*

menjadi:

> *"Momen sakit apa yang cukup sering, cukup mahal, dan bisa gue kurangi dengan service kecil yang jelas?"*

---

## Rencana Praktis 30 Hari

**Minggu 1** — baca *Escaping the Build Trap*.
Target bukan tamat doang. Tiap hari tulis: "di produk gue, fitur mana yang cuma output, bukan outcome?"

**Minggu 2** — baca *The Mom Test*.
Langsung praktik: interview 5 orang. Jangan pitching produk. Tanya proses kerja terakhir mereka:
- meeting requirement terakhir → gimana?
- bikin Jira terakhir → gimana?
- review PRD terakhir → gimana?
- sprint planning terakhir → gimana?

**Minggu 3** — baca bagian inti *Continuous Discovery Habits*, terutama Opportunity Solution Tree.
Ambil hasil interview, kelompokkan jadi opportunity. Jangan bikin fitur dulu.

**Minggu 4** — baca *Good Services* atau pilih beberapa metode dari *This is Service Design Doing*.
Gambar service journey dari satu use case: *"meeting notes → sprint-ready backlog."*

---

## Prinsip di Balik Urutan Ini

> Urutan ini sengaja mulai dari "menghentikan kebiasaan build fitur", lalu baru "belajar mendengar pain", lalu "memetakan opportunity", lalu "mendesain service journey".
>
> - Kalau langsung service design tanpa discovery → mendesain journey dari asumsi
> - Kalau langsung interview tanpa anti-build-trap → semua jawaban tetap diterjemahkan jadi fitur
> - Kalau langsung MVP tanpa opportunity mapping → cepat launch tapi bisa launch hal yang salah

---

## Resource Pelengkap

Selain buku, kebiasaan yang perlu dibangun: baca **post-mortem/build log indie maker**. Pieter Levels dengan "12 startups in 12 months" adalah contoh yang sering disebut.

Tapi jangan tiru permukaannya: "cepat bikin banyak produk." Yang perlu ditiru adalah polanya: pilih pain kecil, scope kecil, launch cepat, ukur reaksi nyata.

---

## Lihat Juga

- [[notes.saas.sdlc-studio-service-vs-product]] — perbedaan product vs service untuk SDLC Studio
- [[handbook.product-thinking.service-sense-and-journey-thinking]] — framework 5 lapis + Moment→Promise→Path→Proof→Loop untuk membangun service sense
