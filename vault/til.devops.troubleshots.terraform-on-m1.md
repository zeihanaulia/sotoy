---
id: 0tk30dy71tpxnt8p8lxiiwb
title: Terraform on M1
desc: 'Panduan singkat mengatasi masalah provider Terraform yang belum mendukung arsitektur Apple Silicon (M1/arm64) di macOS, serta solusi menggunakan m1-terraform-provider-helper untuk build dan install provider secara lokal.'
updated: 1749900629661
created: 1749900138937
tags:
    - terraform
    - apple-silicon
    - m1
    - devops
    - troubleshooting
    - provider
    - arm64
    - macos
---

Gembel banget, entah kenapa terraform di M1 ada issue nyebelin.

```sh
│ Error: Incompatible provider version
│ 
│ Provider registry.terraform.io/hashicorp/template v2.2.0 does not have a package available for your current platform,
│ darwin_arm64.
│ 
│ Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions
│ of this provider may have different platforms supported.
```

bisa bisanya, di M1 gak ada dan gak update. Perlu ada workaround buat benerin ginian.

```sh
brew install kreuzwerker/taps/m1-terraform-provider-helper
m1-terraform-provider-helper activate
m1-terraform-provider-helper install hashicorp/template -v 
```

## Referensi

Lengkapnya disini sih, https://github.com/kreuzwerker/m1-terraform-provider-helper

Gue ceritain dikit kali ya soal gimana cara kerja project `m1-terraform-provider-helper` ini.

Jadi gini, lo abis install Terraform, pengen pake provider tertentu — misalnya `vault` atau `azurerm` — tapi begitu lo jalanin `terraform init`, malah error karena gak nemu provider buat darwin\_arm64. Masalahnya, banyak provider di registry Terraform itu cuma sediain binary buat x86\_64, alias amd64. Nah, di M1, itu gak langsung bisa dipake, dan Terraform juga strict banget soal checksum. Gak bisa asal compile lokal doang, karena lockfile-nya bakal nolak kalau checksum-nya beda.

Di situ lah `m1-terraform-provider-helper` masuk. Dia basically ngebantuin lo untuk compile provider-provider itu dari source code langsung di mesin lo, tapi gak cuma berhenti di compile doang. Dia juga nanganin semua penempatan binary-nya di path yang Terraform expect, dan bahkan bisa bantu lo update `.terraform.lock.hcl` biar checksum dari binary lokal tadi dianggap valid sama Terraform.

Cara pakenya pun cukup simpel. Pertama lo aktifin dulu si helper-nya lewat `m1-terraform-provider-helper activate`. Ini bakal nge-setup environment lo biar Terraform ngarah ke folder plugin lokal yang dipake si helper. Abis itu lo tinggal install providernya, misalnya `m1-terraform-provider-helper install hashicorp/vault -v v2.10.0`. Di balik layar, dia bakal clone repo GitHub providernya, nge-run build (biasanya `make build`), dan nyimpen hasilnya ke direktori plugin Terraform dengan struktur folder yang valid sesuai versi Terraform lo.

Satu langkah lagi yang penting, lo harus update lockfile-nya. Karena provider lokal yang lo compile tadi punya checksum yang beda, lo bisa jalanin `m1-terraform-provider-helper lockfile upgrade` supaya `.terraform.lock.hcl` lo ditambahin checksum dari binary baru tadi. Kalau enggak, Terraform bakal tetap error pas lo `init` atau `apply`.

Dan udah, gitu doang. Lo sekarang bisa jalanin Terraform kaya biasa, tapi semua provider yang tadinya gak support M1 sekarang udah bisa dipake tanpa error checksum atau masalah arsitektur. Tool ini tuh fungsional banget kalau lo kerja banyak dengan Terraform di Mac M1 dan capek debug karena provider gak support.

Kalau lo butuh compile custom atau provider dari repo yang gak standar, dia juga sediain flag buat override build command atau source URL. Tapi buat sebagian besar kasus, command default-nya udah cukup.

Singkatnya, ini tool yang ngisi celah antara Apple Silicon dan ekosistem Terraform yang belum 100% native ARM. Gak perlu hack aneh-aneh atau tunggu provider dirilis resmi, tinggal compile lokal dan jalan.
