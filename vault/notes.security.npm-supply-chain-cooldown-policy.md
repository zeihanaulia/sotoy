---
id: notes.security.npm-supply-chain-cooldown-policy
title: "NPM supply-chain cooldown policy"
desc: "Analisis kebijakan minimum release age dan build script allowlist untuk hardening supply chain npm dengan pnpm."
updated: 1778775961481
created: 1778773660474
tags:
  - notes
  - security
  - supply-chain
  - npm
  - pnpm
---

## Konteks

Thread Kunchenguid membahas satu cara praktis untuk memperketat instalasi dependency npm tanpa memindahkan registry atau memaksa scan semua paket. Fokusnya adalah mencegah project mengambil versi baru yang baru saja dirilis, karena itulah jendela waktu serangan supply-chain paling efektif.

Link: https://x.com/kunchenguid/status/2054600854553206992

## Guardrail utama

Kun menyarankan policy:

- `minimumReleaseAge: 10080`
- `minimumReleaseAgeStrict: true`

Itu berarti pnpm tidak boleh memilih versi yang usia rilisnya kurang dari 7 hari. Policy ini berlaku pada level versi, bukan nama package.

### Kenapa versi, bukan package

Poin pentingnya adalah:

- package bisa trusted tapi versi barunya belum.
- package populer seperti `chalk`, `debug`, `eslint`, atau dependency build tool bisa tetap diteror oleh versi baru yang dirilis setelah akun maintainer disusupi.
- jadi trust harus melekat pada `package@version` dan tanggal rilisnya, bukan sekadar nama paket atau reputasi historis.

## Mengapa pnpm?

Bukan karena registry yang berbeda. Kun tetap menggunakan npm registry. Perbedaan utama adalah pnpm menjadi enforcement layer:

- registry tetap menyimpan semua versi
- pnpm menolak versi yang terlalu baru saat resolving
- ini membuat policy cooldown jadi bagian dari dependency manager, bukan sistem registry

`npm ci` bagus untuk menegakkan lockfile existing, tetapi tidak cukup saat install package baru atau upgrade dependency lama.

## Peran CI

Di CI, Kun menambahkan aturan kedua:

```bash
pnpm install --frozen-lockfile
```

Itu memastikan CI tidak resolve versi baru dengan sendirinya. CI hanya boleh menginstal apa yang sudah terkunci di lockfile. Ini penting untuk membuat build reproducible dan mencegah pipeline mengambil dependency baru secara spontan.

## Hardening install script

Dependency install sering lebih dari sekadar mengunduh file. Banyak package menjalankan lifecycle script seperti `postinstall`, `prepare`, atau build step lain.

Kun menegaskan bahwa hanya dependency tertentu yang harus diberi izin menjalankan skrip build.

Contoh config:

```yaml
onlyBuiltDependencies:
  - esbuild

allowBuilds:
  esbuild: true
```

Ini membatasi area serangan di mana package bisa mengeksekusi kode selama install.

## Escape hatch yang terkontrol

Policy cooldown harus punya pengecualian untuk package internal atau paket yang benar-benar kita kendalikan.

Contoh:

```yaml
minimumReleaseAgeExclude:
  - my-own-package
```

Tapi hati-hati: kalau exception list terlalu panjang, guardrail ini kehilangan fungsi utama.

## Ringkasan flow

1. developer atau maintainer request update dependency
2. pnpm resolve dengan `minimumReleaseAge`
3. lockfile berubah hanya untuk versi yang sudah cukup tua
4. PR review dan merge
5. CI install dengan `--frozen-lockfile`
6. install script hanya jalan untuk dependency yang di-allowlist

## Trade-off

- keuntungan: memotong jendela waktu serangan earliest-stage
- kerugian: update legitimate patch baru bisa tertunda
- mitigasi: gunakan exception/escape hatch untuk kasus darurat, tapi tetap dokumentasikan dan review

## Kenapa ini penting

Policynya memindahkan default behavior dari:

- "ambil versi terbaru kecuali terbukti jahat"

ke:

- "tahan versi baru sampai cukup umur kecuali ada alasan eksplisit"

Itu adalah shift dari reactive security ke friction-based security.

## Related notes

- [[notes.security.trusted-publishing-checklist]]
- [[notes.security.tanstack-postmortem]]
- [[til.security.cooldown-is-delay-gate-not-freeze]]
