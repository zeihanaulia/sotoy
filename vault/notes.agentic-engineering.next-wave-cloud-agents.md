---
id: notes.agentic-engineering.next-wave-cloud-agents
title: 'Next Wave: Cloud Agents dan Autonomous Orchestration'
desc: >-
  Ringkasan pergeseran dari agent CLI lokal ke cloud agents paralel dengan
  orchestration dan harness sebagai safety system.
updated: 1777998274920
created: 1777998274920
tags:
  - notes
  - agentic-engineering
  - cloud-agents
  - harness
---

## Overview

Gue baca konsep "next wave" sebagai pergeseran dari agent CLI lokal/interaktif ke cloud agents plus autonomous orchestration. Faktor utamanya bukan model AI yang lebih pintar lagi, tapi kerja software diperlakukan sebagai sistem agentic yang bisa berjalan paralel, di cloud sandbox, dan divalidasi sebelum sampai ke manusia.

## Apa bedanya agent CLI dengan cloud agents?

Agent CLI itu biasanya hidup di terminal lokal lo. Elo yang buka session, agent membaca repo, mengedit file, lalu elo menunggu output atau error. Masih ada intensitas kehadiran manusia.

Cloud agent memindahkan kerja itu ke environment cloud terisolasi. Ia bisa jalan di background, bisa paralel, bikin PR sendiri, memanggil tool, menjalankan test, dan mengulang sampai memenuhi gate tertentu. Itu lebih dekat ke delegasi daripada interaksi.

Intinya: agent CLI adalah interaksi; cloud agent adalah delegasi.

## Kenapa cloud agents jadi gelombang berikutnya?

Karena bottlenecknya bergeser lagi.

- Fase awal: bisa AI bantu nulis kode atau tidak?
- Fase kedua: bisa AI kerja di repo nyata atau tidak?
- Fase ketiga: bisakah banyak agent bekerja aman, paralel, dan terverifikasi tanpa membanjiri manusia?

Cloud agents adalah gelombang berikutnya karena mereka bukan soal satu sesi chat/terminal, melainkan soal sistem terkoordinasi yang mengatur banyak agent, data, dan feedback loop.

## Bentuk autonomous orchestration yang realistis

Bentuk sederhana yang realistis:

1. Human membuat issue atau task.
2. Planner agent baca issue, repo, dokumen, AGENTS.md, skill files, lalu buat plan.
3. Implementer agent kerjakan plan, buat branch, edit kode, jalankan test.
4. Reviewer agent periksa correctness, maintainability, security, performa.
5. Validator agent jalankan lint, type check, browser automation, observability check.
6. Fixer agent perbaiki failure.
7. Human approver masuk hanya untuk judgement domain, security-sensitive change, database migration, atau arsitektur.

Ini bukan satu agent yang jawab prompt. Ini workflow dengan peran, input/output, gate, dan eskalasi.

## Kenapa cloud environment penting?

Semakin autonomous seorang agent, semakin penting sandbox yang reproducible.

Kalau agent masih jalan di laptop lo, environment biasanya implicit: package sudah terinstall, env var ada, service lokal hidup. Itu berbahaya kalau mau scale.

Cloud agent perlu:

- container atau VM template yang jelas,
- package dan dependency yang terdefinisi,
- network rule dan secret policy,
- mounted files dan permission yang terbatas.

Tanpa ini, agent bisa salah akses data, salah command, atau malah mengubah hal di luar scope.

## Hubungannya dengan harness engineering

Ini yang ngerjain safety system.

Cloud agents tanpa harness cuma jadi vibe coding at scale.

Harness adalah semua hal di sekitar model:

- tools,
- permissions,
- sandbox,
- context,
- skills,
- AGENTS.md,
- test,
- linter,
- observability,
- browser automation,
- feedback loop.

Tujuannya: buat output agent lebih mungkin benar sejak awal, dan sediakan sensor agar agent bisa self-correct sebelum hasilnya sampai manusia.

## Contoh implementasi secara bertahap

Supaya tidak chaos, jalanin ini secara bertahap:

- Level 1: single cloud task.
  - Satu issue kecil.
  - Agent bikin branch, perbaiki, jalankan verify command, buka PR.
- Level 2: agent PR reviewer.
  - Agent review PR dengan struktur: finding, evidence, risk, fix, confidence, human needed.
- Level 3: multi-agent loop.
  - Planner, implementer, reviewer, fixer, validator, reporter.
- Level 4: autonomous workflow with gates.
  - Agent bisa ambil task low-risk, bikin PR, validasi overlay, tapi merge hanya lewat gate.

Autonomy harus naik bertahap: task → review → loop → gated workflow.

## Implementasi untuk engineering/security review

Kalau lo bikin sistem security review agent, desain minimalnya:

- `AGENTS.md` menjelaskan stack, command test, command security scan, dan policy output.
- skill files untuk security triage, dependency review, SQL injection, secrets review, auth review, migration safety.
- sensors: Semgrep, OSV, gitleaks, npm audit, unit test, type check, SBOM, CI status.
- orchestrated workflow: planner, static scanner, reasoning agent, exploitability agent, fixer, triage agent, reporter.
- output harus evidence-backed: file/line, reachable path, impact, tool signal, verification, confidence.

Security agent yang bagus bukan yang paling banyak alert tapi yang paling cepat ubah alert jadi decision yang bisa ditindaklanjuti.

## Apa yang perlu disiapkan sebelum cloud orchestration?

1. Definition of done yang bisa dibaca agent.
   - goal, context, constraints, done when, escalate when.
2. `AGENTS.md` pendek, skill files detail, docs referensi panjang.
3. Environment reproducible: Dockerfile/devcontainer, setup script, test command, seed data, mock service, network policy, secret policy.
4. Permission ketat: approval mode, sandbox mode, token terbatas, default read-only.
5. Observability agent-readable: logs, metrics, traces, screenshot, DOM snapshot.

## Related

- [[notes.agentic-engineering.openclaw.personal-agent-orchestration]]
- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.cloud-agent.handson.references]]
- [[zettel.moc.agentic-engineering]]

## Insight penting

- Gelombang berikutnya bukan AI nulis kode lebih bagus. Ini soal agent bekerja paralel di cloud dengan gate dan verifikasi otomatis.
- Cloud agents boleh lebih cepat, tapi tanpa harness mereka cuma mempercepat PR yang bikin reviewer tenggelam.
- Indikator kesiapan: test dipercaya, CI jelas, permission model, AGENTS.md pendek, skill files, artifact report, eskalasi manusia.
- Kalau belum punya itu, cloud agents cuma mempercepat chaos.

## Referensi

- https://developers.openai.com/codex/cloud
- https://platform.claude.com/docs/en/managed-agents/overview
- https://martinfowler.com/articles/harness-engineering.html
- https://openai.com/index/harness-engineering/
- https://developers.openai.com/codex/learn/best-practices
