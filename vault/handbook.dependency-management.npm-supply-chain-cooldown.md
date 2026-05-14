---
id: handbook.dependency-management.npm-supply-chain-cooldown
title: "Hardening npm dependency installs dengan cooldown policy"
desc: "Panduan implementasi minimum release age, frozen lockfile CI, dan build script allowlist untuk mengurangi risiko supply chain di ekosistem npm/pnpm."
updated: 1778773631311
created: 1778773631311
tags:
  - handbook
  - dependency-management
  - security
  - supply-chain
  - pnpm
---

## Kenapa pakai cooldown policy

Serangan supply-chain npm sering menang di "jendela waktu pertama": versi baru dipublish, lalu project atau pipeline secara otomatis menginstal versi itu sebelum komunitas atau tooling sempat mendeteksi malicious release.

Cooldown policy mengubah default behavior dependency manager dari "ambil versi terbaru" menjadi "tahan dulu versi baru sampai cukup umur".

## Kapan policy ini cocok

Gunakan ketika:

- repo punya jalur rilis sensitif atau produksi yang tidak boleh berubah otomatis
- project memakai agentic tooling, automation, atau workflow CI/CD yang sering install dependency
- tim perlu batasan update dependency baru tanpa memindahkan registry
- kamu ingin mencegah versi baru melewati pipeline hanya karena package manager default

## Basic setup dengan pnpm

Di `.pnpmrc` atau `pnpm-workspace.yaml`:

```yaml
minimumReleaseAge: 10080
minimumReleaseAgeStrict: true
```

Penjelasan:

- `minimumReleaseAge: 10080` = versi package harus berumur minimal 7 hari sebelum pnpm boleh resolve.
- `minimumReleaseAgeStrict: true` = policy ditegakkan keras; versi yang terlalu baru tidak akan dipilih.

## Lapisan CI

Di pipeline CI, pakai:

```bash
pnpm install --frozen-lockfile
```

Tujuan:

- CI tidak resolve dependency baru sendiri
- build hanya menginstal apa yang sudah ada di lockfile
- dependency update harus masuk lewat PR terkontrol, bukan pipeline spontan

## Tangani package internal dan darurat

Jika kamu punya package internal yang harus langsung dipakai, gunakan exception list:

```yaml
minimumReleaseAgeExclude:
  - nama-package-internal-elo
```

Aturan praktis:

- hanya exclude package yang kamu kendalikan secara penuh
- hindari daftar panjang exception
- dokumentasikan setiap pengecualian dan review periodik

## Build script allowlist

Install dependency npm bisa menjalankan kode melalui lifecycle script.

Contoh policy ketat:

```yaml
onlyBuiltDependencies:
  - esbuild

allowBuilds:
  esbuild: true
```

Ini cocok jika kamu ingin memastikan hanya dependency tertentu yang boleh menjalankan script build saat install.

## Proses operasional yang disarankan

1. review dependency update lewat PR khusus
2. pastikan versi baru memenuhi `minimumReleaseAge`
3. commit lockfile setelah resolusi selesai
4. CI install dengan `--frozen-lockfile`
5. jika perlu package baru sebelum 7 hari, gunakan exception yang diaudit
6. batasi build script kepada dependency terverifikasi

## Kelemahan dan trade-off

- `minimumReleaseAge` bisa menunda security patch baru; policy ini bukan freeze, tapi delay gate.
- exception list membuka celah kalau tidak dikelola.
- toolchain lain mungkin tidak mendukung policy yang sama; ini praktis untuk pnpm.
- butuh budaya dependency update yang lebih sadar, bukan hanya `pnpm install` terus jalan.

## Integrasi dengan supply-chain defense

Cooldown policy ini efektif ketika digabungkan dengan:

- lockfile discipline (`commit lockfile`, `frozen lockfile` di CI)
- review update dependency lewat PR
- risk tiering package berdasarkan blast radius
- explicit build script allowlist

## Catatan penting

Policy ini bukan solusi yang menghilangkan semua risiko npm. Ia menambah lapisan yang murah dan mudah diterapkan:

- mencegah versi baru yang terlalu muda masuk otomatis
- membuat dependency update lebih sengaja
- memastikan CI hanya menjalankan dependency yang sudah dikunci

Ini lebih ke "friction-based security" daripada "security scan".

## Related resources

- [[notes.security.npm-supply-chain-cooldown-policy]]
- [[notes.security.trusted-publishing-checklist]]
- [[notes.security.tanstack-postmortem]]
