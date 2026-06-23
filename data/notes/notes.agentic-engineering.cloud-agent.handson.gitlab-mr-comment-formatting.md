
## Overview

Ini lanjutan praktis dari [[notes.agentic-engineering.gitlab-mr-review-agent-coolify.md]].
Fokusnya ke format MR comment yang bisa langsung diimplementasikan oleh review bot di cloud.

Tujuannya: buat format yang bisa dipakai sebagai basis agent MR comment otomatis, tapi tetap mendukung review pedagogis dan traceability.

## Konteks desain

Konteks yang gue pakai di sini bukan cuma implementasi MR comment.
Gue bedain tiga layer:

- **AI code review bot**: service yang menerima webhook MR mention/comment, baca diff/context, lalu post komentar review ke GitLab.
- **Code review skill**: paket instruksi atau checklist untuk agent, belum tentu punya webhook atau GitLab integrasi.
- **Review harness**: gabungan bot + skill + scanner + rule + CI + feedback loop. Ini yang bikin review jadi proses yang terus belajar.

Desain elo yang menarik adalah menggabungkan layer bot dan teaching skill: review bukan cuma menemukan issue, tapi juga ngajarin reviewer/dev lewat before-after, proposed diff, rationale, dan counter-argument space.

Lihat juga daftar referensi dan review satu-per-satu di [[notes.agentic-engineering.cloud-agent.handson.references]].
Lihat juga peta konten di [[zettel.moc.agentic-engineering]].

## Prinsip yang gue pakai

Gue bedakan dua fungsi review:

- **Review note** = catatan arsip lengkap.
- **MR comment** = komentar MR yang punya dua layer: ringkas untuk keputusan, panjang untuk pembelajaran.

Jadi panjang tidak masalah, selama struktur informasinya jelas dan bisa di-scan.

## Langkah hands-on

### 1. Standarisasi status review

Di review note, gunakan status operasional:

```text
approved
approved_with_notes
changes_requested
blocked
failed
```

Buat setiap status punya arti jelas:

- `approved` — review selesai dan tidak ada concern blocking; kode dianggap siap lanjut ke merge setelah verifikasi standar.
- `approved_with_notes` — tidak ada issue blocking, tapi reviewer memberi catatan minor atau improvement yang sebaiknya ditindaklanjuti sebelum merge.
- `changes_requested` — ada satu atau lebih issue yang harus diperbaiki sebelum merge; bisa berupa bug, logika, keamanan, atau kualitas yang relevan.
- `blocked` — ada issue kritis yang tidak boleh diabaikan, seperti keamanan bypass, data corruption, atau arsitektur yang harus diganti.
- `failed` — review gagal dilakukan atau hasil review tidak valid; biasanya karena agent timeout, data kurang, atau review mode tidak mendukung.

Ini langsung bisa dipakai oleh bot untuk keputusan merge.

Buat ini wajib di frontmatter setiap file review.

### 2. Pakai struktur heading konsisten

Untuk review note, selalu pakai pola:

```markdown
# Code Review: <branch>

## Decision

## Ready to merge?

## Summary

## Scope

## Changed files

## Blocking findings

## Non-blocking findings

## Strengths

## Verification

## Human review needed

## Recommendation

## Appendix
```

Kalau review note semua seragam, agent bisa parse field dengan lebih mudah.

### 3. Bedakan MR comment dan archive note

Untuk MR comment, gunakan dua layer dalam satu output:

- **Decision layer**: ringkas, answer key questions, cepat discan.
- **Learning layer**: detail, before-after, rationale, counter-argument space.

Contoh struktur MR comment:

```markdown
## Agent Code Review

**Decision:** changes_requested  
**Ready to merge?** no  
**Blocking findings:** 2  
**Non-blocking notes:** 1  
**Review mode:** diff + context  
**Confidence:** medium

### Quick summary

Branch ini mendekati target, tapi ada dua issue blocking:
1. Missing authorization check pada project settings update.
2. Potensi N+1 query pada billing report.

---

## Detailed findings

### Finding 1 — Missing authorization check

...detail...
```

### 4. Terapkan depth berdasarkan severity

Aturan depth yang gue pakai:

- **Blocking/high-risk**: before, after, diff direction, rationale, verification, counter-argument space.
- **Medium**: problem, evidence, suggested fix, rationale pendek.
- **Minor**: ringkas, satu-dua kalimat.

Jadi agent tidak memperlakukan typo kecil sama dengan authorization bypass.

### 5. Pakai schema internal dulu

Sebelum render Markdown, agent harus bikin data terstruktur.

Contoh schema:

```json
{
  "decision": "changes_requested",
  "scope": ["security", "correctness", "maintainability"],
  "confidence": "medium",
  "review_mode": "diff_only",
  "summary": "...",
  "findings": [
    {
      "title": "Missing authorization check",
      "severity": "high",
      "blocking": true,
      "file": "packages/app/src/...",
      "evidence": "...",
      "risk": "...",
      "suggested_fix": "...",
      "confidence": "high"
    }
  ],
  "verification": {
    "tests_run": false,
    "static_scan_run": false
  },
  "ready_to_merge": "no"
}
```

Dengan schema ini, lo bisa:

- sort severity,
- deduplicate findings,
- filter noise,
- generate MR comment,
- generate full report,
- track metrics,
- fail kalau output nggak sesuai schema.

Tambahkan `ready_to_merge` di schema dengan nilai:
- `no`
- `yes`
- `yes_with_fixes`

### 6. Update review notes menjadi learning artifacts

Di file `reviews/*.md`, tambahkan bagian yang jelas:

- Problem statement
- Evidence
- Proposed fix
- Before/After
- Rationale
- Verification suggestion
- Counter-argument space

Ini bikin note berfungsi sebagai pedagogical artifact sekaligus audit log.

## Contoh format review note yang cocok

Gunakan struktur seperti ini:

```markdown
---
status: changes_requested
review_mode: diff_plus_context
reviewer: agent
mr: !123
branch: feat-jira-oauth
---

# Code Review: feat-jira-oauth

## Decision
changes_requested

## Summary

Branch menambahkan ...

## Scope
security, correctness, maintainability

## Changed files

- `packages/jira/src/auth.ts`
- `packages/jira/src/api.ts`

## Blocking findings

### 1. Missing authorization check

...full learning block...

## Non-blocking findings

### 1. Naming mismatch in config loader

...short note...

## Strengths

- Good test coverage for happy path.
- Clear logging for auth errors.

## Verification

- diff-only review
- no tests run
- no scanner run

## Human review needed

Yes

## Recommendation

Do not merge until authorization issue fixed.

## Appendix

...additional notes...
```

## Kenapa ini cocok untuk hands-on?

Ini bukan soal memperpendek review semata.

Ini soal membuat output agent jadi:

- bisa dieksekusi oleh mesin,
- bisa dibaca cepat oleh reviewer,
- tetap menyimpan penjelasan pedagis untuk dev,
- bisa dikonversi jadi skill/AGENTS.md di harness.

## Yang harus dilakukan sekarang

1. Standarisasi frontmatter status di semua review file.
2. Terapkan struktur heading yang seragam.
3. Definisikan schema internal untuk agent.
4. Pisahkan output singkat untuk MR comment dan output panjang untuk archive.
5. Tambahkan `review_mode` dan `human review needed`.
6. Gunakan severity-based depth untuk detail.

## Insight

Panjang bukan masalah jika ia membawa reasoning.

Review yang baik tidak hanya memberi verdict, tetapi membuat klaimnya bisa diuji: di mana masalahnya, seperti apa before-after-nya, kenapa solusi itu masuk akal, dan kapan temuan itu bisa dibantah.

Disiplin utamanya bukan memendekkan review, tetapi membuatnya terstruktur, berbasis evidence, dan actionable.

## Referensi yang paling relevan

Konteks elo paling cocok dengan kombinasi referensi berikut:

- `aparimeet/ai-code-review`: arsitektur webhook + async worker + fetch diff + post comment. Ini model MVP untuk bot GitLab.
- `antlss/gitlab-review-agent`: lebih lengkap soal clone repo, context-aware review, historical conventions, dan feedback loop yang jadi repository best practices.
- `KrotovM/gitlab-ai-mr-reviewer`: contoh CI-triggered reviewer. Kalau belum mau webhook atau mau model post Markdown ke MR, ini referensi praktis.
- `anthropics/claude-code/plugins/code-review`: model multi-agent, confidence scoring, explicit guideline verification, dan update instructions dari pola review berulang.
- `Alex Ellis` article tentang GitHub review bot: safety architecture, HMAC/webhook validation, sandboxing, prompt injection dari PR description.
- `getsentry/skills`, `awesome-skills/code-review-skill`, `semgrep/skills`, `gohypergiant/agent-skills`, `microsoft/skills code-review.prompt.md`: semua ini bagus untuk struktur skill modular dan rule-based review.

### Apa yang belum banyak ada di referensi lain

Banyak implementasi berhenti di “AI nemu issue”. Yang elo mau adalah teaching layer:

- `finding`
- `evidence`
- `before`
- `after`
- `proposed diff`
- `rationale`
- `verification`
- `counter-argument space`

Itu bisa jadi diferensiasi desain elo.

### Saran baca bertahap

1. `aparimeet/ai-code-review` untuk arsitektur webhook + worker.
2. `antlss/gitlab-review-agent` untuk review harness dan context-aware MR review.
3. `Alex Ellis` untuk safety dan prompt injection.
4. `Anthropic code-review plugin` untuk multi-agent + confidence scoring.
5. `getsentry/skills` dan `semgrep/skills` untuk skill modular.
