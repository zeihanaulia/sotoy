---
name: "nextjs-template"
description: "Instructions for working on the Next.js frontend theme inside nextjs-template/"
applyTo: "nextjs-template/**"
---

# nextjs-template

The `nextjs-template/` directory is a **separate git repo** (branch `2026`) used as the static site frontend. It is symlinked to `.next/` at build/dev time by the `Makefile`.

## Key facts

- **Do not edit `nextjs-template/` as if it were part of the sotoy vault.** It is a standalone Next.js project.
- Changes to `nextjs-template/` must be committed and pushed to `github.com/zeihanaulia/nextjs-template` branch `2026`.
- The sotoy `publish.yml` workflow clones this repo at branch `2026` into `.next/` during CI.

## Routing (branch 2026)

| Page | Route |
|---|---|
| `pages/index.tsx` | `/` — root note (noteIndex) |
| `pages/[...slug].tsx` | `/:slug+` — all other notes by fname slug |
| `pages/refs/[id].tsx` | `/refs/:id` — note references |

## Local dev workflow

```bash
# from sotoy root
make dev      # dendron publish dev --dest .next (hot-reload)
make build    # production build
make install  # install deps in nextjs-template
```

## When modifying nextjs-template

1. `cd nextjs-template`
2. Make changes on branch `2026`
3. `git add` and `git commit` atomically
4. `git push origin 2026`

Full instructions in `nextjs-template/AGENT.md` and `nextjs-template/.github/copilot-instructions.md`.
