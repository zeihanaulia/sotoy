---
id: notes.security.deepsec-docs
title: "Deepsec docs: workflow harness, bukan scanner sekali jalan"
desc: "Ringkasan implementasi deepsec dari repo docs, termasuk instalasi, matcher, context, state, dan workflow nyata."
updated: 1777991151798
created: 1777991151798
tags:
  - notes
  - security
  - deepsec
  - ai-security
---

## Overview
Gue baca docs `vercel-labs/deepsec` dan yang paling nyangkut buat gue adalah: Deepsec itu bukan lagi tool yang cuma jalan sekali lalu selesai. Dia dibuat sebagai workspace security review yang ngatur seluruh proses.

## 1. Instalasi dan workspace terpisah
- `npx deepsec init` bikin folder `.deepsec/` di repo.
- ini penting karena konfigurasi dan data scan disimpen terpisah dari kode aplikasi.
- output scan dan state (`data/<id>/files/`, `runs/`, `project.json`) digitignore.
- menurut gue ini langkah yang bener: workspace terpisah bikin lingkungan scan lebih jelas.
- idempotency juga penting: kalau job gagal, bisa dilanjutkan bukan mulai dari nol.

## 2. Bagaimana deepsec memilih file untuk agent
- `pnpm deepsec scan` jalan duluan, tanpa AI.
- scan ngejalanin ~110 regex matcher dan bikin JSON file per source file yang match.
- ini mirip radar murah untuk nemuin candidate site.
- menurut gue, ini desain yang realistis: jangan suruh AI baca semua file.

## 3. Context project lewat INFO.md
- `INFO.md` diwacanakan sebagai konteks yang disuntik ke agent.
- idealnya singkat: 50–100 baris, fokus ke threat model, auth shape, false-positive, konvensi internal.
- kalau konteks terlalu panjang, agent malah bisa kabur.
- menurut gue, ini pelajaran penting: konteks bukan berarti lebih banyak, tapi lebih relevan.

## 4. Bagaimana hasil disimpan dan divalidasi
- `data/` itu state Deepsec: project.json, config.json, INFO.md, files/, runs/, reports/.
- tiap `FileRecord` nyimpen candidate, hash, git info, findings, history, dan status.
- `pnpm deepsec process` ngejalanin agent. defaultnya Claude Opus dengan 25 file in flight.
- biaya diperkirakan: 100 file ≈ $25–60, 500 file ≈ $130–300, 2.000 file ≈ $500–1.200.
- `pnpm deepsec triage` murah, `revalidate` lebih mahal tapi ngurangin false positive.
- menurut gue, itu step yang saya suka: ada mekanisme audit dan verification.

## 5. Workflow nyata
- lokal dulu: init, isi INFO.md, scan, process --limit 50, revalidate --min-severity HIGH, export.
- jangan langsung full monorepo.
- area target terbaik: auth/session, RBAC, tenant isolation, billing, webhook, file upload, server-side fetch.
- plugin ownership dan notifier bikin hasil bisa masuk workflow tim.
- sandbox relevan kalau repo besar atau kalau butuh isolasi.
- kalau cuma mau coba, lokal dulu. sandbox nggak wajib.

## Apa yang gue pelajari dari docs
- Deepsec bukan cuma agent. dia adalah workflow platform kecil.
- AI hanya salah satu bagian. Ada scan awal, context injection, revalidate, state, dan export.
- `INFO.md` bikin agent lebih tajam.
- `revalidate` jelas menunjukkan bahwa developer harus curiga sama output awal.
- ownership/notifier bikin temuan lebih mungkin ditindaklanjuti.

## Batasan operasional
- Deepsec cocok untuk audit burst, bukan scan setiap PR terus-menerus.
- biaya bisa nyata, jadi butuh budget dan pengaturan area.
- default matcher nggak menangkap semua pola org-specific.
- jika pakai remote sandbox/gateway, perlu atur security source code sendiri.
- output banyak belum cukup; harus ditriage dan diekspor.

## Insight utama
Docs ini bikin gue sadar bahwa keamanan AI-native bukan cuma soal model. Ini soal cara kerja.

Pola yang gue tangkep:
- scan murah dulu,
- context spesifik lewat INFO.md,
- agent proses candidate,
- triage dan revalidate sebelum percaya,
- simpan state di data/,
- hubungkan hasil ke workflow.

Kalau elo ngerti docs-nya, pertanyaannya bukan "model apa?" lagi, tapi "bagaimana ini diintegrasikan ke workflow kita?"

## Referensi utama
- `README.md`
- `docs/getting-started.md`
- `docs/writing-matchers.md`
- `docs/configuration.md`
- `docs/plugins.md`
- `docs/models.md`
- `docs/vercel-setup.md`
- `docs/architecture.md`
- `docs/data-layout.md`
- `docs/faq.md`
- `samples/webapp/deepsec.config.ts`

## Related Zettels
- [[zettel.20260505179969]]
- [[zettel.20260505179970]]
- [[zettel.20260505179975]]
- [[zettel.20260505179976]]
- [[zettel.20260505179977]]
- [[zettel.20260505179978]]
- [[zettel.20260505179979]]
- [[zettel.20260505179980]]
- [[zettel.20260505179983]]
- [[daily.journal.2026.05.05]]
