
Untuk coding agent, kualitas model hanya satu bagian dari persamaan.

Yang lebih krusial adalah:

- tool access: grep, read_file, replace_in_file, run_tests, git diff,
- state file: rebrand-plan.md atau agent-state.json,
- context pack: PROJECT_CONTEXT.md, REBRAND_RULES.md, NAMING_MAP.md, DO_NOT_TOUCH.md,
- budget rule: jangan scan repo berkali-kali; mulai dari inventory lalu kerjakan dari inventory itu.

Kalau workflow dan state management rapi, model kecil bisa jadi jauh lebih efektif daripada model besar tanpa structure.
