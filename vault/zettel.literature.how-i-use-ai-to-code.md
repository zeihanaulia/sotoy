---
id: zettel.literature.how-i-use-ai-to-code
title: How I Use AI to Code — literature note
desc: >-
  Literature note untuk artikel Chris Parsons tentang AI coding yang didukung
  oleh harness, verification, dan agentic workflow.
updated: 1780426712062
created: 1778000402026
tags:
  - zettel
  - literature
  - agentic-engineering
  - ai-coding
  - harness
---

## Summary

Artikel Chris Parsons menjelaskan bahwa kekuatan AI coding bukan berasal dari kecerdasan model saja, tapi dari sistem verifikasi dan harness di sekitarnya. Agent CLI memegang peran utama karena bisa membaca repo penuh, menjalankan command, mengulang loop perbaikan, dan menjaga konteks lebih baik daripada bantuan editor tradisional.

## Core claims

- AI coding berhasil karena loop verifikasi objektif, bukan karena model memahami software.
- Harness adalah rangka kerja utama; prompt hanya bagian kecil dari sistem.
- Senior engineer terbaik memindahkan judgement ke harness, bukan sekadar review diff.
- Instruksi permanen seperti `AGENTS.md` / `CLAUDE.md` dan skill files menjaga konsistensi agent.
- Bottleneck sekarang adalah verification speed, bukan code speed.
- Spesifikasi problem-first lebih kuat daripada spesifikasi solusi detail.
- Agentic engineering berbeda dari vibe coding: output AI perlu disiplin engineering dan verifikasi, bukan sekadar kelihatan berhasil.

## Quotes

- “If you are still tied to your IDE, whether Cursor or Copilot, you are working a year behind. Coding turned out to be AI’s home territory.”
- “Verified used to mean ‘read by you’. With modern agent throughput, it has to mean ‘checked by tests, by type checkers, by automated gates, or by you where your judgement matters’.”
- “The reason is the harness, not the model.”
- “When an agent gets stuck on something that should be trivial, treat it as a context failure, not a prompt failure.”
- “Specify the problem, not the solution.”
- “Output quality is a curve against context. Too little, and you get generic slop. Too much, and the model drowns in what it has been fed and the output gets vaguer and more confident at the same time.”

## Source

https://www.chrismdp.com/coding-with-ai/

## Related

- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.gitlab-mr-review-agent-coolify]]
- [[notes.agentic-engineering.cloud-agent.handson.gitlab-mr-comment-formatting]]
- [[notes.agentic-engineering.openclaw.personal-agent-orchestration]]
- [[notes.agentic-engineering.next-wave-cloud-agents]]
- [[notes.agentic-engineering.senior-judgement-to-harness]]
- [[notes.agentic-engineering.before-after-judgement-harness]]
- [[zettel.moc.agentic-engineering]]
- [[zettel.1778000377281]]
- [[zettel.1778000377282]]
- [[zettel.1778000377283]]
- [[zettel.1778000377284]]
- [[zettel.1778000377285]]
- [[zettel.1778000377286]]
- [[zettel.1778000377287]]
- [[zettel.1778000377288]]
- [[zettel.1778000377289]]
- [[zettel.1778000377290]]
- [[zettel.1778000377291]]
- [[zettel.1778001021442]]
- [[zettel.1778000377292]]
