---
id: notes.agentic-engineering.how-i-use-ai-to-code
title: How I Use AI to Code
desc: >-
  Ringkasan artikel Chris Parsons tentang agent CLI, harness, dan pergeseran
  dari prompt ke verifikasi dalam AI coding.
updated: 1780426712062
created: 1777997610939
tags:
  - notes
  - agentic-engineering
  - ai-coding
  - harness
---

## Overview

Gue baca halaman aktif "How I Use AI to Code" dari Chris Parsons tanggal 22 April 2026 sebagai esai tentang bagaimana AI sekarang dipakai untuk kerja software, bukan sekadar autocomplete. Intinya: model AI itu bukan lagi soal siapa nulis kode, tapi siapa atau apa yang menjamin kode itu benar.

## Key quotes

- “If you are still tied to your IDE, whether Cursor or Copilot, you are working a year behind. Coding turned out to be AI’s home territory.”
- “Verified used to mean ‘read by you’. With modern agent throughput, it has to mean ‘checked by tests, by type checkers, by automated gates, or by you where your judgement matters’.”
- “The reason is the harness, not the model.”
- “When an agent gets stuck on something that should be trivial, treat it as a context failure, not a prompt failure.”
- “Specify the problem, not the solution.”

## Kenapa coding jadi "home territory" AI

Chris menegaskan coding cocok banget untuk AI karena kode adalah teks yang padat informasi, presisi, dan bisa diverifikasi. Itu bedanya dengan AI yang nulis esai atau opini: kalau kode salah, kita bisa jalankan compiler, type checker, linter, unit test, integration test, atau runtime error.

Berarti AI coding sukses bukan karena AI tiba-tiba "ngerti" software secara manusia, tapi karena software punya feedback loop objektif. Tulis sedikit, verify, baca diff, perbaiki, ulangi. Loop kecil inilah yang bikin agent CLI bisa bekerja.

## Kenapa toolchain pindah dari IDE ke CLI

Chris bilang kalau lo masih nempel ke IDE seperti Cursor atau Copilot, lo ketinggalan setahun. Bukan karena IDE itu jelek, tapi karena AI coding terkuat sekarang bukan lagi editor assistant. Ia adalah command-line agent yang bisa:

- baca seluruh repo,
- ubah beberapa file sekaligus,
- jalankan command test, lint, build,
- perbaiki error dan terus iterasi.

Dengan CLI, kerja AI bisa lintas file, lintas command, dan lintas siklus. Ini lebih cocok untuk agen yang perlu konteks repo penuh dan loop verifikasi.

## Senior engineer harus jadi trainer, bukan reviewer

Ide ini penting:

Senior tidak boleh terjebak jadi orang yang hanya baca diff dan approve. Kalau banyak komentar review yang berulang, itu tanda kegagalan sistem.

Chris membedakan dua cara kerja AI coding:

- **Vibe coding**: cepat, output AI dibiarkan berjalan, dan yang penting tampak berhasil.
- **Agentic engineering**: AI boleh menghasilkan kode, tetapi perubahan tetap kecil, ada guardrail, dokumentasi, test, type checker, review surface, dan automated gate.

Perubahan kecil di sini bukan soal berapa baris kode. Ini soal satu siklus kerja yang memiliki satu tujuan jelas, satu risiko utama, dan satu cara verifikasi jelas.
Satu task agentic engineering harus small, bounded, dan tidak mencampur banyak keputusan sekaligus.

Bukan berarti fitur harus kecil selamanya. Bisa saja 200 baris jika scope-nya satu konsep. Yang kecil adalah ruang keputusan dan risiko.

Itu membuat perbedaan penting: bukan prompt yang utama, tapi apakah agen punya lingkungan kerja yang bisa memverifikasi hasilnya sendiri.

Senior terbaik menurut Chris adalah yang bisa memindahkan judgement itu ke harness. Kalau agent sering salah query database di loop, jangan terus komentar. Buat rule, skill, linter, atau test yang mencegahnya.

Kalau agent lupa audit trail, jangan lagi cuma kasih komentar. Tambahkan skill dan gate yang memaksa audit trace.

## Harness lebih penting daripada prompt

Kalimat pentingnya: "The reason is the harness, not the model." Dan juga: "When an agent gets stuck on something that should be trivial, treat it as a context failure, not a prompt failure."

Jadi nggak cukup sekadar memperbaiki prompt. Kalau agent salah, yang perlu dicek dulu adalah:

- apakah dia punya konteks repo yang benar?
- apakah ada instruksi permanen seperti `AGENTS.md` atau `CLAUDE.md`?
- apakah ada skill file untuk spesifik domain?
- apakah loop verifikasi sudah otomatis?

Prompt hanya bagian kecil. Harness adalah rangka kerja yang menjaga agent tetap konsisten dan bisa diaudit.

## Apa saja komponen harness yang Chris pakai

Chris menekankan tiga layer praktis:

1. `AGENTS.md` / `CLAUDE.md`
   - file instruksi permanen untuk perilaku agent.
   - singkat, spesifik, terus diperbaiki setelah tiap sesi.
2. Skill files
   - rules yang lebih detail untuk area khusus: security review, database migration, API convention, testing strategy, dsb.
3. Portable vault
   - catatan Markdown terpisah yang bisa dipakai ulang oleh agen lain.
   - ini bikin knowledge durable, bukan terjebak di satu tool.

## Kenapa bottleneck baru bukan coding, tapi feedback

Kutipan penting dari artikel ini:

> “The game is not ‘how fast can we build’ any more. It is ‘how fast can we tell whether this is right’.”

Ini pusat argumen: kecepatan generate tidak lagi jadi keunggulan utama. Keunggulan baru adalah kecepatan membuktikan bahwa sesuatu benar.

Sekarang masalahnya bukan lagi "siapa yang bisa nulis kode cepat." Masalahnya: "seberapa cepat kita tahu kode itu benar?"

Chris bilang game-nya berubah dari build speed ke verification speed. Kalau tim nggak punya test dan CI kuat, AI cuma menambah PR dan rework.

Developer bisa merasa 20% lebih cepat karena kodenya jadi cepat jadi, tapi delivery terukur bisa jadi lebih lambat karena semua overhead verifikasi jadi dominan.

## Kenapa spesifikasi harus problem-first

Chris mengkritik pendekatan yang salah: tulis spec solusi terlalu detail, lalu biarkan AI jadi stenografer.

Yang lebih kuat adalah spesifikasi problem dengan constraint dan success criteria. Contoh:

- buruk: "Buat tabel audit_log dengan delapan kolom dan index ini."
- lebih baik: "Butuh audit log untuk setiap write, searchable by user, disimpan tujuh tahun, dan tidak boleh memperlambat hot path."

Dengan cara itu, agent masih bisa usul desain yang masuk akal, sementara kita tetap memberi batasan yang benar.

## Context sweet spot

Kualitas output AI tergantung jumlah konteks yang tepat. Terlalu sedikit: output generic. Terlalu banyak: model kebanjiran noise.

Sweet spot berarti cukup informasi untuk problem, tapi tidak overload. Kalau agent mulai refactor tak perlu, mengulang asumsi, atau terdengar yakin tapi nggak nyambung, itu tanda harus reset dan mulai lagi dengan chunk yang lebih bersih.

## Failure mode yang Chris sebut

Beberapa jebakan yang masih sering terjadi:

- accidental vibe coding: agent dipakai tanpa guardrail, lalu ship sebelum diverifikasi.
- review fatigue: senior kewalahan baca semua diff.
- invisible dependencies: agen ngandelin kemampuan tersembunyi yang bisa hilang saat model berganti.
- premature relief: tim merasa adaptasi selesai karena sudah pasang Claude Code atau Codex CLI.

## Korelasi dengan agentic engineering dan security review

Kalau lo bikin agent CLI untuk security, pendekatan vibe coding akan berhenti di "scan repo, cari vuln, kasih rekomendasi." Itu raw dan sering noisy.

Approach Chris lebih agentic engineering:

- ada `AGENTS.md` untuk prinsip security repo,
- ada skill file untuk review dependency, auth flow, SQL injection, dsb,
- agent menjalankan tool nyata: Semgrep, OSV, npm audit, trufflehog, unit test, type check,
- temuan harus punya evidence, severity, dan recommended fix,
- false positive dibalik jadi aturan supaya sesi berikutnya lebih presisi.

## Kenapa ini penting

Buat gue, nilai utama artikel ini bukan sekadar "Claude Code vs Copilot." Ini tentang pergeseran struktur kerja:

- dari nulis kode ke membangun sistem yang menghasilkan kode benar,
- dari prompt ke harness,
- dari review manual ke feedback loop,
- dari senior sebagai coder utama ke senior sebagai trainer sistem,
- dari spec solusi ke framing problem,
- dari knowledge di kepala senior ke knowledge di Markdown + skill file + gate.

## Referensi

- https://www.chrismdp.com/coding-with-ai/

## Related Zettels

- [[zettel.20260505179969]]
- [[zettel.20260505179908]]

## Related notes

- [[notes.agentic-engineering.next-wave-cloud-agents]]
- [[notes.agentic-engineering.openclaw.personal-agent-orchestration]]
- [[notes.agentic-engineering.senior-judgement-to-harness]]
- [[notes.agentic-engineering.cloud-agent.handson.references]]
- [[zettel.moc.agentic-engineering]]
