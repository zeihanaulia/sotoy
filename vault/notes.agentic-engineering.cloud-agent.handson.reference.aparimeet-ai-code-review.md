---
id: notes.agentic-engineering.cloud-agent.handson.reference.aparimeet-ai-code-review
title: "Aparimeet AI Code Review"
desc: "Review arsitektur webhook dan worker untuk AI-driven GitLab/GitHub code review."
updated: 1777999929389
created: 1777999929389
tags:
  - notes
  - agentic-engineering
  - cloud-agent
  - handson
  - reference
  - gitlab
---

## Why this reference matters

Aparimeet/ai-code-review paling relevan untuk desain bot layer: service yang menerima webhook MR/PR, segera balas 200, terus proses review di background.

## What it teaches

- webhook receiver harus cepat dan stateless,
- job queue/worker adalah wajib untuk kerja berat,
- diff/context fetching bisa dipisahkan dari comment posting.

## What to copy for our design

- `webhook -> 200 OK -> background job` sebagai pola MVP,
- clean separation antara event ingestion dan review execution,
- fallback/resilience saat review gagal.

## Gap vs our design

Aparimeet fokus ke comment pipeline, tapi belum cukup memaksa output jadi pedagogis dengan before-after, proposed diff, dan counter-argument space.

## Practical takeaway

Gunakan ini sebagai blueprint arsitektur bot; tambahkan teaching format di atas pipeline yang mereka rekomendasikan.
