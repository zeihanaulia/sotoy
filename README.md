# sotoy

## Ringkasan

`sotoy` adalah repositori personal knowledge base yang dibangun menggunakan Dendron. Proyek ini menyimpan catatan dan konten pengetahuan di dalam vault Dendron dan mempublikasikannya sebagai situs statis ke folder `docs/`.

## Apa yang ada di dalam repositori

- `dendron.yml` — konfigurasi workspace Dendron, vault, dan publikasi.
- `vault/` — vault Dendron utama untuk catatan dan knowledge base.
- `vault2/` — vault pribadi tambahan (`vault-private`) dengan sinkronisasi git.
- `docs/` — output situs statis yang dihasilkan oleh Dendron publishing.
- `.next/` — folder build Next.js yang dihasilkan oleh Dendron/NextJS template.
- `nextjs-template/` — template Dendron Next.js yang digunakan sebagai basis tampilan situs.
- `Makefile` — target helper untuk develop, build, preview, dan clean.
- `package.json` — instalasi Dendron CLI untuk workspace.

## Struktur penting

- `dendron.yml` mengontrol: vault, publishing, preview, dan pengaturan Dendron.
- `docs/` dihasilkan secara otomatis; jangan diedit langsung.
- `nextjs-template/` berisi source untuk tema Next.js yang digunakan oleh situs.
- `vault/` dan `vault2/` berisi catatan yang dikelola Dendron.

## Cara memulai

1. Pastikan Node.js dan npm terpasang.
2. Di root repository, jalankan:

```bash
npm install
```

3. Untuk menjalankan Dendron dalam mode pengembangan:

```bash
make dev
```

4. Untuk membangun situs untuk produksi:

```bash
make build
```

5. Untuk melihat hasil build statis secara lokal (via base path `/sotoy/`):

```bash
make preview
```

> Buka `http://localhost:8000/sotoy/` setelah menjalankan preview.

## Flow Publish

- `make dev` menjalankan `npx dendron publish dev`.
- Perintah ini akan mempersiapkan template `.next`, menghasilkan metadata publikasi yang diperlukan, lalu menjalankan server Next.js development.
- Jadi untuk development, tidak perlu menjalankan `make build` secara manual sebelum `make dev`.
- `make build` digunakan untuk build produksi: metadata Dendron dihasilkan lalu Next.js dibangun menjadi output produksi.
- `make preview` membutuhkan folder `docs/` yang sudah dibuat oleh `make build`, jadi jalankan `make build` terlebih dahulu sebelum preview.

## Custom Template

- Folder `nextjs-template/` adalah sumber template Next.js yang digunakan untuk situs Dendron.
- Jangan edit folder `.next/` secara langsung, karena itu adalah artefak build.
- Jika ingin custom tampilan, ubah file di `nextjs-template/` lalu jalankan `make build` atau `make dev` untuk menerapkannya.
- `dendron.yml` mengarahkan publikasi ke `docs/`, jadi hasil build produksi akan berada di folder tersebut.

## Target Makefile utama

- `make dev` — jalankan server pengembangan Dendron.
- `make build` — build metadata Dendron dan HTML situs.
- `make preview` — jalankan preview statis dari folder `docs/`.
- `make clean` — hapus build artefak `.next/` dan `docs/`.

## Catatan tambahan

- `package-lock.json` dan `.next/` adalah artefak build; biasanya tidak perlu diedit.
- Jika ingin menyesuaikan tampilan situs, ubah file di `nextjs-template/`.
- `dendron.yml` sudah konfigurasi publikasi GitHub Pages dengan `siteUrl: https://zeihanaulia.github.io` dan `assetsPrefix: /sotoy`.

---

## Kontak

- Remote Git repository: `https://github.com/zeihanaulia/sotoy`
- `package.json` homepage sudah menunjuk `https://github.com/zeihanaulia/sotoy#readme`.
