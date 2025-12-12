---
name: "Dendron Daily Journal"
description: "Instructions for creating daily journals with Five Minute Journal template"
applyTo: "vault2/daily.journal.*.md"
---

# Creating a Daily Journal with Five Minute Journal Template

## Naming Convention
Follow Dendron's journal naming convention based on `dendron.yml` configuration:
- Format: `daily.journal.{year}.{month}.{day}`
- Example: `daily.journal.2025.12.12`

## Workflow

1. **Create note with proper naming**:
   - Press `Ctrl+L` (Lookup Note)
   - Type: `daily.journal.YYYY.MM.DD` (replace with actual date)
   - Press Enter to create empty note

2. **Apply Five Minute Journal template**:
   - In the new note, press `Ctrl+Shift+P`
   - Search and select: `Dendron: Apply Template`
   - Choose: `templates.journal.daily.5mj`
   - Template structure will be copied to your note

3. **Fill in journal sections**:
   - **Morning**: 
     - I am grateful for...
     - What would make today great?
     - Daily affirmations
   - **Evening**: 
     - Amazing things that happened today
     - How could I have made today better?

## Available Templates
- `templates.journal.daily.5mj` - The Five Minute Journal (from dendron.templates)
- `templates.daily` - Daily Journal Template (vault-private)

## Quick Command
Alternative: Use `Dendron: Create Daily Journal Note` to auto-generate today's journal with proper naming.
