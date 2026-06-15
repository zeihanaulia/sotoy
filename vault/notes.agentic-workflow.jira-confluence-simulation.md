---
id: notes.agentic-workflow.jira-confluence-simulation
title: "Agentic workflow simulation: Jira + Confluence state mapping"
description: "Simulasi agentic workflow dengan dua lapis state: backlog/ticket dan pipeline agent, menggunakan example Jira task + Confluence requirement."
tags:
  - agentic
  - workflow
  - jira
  - confluence
  - backlog
status: published
created: 1778557611112
updated: 1778604764488
---

Gue bikin simulasi ini supaya bisa melihat lebih jelas dua lapis state yang sering keblurr di agentic workflow: backlog/ticket dan pipeline agent.

## Konteks

Arti **states** di sini adalah dua lapis state:

1. **state backlog/ticket**: Epic → Task → To Do → In Progress → Done / On Hold
2. **state pipeline agent**: Intake → Canonicalize → Groom → Execute → Verify → Publish → Reconcile → Audit

Simulasi ini menunjukkan bahwa agent tidak langsung membaca task lalu ngoding. Agent lebih dulu mengubah niat manusia menjadi state yang bisa dikontrol: requirement jadi backlog item, backlog item jadi fix plan, fix plan jadi diff, diff jadi evidence, evidence jadi status Jira.

---

## Skenario

### Epic

```text
EPIC-100
Title: Improve Account Security
Goal: memperkuat keamanan akun user
```

### Task

```text
SEC-123
Title: Add rate limiting to login endpoint
Status: To Do
Description: See Confluence page: Account Security Hardening v2
```

### Confluence detail

```text
Confluence: Account Security Hardening v2

Requirement:
- Login endpoint harus punya rate limit 5 percobaan gagal per 10 menit per user/email.
- Jika limit tercapai, API mengembalikan HTTP 429.
- Event harus dicatat ke security log.
- Existing successful login flow tidak boleh berubah.

Acceptance Criteria:
1. Failed login attempt dihitung per email normalized.
2. Setelah 5 failed attempt dalam 10 menit, request berikutnya kena 429.
3. Counter reset setelah successful login.
4. Unit test mencakup normal login, failed login, lockout, dan reset.
5. Tidak boleh menyimpan password/token di log.
```

---

## State 0 — Epic sebagai konteks besar

Di awal, Epic hanya memberikan arah besar.

Agent belum boleh ngoding dari Epic langsung karena Epic terlalu luas dan ambigu.

### Tindakan agent

```text
Baca Epic
↓
Cari linked tasks
↓
Cari linked Confluence page
↓
Klasifikasikan sebagai security hardening work
```

### Output sementara

```text
Epic detected:
- Domain: account security
- Scope: login flow
- Linked task: SEC-123
- Source doc: Confluence Account Security Hardening v2
```

**Atomic idea**: Epic memberi arah, bukan instruksi eksekusi.

---

## State 1 — Intake: membaca task dan Confluence

Agent mengambil detail dari Jira dan Confluence, lalu mengekstrak requirement ke field standar.

### Tindakan agent

```text
SEC-123
↓
Confluence page
↓
Structured requirement extraction
```

### Hasil intake

```json
{
  "source": "confluence:Account Security Hardening v2",
  "jira_key": "SEC-123",
  "epic": "EPIC-100",
  "title": "Add rate limiting to login endpoint",
  "requirement": "Limit failed login attempts to 5 per 10 minutes per normalized email",
  "acceptance_criteria": [
    "Failed login attempt counted per normalized email",
    "6th failed attempt within 10 minutes returns HTTP 429",
    "Successful login resets failed-attempt counter",
    "Security event is logged without secrets",
    "Unit tests cover success, failure, lockout, reset"
  ],
  "tags": ["security", "auth", "rate-limit", "backend"],
  "owner": "backend",
  "priority": "high"
}
```

### Gate intake

Agent hanya boleh lanjut kalau:

- Ada Jira key
- Ada source reference
- Ada requirement jelas
- Ada acceptance criteria
- Ada owner
- Ada priority

Kalau Confluence kosong atau link mati, status masuk `On Hold / Needs Clarification`.

**Atomic idea**: agent baru boleh bekerja kalau requirement sudah bisa diuji.

---

## State 2 — Canonicalization: cek duplicate dan kecocokan

Agent mengecek apakah task ini benar-benar baru atau sudah ada item serupa.

### Tindakan agent

- bandingkan dengan canonical backlog
- hitung similarity
- tentukan tier confidence

### Simulasi

```text
SEC-123 vs SEC-089 = 0.61
SEC-123 vs SEC-101 = 0.55
SEC-123 vs existing exact key = 1.00
```

Confidence tinggi karena Jira key jelas dan detail cocok.

### Output

```json
{
  "canonical_id": "AUTO-SEC-LOGIN-RATE-LIMIT-001",
  "jira_key": "SEC-123",
  "confidence": 0.91,
  "decision": "eligible_for_autonomous_grooming",
  "related_items": ["SEC-089", "SEC-101"],
  "source_of_truth": "canonical_backlog"
}
```

**Atomic idea**: duplicate dan overlap harus dibereskan sebelum agent menulis kode.

---

## State 3 — Grooming: requirement jadi fix plan

Agent tidak langsung memperbaiki kode. Dia membuat rencana kerja yang actionable.

### Tindakan agent

- identifikasi file relevan
- buat fix_strategy
- buat verification_plan

### Contoh fix plan

```json
{
  "ticket": "SEC-123",
  "priority_score": 94,
  "priority_type": "security_hardening",
  "area": "backend/auth",
  "relevant_paths": [
    "backend/auth/login.py",
    "backend/auth/rate_limit.py",
    "backend/security/audit_log.py",
    "tests/auth/test_login.py"
  ],
  "fix_strategy": [
    "Add failed-login counter keyed by normalized email",
    "Enforce 5 failed attempts per 10 minutes",
    "Return HTTP 429 when threshold exceeded",
    "Reset counter after successful login",
    "Emit sanitized security log event",
    "Add unit tests for success, failure, lockout, reset"
  ],
  "verification_plan": [
    "Run auth unit tests",
    "Run security log test",
    "Run lint",
    "Check no password/token logged"
  ],
  "confidence": 0.88
}
```

Status Jira masih `To Do`.

**Atomic idea**: grooming menghasilkan rencana, bukan perubahan.

---

## State 4 — Claim Lock: agent mengambil ticket

Sebelum eksekusi, agent harus mengunci ticket secara eksternal.

### Tindakan agent

```text
SEC-123: To Do → In Progress
```

### Output

```json
{
  "ticket": "SEC-123",
  "transition": "To Do -> In Progress",
  "claim_owner": "lane4-worker-2",
  "run_id": "RUN-2026-05-12-001",
  "status": "claimed"
}
```

**Atomic idea**: ownership harus terlihat di Jira sebelum agent mengubah kode.

---

## State 5 — Execution: patch di isolated worktree

Agent membuat perubahan di ruang isolasi.

### Tindakan agent

- buat isolated worktree
- apply patch
- generate diff
- simpan evidence

### Contoh diff summary

```json
{
  "run_id": "RUN-2026-05-12-001",
  "ticket": "SEC-123",
  "diff_summary": {
    "files_changed": 4,
    "lines_added": 142,
    "lines_removed": 18
  },
  "risk_tier": "extended_verification",
  "reason": "diff between 50 and 200 lines"
}
```

**Atomic idea**: agent boleh mengubah kode, tapi hanya di ruang isolasi dan dengan evidence.

---

## State 6 — Verification: executor tidak boleh jadi auditor

Verifier terpisah menjalankan quality gate.

### Verifikasi yang dijalankan

- unit tests
- lint/static analysis
- security checks
- mutation/state checks

### Pass

```json
{
  "ticket": "SEC-123",
  "product_verifier": "pass",
  "security_verifier": "pass",
  "mutation_check": "pass",
  "result": "verified"
}
```

Jira: `In Progress → Done`

### Fail

```json
{
  "ticket": "SEC-123",
  "product_verifier": "fail",
  "failed_test": "test_successful_login_resets_failed_attempt_counter",
  "result": "requeue"
}
```

Jira: `In Progress → To Do`

**Atomic idea**: yang memutuskan selesai adalah verifier independen, bukan agent yang membuat patch.

---

## State 7 — Publication: hasil ditulis ke Jira

Jika verification pass atau fail, agent mem-publish hasil dengan konteks.

### Contoh komentar pass

```text
Automation result: VERIFIED

Run ID: RUN-2026-05-12-001
Source: Confluence Account Security Hardening v2
Epic: EPIC-100
Ticket: SEC-123

Changes:
- Added failed login rate limiting per normalized email.
- Added HTTP 429 response after threshold.
- Added reset on successful login.
- Added sanitized security logging.
- Added unit tests for success, failure, lockout, reset.

Verification:
- Auth unit tests: PASS
- Security log tests: PASS
- Lint/static analysis: PASS
- Secret logging check: PASS

Evidence:
- diff: evidence/RUN-2026-05-12-001/diff.patch
- test output: evidence/RUN-2026-05-12-001/tests.log
- verifier output: evidence/RUN-2026-05-12-001/verifier.json
```

### Contoh komentar fail

```text
Automation result: FAILED VERIFICATION

Run ID: RUN-2026-05-12-001
Ticket: SEC-123

Failure:
- test_successful_login_resets_failed_attempt_counter failed.

Action:
- Ticket returned to To Do for re-grooming.
- Patch worktree discarded.
- Evidence saved for review.
```

**Atomic idea**: Jira update harus menjelaskan keputusan, bukan sekadar mengubah status.

---

## State 8 — Reconciliation: canonical backlog diperbarui

Setelah Jira berubah, canonical backlog juga disinkronkan.

### Pass

```json
{
  "canonical_id": "AUTO-SEC-LOGIN-RATE-LIMIT-001",
  "jira_key": "SEC-123",
  "epic": "EPIC-100",
  "state": "done",
  "last_run_id": "RUN-2026-05-12-001",
  "source_doc": "Confluence Account Security Hardening v2",
  "verification": {
    "product": "pass",
    "security": "pass"
  },
  "completed_at": "2026-05-12T..."
}
```

### Fail

```json
{
  "canonical_id": "AUTO-SEC-LOGIN-RATE-LIMIT-001",
  "jira_key": "SEC-123",
  "state": "to_do",
  "last_run_id": "RUN-2026-05-12-001",
  "failure_reason": "reset counter test failed",
  "next_action": "regroom"
}
```

**Atomic idea**: state eksternal dan internal harus sinkron.

---

## State 9 — Audit Trail: evidence chain lengkap

Evidence folder per run menyimpan semua keputusan.

```text
evidence/
  RUN-2026-05-12-001/
    input.json
    source_refs.json
    confluence_snapshot.md
    jira_before.json
    fix_plan.json
    diff.patch
    test_output.log
    security_verifier.json
    jira_receipt.json
    final_status.json
```

### Jawaban audit

Jika ditanya, "Kenapa SEC-123 ditutup?" jawaban harus berbasis evidence chain, bukan klaim model.

**Atomic idea**: trust datang dari evidence chain, bukan dari klaim model.

---

## Batas autonomy yang realistis

Agent hanya boleh lanjut jika:

- requirement jelas
- acceptance criteria testable
- fix plan sudah dikenal
- diff size masih dalam batas
- verifier dapat membuktikan hasil
- tidak butuh keputusan arsitektural baru

Jika salah satu tidak terpenuhi, agent harus berhenti dan minta manusia:

- `On Hold` jika requirement tidak testable
- `Human review` jika arsitektural judgment diperlukan

---

## Ringkasan state lengkap

```text
[EPIC-100]
Improve Account Security
    ↓
[SEC-123 - To Do]
Task linked to Confluence requirement
    ↓
[S1 Intake]
Agent baca Jira + Confluence
Extract requirement + acceptance criteria
    ↓
[S2 Canonicalize]
Cek duplicate, mapping, confidence score
confidence 0.91
    ↓
[S3 Groom]
Buat fix_plan + relevant_paths + verification_plan
Masuk fix_queue
    ↓
[S4 Claim]
Jira: To Do → In Progress
Agent worker dapat lock
    ↓
[S5 Execute]
Agent apply patch di isolated worktree
Generate diff + evidence
    ↓
[S6 Verify]
Verifier terpisah jalan:
tests + lint + security + mutation check
    ↓
    ┌───────────────┬────────────────┐
    │ PASS          │ FAIL           │
    ↓               ↓
Jira: Done      Jira: To Do
Publish result  Publish failure
Reconcile       Re-groom next cycle
    ↓
[S7 Audit]
Evidence chain tersimpan
```

---

## Insight

Yang paling penting adalah transformasi ini:

```text
narasi requirement → acceptance criteria → fix plan → diff → verifier result → Jira transition → audit evidence
```

Kalau salah satu rantai putus, sistem harus berhenti atau minta manusia. Di situlah bedanya workflow agentic yang aman dengan agent coding yang cuma agresif.
