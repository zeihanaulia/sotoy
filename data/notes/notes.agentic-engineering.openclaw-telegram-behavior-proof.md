
## Overview

Di sini "project" yang gue lihat adalah workflow QA evidence di OpenClaw: OpenClaw app, Telegram extension, Crabbox, Codex/GitHub workflow, dan bukti perilaku nyata.

Bukan seluruh OpenClaw produk. Fokusnya: bagaimana PR ini jadi paket audit kecil, bukan cuma patch kode.

Intinya:

- PR ini nggak hanya menjelaskan bug dan fix.
- PR ini juga membawa: runtime path, environment, before/after, evidence scope, dan area yang belum dites.
- Crabbox di sini bukan sekadar screen recorder. Ia adalah agent workspace control plane: prepare box, sync checkout, run remote command, collect evidence, release.

## 6 pertanyaan kunci

### 1. Sebenernya OpenClaw lagi ngetes apa?

PR ini kecil, tapi karena konteksnya Telegram formatter, bug-nya bisa berdampak besar.

Bug: output Telegram hilang blank line antara bullet block dan numbered section.

Sebelum fix:

```text
report/draft.\n3. Cognee
```

Sesudah fix:

```text
report/draft.\n\n3. Cognee
```

Di chat interface, blank line bukan sekadar estetika. Dia adalah pembatas semantik.

Atomic idea: **bug kecil formatting dapat merusak struktur pesan di channel chat**.

### 2. Pipeline teknisnya kira-kira gimana?

Dari PR dan bot review, alurnya bisa dipetakan seperti ini:

```text
Issue masuk
  ↓
Bug direproduksi dari input nyata
  ↓
Patch dibuat di Telegram formatter
  ↓
Unit/regression test ditambah
  ↓
Bot review mengecek correctness + security + changelog
  ↓
Crabbox menjalankan real Telegram Desktop proof
  ↓
Before/after GIF dipublish ke PR
  ↓
Label berubah jadi proof: supplied
  ↓
PR di-merge
```

Yang penting bukan satu tool sakti. Ini adalah **rantai kerja**.

- OpenClaw: system under test
- Telegram extension: area bug
- Formatter: kode yang diubah
- Codex/GitHub workflow: proses patch dan before/after
- Crabbox: environment, execution, evidence
- Bot review: gating, label, boundary

### 3. Kenapa bot review-nya penting?

Di PR ini ada bot yang menolak merge karena temuan teknis bukan sekadar test fail.

Temuan bot:

- normalizer baru hanya melacak fenced code block
- Markdown juga punya indented code block
- normalizer bekerja sebelum parser paham struktur
- ini bisa membuat blank line masuk ke literal code block

Atomic idea: **semakin awal normalizer bekerja, semakin tinggi risikonya mengubah syntax yang belum dipahami**.

Bot tidak cuma mengatakan "error". Bot menelusuri boundary dan meminta regression guard untuk kasus indented code block.

### 4. Apa peran Crabbox di sini?

Crabbox bukan hanya recorder. Dia adalah control plane agent workspace.

Dari publiknya, Crabbox bisa:

- sewa/siapkan environment
- sync checkout lokal ke remote
- jalankan command jarak jauh
- stream output
- collect evidence
- release box

Dalam PR ini evidence-nya lebih dari sekadar GIF:

- before GIF
- after GIF
- real Telegram Desktop session
- real Telegram user
- shared group
- model response deterministic
- SUT bot reply via OpenClaw Telegram

### 5. Mengapa model response harus deterministic?

Karena tujuan proof adalah mengisolasi perubahan formatter.

Jika model response berubah, before/after jadi lemah.

Prinsipnya mirip eksperimen yang benar:

- kontrol prompt sama
- kontrol mock response sama
- kontrol channel sama
- kontrol UI sama

Yang diuji hanya:

- formatter main vs formatter PR

Atomic idea: **real behavior proof tetap butuh controlled experiment**.

### 6. Kalau mau direproduce, levelnya ada berapa?

Jangan langsung lompat ke full Crabbox + Telegram real.

Bagi jadi tiga level.

#### Level 1: Lokal minimal

Tujuannya: buktikan formatter bug.

Yang dibutuhkan:

- repo OpenClaw
- Node/pnpm sesuai repo
- file Telegram formatter
- test file Telegram formatter

Contoh perintah:

```bash
pnpm test extensions/telegram/src/format.test.ts
pnpm exec oxfmt --check --threads=1 extensions/telegram/src/format.ts extensions/telegram/src/format.test.ts CHANGELOG.md
```

#### Level 2: Integration-ish dengan mock channel

Tujuannya: buktikan output path benar.

Alur:

```text
mock model response
  ↓
OpenClaw Telegram formatter
  ↓
render ke Telegram HTML/chunks
  ↓
assert pemisah benar
```

Khususnya: cek normal reply rendering dan chunked reply rendering.

#### Level 3: Real behavior proof

Baru ini mirip PR sebenarnya.

Alur ideal:

```text
git checkout main
run OpenClaw Telegram bot test
kirim prompt via Telegram user ke group
mock model deterministic
record Telegram Desktop: main-before
checkout PR branch
ulang prompt sama
record Telegram Desktop: pr-after
publish GIF/video + notes ke PR
```

Kontrol penting:

- prompt sama
- mock response sama
- Telegram account/session sama
- chat/group sama
- screen size sama
- font/UI scale sama
- commit SHA jelas
- recording timestamp jelas

## Arsitektur yang bisa ditiru

Bagian paling penting bukan recorder. Yang paling penting adalah **evidence schema**.

Minimal architecture:

```text
GitHub PR
  ↓
CI / GH Workflow
  ↓
Crabbox / Runner
  ↓
Real Channel
  ↓
Evidence Pack
  ↓
PR Comment
```

Contoh evidence schema:

```markdown
## Real behavior proof

Behavior addressed:
- [jelaskan bug yang diperbaiki]

Environment:
- app:
- channel:
- OS:
- commit before:
- commit after:

Scenario:
- [siapa mengirim apa ke mana]
- [response mock/model apa]
- [expected visual behavior apa]

Evidence:
- before:
- after:
- logs:

Observed before:
- ...

Observed after:
- ...

What was not tested:
- ...
```

GIF/video tanpa konteks itu lemah. GIF + commit + scenario + expected result + scope not-tested yang membuatnya menjadi audit evidence.

## Insight terakhir

Project ini paling menarik bukan karena "mereka bikin GIF before/after".

Sebab yang lebih penting:

- mereka sedang membangun workflow di mana perubahan kode harus membawa bukti perilaku nyata
- PR jadi paket audit kecil, bukan sekadar patch
- evidence harus terstruktur agar tidak overclaim

Kalau mau mulai di project sendiri:

1. pilih flow yang susah dipercaya hanya dari diff
2. buat deterministic fixture input
3. jalankan main vs patch
4. record behavior dengan alat yang ada
5. attach artifact + context
6. tulis batasan apa yang tidak dites

Video proof bukan test utama. Dia adalah **lapisan trust di atas test**.
