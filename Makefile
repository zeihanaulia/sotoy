# Makefile untuk menjalankan situs web Dendron
.PHONY: help build install serve dev clean preview

# Default target
help:
	@echo "Makefile untuk menjalankan situs web Dendron"
	@echo ""
	@echo "Target yang tersedia:"
	@echo "  build    - Build metadata dan HTML untuk production"
	@echo "  install  - Install dependencies di folder .next"
	@echo "  serve    - Jalankan server production (port 3001)"
	@echo "  dev      - Jalankan development server"
	@echo "  preview  - Preview dengan server static (port 8000)"
	@echo "  clean    - Bersihkan build files"
	@echo "  help     - Tampilkan pesan bantuan ini"
	@echo ""
	@echo "Contoh penggunaan:"
	@echo "  make build    # Build untuk production"
	@echo "  make serve    # Jalankan server setelah build"
	@echo "  make dev      # Jalankan development server"

# Build metadata dan HTML untuk production
build:
	@echo "🔨 Building metadata..."
	npx dendron publish build
	@echo "🏗️  Building HTML..."
	cd .next && npm run build
	@echo "✅ Build selesai!"

# Install dependencies
install:
	@echo "📦 Installing dependencies..."
	cd .next && npm install
	@echo "✅ Dependencies terinstall!"

# Jalankan server production
serve:
	@echo "🚀 Menjalankan server production..."
	@if [ ! -d ".next/.next" ]; then \
		echo "❌ Build belum dilakukan. Jalankan 'make build' terlebih dahulu."; \
		exit 1; \
	fi
	cd .next && PORT=3001 npm run start

# Jalankan development server
dev:
	@echo "🔧 Menjalankan development server..."
	npx dendron publish dev

# Preview dengan server static
preview:
	@echo "👀 Menjalankan preview server..."
	@if [ ! -d "docs" ]; then \
		echo "❌ Folder docs tidak ditemukan. Jalankan 'make build' terlebih dahulu."; \
		exit 1; \
	fi
	cd docs && npx serve -s -l 8000

# Bersihkan build files
clean:
	@echo "🧹 Membersihkan build files..."
	rm -rf .next/.next
	rm -rf .next/out
	rm -rf docs
	@echo "✅ Clean selesai!"

# Setup lengkap (install + build + serve)
setup: install build serve

# Development workflow (build + dev)
develop: build dev
