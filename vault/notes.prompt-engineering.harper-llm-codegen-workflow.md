---
id: notes.prompt-engineering.harper-llm-codegen-workflow
title: "Harper Reed: LLM codegen workflow"
desc: "Analisis Harper Reed tentang workflow LLM coding yang memisahkan brainstorming, spec, planning, eksekusi, dan test."
updated: 1778773904838
created: 1778773904838
tags:
  - notes
  - prompt-engineering
  - ai
  - codegen
  - workflow
---

## Workflow utama

Harper Reed menggambarkan workflow LLM codegen sebagai rangkaian eksplisit: brainstorming → spec → plan → execution → test/iterate. Ini bukan sekadar "chatbot bikin kode sekali jadi"; ini disiplin engineering yang membuat AI bekerja di rel kecil.

Link: https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm/

Secara praktis, tahapannya adalah:

1. brainstorm/spec: LLM bertanya satu per satu sampai requirement matang.
2. compile spec: hasil percakapan dirapikan menjadi `spec.md`.
3. planning: spec diberi ke reasoning model untuk membuat blueprint dan `prompt_plan.md`.
4. todo/checklist: progress disimpan agar state tidak hilang.
5. execution: codegen dijalankan di tool seperti Claude, Aider, Cursor.
6. test/iterate: hasil diuji dan diperbaiki sebelum lanjut.

## Kenapa mulai dari brainstorming/spec?

Karena ide mentah biasanya tidak cukup tajam untuk dieksekusi. Jika hanya bilang "buatkan app habit tracker", LLM akan mengisi banyak asumsi sembarangan.

Harper menghindari itu dengan meminta LLM menanyakan detail secara bertahap:

- apakah habit harian atau fleksibel?
- apakah user membutuhkan streak?
- data disimpan lokal atau cloud?
- kapan fitur reminder diperlukan?
- bagaimana perilaku skip hari?
- seperti apa UI/UX yang diharapkan?

Spec menjadi alat untuk mengurangi tebakan, bukan dokumen administratif.

## Mengapa planning dipisah dari execution?

Harper menekankan bahwa task besar harus dipecah menjadi chunk kecil yang aman untuk dieksekusi dan diuji.

Ia meminta model untuk membuat blueprint yang rinci, lalu membagi blueprint tersebut menjadi langkah-langkah kecil. Dengan cara ini, LLM tidak lagi diminta mengubah banyak file sekaligus tanpa kontrol.

Ini mencegah kegagalan mode "build the whole app" di mana sebuah prompt besar menghasilkan perubahan luas yang sulit diaudit.

## Greenfield vs brownfield

### Greenfield

Untuk proyek baru, workflow Harper sangat planning-heavy. Ia mulai dari ide, lalu buat spec, plan, todo, dan eksekusi incremental.

Spec juga bisa dipakai untuk hal lain: white paper, business model, atau riset lebih dalam. Ini menunjukkan bahwa spec adalah artefak pusat.

### Brownfield

Untuk codebase yang sudah ada, fokusnya bergeser ke context extraction per task.

Harper menggunakan repomix untuk membuat bundle `output.txt` dari repo, lalu memberikannya ke LLM. Ia menghindari mindset "LLM refactor seluruh repo" dan lebih memilih improvement kecil:

- generate code review,
- temukan missing tests,
- buat GitHub issue,
- implementasi satu issue kecil,
- jalankan tests,
- ulangi.

## Risiko "over my skis"

Harper menulis bahwa AI coding bisa membuat kita bergerak terlalu cepat sampai kehilangan kontrol:

- kode dibuat terus,
- pemahaman manusia tertinggal,
- tiba-tiba ada file yang tidak jelas asalnya,
- architecture berubah tanpa disadari,
- dependency ditambah tanpa alasan yang kuat.

Solusinya bukan menghindari LLM, melainkan memberi rem engineering: step kecil, dokumentasi, testing, dan review yang disiplin.

## Testing sebagai rem

Testing di workflow ini bukan aksesori. Ia adalah kontrol objektif.

Harper meminta setiap step cukup kecil untuk diimplementasikan dengan testing yang kuat. Ini mencegah "perasaan sudah maju" ketika sebenarnya bug menumpuk.

Tanpa testing, AI coding bisa terasa cepat tetapi mudah menghasilkan utang teknis besar.

## Sosial: solo vs team

Harper mengkritik bahwa workflow AI coding saat ini masih banyak bersifat solo. Antarmuka dan prosesnya cenderung single-player.

Dalam tim, masalahnya muncul di:

- bot yang bertabrakan,
- konflik merge,
- konteks yang berbeda antar orang,
- history decision tersebar di chat,
- reviewer tidak tahu alasan perubahan,
- prompt dan issue tidak terhubung ke PR.

AI coding efektif bukan hanya soal model. Ini soal collaboration protocol: bagaimana tim menyimpan spec, prompt, todo, review, dan test agar bisa dimainkan bersama.

## Hubungan dengan Martin Fowler

Harper adalah implementasi praktis dari gagasan Fowler tentang Interrogatory LLM.

- Fowler: LLM sebagai pewawancara untuk menggali konteks.
- Harper: gunakan konteks itu untuk membuat `spec.md`, `prompt_plan.md`, dan `todo.md`, lalu eksekusi incremental.

Dengan cara ini, proses codegen menjadi pipeline artefak yang dapat diwariskan antar tahap dan bukan sekadar prompt sekali tembak.

## Related notes

- [[notes.prompt-engineering]]
- [[til.ai.interrogatory-llm-context-elicitation]]
