---
id: til.ai.semgrep.guardrails
title: "Semgrep sebagai guardrail agentic engineering"
desc: "TIL bahwa Semgrep bisa mengubah komentar review senior menjadi static rule yang dijalankan di verify.sh." 
updated: 1778003043867
created: 1778003043867
tags:
  - til
  - ai
  - semgrep
  - guardrail
  - verification
---

Semgrep bukan cuma SAST scanner. Dia bisa dipakai sebagai jembatan antara judgement senior dan automated guardrail.

Kalau review senior terus-terusan menulis "jangan panggil repository di dalam loop" atau "ini rawan N+1", sebagian pola itu bisa ditulis sebagai rule Semgrep. Rule itu bisa dijalankan di CI atau `verify.sh`, sehingga agent dan developer dapat feedback sebelum human review.

Penting:
- `verify.sh` bukan sensor otomatis; dia hanya tombol yang menjalankan sensor.
- Jika `verify.sh` cuma berisi lint/typecheck/test, N+1 masih bisa lolos.
- `verify.sh` baru bisa menangkap N+1 kalau ada sensor N+1 di dalamnya, misalnya Semgrep rule, query-count regression test, atau runtime query profiler.

Tiga level N+1 detection lewat `verify.sh`:
1. Static Semgrep pattern untuk `repository call di dalam loop` sebagai alarm awal.
2. Query-count regression test yang memverifikasi actual query behavior dengan data banyak.
3. Runtime/integration observation yang menghitung query di request path.

Semgrep docs yang relevant:
- Introduction: Semgrep bisa scan source tanpa eksekusi, jadi cocok sebagai sensor di verify.sh.
- Rule pattern syntax: `pattern-inside`, `pattern-either`, `metavariables` untuk custom rules.
- Rule structure syntax: YAML rule fields dan bagaimana Semgrep mengevaluasi pattern.
- Write rules overview: panduan kalau mau bikin rule dari nol.
- AI skills article: skill yang bisa diuji harus terhubung ke rule/semgrep, bukan sekadar prompt abstrak.

Referensi:
- https://semgrep.dev/docs/introduction
- https://semgrep.dev/docs/writing-rules/pattern-syntax
- https://semgrep.dev/docs/writing-rules/rule-syntax
- https://semgrep.dev/docs/writing-rules/overview
- https://semgrep.dev/blog/2026/security-skills-ai-agents
- https://github.com/semgrep/semgrep
