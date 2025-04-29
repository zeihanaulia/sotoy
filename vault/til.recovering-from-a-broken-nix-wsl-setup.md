---
id: 57q7jyz0wff078xaz4s6eea
title: Recovering from a Broken Nix Wsl Setup
desc: 'Nix, WSL, Recovery, Mitchell Hashimoto Inspiration'
updated: 1745898940355
created: 1745898582297
tags: [nix, wsl, developer-tools]
---

## How It Started

Beberapa bulan lalu, gue nonton sesi [Dev Tool Time](https://www.youtube.com/watch?v=LA8KF9Fs2sk) narasumbernya **Mitchell Hashimoto** (founder Vagrant, Terraform, Vault).

Di situ Mitchell menunjukkan setup developernya:  
- Menggunakan **NixOS di dalam VM**.
- Semua konfigurasi deklaratif.
- Bisa rebuilding environment hanya dengan 1 perintah.

Kalau Mitchell bisa punya environment yang **reproducible**, **stabil**, dan **independent**, kenapa gue tidak?

Akhirnya gue mencoba membawa konsep itu ke komputer gue sendiri — **tapi tidak lewat VM**.  
gue install Nix langsung di **WSL Ubuntu**.

Dan di situlah petualangan (dan tragedi kecil) ini bermula.

## The Incident

Beberapa waktu setelah setup berjalan, tiba-tiba semua command dasar mulai error:

```bash
mkdir: symbol lookup error: /nix/store/.../libc.so.6: undefined symbol: __tunable_is_initialized, version GLIBC_PRIVATE
```
Bahkan `ls`, `mkdir`, `rm`, sampai `bash` pun tidak bisa dipakai.

**Seluruh sistem WSL rusak total.**

Kenapa?  
Ternyata:
- `glibc` yang dipakai Nix (`2.40-36`) terlalu bleeding edge.
- Ada perubahan internal symbol `__tunable_is_initialized` yang menyebabkan semua binary tua crash.
- Karena gue jadikan Nix "basis shell", semua dependency utama (`coreutils`, `bash`, `nix`) rusak juga.
- WSL `.vhdx` file terkunci karena error runtime.

## The Recovery Plan

Karena `bash`, `rm`, bahkan `ls` pun error, opsi recovery di dalam WSL sudah tidak mungkin.

**Strategi penyelamatan:**
1. Temukan file `.vhdx` WSL:
   ```
   C:\Users\<username>\AppData\Local\Packages\<distro>\LocalState\ext4.vhdx
   ```
2. Copy file `.vhdx` ke lokasi aman (karena file ini 75GB, proses copy memakan waktu lama).
3. Import `.vhdx` ke WSL baru menggunakan perintah:
   ```bash
   wsl --import --vhd recovery-distro D:\wsl-recovery\ D:\ext4-copy.vhdx --version 2
   ```
4. Masuk ke WSL recovery:
   ```bash
   wsl -d recovery-distro
   ```
5. Backup semua data penting (`/home`, `/etc`, dll) ke Windows:
   ```bash
   tar czvf /mnt/c/Users/<username>/Desktop/home-backup.tar.gz /home
   ```
6. Setelah yakin semua data aman, **hapus semua distro rusak**:
   ```bash
   wsl --list --verbose
   wsl --unregister Ubuntu
   wsl --unregister recovery-distro
   ```

## Reflection: What Went Wrong

- **Mitchell Hashimoto menggunakan Nix di dalam VM**, bukan langsung di host/WSL environment.
- **Nix seharusnya menjadi isolated dev environment**, bukan menggantikan core OS userland.
- Kalau satu library penting (`glibc`) rusak, semua dependency hancur — dan recovery sangat sulit.

gue terlalu cepat mengadopsi "reproducibility" impian dari Nix, tanpa memahami bahwa:
> "Nix **aims** for reproducibility, but it does **not guarantee** it."

Referensi penting:  
[Nix does not guarantee reproducibility](https://cs-syd.eu/posts/2025-03-14-nix-does-not-guarantee-reproducibility)


## 📚 Lessons Learned

| What I Should Keep Doing | What I Should Avoid |
|:---|:---|
| Gunakan Nix untuk `devShell`, bukan sebagai base shell. | Jangan replace core OS tools (`ls`, `bash`, `glibc`) dengan Nix-managed versions di WSL. |
| Isolasi environment di dalam VM atau container. | Jangan terlalu cepat trust bleeding edge glibc dari Nixpkgs unstable. |
| Pin `nixpkgs` version di `flake.nix` ke branch stabil (`nixos-23.11`). | Jangan host semua production environment di dalam Nix unstable tanpa backup. |
| Setup periodic backup `.vhdx` dan config ke Git. | Jangan lupa betapa sulitnya recovery kalau root filesystem rusak. |


## Next Steps

- Refactor project ke pure `nix develop` + `devShell` model.
- Bikin `flake.nix` yang modular dan aman.
- Pindahkan semua dependency ke `shell.nix` berbasis flake.
- Gunakan VM untuk isolasi environment (mengikuti cara Mitchell).
- Tambahkan recovery fallback (`busybox`, `bashStatic`, `coreutils`) di luar Nix.


> "Nix is amazing, but like a nuclear reactor,  
> you don’t use it to toast your bread."

