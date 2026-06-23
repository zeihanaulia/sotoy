
## Ringkasan

Analisis menunjukkan bahwa proyek `sotoy` sendiri memiliki dependensi langsung minimal, tetapi hasil `npm audit` mengungkap banyak alert dari tree dependency transitive.

- `sotoy/package.json` hanya memiliki dependency langsung:
  - `@dendronhq/dendron-cli@^0.122.0`
- `npm audit` di root `sotoy` menghasilkan:
  - 60 advisory
  - 120 total vulnerabilities
  - 4 `critical`, 29 `high`, 17 `moderate`, 10 `low`

Proyek `research/dendron/packages/nextjs-template` juga menggunakan dependensi lama yang berpotensi memicu alert saat audit.

---

## Temuan utama pada `sotoy`

### Sumber alert terbesar

Banyak issue berasal dari dependency transitive yang dibawa oleh `@dendronhq/dendron-cli`.

### Paket bermasalah yang muncul di audit

- `axios`
- `form-data`
- `handlebars`
- `simple-git`
- `@dendronhq/api-server`
- `@dendronhq/common-all`
- `@dendronhq/common-server`
- `@dendronhq/dendron-cli`
- `@dendronhq/dendron-viz`
- `@dendronhq/engine-server`
- `@dendronhq/pods-core`
- `@dendronhq/unified`
- `analytics-node`
- `cacache`
- `clipboardy`
- `cross-spawn`
- `execa`
- `express`
- `jws`
- `lodash`
- `make-fetch-happen`
- `minimatch`
- `node-forge`
- `node-gyp`
- `path-to-regexp`
- `picomatch`
- `remark`
- `remark-parse`
- `sqlite3`
- `tar`
- `tar-fs`
- `title`
- `trim`

### Paket `moderate`

- `@babel/runtime`
- `@mapbox/rehype-prism`
- `@octokit/graphql`
- `@octokit/request`
- `@octokit/request-error`
- `ajv`
- `brace-expansion`
- `follow-redirects`
- `js-yaml`
- `katex`
- `nanoid`
- `prismjs`
- `qs`
- `refractor`
- `rehype-katex`
- `yaml`
- `zod`

### Paket `low`

- `@sentry/node`
- `@tootallnate/once`
- `body-parser`
- `cookie`
- `diff`
- `diff2html`
- `http-proxy-agent`
- `morgan`
- `on-headers`
- `tmp`

---

## Sumber potensi masalah di `nextjs-template`

`research/dendron/packages/nextjs-template` ditemukan menggunakan versi lama untuk beberapa paket front-end dan build:

- `next@12.3.0`
- `react@17.0.2`
- `eslint@7.32.0`
- `typescript@4.5.4`
- `sass@1.49.0`
- `axios@0.21.4`
- `minimatch@5.1.0`

Paket di atas dapat menghasilkan alert tambahan pada dependensi template dan berkontribusi ke jumlah issue yang dilaporkan oleh Dependabot.

---

## Catatan teknis

- `npm --version` di environment ini adalah `11.6.2`.
- `npm audit` di `sotoy` harus dijalankan di root repository karena `sotoy/package-lock.json` tersedia di sana.
- `nextjs-template` tidak di-audit langsung karena environment saat ini tidak memiliki `node_modules` di dalam `research/dendron/packages/nextjs-template`.

---

## Rekomendasi awal

1. Evaluasi upgrade `@dendronhq/dendron-cli` ke versi terbaru yang kompatibel.
2. Jika memungkinkan, perbarui `nextjs-template` ke versi Next.js / React / TypeScript yang lebih baru.
3. Periksa apakah patch di Dependabot dapat diterapkan melalui override/resolution di `package-lock.json` atau dengan update package upstream.
4. Tulis ulang audit dan dokumentasi per-tahap setelah dependensi utama diupgrade.

---

## Prioritas Perbaikan (per 2026-04-16)

> Total: **74 Open** alert — 5 Critical, 4+ High (dari screenshot GitHub Dependabot)
>
> Semua alert berasal dari transitive dependency `@dendronhq/dendron-cli@^0.122.0`.
> Strategi utama: gunakan `npm overrides` di `package.json` untuk memaksa versi aman pada sub-dependency.

### Tier 1 — CRITICAL (perbaiki duluan)

| # | Package | Isu | Dependabot # | Aksi |
|---|---------|-----|-------------|------|
| 1 | `handlebars` | JavaScript injection via AST Type Confusion | #102 | Override ke `>=4.7.8` |
| 2 | `simple-git` | `blockUnsafeOperationsPlugin` bypass via case-insensitive `protocol.allow` → RCE | #100 | Override ke `>=3.16.0` |
| 3 | `axios` | Unrestricted Cloud Metadata Exfiltration via Header Injection Chain | #105 | Override ke `>=1.7.4` |
| 4 | `axios` | NO_PROXY Hostname Normalization Bypass → SSRF | #104 | Override ke `>=1.7.4` (sama) |
| 5 | `form-data` | Unsafe random function untuk boundary → predictable multipart | #61 | Override ke `>=4.0.1` |

### Tier 2 — HIGH (perbaiki setelah Critical selesai)

| # | Package | Isu | Dependabot # | Aksi |
|---|---------|-----|-------------|------|
| 6 | `tar-fs` | Extract outside specified dir via crafted tarball (path traversal) | #47, #58 | Override ke `>=3.0.6` |
| 7 | `node-forge` | ASN.1 Unbounded Recursion (DoS) | #72 | Override ke `>=1.3.1` |
| 8 | `trim` | Regular Expression Denial of Service (ReDoS) | #2 | Override atau replace usage |

### Rencana Implementasi

**Langkah 1 — Tambahkan `overrides` di `package.json`**

```json
{
  "overrides": {
    "handlebars": ">=4.7.8",
    "simple-git": ">=3.16.0",
    "axios": ">=1.7.4",
    "form-data": ">=4.0.1",
    "tar-fs": ">=3.0.6",
    "node-forge": ">=1.3.1"
  }
}
```

**Langkah 2 — Jalankan ulang install dan audit**

```bash
npm install
npm audit
```

**Langkah 3 — Verifikasi**

Pastikan jumlah critical dan high berkurang setelah override diterapkan.
Jika masih ada, periksa apakah versi yang di-override kompatibel dengan `@dendronhq/dendron-cli`.

**Langkah 4 — Evaluasi upgrade `@dendronhq/dendron-cli`**

Cek apakah ada versi terbaru yang sudah memperbarui sub-dependency:

```bash
npm outdated @dendronhq/dendron-cli
npm view @dendronhq/dendron-cli versions --json | tail -20
```

**Langkah 5 — Update `nextjs-template` (opsional, lower priority)**

Upgrade paket di `research/dendron/packages/nextjs-template` jika digunakan aktif.

### Status (diupdate 2026-04-16)

- [x] Tier 1 — Critical: override `handlebars@>=4.7.9`, `simple-git@>=3.32.3`, `axios@>=1.7.4`, `form-data@>=4.0.4`
- [x] Tier 2 — High: override `tar-fs@>=3.0.6`, `node-forge@>=1.3.1`
- [x] Verifikasi `npm audit` pasca override → **0 critical** (turun dari 5), total 53 (dari 74)
- [ ] Remaining high (27) — lihat seksi "Sisa High Vulnerabilities" di bawah
- [ ] Evaluasi migrasi dari `@dendronhq/dendron-cli` (abandoned sejak Maret 2024)
- [ ] Dismiss alert Dependabot di GitHub untuk package yang sudah di-cover override

---

## Sisa High Vulnerabilities (27) — Analisis & Opsi

> Setelah override pertama, tersisa 27 high dari dua kelompok berbeda.

### Kelompok A — Bisa di-override (package eksternal)

Package-package ini punya versi aman yang tersedia di npm dan dapat di-override dari `package.json`:

| Package | Vulnerable Range | Fix Version | Issue |
|---------|-----------------|-------------|-------|
| `cross-spawn` | `<6.0.6` | `>=6.0.6` | ReDoS |
| `node-forge` | `<1.4.0` | `>=1.4.0` | Ed25519 forgery, RSA-PKCS forgery, DoS (override kita masih `>=1.3.1`) |
| `path-to-regexp` | `<0.1.13` | `>=0.1.13` | ReDoS via multiple params |
| `picomatch` | `<2.3.2` | `>=2.3.2` | ReDoS via extglob + method injection |
| `tar` | `<=7.5.10` | `>=7.5.11` | Multiple path traversal & symlink CVEs |
| `jws` | `==4.0.0` | `>=4.0.1` | HMAC signature verification bypass |
| `lodash` | `<=4.17.23` | `>=4.17.21` (partial) | Prototype pollution + code injection |
| `trim` | `<0.0.3` | `>=0.0.3` | ReDoS |
| `minimatch` | `<3.1.4` atau `>=5.0.0 <5.1.8` | `>=3.1.4` dan `>=5.1.8` | ReDoS via wildcards & extglob |

### Kelompok B — Tidak bisa di-override (internal `@dendronhq/*`)

Package berikut adalah bagian dari `@dendronhq` monorepo itu sendiri. Mereka vulnerable karena membawa sub-dep bermasalah di dalam build mereka, tapi npm overrides tidak bisa menjangkau ke dalam package yang sudah di-publish ke npm registry.

| Package | Via |
|---------|-----|
| `@dendronhq/common-all` | `minimatch`, `title`, `zod` |
| `@dendronhq/common-server` | `@dendronhq/common-all`, `@sentry/node` |
| `@dendronhq/engine-server` | `remark`, `remark-parse`, `sqlite3`, `rehype-katex` |
| `@dendronhq/unified` | `rehype-katex`, `remark`, `remark-parse` |
| `@dendronhq/api-server` | (via semua di atas) |
| `@dendronhq/pods-core` | (via semua di atas) |
| `@dendronhq/dendron-cli` | (root package) |

---

## Opsi Penanganan Sisa High

### Opsi 1 — Tambah Override Kelompok A (Rekomendasi)

Paling pragmatis. Tambahkan override untuk semua Kelompok A. Ini akan mengurangi ~15-18 high dari total 27.

```json
"overrides": {
  "handlebars": ">=4.7.9",
  "simple-git": ">=3.32.3",
  "axios": ">=1.7.4",
  "form-data": ">=4.0.4",
  "tar-fs": ">=3.0.6",
  "node-forge": ">=1.4.0",
  "cross-spawn": ">=6.0.6",
  "path-to-regexp": ">=0.1.13",
  "picomatch": ">=2.3.2",
  "tar": ">=7.5.11",
  "jws": ">=4.0.1",
  "lodash": ">=4.17.21",
  "trim": ">=0.0.3",
  "minimatch": ">=3.1.4"
}
```

Sisa setelah ini: hanya Kelompok B (`@dendronhq/*` internal) yang belum bisa diperbaiki dengan cara ini.

**Trade-off**: Ada risiko minor bahwa override versi baru tidak kompatibel dengan cara `@dendronhq/dendron-cli` menggunakan package tersebut — perlu test setelah apply.

### Opsi 2 — Terima Risk untuk Kelompok B (Mitigate)

Karena `@dendronhq/dendron-cli` dipakai sebagai **CLI tool lokal** (bukan server yang menerima input publik), banyak dari CVE Kelompok B (ReDoS di `minimatch`, prototype pollution di `lodash`) tidak relevan secara praktis — exploitnya butuh input yang dikontrol attacker ke proses yang tidak terekspos.

Dismiss alert Dependabot untuk Kelompok B dengan alasan "vulnerable code path not reachable" atau "CLI tool only, no network exposure."

### Opsi 3 — Migrasi dari `@dendronhq/dendron-cli`

Dendron CLI terakhir publish Maret 2024 dan proyeknya tidak aktif. Opsi jangka panjang:

- **Dendron alternatives**: Cek apakah ada fork aktif atau tool pengganti untuk kebutuhan vault/notes management
- **Remove dependency**: Jika Dendron CLI tidak dipakai aktif, hapus dan ganti workflow
- **Vendor-in**: Clone dan build sendiri dari source di `research/dendron` (high effort, sudah didiskusikan sebelumnya)

### Opsi 4 — Gunakan `npm audit --omit=dev` / Production-only scope

Jika beberapa vulnerable package hanya dipakai di dev/build pipeline dan tidak di runtime produksi, flag ini membantu mempersempit scope alert yang perlu direspons.

---

## Rekomendasi Final

1. **Segera**: Apply Opsi 1 — tambah override Kelompok A untuk menghapus semua high yang bisa di-fix
2. **Short-term**: Dismiss Kelompok B di Dependabot dengan justifikasi "CLI-only, no public exposure"
3. **Long-term**: Evaluasi migrasi atau removal `@dendronhq/dendron-cli` (Opsi 3)

---

---

## Analisis Risiko untuk https://zeihanaulia.github.io/sotoy/

> **Konteks penting**: Site ini adalah **static export** — `next build && next export` di GitHub Actions, hasilnya file HTML/CSS/JS statis yang di-serve GitHub Pages.
> Tidak ada server Node.js yang berjalan di production. Semua page menggunakan `getStaticProps`, tidak ada `getServerSideProps` atau API routes.

### Konsekuensi arsitektur ini terhadap CVE

Mayoritas CVE di `next@12` **tidak berlaku** karena tidak ada server:

| CVE | Deskripsi | Relevan? | Alasan |
|-----|-----------|---------|--------|
| Next.js Authorization Bypass in Middleware | Bypass auth middleware | **TIDAK** | Middleware tidak jalan di static export |
| Next.js HTTP Request Smuggling in rewrites | Smuggling via rewrite rules | **TIDAK** | Tidak ada server |
| Next.js SSRF via Middleware Redirect | SSRF dari redirect handling | **TIDAK** | Tidak ada server |
| Next.js Image Optimization DoS | DoS via banyak request ke `/_next/image` | **TIDAK** | Tidak ada image optimization server |
| Next.js Cache Poisoning / Cache Key Confusion | Poisoning CDN cache | **TIDAK** | GitHub Pages hanya serve file statis |
| Next.js Content Injection via Image API | Inject konten via image endpoint | **TIDAK** | Tidak ada endpoint |

### CVE yang BENAR-BENAR berbahaya

Karena tidak ada server runtime, risiko bergeser ke **build pipeline** (GitHub Actions).

#### 1. `@babel/traverse <7.23.2` — Arbitrary Code Execution (Critical, BUILD-TIME)

**Berbahaya.** Babel dipakai saat `next build` mengkompilasi semua JS/TS. Jika ada kode JavaScript berbahaya yang masuk ke dalam proses build (misalnya melalui dependency yang dikompromikan atau file di repo), ini bisa mengeksekusi kode arbitrer di GitHub Actions runner — di mana `GITHUB_TOKEN` dan secrets lain tersedia.

- Exploit butuh: kode JS berbahaya masuk ke dalam build process
- Impact: RCE di GitHub Actions runner, potential secret exfiltration

**Fix**: Override `@babel/traverse` ke `>=7.23.2`

#### 2. `axios@0.21.4` — Multiple CVE (High, BUILD-TIME + CLIENT-SIDE)

`axios` masih ada di `@dendronhq/common-all`. Meski tidak dipakai langsung di pages client-side (tidak ada `import axios` ditemukan di code), library ini bisa dieksekusi selama proses build saat Dendron CLI memproses vault.

- SSRF + credential leakage: relevan jika axios dipakai di build untuk fetch external data dengan env vars GitHub Actions
- CSRF: tidak relevan (tidak ada session/cookie di static site)

**Fix**: Override `axios` di nextjs-template juga

#### 3. `lodash` Code Injection via `_.template` (High, BUILD-TIME)

`lodash` dipakai sebagai direct dependency di nextjs-template. Jika `_.template()` dipanggil dengan string yang berasal dari konten vault/notes, bisa dieksploitasi.

- Exploit butuh: content dari notes/vault diteruskan ke `_.template()`
- Impact: code injection di build time
- Probabilitas rendah untuk use case notes biasa

### CVE yang LOW RISK untuk use case ini

| Package | CVE | Kenapa Low Risk |
|---------|-----|----------------|
| `minimatch`, `cross-spawn`, `picomatch`, `micromatch` | ReDoS | Build-time only, input adalah file paths yang dikontrol — bukan user input |
| `ws` | DoS via HTTP headers | Tidak ada WebSocket server |
| `ip` | SSRF improper classification | Hanya di `@react-native-community/cli` (dev tool, tidak di-bundle) |
| `luxon` | ReDoS | Input dari notes yang dikontrol sendiri |
| `semver` | ReDoS | Hanya di build tools, bukan runtime |
| `json5` | Prototype Pollution | Bukan di hot path dengan user input |
| `immutable` | Prototype Pollution | Tidak ada user-controlled input |
| `flatted` | Prototype Pollution / DoS | Tidak ada user-controlled input |
| `braces`, `decode-uri-component` | ReDoS / DoS | Build-time only |

### Prioritas Fix untuk nextjs-template

**Tier 1 — DONE (2026-04-16):**

Override ditambahkan ke `nextjs-template/package.json`:
```json
"overrides": {
  "trim": "0.0.3",
  "@types/react": "17.0.38",
  "@babel/traverse": ">=7.23.2",
  "axios": ">=1.7.4"
}
```

Hasil setelah `npm install`:
- Sebelum: **3 critical**, 23 high, total 53
- Sesudah: **1 critical**, 23 high, total 50
- `@babel/traverse` → resolved ke `7.29.0` ✓
- `axios` → resolved ke `1.15.0` ✓

Sisa 1 critical: `next@12` itu sendiri — seluruh CVE-nya adalah server-side (middleware, image optimization, rewrites). **Tidak berlaku** untuk static export di GitHub Pages.

**Tier 2 — Upgrade Next.js (jangka panjang):**

`next@12` sudah EOL. Upgrade ke `next@14` atau `next@15` akan menutup seluruh blok CVE Next.js sekaligus. Ini butuh effort lebih karena ada breaking changes, tapi ini fix yang paling bersih.

**Tier 3 — Accept & dismiss:**

CVE `next@12` server-side bisa di-dismiss di Dependabot dengan catatan: _"Not applicable — site is a static export served via GitHub Pages, no Next.js server running in production."_

---

## Referensi

- `sotoy/package.json`
- `sotoy/package-lock.json`
- `nextjs-template/package.json`
- `nextjs-template/next.config.js`
- `.github/workflows/publish.yml`
- [GitHub Dependabot Alerts](https://github.com/zeihanaulia/sotoy/security/dependabot)
