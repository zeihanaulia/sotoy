---
id: 57q7jyz0wff078xaz4s6eea
title: Recovering from a Broken Nix Wsl Setup
desc: 'Nix, WSL, Recovery, Mitchell Hashimoto Inspiration'
updated: 1745902346611
created: 1745898582297
tags:
  - nix
  - wsl
  - developer-tools
---


Beberapa bulan lalu, gue lagi nonton sesi [Dev Tool Time](https://www.youtube.com/watch?v=LA8KF9Fs2sk), narasumbernya **Mitchell Hashimoto** (founder Vagrant, Terraform, Vault).

Di situ Mitchell nunjukin setup developernya yang keren banget: pakai **NixOS di dalam VM**, semua konfigurasinya deklaratif, dan kalau mau rebuild environment cukup jalanin satu perintah. 

Gue mikir, "Wah gila, keren banget. Kalau Mitchell bisa, masa gue nggak?". Akhirnya gue mulai eksperimen sendiri: pasang Nix langsung di WSL Ubuntu, tanpa VM. Gue pikir bakal lebih praktis. Ternyata... malah jadi awal bencana kecil.

## Masalah

Awalnya semua keliatan baik-baik aja. Tapi hari ini 2025-04-29 , tiba-tiba semua command dasar kayak `ls`, `mkdir`, `rm` mulai error. Pesannya aneh banget:

```bash
mkdir: symbol lookup error: /nix/store/.../libc.so.6: undefined symbol: __tunable_is_initialized, version GLIBC_PRIVATE
```

Semua binary standar mati total, bahkan `bash` sendiri error. Sistem WSL gue kayak zombified.

Setelah gue selidiki, ketauan masalahnya: glibc versi baru dari Nix terlalu bleeding edge. Ada perubahan internal symbol yang bikin semua binary yang udah ada langsung crash. Dan karena gue make Nix sebagai base shell, ya udah, kena semua.

Parahnya lagi, file `.vhdx` WSL jadi ke-lock. Mau akses lewat Windows pun nggak bisa. Total disaster.

## Usaha Recovery

Karena dari dalam WSL udah nggak mungkin recovery sih wkwkwk,  satu-satunya jalan dengan melakukan operasi penyelamatan dari luar.

Gue mulai dengan cari file `.vhdx` di:

```
C:\Users\<username>\AppData\Local\Packages\<distro>\LocalState\ext4.vhdx
```

Abis itu gue copy `.vhdx` ke lokasi aman. Butuh waktu lama, karena ukurannya 75GB lebih.

Setelah itu, gue import lagi file itu ke WSL baru:

```bash
wsl --import --vhd recovery-distro D:\wsl-recovery\ D:\ext4-copy.vhdx --version 2
```

Lanjut, gue jalanin:

```bash
wsl -d recovery-distro
```

Akhirnya bisa masuk ke recovery mode. Tapi jangan buru-buru copy semua `/home`, itu malah buang-buang space. Gue cuma backup folder-folder penting buat development aja kayak project directory sama `.ssh`.

Pakai `tar` gini:

```bash
#!/bin/bash
BACKUP_NAME="home-important-$(date +%Y%m%d%H%M%S).tar.gz"
BACKUP_PATH="/mnt/c/Users/<username>/Desktop/$BACKUP_NAME"

echo "\ud83d\udce6 Creating selective backup..."

tar -czvf "$BACKUP_PATH" \
  /home/<username>/folder1 \
  /home/<username>/folder2 \
  /home/<username>/folder3 \
  /home/<username>/.ssh

echo "\u2705 Backup completed: $BACKUP_PATH"
```

Setelah semua data penting aman, gue unregister distro yang rusak:

```bash
wsl --list --verbose
wsl --unregister Ubuntu
wsl --unregister recovery-distro
```

## Refleksi

Kalau dipikir-pikir, gue salah kaprah dari awal.

Mitchell itu pakai Nix di dalam **VM**. Environment dia isolated. Kalau rusak? Ya VM tinggal rebuild.

Gue malah pasang Nix langsung di WSL, ngegantiin tool dasar OS. Begitu `glibc` crash, semua ikut ambruk. Gue juga terlalu optimis sama janji "reproducibility"-nya Nix, padahal kenyataannya. wkwkwkw

> "Nix **aims** for reproducibility, but it does **not guarantee** it."

Kalau mau baca lebih dalem, ini artikelnya:  
[Nix does not guarantee reproducibility](https://cs-syd.eu/posts/2025-03-14-nix-does-not-guarantee-reproducibility)

## Yang Gue Pelajarin

Mulai sekarang, gue bakal pakai Nix cuma buat bikin `devShell`, bukan gantiin shell dasar. Semua environment harus dipisah, entah itu di VM atau container. Nggak bakal lagi install Nix langsung buat ngeganti sistem operasi.

Flake bakal gue setup lebih hati-hati, pin `nixpkgs` ke branch stabil kayak `nixos-23.11`, dan semua yang berhubungan sama core OS bakal gue pisahin.

Backup rutin juga jadi wajib. Kalau perlu gue taro snapshot `.vhdx` mingguan ke external drive.

Dan yang paling penting: jangan percaya bleeding edge glibc.

## Penutup

Belajar dari pengalaman ini, gue sadar: Nix itu powerful gila, tapi kayak reaktor nuklir.

Kalau lo salah pake...  Bisa meledak, untung ya beberapa project itu udah di github sih.

Makanya sekarang, gue tetep pakai Nix, tapi dengan lebih hati-hati. 
Biar keren kayak Mitchell... tanpa harus jungkir balik recovery lagi. wkwkwk