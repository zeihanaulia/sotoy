---
id: ov1jn2bwsgt3mj88r7ddiss
title: Nixos on Windows
desc: ''
updated: 1746161590837
created: 1746161248147
---

## NixOS di WSL — Biar Setup Dev Lo Gak Ribet Tiap Ganti Laptop

Gue udah capek tiap kali pindah laptop atau reinstall sistem harus setup ulang environment satu per satu. Install ini itu, copy config, lupa set env var, dan akhirnya... gak konsisten. Padahal kan pengennya begitu install, semua langsung jalan kaya sebelumnya.

Makanya, gue mutusin buat pindah ke NixOS. Nantinya setup development env gue di wsl atau di MacOS akan sama. Tujuan akhirnya: dev environment yang deklaratif dan reproducible.

---

### Kenapa Gak Cukup Pakai Ubuntu + Nix?

Gue sempet nyobain itu juga. Di WSL Ubuntu, lo bisa install `nix`, terus setup environment lo lewat `nix-env`, `nix profile`, bahkan `home-manager`. Tapi hasilnya agak laen sih wkwkwk, environment lo seolah ditiban di atas Ubuntu. Kernel, systemd, dan banyak hal lain tetap milik Ubuntu. Yang gue dapet cuma `nix`-based package manager, bukan full declarative system.

Dan ya, waktu itu gue juga ngalamin beberapa issue aneh. Salah satunya tentang path resolution di dalam WSL Ubuntu yang bikin environment keacak, terutama kalau lo setup pake `.bashrc`/`.zshrc` terus dijalanin lewat flake. Ada juga masalah PATH yang berantakan karena colokan antara Windows dan Linux. Gue dokumentasiin juga di sini:

👉 [Recovering from a Broken Nix Wsl Setup](https://zeihanaulia.github.io/sotoy/notes/57q7jyz0wff078xaz4s6eea)

Intinya, pendekatan "Ubuntu + Nix" bisa dibilang setengah jalan. Kayak lo pengen declarative, tapi fondasinya tetep mutable. Jadi nantinya setiap mau setup atau instalasi baru cuma bisa lewat declarative config ini. 

---

### Install NixOS di WSL

Pertama, download image `.wsl` dari GitHub release-nya:
→ https://github.com/nix-community/NixOS-WSL/releases

Setelah itu, import ke WSL pake PowerShell:

```powershell
wsl --import NixOS C:\Distros\NixOS .\Downloads\nixos.wsl --version 2
```

- `NixOS` di situ nama instance-nya. Lo bisa namain ini apa pun sih.
- `C:\Distros\NixOS` itu direktori tempat disimpannya data `.ext4`
- file `.wsl` tadi yang udah lo download

Kalau lo mau bikin instance kedua buat testing atau sandbox, tinggal ganti nama dan path:

```powershell
wsl --import NixTest C:\Distros\NixTest .\Downloads\nixos.wsl --version 2
```

Abis itu, lo tinggal masuk:

```bash
wsl -d NixOS
```

Lo bakal disambut dengan shell bash kosong. Gak ada `zsh`, gak ada `nvim`, belum ada flake juga. Tapi ini udah NixOS beneran.

---

### Konfigurasi Awal

Tambahin ini ke `.bashrc` lo supaya fitur flake bisa jalan:

```bash
echo 'export NIX_CONFIG="experimental-features = nix-command flakes"' >> ~/.bashrc
source ~/.bashrc
```

Setelah itu tes apakah environment-nya udah siap:

```bash
nix eval nixpkgs#hello
nix shell nixpkgs#bat
bat --version
```

Kalau semua jalan, berarti base system udah siap. Nix bisa resolve package, download derivation, dan aktifin shell-nya.

---

### Lokasi File Nix

Secara default, Nix nyimpen semua derivation dan build result lo di `/nix/store`. Karena lo lagi di WSL, partisi ini diemount dari file `.ext4` yang lo simpan waktu import tadi.

Misal tadi lo import ke `C:\Distros\NixOS`, maka file ext4-nya ada di situ. Di dalam situ ya semua file yang dibaca Nix.

Menariknya, bahkan kalau lo `ls /nix`, itu cuma symlink ke isi mount. Tapi NixOS-WSL udah handle semua mount-nya otomatis.

---

### Testing Basic Dev Setup

Lo bisa cobain mulai dari command sederhana:

```bash
nix shell nixpkgs#bat
```

Masuk ke shell itu dan jalanin:

```bash
bat --version
```

Kalau jalan, artinya `nixpkgs` lo up to date dan semua udah siap dipake.

---

### What's Next?

Gue udah bikin struktur awal kayak gini:

```
flake.nix
flake.lock
/home/
  zeihanaulia.nix
/modules/
  dev-tools.nix
```

Tujuannya jelas: gue pengen punya satu file `flake.nix` yang bisa dipake buat install semua dev tools, shell config, editor setup, bahkan CLI-CLI kecil yang biasa gue pake tiap hari.

Gue juga rencanain pake `home-manager` supaya semua user config (git, shell, aliases, dll) bisa diatur dari 1 tempat. Tapi itu di langkah berikutnya.

---

### Penutup

Yang penting sekarang, gue udah punya pondasi: WSL + NixOS yang proper, gak half-baked. Gak perlu ribet tiap kali ganti laptop atau setup baru. Semua tinggal pull repo dan `nixos-rebuild`.

Kalau lo juga pengen dev environment yang gak cuma "works on my machine", tapi bisa dibangun ulang dengan satu command, menurut gue ini worth banget dicoba.

Mau lanjut ke bagian flake setup dan home-manager? Gas. Kita bikin sampe lo tinggal `nixos-rebuild switch` dan semuanya siap tempur.
