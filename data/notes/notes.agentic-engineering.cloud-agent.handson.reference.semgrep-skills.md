
## Why this reference matters

Semgrep/skills relevan karena fokus ke security guideline untuk LLM apps dan review code yang memanggil model.

## What it teaches

- keamanan LLM app sebagai domain review,
- rule-based review untuk masalah prompt injection, secret leakage, dan unsafe retrieval,
- hubungan antara agent review dan static scanner.

## What to copy for our design

- masukkan security checklist khusus LLM ke dalam review skill,
- gunakan rule file sebagai referensi, bukan hanya prompt saja,
- jadikan review layer-aware terhadap LLM-specific risk.

## Gap vs our design

Ini lebih ke skill/rules dan bukan bot integration. Tapi cocok untuk safety guardrails.

## Practical takeaway

Buat review skill khusus untuk agent safety dan LLM code review.
