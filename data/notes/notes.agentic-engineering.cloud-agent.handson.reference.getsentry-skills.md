
## Why this reference matters

Getsentry/skills menunjukkan bagaimana tim nyata mengorganisir agent skills menjadi function-specific modules.

## What it teaches

- memecah skill jadi bug finding, security review, performance review, dan lainnya,
- skill bukan sekadar prompt, tapi bagian dari workflow tim,
- contoh nomenklatur dan packaging skill.

## What to copy for our design

- struktur modul skill berdasarkan domain review,
- gunakan skill-specific activation,
- buat skill library yang bisa dikombinasikan di harness.

## Gap vs our design

Ini tidak meng-cover GitLab comment bot, tetapi jadi basis bagus untuk skill orchestration.

## Practical takeaway

Atur review skill kita sebagai library yang bisa dipanggil oleh bot layer sesuai issue domain.
