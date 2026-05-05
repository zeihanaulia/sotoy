---
id: notes.agentic-engineering.gitlab-mr-review-agent-coolify
title: "GitLab MR Review Agent di Coolify"
desc: "Desain self-hosted GitLab MR review agent di Coolify dengan webhook trigger comment, worker terisolasi, dan structured report."
updated: 1777998890459
created: 1777998890459
tags:
  - notes
  - agentic-engineering
  - gitlab
  - coolify
  - mr-review
---

## Overview

Use case gue adalah GitLab Merge Request review agent yang gue deploy di Coolify.

Yang gue mau bukan semua MR otomatis direview. Triggernya harus dari comment di MR, misalnya `/agent review security` atau `/agent review`.

Ini bukan agent coding bebas. Ini lebih pas disebut **MR review bot dengan worker agent di belakangnya**.

## Terminologi penting

- **Mention** = komentar di MR seperti `/agent review`. Di GitLab ini masuk kategori Comment event / Note event.
- **Post comment balik** = pakai Notes API atau Discussions API untuk balas comment di MR.
- **Coolify deployment** = deploy container via Dockerfile atau Docker Compose, dengan env vars, volumes, dan domain.

## Flow yang gue rekomendasikan

```text
GitLab MR comment
  "/agent review"
        ↓
GitLab Note Event Webhook
        ↓
Coolify app: webhook API
        ↓
Validate secret token + parse payload
        ↓
Check command mention
        ↓
Queue review job
        ↓
Worker clone repo + checkout MR source branch
        ↓
Fetch MR diff + existing discussions + project instructions
        ↓
Run agent review
        ↓
Generate structured review report
        ↓
Post comment to GitLab MR
```

Penting: **jangan jalankan agent langsung di HTTP request**. Webhook harus cepat balas `200 OK`, lalu kerja berat dijalankan di queue/worker.

## Arsitektur Coolify yang gue pakai

Gue pisahkan API dan worker.

Contoh konfigurasi Docker Compose minimal:

```yaml
services:
  api:
    build: .
    command: node dist/server.js
    ports:
      - "3000:3000"
    environment:
      - GITLAB_BASE_URL=${GITLAB_BASE_URL:?}
      - GITLAB_TOKEN=${GITLAB_TOKEN:?}
      - GITLAB_WEBHOOK_SECRET=${GITLAB_WEBHOOK_SECRET:?}
      - AGENT_PROVIDER=${AGENT_PROVIDER:-openai}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - REDIS_URL=redis://redis:6379
      - WORKSPACE_DIR=/workspaces
    volumes:
      - agent-workspaces:/workspaces
    depends_on:
      - redis

  worker:
    build: .
    command: node dist/worker.js
    environment:
      - GITLAB_BASE_URL=${GITLAB_BASE_URL:?}
      - GITLAB_TOKEN=${GITLAB_TOKEN:?}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - REDIS_URL=redis://redis:6379
      - WORKSPACE_DIR=/workspaces
    volumes:
      - agent-workspaces:/workspaces
    depends_on:
      - redis

  redis:
    image: redis:7-alpine
    volumes:
      - redis-data:/data

volumes:
  agent-workspaces:
  redis-data:
```

## GitLab setup yang gue sarankan

Di project GitLab:

- Settings → Webhooks
- URL: `https://agent-domain-elo.com/webhooks/gitlab`
- Event: Comments / Note events
- Secret token: random secret

Di app, validasi header `X-Gitlab-Token`.

## Trigger command

Gunakan command eksplisit, jangan cuma `@agent`.

Contoh:

```text
/agent review
/agent review security
/agent review performance
```

Rule trigger yang gue pake:

- event adalah `Note Hook`
- `noteable_type` adalah `MergeRequest`
- body dimulai dengan `/agent review`
- author bukan bot sendiri

## Permission dan token

Buat bot user dengan token scope minimal.

Untuk review-only, token cukup dengan:

- `read_repository`
- `api`

Jangan pakai token personal utama.

## Data yang worker butuh

Worker harus ambil:

- Project ID
- MR IID
- Source branch
- Target branch
- MR diff
- MR title/description
- Existing discussions jika perlu
- Repository instructions seperti `AGENTS.md` atau `.agent-review.md`

Endpoint GitLab yang relevan:

- `GET /projects/:id/merge_requests/:merge_request_iid`
- `GET /projects/:id/merge_requests/:merge_request_iid/diffs`
- `GET /projects/:id/merge_requests/:merge_request_iid/discussions`
- `POST /projects/:id/merge_requests/:merge_request_iid/notes`

## Comment vs discussion

Untuk MVP, gue pilih general comment dulu lewat Notes API.

Discussion API bagus untuk thread atau diff comment, tapi itu bikin implementasi awal lebih rumit.

## Contoh review output yang gue inginkan

Agent comment harus terstruktur, evidence-based, dan bukan opini dangkal.

Contoh:

```markdown
## Agent Code Review

### Summary

Found 2 issues.

### Findings

#### 1. Missing authorization check
Severity: High
File: `src/projects/project.controller.ts`
Evidence: `PATCH /projects/:id/settings` checks authentication but does not check ownership.
Suggested fix: call `requireProjectAdmin(user.id, project.id)` before update.
Confidence: High

#### 2. Possible N+1 query
Severity: Medium
File: `src/reports/billing.ts`
Evidence: repository call inside loop over customers.
Suggested fix: bulk fetch invoices by customer IDs.
Confidence: Medium

### Verification

- Static review: completed
- Tests run: not run
- Security scan: not run

### Human review needed

Yes. Authorization logic should be checked by project owner.
```

## Minimal implementation yang gue pikirkan

### `server.ts`

Menerima webhook, validasi token, parse payload, queue job.

### `worker.ts`

Ambil job, fetch MR info/diff/discussions, run review, post comment.

### `gitlab.ts`

Wrapper GitLab API untuk MR, diffs, discussions, notes.

## Clone repo atau diff-only review?

Untuk MVP, gue mulai dengan diff-only review dulu. Clone full repo bisa ditambahkan setelah komentar awal stabil.

Flow clone repo:

```text
1. Ambil MR metadata.
2. Clone repo ke workspace.
3. Checkout source branch.
4. Baca `AGENTS.md` / `.agent-review.md`.
5. Ambil diff.
6. Jalankan review.
7. Post comment.
8. Hapus workspace atau simpan untuk audit.
```

## Instruction file di repo

Contoh `.agent-review.md` yang gue taruh di repo:

```markdown
# Agent MR Review Instructions

Review priorities:
1. Security
2. Correctness
3. Data integrity
4. Performance risks
5. Maintainability

Do not comment on style unless it affects readability or correctness.

For each finding, include:
- severity
- file path
- evidence from diff
- why it matters
- suggested fix
- confidence
```

## Safety guardrail

Yang gue tanam di awal:

- validasi webhook secret
- allowlist project
- allowlist trigger users
- anti self-trigger
- idempotency `projectId:mrIid:noteId`
- concurrency limit
- timeout
- jangan auto-approve/merge

## Before-after workflow

Sebelum:

```text
Developer mention human senior.
Senior buka MR, baca diff, komentar manual.
```

Setelah MVP:

```text
Developer comment `/agent review security`.
Worker ambil MR diff.
Agent review.
Post comment.
Senior cek only high-risk findings.
```

## Roadmap

1. webhook + comment balik
2. diff-only LLM review
3. instructions file support
4. clone repo dan workspace
5. scanner integration
6. optional discussion thread

## Kesimpulan

Menurut gue, MVP ini feasible di Coolify.

Target pertama:

- api service
- worker service
- redis
- GitLab Note event trigger
- review-only comment response

Jangan mulai dari push/code-fix. Mulai dari review-only dulu.

## Related

- [[notes.agentic-engineering.cloud-agent.handson.gitlab-mr-comment-formatting]]
- [[notes.agentic-engineering.cloud-agent.handson.references]]
- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[zettel.moc.agentic-engineering]]
