---
id: til.ai.real-behavior-proof-setup
title: "Setup MVP untuk workflow real behavior proof"
desc: "Setup minimal untuk mereplikasi workflow video proof / real behavior proof mirip PR OpenClaw."
updated: 1780000000000
created: 1780000000000
tags:
  - til
  - ai
  - agentic-engineering
  - qa
  - evidence
---

## Inti setup

Setup ini bukan sekadar nyiapin screen recorder. Yang dibangun adalah **evidence pipeline**:

1. kode berubah
2. test jalan
3. app dijalankan
4. skenario direproduksi
5. behavior direkam
6. artifact ditempel ke PR

Jadi tools-nya harus menutup tiga kebutuhan utama:

- kontrol environment
- kontrol input
- bukti output

## Tools minimum untuk mulai

Paling kecil yang diperlukan:

- Git
- Runtime project sesuai stack
  - Node.js / pnpm untuk JS/TS
  - Python / pytest untuk Python
  - Go / cargo untuk Go
- Test runner
  - Vitest / Jest / pytest / go test / cargo test
- Script runner
  - bash / npm scripts / Makefile / justfile
- Recorder sederhana
  - Playwright video untuk web
  - OBS / ffmpeg untuk manual / desktop
- Tempat simpan artifact
  - GitHub Actions artifacts
  - S3/R2
  - attachment PR langsung
- Template PR comment

Kalau sudah punya ini, versi pertama sudah bisa jalan.

## Kalau flow-nya browser/web app

Stack yang masuk akal:

- Playwright
  - buka app
  - jalankan skenario
  - record video / screenshot
  - simpan artifact
- GitHub Actions
  - checkout main
  - jalankan before
  - checkout PR
  - jalankan after
  - upload artifacts
  - comment ke PR

Tools konkret:

- Git
- GitHub Actions
- Node.js / pnpm / npm
- Playwright
- ffmpeg (optional untuk trim/convert)
- gh CLI untuk comment PR

## Kalau flow-nya desktop app seperti Telegram

Tools-nya lebih berat:

- Linux VM / container dengan GUI
- Xvfb atau display server nyata
- VNC / noVNC untuk inspect manual
- Telegram Desktop
- ffmpeg untuk screen recording
- scripted input tool
  - xdotool / ydotool
  - Playwright kalau ada browser part
  - custom automation

Untuk Telegram khususnya:

- Telegram Desktop terinstal
- akun Telegram test
- grup / channel test
- bot token untuk SUT
- session persistence supaya login tidak ulang terus
- secret management untuk token/session

Jangan remehkan real login/session. Kalau tiap run butuh login manual, workflow langsung rapuh.

## “Satu PC” sebagai environment eksekusi

Dalam konteks ini, “satu PC” bukan harus perangkat fisik khusus. Ini adalah satu environment eksekusi yang punya display/session untuk menjalankan app dan merekam behavior.

Bentuknya bisa:

- PC/laptop lokal: cocok untuk eksperimen awal.
- VM dengan GUI: cocok untuk automation serius.
- Cloud runner dengan virtual display: cocok untuk CI web/headless.
- Remote desktop pool: cocok untuk desktop app nyata seperti Telegram Desktop.
- Container biasa: cukup kalau cuma web/headless test.

Perbedaan utama:

- Web app biasanya cukup dengan Playwright + Chromium + video recording di CI.
- Desktop app nyata butuh GUI session, login session, dan recorder seperti ffmpeg.

Trade-off:

- disposable runner:
  - + bersih
  - + aman
  - + repeatable
  - - login ulang susah
  - - setup lebih lama
- persistent runner:
  - + session login tetap ada
  - - butuh jaga secret/state
  - - rentan noisy state

## Untuk GitHub PR automation

Minimal:

- GitHub Actions
- actions/checkout
- actions/upload-artifact
- gh CLI
- GitHub token dengan permission comment PR

Lebih proper:

- Cloudflare R2 / S3 / GCS
- metadata artifact
  - commit SHA before
  - commit SHA after
  - test command
  - scenario name
  - timestamp
  - environment info

## Optional tapi bikin workflow matang

Biar lebih disiplin:

- label bot
- review bot
- changelog checker
- code owner routing
- scoped test detector
- before/after diff generator
- evidence retention policy

## Kenapa mock model penting

Real behavior proof lo harus terkontrol. Kalau pake model live, before/after bisa beda karena output model, bukan karena patch.

Mock model yang deterministik membuat variabel pengujian jadi jelas:

- prompt sama
- response sama
- channel sama
- UI sama

Yang diuji cuma patch / formatter / behavior change.

## Level maturity setup

Level 1 — paling murah:

- Unit/regression test
- Manual screen recording
- Manual PR comment

Level 2 — semi otomatis:

- Playwright
- GitHub Actions
- auto upload artifact
- auto PR comment

Level 3 — real behavior automation:

- VM/runner GUI
- ffmpeg
- VNC/noVNC
- real account/session
- mock service deterministik
- auto before/after run

Level 4 — agentic evidence pipeline:

- Codex / agent untuk generate fix/proof notes
- review bot untuk correctness/security/changelog
- label bot untuk proof required/supplied
- artifact server
- scenario registry

## Cara pikir yang benar

Jangan lihat tools sebagai daftar belanja. Lihat sebagai rantai:

- Test runner → membuktikan logic
- Mock service → membuat input deterministic
- Runner / VM → jalankan app di environment nyata
- Recorder → tangkap behavior
- Artifact storage → simpan bukti
- PR bot → bawa bukti ke tempat keputusan merge

Insight-nya: setup terbaik bukan yang paling lengkap. Setup terbaik adalah yang menjawab pertanyaan:

> Jika reviewer lihat PR ini, apakah dia bisa percaya bahwa bug yang diklaim sudah berubah behavior-nya?

Kalau iya, MVP lo sudah benar.
