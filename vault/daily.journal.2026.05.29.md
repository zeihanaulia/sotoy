---
id: daily.journal.2026.05.29
title: '2026-05-29'
desc: "Refleksi eksperimen Codex macOS sandboxing dan praktik shell bersih untuk menghindari secret env kebocoran."
created: 1780042623130
updated: 1780043749000
tags:
  - daily
  - security
  - codex
  - sandboxing
---

## Hari ini gue ngulik Codex sandbox di macOS dari sudut env hygiene

Gue sudah paham bahwa Seatbelt itu batasan akses proses, bukan secret manager. Yang bikin masalah bukan karena sandbox "bocor"; yang bikin masalah adalah kalau gue mulai Codex dari terminal yang sudah punya API key dan token.

## Insight utama yang gue dapat

Kalau proses child sudah memegang env var secret dari parent shell, Seatbelt nggak otomatis menariknya lagi. Itu kayak lo sudah ngasih kertas berisi password ke anak, terus lo pasang pagar di sekitar dia: pagar nggak bisa bikin kertas itu hilang.

Jadi pola yang lebih masuk akal adalah:

- jangan mulai Codex dari terminal yang penuh token
- bersihkan environment dulu dengan `env -i`
- whitelist hanya variabel yang aman seperti `HOME`, `PATH`, `SHELL`, `TERM`
- jangan export secret global di `~/.zshrc`
- pakai Keychain/secret manager dengan approval eksplisit bila perlu

## Workaround operasional yang gue rekam

Bukan: minta Seatbelt menyensor env.
Ini: mulai Codex dari shell yang bersih.

Contoh yang gue catat:

```bash
env -i \
  HOME="$HOME" \
  PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" \
  SHELL="$SHELL" \
  TERM="$TERM" \
  codex
```

Dan solusi gampangnya: buat `codex-safe` di `~/.zshrc`, lalu jalankan Codex lewat situ. Itu yang harus jadi kebiasaan untuk repo yang belum sepenuhnya gue percaya.

## Setup Codex lokal yang gue simpan

Gue juga nyimpen konfigurasi user-level di `~/.codex/config.toml` supaya perilaku Codex CLI/IDE lebih mirip eksperimen `sandbox-exec`:

```toml
sandbox_mode = "workspace-write"
approval_policy = "on-request"
approvals_reviewer = "user"

[sandbox_workspace_write]
network_access = false
writable_roots = []
exclude_tmpdir_env_var = true
exclude_slash_tmp = true

[shell_environment_policy]
inherit = "core"
ignore_default_excludes = false
exclude = [
  "*KEY*",
  "*TOKEN*",
  "*SECRET*",
  "*PASSWORD*",
  "*CREDENTIAL*",
  "AWS_*",
  "OPENAI_API_KEY",
  "GITHUB_TOKEN",
  "GH_TOKEN",
  "NPM_TOKEN",
  "DATABASE_URL",
  "PGPASSWORD"
]
include_only = []
set = {}
```

Itu adalah baseline yang gue pake: workspace masih bisa dikerjain, network dimatikan, env sensitif tidak diwariskan, dan root tambahan cuma dibuka kalau perlu.

Kalau repo asing, gue lebih ketat lagi dengan `inherit = "none"` dan `include_only` minimal. Baru kalau ada tool yang benar-benar butuh env spesifik, gue tambahkan satu per satu.

## Global vs per repo/project
Gue sekarang melihatnya sebagai layer konfigurasi Codex, bukan setting sandbox macOS mentah. Global config di `~/.codex/config.toml` adalah sabuk pengaman default yang harus konservatif. Per-project config di `.codex/config.toml` adalah izin kerja khusus untuk repo tertentu, dan hanya boleh dipakai kalau repo itu dipercaya.

Profile config `~/.codex/.config.toml` berguna untuk mode kerja yang berbeda—misalnya `paranoid` untuk repo asing atau `internal` untuk repo kantor. CLI flags paling kuat; pakai untuk override satu sesi tanpa mengubah config.

Jadi prinsipnya:

- global = baseline aman
- per-project = exception spesifik
- profile = mode kerja
- CLI flag = override sementara

Itu yang bikin setup Codex lebih sehat daripada sekadar nge-DIY `sandbox-exec`.

## Hasil eksperimen yang gue ingat

- `sandbox-exec` bisa menahan akses file/network di luar workspace.
- tapi `FAKE_API_KEY` masih muncul kalau env dari parent shell ikut.
- workspace writable tetap bisa diubah kalau profile mengizinkan.
- network deny bisa memblokir eksfiltrasi, tapi env var tetap bisa dibaca kalau sudah diwariskan.
- current working directory juga penting: kalau shell dijalankan dari path yang tidak diizinkan, buka shell bisa error `getcwd`.

## Kenapa ini penting buat workflow gue

Karena gue mau pakai Codex lokal tanpa ngasih false sense of security. Sandbox itu bagian yang penting, tapi bukan satu-satunya. Gue butuh:

- shell bersih sebagai lapisan pertama
- approval policy untuk network/escalation
- git diff untuk review perubahan workspace
- secret manager daripada export global

Kalau repo asing atau mencurigakan, gue masih pakai container/VM/remote sandbox.

## Tautan terkait

- [[notes.agentic-engineering.codex-macos-sandboxing]]
