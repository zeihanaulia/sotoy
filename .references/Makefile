# Makefile for updating reference repositories
# This file should be placed in the references/ folder

.PHONY: help update update-force

help:
	@echo "Reference Repository Update Commands:"
	@echo "  update      - Update all git repositories (skip if local changes exist)"
	@echo "  update-force - Force update all repositories (discard local changes)"
	@echo ""
	@echo "Usage:"
	@echo "  cd references && make update"
	@echo "  cd references && make update-force"

# Update all git repositories (skip if local changes exist)
update:
	@echo "🔄 Updating all git repositories in references/ folder..."
	@for dir in */; do \
		if [ -d "$$dir/.git" ]; then \
			echo "📥 Updating $$(basename $$dir)..."; \
			(cd "$$dir" && git pull --quiet) && echo "✅ $$(basename $$dir) updated" || echo "❌ Failed to update $$(basename $$dir)"; \
		else \
			echo "⏭️  Skipping $$(basename $$dir) (no .git folder)"; \
		fi; \
	done
	@echo "🎉 References update complete!"

# Force update all git repositories (discard local changes)
update-force:
	@echo "🔄 Force updating all git repositories in references/ folder..."
	@echo "⚠️  WARNING: This will discard any local changes in references/ folders"
	@echo ""
	@for dir in */; do \
		if [ -d "$$dir/.git" ]; then \
			echo "📥 Force updating $$(basename $$dir)..."; \
			(cd "$$dir" && git checkout . && git clean -fd && git pull --quiet) && echo "✅ $$(basename $$dir) force updated" || echo "❌ Failed to force update $$(basename $$dir)"; \
		else \
			echo "⏭️  Skipping $$(basename $$dir) (no .git folder)"; \
		fi; \
	done
	@echo "🎉 Force update complete!"