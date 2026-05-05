---
id: notes.agentic-engineering.cloud-agent.handson.reference.anthropic-claude-code-review-plugin
title: "Anthropic Claude Code Review Plugin"
desc: "Review arsitektur multi-agent, confidence scoring, dan explicit guideline verification untuk code review."
updated: 1777999929389
created: 1777999929389
tags:
  - notes
  - agentic-engineering
  - cloud-agent
  - handson
  - reference
  - review
---

## Why this reference matters

Anthropic Claude Code review plugin menunjukkan orchestration review multi-perspektif dengan confidence scoring dan guideline validation.

## What it teaches

- multiple reviewer agents untuk security, correctness, dan history,
- confidence threshold untuk memfilter false positive,
- explicit `CLAUDE.md` or guideline file sebagai source of truth.

## What to copy for our design

- pakai beberapa skill reviewer bersama,
- desak hasil review jadi explicit findings + score,
- sync recurring patterns ke rulebook atau instruction file.

## Gap vs our design

Mereka fokus pada audit orchestration; kita butuh menambahkan output pedagogis yang lebih kuat untuk developer learning.

## Practical takeaway

Jadikan ini kerangka v3: selain satu reviewer bot, jalankan beberapa agent paralel lalu dedupe findings.
