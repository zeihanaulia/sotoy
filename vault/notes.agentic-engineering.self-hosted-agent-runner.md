---
id: notes.agentic-engineering.self-hosted-agent-runner
title: "Self-Hosted Cloud Agent Runner"
desc: "Praktik membuat self-hosted agent runner di VM/container sendiri untuk coding task, workspace terisolasi, verification, dan PR/report flow."
updated: 1778003052300
created: 1777998859715
tags:
  - notes
  - agentic-engineering
  - cloud-agents
  - self-hosted
  - workflow
---

## Overview

Yang bakalan dibuat bukan OpenClaw lengkap. Yang realistis adalah agent worker di VM sendiri yang:

- menerima task dari GitHub issue/PR/manual command,
- checkout repo ke workspace terisolasi,
- jalankan coding agent CLI,
- jalankan verification command,
- buat branch + PR atau report,
- punya akses minimal.

## Perbedaan penting

- **Self-hosted agent runner**: agent coding berjalan di VM/container sendiri, task dijemput dari source, workspace terisolasi, verifikasi lokal.
- **Codex cloud resmi**: agent berjalan di environment OpenAI, job bisa background/paralel, repo tetap di cloud environment mereka.

Inti: kamu ingin versi sederhana sendiri di VM, bukan langsung platform agent total.

## Target praktis besok

Bukan cloud agent sempurna.
Targetnya:

```text
GitHub Issue / manual task
        ↓
VM agent runner
        ↓
clone repo ke workspace sementara
        ↓
agent CLI mengerjakan task
        ↓
verify.sh jalan
        ↓
branch + PR / report
```

Dan mulainya harus manual trigger dulu.

## Minimal architecture

Komponen paling kecil:

```text
VM
├── Docker
├── GitHub CLI
├── Node.js / pnpm / stack repo lo
├── Codex CLI atau Claude Code CLI
├── agent-runner.sh
├── workspaces/
│   └── task-<id>/
└── repo dengan:
    ├── AGENTS.md
    └── .ai/commands/verify.sh
```

Atomic idea: cloud agent bukan cuma model; dia butuh workspace, permission, verification, dan output channel.

## Langkah hands-on

### 1. Siapkan VM

Rekomendasi minimal:

- 2–4 vCPU
- 8–16 GB RAM
- 40–80 GB disk
- Docker
- Node.js LTS
- Git
- GitHub CLI

Install dasar:

```bash
sudo apt update
sudo apt install -y git curl jq ca-certificates build-essential
```

### 2. Buat user agent khusus

Jangan jalankan agent sebagai root.

```bash
sudo adduser agent
sudo usermod -aG docker agent
su - agent
mkdir -p ~/agent-runner/workspaces
mkdir -p ~/agent-runner/logs
```

Penting: blast radius kecil.

### 3. Install agent CLI

Pilih satu dulu:

- `npm i -g @openai/codex` untuk Codex CLI lokal,
- atau Claude Code CLI.

Jangan campur dulu. Fokus ke satu worker.

### 4. Siapkan repo dengan `AGENTS.md`

Contoh sederhana di root repo:

```markdown
# Agent Instructions

## Project commands

Install dependencies:
```bash
pnpm install --frozen-lockfile
```

Run verification:
```bash
./.ai/commands/verify.sh
```

## Rules

- Keep changes small.
- Do not modify public APIs unless the task explicitly asks for it.
- Do not add new runtime dependencies without justification.
- Do not perform database or repository calls inside loops over collections.
- Add or update tests for behavior changes.
- Before declaring the task complete, run `./.ai/commands/verify.sh`.
- Report commands run, test results, changed files, and remaining risks.
```

### 5. Buat `verify.sh`

Ini bukan nama tool standar yang wajib ada. Ini konvensi internal: satu executable entrypoint untuk semua verifikasi minimal.

Dengan `./.ai/commands/verify.sh`, agent nggak perlu menebak apakah repo harus menjalankan `npm test`, `pnpm test`, `pytest`, `cargo test`, `semgrep`, atau scanner lain. Dia tinggal menjalankan satu command yang tim setujui sebagai definition of done.

Buat file standar di repo:

```bash
mkdir -p .ai/commands
cat > .ai/commands/verify.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

pnpm lint
pnpm typecheck
pnpm test
EOF
chmod +x .ai/commands/verify.sh
```

Kalau project belum ready lint/typecheck/test, sesuaikan command dengan kondisi nyata.

Ini juga bukan keharusan bahwa pathnya harus `./.ai/commands/verify.sh`. Yang penting adalah satu stable verification entrypoint, misalnya `./scripts/verify.sh`, `make verify`, atau `npm run verify`.

### 6. Buat runner manual

Contoh script di VM:

```bash
cat > ~/agent-runner/run-task.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:?Usage: run-task.sh <repo-url> <branch-name> <task-file>}"
BRANCH_NAME="${2:?Usage: run-task.sh <repo-url> <branch-name> <task-file>}"
TASK_FILE="${3:?Usage: run-task.sh <repo-url> <branch-name> <task-file>}"

BASE_DIR="$HOME/agent-runner"
WORK_DIR="$BASE_DIR/workspaces/$BRANCH_NAME"

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"

git clone "$REPO_URL" "$WORK_DIR/repo"
cd "$WORK_DIR/repo"

git checkout -b "$BRANCH_NAME"

echo "=== TASK ==="
cat "$TASK_FILE"
echo "============"

codex "$(cat "$TASK_FILE")"

echo "=== VERIFY ==="
./.ai/commands/verify.sh

echo "=== GIT DIFF ==="
git status
git diff --stat

echo "Task finished. Review changes in:"
echo "$WORK_DIR/repo"
EOF
chmod +x ~/agent-runner/run-task.sh
```

Task file example:

```text
Fix the failing user service tests.

Constraints:
- Keep the change minimal.
- Do not change public APIs.
- Add a regression test if you find a bug.
- Run ./.ai/commands/verify.sh before finishing.

Done when:
- lint passes
- typecheck passes
- tests pass
- summary explains root cause and changed files
```

Run:

```bash
~/agent-runner/run-task.sh git@github.com:ORG/REPO.git agent/task-001 ~/agent-runner/task-001.txt
```

### 7. Tambahkan PR creation

Setelah manual flow stabil, tambah commit/push/PR creation.

```bash
git add .
git commit -m "Fix user service tests"
git push origin agent/task-001
gh pr create \
  --title "Fix user service tests" \
  --body "Agent-generated PR. Verification command passed on VM runner."
```

Di awal, PR creation bisa tetap manual.

### 8. Tambahkan Docker sandbox

Untuk safety, jalankan task di container bukan langsung di host.

Dockerfile minimal:

```Dockerfile
FROM node:22-bookworm
RUN apt-get update && apt-get install -y git curl jq build-essential ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
RUN npm i -g @openai/codex
CMD ["/bin/bash"]
```

Build dan run:

```bash
docker build -t coding-agent-runner .

docker run --rm -it \
  -v "$WORK_DIR/repo:/workspace/repo" \
  -v "$TASK_FILE:/workspace/task.txt:ro" \
  -w /workspace/repo \
  --network none \
  coding-agent-runner \
  bash -lc 'codex "$(cat /workspace/task.txt)" && ./.ai/commands/verify.sh'
```

Targetnya adalah permission explicit.

### 9. Opsional: versi Coolify

Kalau kamu ingin menjalankan runner ini sebagai service yang lebih mudah di-deploy dan dikelola, Coolify bisa jadi next step. Intinya, alih-alih memanggil `run-task.sh` di VM langsung, kamu bisa:

- buat repository deploy Coolify di VM atau VPS,
- bungkus `agent-runner.sh` dan workspace dengan Docker Compose atau Dockerfile,
- set environment untuk GitHub token dan optional model key,
- expose endpoint manual / webhook untuk trigger task,
- tetap jalankan task di container terisolasi, dengan `verify.sh` sebagai gate.

Contoh konsep:

```yaml
version: '3.8'
services:
  agent-runner:
    build: .
    volumes:
      - ./workspaces:/workspaces
      - ./repo:/repo
    environment:
      - GITHUB_TOKEN=${GITHUB_TOKEN}
      - AI_CLI_KEY=${AI_CLI_KEY}
    entrypoint: ["/bin/bash", "/usr/local/bin/agent-runner.sh"]
```

Secara ringkas, Coolify di sini bukan menggantikan ide self-hosted runner. Dia cuma mempermudah deployment dan lifecycle service while tetap menjaga workflow:

- trigger task manual atau via webhook,
- agent bekerja di container Coolify,
- `verify.sh` jalan di dalam container,
- hasil disimpan di workspace terisolasi,
- PR creation bisa tetap manual atau otomatis setelah verifikasi.

Kalau kamu sudah siap, bisa lanjut bikin satu `notes.agentic-engineering.cloud-agent.handson.coolify-agent-runner.md` untuk langkah deploy Coolify yang lebih spesifik.

### 10. Tambahkan agent report

Minta agent bikin summary akhir, bukan cuma diff.

Contoh format:

```markdown
# Agent Task Report

## Summary

## Files changed

## Verification

## Risks

## Human review needed

## Follow-up
```

### 10. Tambahkan security sensor

Kalau mau lebih serius, tambahkan scans ke `verify.sh`:

```bash
if command -v gitleaks >/dev/null 2>&1; then
  gitleaks detect --source . --no-git
fi

if command -v osv-scanner >/dev/null 2>&1; then
  osv-scanner --recursive .
fi
```

## Jalur belajar besok

1. Baca mental model Codex cloud dan Claude Code GitHub Actions.
2. Setup VM + install CLI + clone repo kecil.
3. Buat `AGENTS.md` dan `verify.sh`.
4. Buat `run-task.sh` dan jalankan task manual.
5. Review diff manual + PR.
6. Upgrade ke Docker sandbox / report template.

## Insight

Versi pertama self-hosted agent runner tidak perlu UI, OpenClaw-style orchestration, atau multi-agent planner.

Versi pertama cukup menjawab:

"Bisa nggak VM gue menerima satu task kecil, mengerjakannya di workspace terisolasi, menjalankan verification, lalu menghasilkan PR/report yang bisa gue review?"

Kalau iya: lanjut ke trigger GitHub, sandbox ketat, security scan, PR reviewer agent, dan orchestration.

## Related

- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.cloud-agent.handson.gitlab-mr-comment-formatting]]
- [[zettel.moc.agentic-engineering]]
