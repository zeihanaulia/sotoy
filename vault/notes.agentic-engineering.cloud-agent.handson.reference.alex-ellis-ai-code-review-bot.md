---
id: notes.agentic-engineering.cloud-agent.handson.reference.alex-ellis-ai-code-review-bot
title: "Alex Ellis AI Code Review Bot"
desc: "Review safety architecture untuk webhook-based code review, HMAC, sandboxing, dan prompt injection."
updated: 1778003052323
created: 1777999959891
tags:
  - notes
  - agentic-engineering
  - cloud-agent
  - handson
  - reference
  - security
---

## Why this reference matters

Alex Ellis menjelaskan safety architecture untuk bot review yang menjalankan kode dari PR dan MR, termasuk bahaya prompt injection.

## What it teaches

- validasi webhook HMAC / secret token,
- short-lived token dan sandbox execution,
- jangan percayai PR/MR description sebagai instruksi.

## What to copy for our design

- treat MR content as untrusted input,
- jangan biarkan review agent membaca PR description sebagai prompt override,
- harden webhook endpoint dan service boundary.

## Gap vs our design

Ini lebih fokus ke safety daripada pedagogi, tapi safety adalah layer non-negotiable sebelum kita publish bot.

## Practical takeaway

Prioritaskan web security dan prompt hygiene di MVP, sebelum menambahkan teaching output.
