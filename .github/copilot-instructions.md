# Sotoy repository Copilot instructions

## Purpose

This repository is a Dendron-based personal knowledge base published as a static site under the `sotoy` project.

Use this file to guide Copilot/AI when creating or improving notes so the output matches Dendron conventions for this workspace.

## What belongs where

- `vault/`: public notes, tutorials, book summaries, technical reference, and knowledge content.
- `vault2/`: private journal entries, experiment notes, and sync-only personal content.
- `docs/`: generated site output. Do not edit directly.
- `nextjs-template/`: theme and static site frontend sources.
- `seeds/dendron.templates/`: note templates.

## Generate notes with these steps

1. Determine the note target vault.
   - `vault/` for public documentation and knowledge notes.
   - `vault2/` for private journals and personal reflections.
2. Choose a hierarchical Dendron name.
   - Prefer `book-summaries.*`, `handbook.*`, `notes.*`, or `today-i-learned.*`.
   - Use dot notation for hierarchy and kebab-case for note names.
3. Add frontmatter.
   - Always include a frontmatter block at the top of new notes.
   - Include `title`, `description`, and optionally `tags`, `aliases`, and `status`.
4. Make content structured and clear.
   - Use headings, bullets, and examples.
   - Keep sections short and actionable.
5. Add internal Dendron links when relevant.
   - Use `[[wiki-links]]` to connect related notes.

## Frontmatter best practices

Use this pattern:

```yaml
---
id: "book-summaries.ci-cd-pipelines"
title: "CI/CD pipelines"
description: "Short summary of the note content"
tags:
  - dendron
  - ci
  - cd
aliases:
  - "CI/CD workflow"
---
```

Recommended fields:
- `id`: unique note identifier; typically a stable string that matches the note path or logical note name
- `title`: human-readable note title
- `description`: one-sentence summary
- `tags`: relevant categories or topics
- `aliases`: alternate lookups or synonyms

Optional fields when needed:
- `status`: `draft`, `work-in-progress`, or `published`
- `source`: external reference URL
- `author`: contributor or guest author

## Note structure guidelines

- Use `#` only for the top-level title when needed.
- Use `##` for main sections.
- Use `###` for subsections.
- Prefer bullets for steps and lists.
- Use code blocks for commands and examples.

Recommended narrative flow:
- short introduction
- why it matters
- how to use it
- examples or commands
- summary or practical takeaway

## Naming conventions for this repo

- `book-summaries.*` for book summaries.
- `handbook.*` for reference or process guides.
- `notes.*` for general technical notes.
- `today-i-learned.*` for short daily learnings.
- `daily.journal.{year}.{month}.{day}` for private journal entries in `vault2/`.

## AI output expectations

When asked to generate documentation:
- be direct and actionable
- use headings and bullet lists
- align with Dendron note conventions
- make the result easy to paste into a `.md` note

If asked for a draft:
- include suggested frontmatter
- include an outline

If asked for a finished note:
- produce ready-to-paste markdown with frontmatter, headings, lists, and code/examples

## Follow-up questions

Ask the user for clarification if they do not specify:
- public vs private note
- target vault (`vault/` or `vault2/`)
- note type (summary, handbook, journal, how-to)

## nextjs-template (frontend theme)

The `nextjs-template/` directory is a **separate git repo** (branch `2026`) that provides the static site frontend. It is symlinked to `.next/` at build time.

- Do not treat `nextjs-template/` as note content — it is a Next.js project.
- Changes there must be committed and pushed to `github.com/zeihanaulia/nextjs-template` on branch `2026`.
- See `nextjs-template/AGENT.md` for full dev instructions.
- See `.github/instructions/nextjs-template.instructions.md` for Copilot context.

### Routing in branch 2026

- `pages/index.tsx` → `/` (root note)
- `pages/[...slug].tsx` → all other notes (slug = `note.fname.split(".")`)
- Never use `[[...slug]].tsx` — it conflicts with `index.tsx`

## Important repository reminders

- Treat `docs/` as generated output, not source content.
- Prefer `vault/` for public documentation and `vault2/` for private notes.
- Use Dendron templates when available.
- Keep notes atomic, well-named, and linked.
- `nextjs-template/` is a separate git repo — commit and push it independently.
