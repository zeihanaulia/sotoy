# Project Description

This is a personal knowledge base (PKM) built with Dendron, a hierarchical note-taking tool for developers. The workspace contains book summaries, technical notes, daily journals, and learning documentation organized in a structured, interconnected way.

## Tech Stack

- **Dendron**: Core note-taking system with hierarchical structure
- **Markdown**: All notes are written in Markdown format
- **Git**: Version control for tracking changes
- **Next.js**: Static site generation for publishing notes (in `docs/` folder)
- **Seeds**: Template system from `dendron.templates` for consistent note structures

## Project Structure

- `vault/` - Public notes (book summaries, handbook, technical notes, TIL)
- `vault2/` - Private notes (daily journals, personal reflections)
- `seeds/dendron.templates/` - Template vault containing reusable note templates
- `docs/` - Generated static site (Next.js) for publishing notes
- `assets/` - Images, diagrams, and other static assets
- `.github/` - GitHub configuration and workflows

## Project Guidelines

- All notes follow Dendron naming convention: hierarchical with dot notation (e.g., `book-summaries.the-devops-handbook.md`)
- Use kebab-case for note names
- Journal notes follow `daily.journal.{year}.{month}.{day}` format (e.g., `daily.journal.2025.12.12`)
- Templates should be applied consistently when creating new notes
- Keep notes atomic and well-linked using Dendron's wiki links
- Maintain proper frontmatter metadata (title, desc, updated, created)

## Naming Conventions

### Journal Notes
Based on `dendron.yml` configuration:
```yaml
journal:
  dailyDomain: daily
  name: journal
  dateFormat: y.MM.dd
  addBehavior: childOfDomain
```

**Format**: `daily.journal.{year}.{month}.{day}`
**Examples**: 
- `daily.journal.2025.12.12`
- `daily.journal.2025.01.15`

### Other Notes
- Book summaries: `book-summaries.{book-title}.md`
- Handbook: `handbook.{topic}.{subtopic}.md`
- TIL: `til.{category}.{topic}.md`
- Notes: `notes.{category}.{topic}.md`

## Resources

### Templates Available (from dendron.templates seed)
- `templates.journal.daily.5mj` - Five Minute Journal template
- `templates.daily` - Daily journal template
- `templates.module` - Module/package documentation template
- `templates.project` - Project planning template
- `templates.contacts` - Contact management template
- `templates.task-list` - Task list template

### Key Commands
- `Ctrl+L` (Lookup Note) - Search/create notes
- `Ctrl+Shift+P` - Command Palette
- `Dendron: Create Daily Journal Note` - Auto-create today's journal
- `Dendron: Apply Template` - Apply template to current note
- `Dendron: Reload Index` - Refresh vault index

### Schemas
Schemas define hierarchies and can auto-apply templates:
- `daily.schema.yml` - Daily journal structure
- `module.schema.yml` - Module documentation structure
- `proj.schema.yml` - Project structure

---

## Workflow Instructions

### Creating a Daily Journal with Five Minute Journal Template
**applyTo**: `vault2/daily.journal.*.md`

1. Create note with proper naming:
   - Press `Ctrl+L` (Lookup Note)
   - Type: `daily.journal.YYYY.MM.DD` (replace with actual date)
   - Press Enter to create empty note

2. Apply Five Minute Journal template:
   - In the new note, press `Ctrl+Shift+P`
   - Search and select: `Dendron: Apply Template`
   - Choose: `templates.journal.daily.5mj`
   - Template structure will be copied to your note

3. Fill in journal sections:
   - **Morning**: Gratitude, goals for the day
   - **Evening**: Achievements, improvements

### Creating Technical Notes
**applyTo**: `vault/**/*.md`

- Use descriptive hierarchical names (e.g., `notes.microservice.security.access-control.md`)
- Apply relevant templates when available
- Link related notes using `[[wiki-links]]`
- Add proper tags and frontmatter

### Using Templates from Seeds
**applyTo**: `**/*.md`

Templates are stored in `seeds/dendron.templates/templates/`:
1. First, ensure vault visibility is set to `public` in `dendron.yml`
2. Create note with desired name
3. Apply template via `Dendron: Apply Template` command
4. Templates auto-populate structure and placeholders

---

## Best Practices

- Keep notes atomic (one main idea per note)
- Use consistent naming conventions
- Apply templates for structured content
- Link related notes extensively
- Update frontmatter metadata
- Commit changes regularly to Git
- Review and refactor hierarchies as needed
