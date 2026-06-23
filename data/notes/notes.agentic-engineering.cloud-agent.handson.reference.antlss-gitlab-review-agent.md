
## Why this reference matters

Antlss/gitlab-review-agent dekat dengan use case kita karena bukan sekadar `.patch` reader. Mereka mencoba ambil konteks repo, history, dan conventions.

## What it teaches

- clone repo dan baca lebih banyak dari sekadar diff,
- track historical AI reviews sebagai data untuk rulebook,
- bisa menambahkan context-aware review rules.

## What to copy for our design

- builder loop: review lama jadi sumber aturan baru,
- konteks repo dan conventions harus jadi input review,
- review output bisa dikaitkan dengan repository best practices.

## Gap vs our design

Masih kurang di việc review sebagai teaching artifact; output mereka harus ditambahkan layer explainability yang mudah diperdebatkan.

## Practical takeaway

Pakai ide clone repo + historical conventions sebagai v2/v3, tapi jangan lupa pertahankan format pedagogis yang jelas.
