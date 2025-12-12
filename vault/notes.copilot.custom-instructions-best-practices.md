---
id: notes.copilot.custom-instructions-best-practices
title: Best Practices for Writing Copilot Custom Instructions
desc: Guidelines and best practices for creating effective GitHub Copilot custom instructions files
updated: 1734021600000
created: 1734021600000
---


Custom instructions enable you to define common guidelines and rules that automatically influence how GitHub Copilot generates code and handles development tasks. Instead of manually including context in every chat prompt, specify custom instructions in Markdown files to ensure consistent AI responses.

## Types of Instructions Files

### 1. `.github/copilot-instructions.md`
- Single file that applies to **all** chat requests in the workspace
- Best for project-wide guidelines
- Automatically detected by VS Code, Visual Studio, and GitHub.com

### 2. `.instructions.md` Files
- Multiple files with conditional application based on file patterns
- Uses `applyTo` glob pattern in YAML frontmatter
- Stored in `.github/instructions/` folder or user profile
- Best for language-specific or task-specific instructions

### 3. `AGENTS.md` Files
- For workspaces using multiple AI agents
- Can be nested in subfolders (experimental)
- Applies to all chat requests in workspace

## Five Essential Sections

Based on [GitHub's recommendations](https://github.blog/ai-and-ml/github-copilot/5-tips-for-writing-better-custom-instructions-for-copilot/), every instruction file should include:

### 1. **Project Overview**
Provide an elevator pitch of your application:
- What is the app?
- Who is the audience?
- What are key features?

**Example**:
```markdown
# Project Description

This is a personal knowledge base (PKM) built with Dendron, a hierarchical note-taking tool for developers. The workspace contains book summaries, technical notes, daily journals, and learning documentation.
```

### 2. **Tech Stack**
List frameworks, languages, and tools used:
- Backend technologies
- Frontend frameworks
- Testing suites
- APIs and databases

**Example**:
```markdown
## Tech Stack

- **Dendron**: Core note-taking system with hierarchical structure
- **Markdown**: All notes are written in Markdown format
- **Next.js**: Static site generation for publishing
- **Git**: Version control
```

### 3. **Coding Guidelines**
Specify coding standards and practices:
- Code style preferences (semicolons, type hints, indentation)
- Testing requirements
- Security practices
- Naming conventions

**Example**:
```markdown
## Project Guidelines

- All notes follow Dendron naming convention: hierarchical with dot notation
- Use kebab-case for note names
- Journal notes follow `daily.journal.{year}.{month}.{day}` format
- Keep notes atomic and well-linked using wiki links
```

### 4. **Project Structure**
Explain folder organization:
- Main directories and their purposes
- Where to find specific types of files
- Configuration locations

**Example**:
```markdown
## Project Structure

- `vault/` - Public notes (book summaries, handbook, technical notes)
- `vault2/` - Private notes (daily journals, personal reflections)
- `.github/instructions/` - Custom instruction files
- `docs/` - Generated static site
```

### 5. **Available Resources**
Point to tools, scripts, and utilities:
- Development scripts
- Template systems
- Key commands
- MCP servers

**Example**:
```markdown
## Resources

### Templates Available
- `templates.journal.daily.5mj` - Five Minute Journal template
- `templates.module` - Module documentation template

### Key Commands
- `Ctrl+L` - Lookup Note
- `Dendron: Apply Template` - Apply template to current note
```

## Using `.instructions.md` Files with `applyTo`

For task-specific or file-specific instructions, create separate `.instructions.md` files:

### File Format
```markdown
---
name: "Instruction Name"
description: "Brief description"
applyTo: "**/*.py"  # Glob pattern
---

# Instructions content here

Your specific guidelines for files matching the pattern.
```

### Example: Python-Specific Instructions
```markdown
---
name: "Python Coding Standards"
description: "PEP 8 and project-specific Python guidelines"
applyTo: "**/*.py"
---

# Python Coding Standards

- Follow PEP 8 style guide
- Always use type hints
- Write docstrings for all public functions
- Use 4 spaces for indentation
```

### Creating via UI
1. Open Chat view in VS Code
2. Click gear icon (⚙️) > **Chat Instructions**
3. Select **New instruction file**
4. Choose location (Workspace or User profile)
5. Add YAML frontmatter and instructions

## Best Practices

### Keep Instructions Short and Focused
- Each instruction should be a single, simple statement
- Use bullet points for clarity
- Avoid lengthy paragraphs

### Use Multiple Files for Different Topics
Instead of one large file:
```
.github/instructions/
  ├── python-standards.instructions.md
  ├── typescript-standards.instructions.md
  ├── testing-guidelines.instructions.md
  └── api-design.instructions.md
```

### Leverage `applyTo` Patterns
Common patterns:
- `"**/*.py"` - All Python files
- `"src/**/*.ts"` - TypeScript in src folder
- `"tests/**/*"` - All test files
- `"vault2/daily.journal.*.md"` - Daily journal notes

### Reference External Resources
Use Markdown links to reference:
- Documentation URLs
- Design documents
- Code examples
- Tool documentation

### Store in Version Control
- Commit instructions files to Git
- Share with team members
- Track changes over time

### Test Your Instructions
After creating instructions:
1. Ask Copilot about the project
2. Verify it references your guidelines
3. Request code generation to check compliance
4. Iterate based on results

## Common Use Cases

### Daily Journal Workflow
```markdown
---
name: "Daily Journal Template"
applyTo: "vault2/daily.journal.*.md"
---

# Creating Daily Journals

1. Use naming: `daily.journal.YYYY.MM.DD`
2. Apply template: `templates.journal.daily.5mj`
3. Fill sections: Morning gratitude, Evening reflections
```

### Code Review Guidelines
```markdown
---
name: "Code Review Standards"
description: "Guidelines for reviewing pull requests"
---

# Code Review Checklist

- Verify unit tests pass
- Check for security vulnerabilities
- Ensure code follows style guide
- Review performance implications
```

## Tips from GitHub

1. **Don't Overthink**: Start simple, iterate based on experience
2. **Use Copilot to Generate**: Ask Copilot to help create instruction files
3. **Keep Under 2 Pages**: Avoid overly long instructions
4. **Be Specific**: Clear, actionable guidelines work best
5. **Update Regularly**: Instructions should evolve with your project

## Common Mistakes to Avoid

❌ **Too Generic**
```markdown
Write good code with best practices.
```

✅ **Specific and Actionable**
```markdown
- Use TypeScript strict mode
- All functions must have JSDoc comments
- Prefer async/await over raw Promises
```

❌ **Too Long**
- Multiple pages of detailed specifications
- Copy-pasting entire style guides

✅ **Concise**
- Link to full documentation
- Highlight key points only

## References

- [VS Code Docs: Custom Instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [GitHub Blog: 5 Tips for Better Custom Instructions](https://github.blog/ai-and-ml/github-copilot/5-tips-for-writing-better-custom-instructions-for-copilot/)
- [GitHub Skills: Customize Copilot Experience](https://github.com/skills/customize-your-github-copilot-experience)
- [GitHub Docs: Repository Custom Instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions)
- [Awesome Copilot Examples](https://github.com/github/awesome-copilot/tree/main)

## Related Notes

- [[notes.dendron.workspace-setup]]
- [[handbook.vscode.copilot-configuration]]
- [[til.copilot.custom-agents]]
