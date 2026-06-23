
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
