
## Overview

Buat gue, `./.ai/commands/verify.sh` bukan standar universal. Itu adalah konvensi internal yang punya fungsi spesifik: satu executable entrypoint untuk semua verifikasi minimal.

Kalau `AGENTS.md` bilang "jangan selesai sebelum test pass", `verify.sh` adalah bentuk konkretnya. Dia adalah script yang bisa dijalankan agent, manusia, dan CI untuk membuktikan bahwa klaim "sudah selesai" punya bukti.

## Why this matters

Verifikasi sering jadi tempat agent salah tebak.
Bukan karena agent nggak bisa menulis test, tapi karena dia sering nggak tahu command yang tepat di repo itu.

Di satu repo, verifikasi bisa berarti:
- `pnpm test`
- `npm run lint`
- `go test ./...`
- `pytest`
- `cargo test`
- `dotnet test`
- `semgrep --config auto .`
- `gitleaks detect --source . --no-git`
- `osv-scanner --recursive .`

Kalau agent harus menebak semua ini, dia bisa gagal atau jalankan hal yang tidak lengkap.

Dengan satu entrypoint, kita membuat definisi selesai jadi executable.

## What `verify.sh` sebenarnya adalah

- bukan tool khusus
- bukan requirement path yang wajib dinamai demikian
- bukan magic
- bukan pengganti `AGENTS.md`
- bukan sensor otomatis

Dia adalah: **single verification entrypoint**.

Artinya, tim menyediakan satu command stabil yang menyatukan semua check minimal.

`verify.sh` hanya bisa mendeteksi N+1 jika repo sudah menaruh sensor N+1 di dalamnya: munculnya `semgrep`, regression test query-count, atau checker lain.

Kalau isinya cuma:

```bash
pnpm lint
pnpm typecheck
pnpm test
```

maka `verify.sh` belum tentu bisa menangkap N+1.

Kalau repo ingin `verify.sh` menangkap data-layer smell seperti N+1, maka sensor itu harus ditambahkan terlebih dulu — dan `verify.sh` menjadi tombol untuk menjalankannya.

## Example

```bash
#!/usr/bin/env bash
set -euo pipefail

pnpm lint
pnpm typecheck
pnpm test
```

Untuk repo yang security-sensitive, bisa ditambah:

```bash
#!/usr/bin/env bash
set -euo pipefail

pnpm lint
pnpm typecheck
pnpm test

gitleaks detect --source . --no-git
osv-scanner --recursive .
semgrep --config auto .
```

## Why `.ai/commands/`?

Itu juga bukan keharusan. Di sini pilihannya cuma supaya jelas bahwa script ini bagian dari harness agent.

Bisa saja pathnya:
- `./scripts/verify.sh`
- `./bin/verify`
- `./tools/check.sh`
- `./ci/local-check.sh`
- `make verify`
- `just verify`
- `npm run verify`

Yang penting bukan pathnya. Yang penting ada satu entrypoint yang stabil.

## How to use it

Di `AGENTS.md`, cukup tulis:

```text
Before completion, run:

./.ai/commands/verify.sh
```

Setiap agent atau reviewer tahu persis apa yang harus dijalankan.

## What verify.sh can catch

Ada tiga level sensor N+1 yang bisa ditambahkan ke `verify.sh`:

1. Static check: Semgrep atau rule sederhana yang mencari query/repo call di dalam loop.
2. Query-count regression test: behavior test yang memverifikasi jumlah query tetap bounded untuk banyak data.
3. Runtime/integration check: observability/profiler-based assertion pada query count selama request berjalan.

`verify.sh` sendiri bukan network inspector. Dia hanya menjalankan sensor yang sudah ada.

Kalau belum ada sensor N+1, `verify.sh` tidak akan ajaib tahu ada N+1.

## Practical benefit

1. Konsistensi. Semua pihak menjalankan command yang sama.
2. Perubahan mudah. Tambah scan baru di script, agent nggak perlu tahu detailnya.
3. Kurangi prompt panjang. Cukup refer ke satu command.
4. Bukti klaim. Jika agent bilang "verified", dia bisa melaporkan hasil entrypoint yang dijalankan.

## Related
- [[notes.agentic-engineering.self-hosted-agent-runner]]
- [[notes.agentic-engineering.openclaw.personal-agent-orchestration]]
- [[notes.agentic-engineering.before-after-judgement-harness]]
