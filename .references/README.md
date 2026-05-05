# Folder References

Folder ini berisi berbagai repositori yang dikloning dari coding agents dan tools sebagai referensi.

## Kategori Repositori

Berdasarkan analisis setiap repositori, berikut adalah kategorisasi yang lebih detail:

### Coding Agents and Assistants
Repositori yang fokus pada AI agents untuk tugas coding, seperti membantu penulisan kode, debugging, dan pengembangan perangkat lunak.
- **opencode**: Open source coding agent
- **qwen-code**: Qwen Code agent dari Alibaba

## Memperbarui Referensi

Gunakan Makefile di folder ini untuk memperbarui semua repositori:

```bash
# Navigasi ke folder references
cd references

# Perbarui semua repositori (lewati jika ada perubahan lokal)
make update

# Paksa perbarui semua repositori (buang perubahan lokal)
make update-force

# Tampilkan perintah yang tersedia
make help
```

## Catatan Penting

- Repositori ini untuk **referensi saja** - jangan modifikasi untuk pengembangan
- Gunakan `make update-force` jika perlu membuang perubahan lokal

## Tujuan

Koleksi ini berfungsi sebagai:
- **Bahan riset** untuk menganalisis arsitektur agent yang berbeda
- **Benchmarking** terhadap implementasi yang ada
- **Inspirasi** untuk pengembangan fitur
- **Referensi dokumentasi** untuk berbagai tools dan frameworks

## Git Clone Snippets

Berikut adalah snippet git clone untuk mengkloning ulang repositori referensi ini:

```bash
git clone git@github.com:sst/opencode.git opencode/
git clone https://github.com/QwenLM/qwen-code.git qwen-code/
```