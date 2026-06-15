---
id: notes.agentic-engineering.cloud-agent.handson.reference.krotovm-gitlab-ai-mr-reviewer
title: "KrotovM GitLab AI MR Reviewer"
desc: "Review pendekatan CI-triggered GitLab MR reviewer yang menghasilkan Markdown comment dari OpenAI."
updated: 1778003052445
created: 1777999959813
tags:
  - notes
  - agentic-engineering
  - cloud-agent
  - handson
  - reference
  - gitlab
---

## Why this reference matters

KrotovM/gitlab-ai-mr-reviewer memberikan model sederhana untuk review yang dijalankan dari CI, cocok sebagai alternatif ketika webhook belum siap.

## What it teaches

- bagaimana post Markdown review ke GitLab MR dari pipeline,
- arsitektur minimal untuk review otomatis di CI,
- trade-off antara event-driven dan CI-triggered.

## What to copy for our design

- format komentar Markdown yang jelas,
- cara integrasi dengan GitLab API untuk posting review,
- fallback strategy ketika webhook tidak tersedia.

## Gap vs our design

Because kita mau mention-based bot, CI-triggered flow ini lebih sebagai referensi alternatif, bukan model utama.

## Practical takeaway

Gunakan sebagai inspirasi kalau mau build MVP cepat: bisa mulai dengan pipeline review sementara webhook bot dibangun.
