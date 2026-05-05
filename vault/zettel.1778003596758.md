---
id: zettel.1778003596758
title: "Review comments should be encoded as guardrails, not left in PR threads"
desc: "Review warnings that recur are institution-level knowledge and should become automated guardrails." 
updated: 1778003596758
created: 1778003596758
tags:
  - zettel
  - guardrail
  - review
  - agentic-engineering
---

Review comments seperti "jangan query DB di loop" atau "ini rawan N+1" bukan hanya feedback untuk satu PR. Itu judgement operasional yang harus dipindahkan ke workflow sebagai guardrail, bukan disimpan di thread review.

Jika peringatan yang sama terus muncul, senior engineer paling bernilai ketika dia tidak lagi mengulanginya di review. Yang lebih penting adalah membuat rule atau sensor yang mencegah kelas kesalahan itu, misalnya:

- Semgrep rule untuk pola query di loop
- regression test query count
- runtime profiler / request path observability
- stable `./.ai/commands/verify.sh` yang menjalankan semua sensor tersebut

Dengan begini, knowledge jadi reusable dan review manusia bisa fokus ke judgement domain/arsitektur, bukan koreksi kesalahan operasional yang berulang.

Related:
- [[notes.agentic-engineering.before-after-judgement-harness]]
- [[notes.agentic-engineering.self-hosted-agent-runner]]
- [[til.ai.semgrep.guardrails]]
- [[zettel.20260506180000]]
