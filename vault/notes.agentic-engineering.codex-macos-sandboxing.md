---
id: notes.agentic-engineering.codex-macos-sandboxing
title: "Codex macOS sandboxing dengan Seatbelt"
desc: "Eksperimen dan konsep sandbox lokal Codex di macOS menggunakan Seatbelt sebagai permission boundary."
updated: 1780044560196
created: 1780041862880
tags:
  - notes
  - security
  - codex
  - sandboxing
  - macos
source:
  - https://developers.openai.com/codex/concepts/sandboxing
---

## Ringkasan utama
Sandbox Codex lokal di macOS bukan container atau VM. Ia adalah permission boundary yang dijalankan oleh OS. Proses tetap jalan di mesin lokal, tapi aksesnya dikontrol oleh Seatbelt lewat `sandbox-exec` dan sandbox profile.

## 1. Proses tetap lokal, batasannya yang beda
Dalam eksperimen kita, Codex menjalankan command di mesin sendiri. Tidak ada mesin remote, tidak ada container Linux terpisah. Perbedaannya adalah command tersebut dibungkus dengan profile sandbox, lalu macOS Seatbelt mengecek setiap akses.

Jadi alur dasarnya adalah:

- Codex ingin menjalankan command.
- Command dijalankan melalui `sandbox-exec` dengan profile tertentu.
- Seatbelt memutuskan apakah akses diperbolehkan.
- Kalau tidak, muncul `Operation not permitted`.

Artinya sandbox lebih mirip pagar di sekitar proses, bukan ruang terpisah.

## 2. Seatbelt sebagai layer tambahan di atas Unix permission
Seatbelt bukanlah sistem file. Ia adalah mekanisme tambahan di OS yang mengevaluasi permintaan proses.

Kalau dilihat dari perspektif akses:

- Unix/macOS permission mengecek apakah user boleh mengakses file.
- Seatbelt mengecek apakah proses dengan profile ini boleh mengakses file.

Dalam eksperimen, proses yang sandboxed bisa ditolak membaca file yang sebenarnya bisa diakses oleh user normal. Itu contoh nyata batasan dua lapis.

## 3. `sandbox-exec` dan profile
`sandbox-exec` adalah wrapper CLI yang menjalankan command dengan profile sandbox. Format dasarnya:

```bash
sandbox-exec -f profile.sb command args
```

Atau langsung lewat `-p` dengan profile inline. Contoh yang berhasil:

```bash
sandbox-exec -p '(version 1) (allow default)' /bin/echo ok
```

Itu menunjukkan sandbox aktif dan bisa menjalankan command sederhana.

## 4. Codex local di macOS generate policy runtime, bukan nulis `.sb`
Yang penting dipahami: Codex lokal biasanya tidak membuat file `.sb` permanen untuk user. Ia mengonversi config seperti `sandbox_mode`, `writable_roots`, `network_access`, dan `shell_environment_policy` menjadi model permission internal.

Di source Codex, `seatbelt.rs` include template SBPL bawaan seperti `seatbelt_base_policy.sbpl` dan `seatbelt_network_policy.sbpl`. Lalu runtime Codex menyusun `full_policy` sebagai string, dan memanggil `/usr/bin/sandbox-exec -p "..." -- <command>`. Artinya aturan sandbox dikirim langsung lewat argumen `-p`, bukan disimpan sebagai file user-visible.

Jadi `~/.codex/config.toml` adalah tempat kita mengatur intent. `sandbox_mode` dan `writable_roots` menjadi rules yang di-render ke SBPL di memori, sementara user tidak perlu edit `.sb` langsung.

## 5. Profile menentukan aturan akses
Profile Seatbelt ditulis dengan S-expression. Contoh paling longgar:

```lisp
(version 1)

(allow default)
```

Kalau kita tambahkan deny untuk folder tertentu, aturan berubah jadi:

```lisp
(allow default)

(deny file-read*
  (subpath "$HOME/codex-sandbox-lab/outside"))

(deny file-write*
  (subpath "$HOME/codex-sandbox-lab/outside"))
```

Dengan model blacklist seperti ini, semua boleh kecuali satu folder.

## 5. Blacklist vs whitelist
Model blacklist mudah dipakai untuk eksperimen, tapi tetap longgar. Contohnya ketika profile hanya menolak `outside`, shell masih bisa melihat isi `$HOME` karena `allow default` masih aktif.

Model whitelist yang lebih ketat adalah:

- deny semua akses ke `$HOME`
- allow baca/tulis workspace
- allow baca folder script yang diperlukan

Dengan model ini, perintah `ls "$HOME"` gagal, tetapi `cat workspace/app.txt` berhasil.

Itu lebih mendekati pola Codex `workspace-write`.

## 6. `deny default` terlalu brutal untuk macOS modern
Kita mencoba `deny default` lalu mengizinkan proses dan path penting. Hasilnya profile abort.

Maknanya: proses yang kelihatannya sederhana masih butuh banyak akses implisit seperti dynamic loader, metadata, locale, atau mach service. Jadi:

- `deny default` lebih aman secara prinsip,
- tapi sulit stabil di praktik.

Praktik yang lebih realistis adalah `allow default + deny spesifik` atau `deny HOME + allow workspace`.

## 7. Current working directory perlu diperhatikan
Sandbox mempengaruhi `getcwd()` saat shell start. Kalau profile menutup `$HOME` sementara current directory berada di path yang tidak diizinkan, shell bisa gagal dengan pesan:

```text
shell-init: error retrieving current directory: getcwd: cannot access parent directories: Operation not permitted
```

Solusinya adalah menjalankan sandbox dari dalam workspace yang diizinkan.

## 8. Batasan utama sandbox
Eksperimen malicious script menunjukkan:

- baca workspace → berhasil
- baca outside secret → ditolak
- tulis workspace → berhasil
- tulis outside secret → ditolak

Itu menegaskan bahwa sandbox bisa menahan akses keluar boundary. Tapi ia tidak membedakan apakah perubahan di dalam workspace baik atau jahat.

## 9. Workspace writable bukan berarti aman
Kalau workspace diizinkan tulis, setiap skrip jahat yang ada di dalamnya bisa melakukan perubahan berbahaya seperti `rm -rf ./src` atau menyisipkan backdoor ke `package.json`.

Sandbox hanya menjawab pertanyaan “proses boleh ke mana?”, bukan “apakah proses ini niatnya baik?”.

Jadi kontrol tambahan tetap perlu:

- `git diff`
- `git status`
- review perubahan
- rollback jika perlu

## 10. Network deny bisa mengurangi eksfiltrasi
Kita juga tes profile yang menolak `network*`. Hasilnya `curl` jadi gagal resolve host.

Itu efektif untuk menghalangi dependency jahat yang mencoba mengirim data keluar. Tapi efeknya hanya berlaku jika network memang diblokir oleh profile.

## 11. Workaround: jangan mulai Codex dari shell yang sudah punya secret
Masalahnya bukan Seatbelt menyensor env. Masalahnya secret sudah ikut naik ke proses dari parent shell. Sandbox membatasi file dan network, tapi environment variable itu seperti kertas yang sudah dikasih ke proses sejak lahir. Kalau proses sudah memegang kertas itu, Seatbelt tidak otomatis menariknya kembali.

Workaround paling simpel adalah jalankan Codex dari environment bersih:

```bash
env -i \
  HOME="$HOME" \
  PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" \
  SHELL="$SHELL" \
  TERM="$TERM" \
  codex
```

Dengan `env -i`, proses dimulai tanpa variabel environment dari shell lama. Hanya variabel yang kita set ulang yang akan ikut.

Kalau mau masuk ke folder project dulu:

```bash
cd /path/to/project

env -i \
  HOME="$HOME" \
  PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" \
  SHELL="$SHELL" \
  TERM="$TERM" \
  codex
```

Ini mencegah variabel seperti `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `OPENAI_API_KEY`, `GITHUB_TOKEN`, `NPM_TOKEN`, atau `DATABASE_URL` ikut dibawa, kecuali sengaja dimasukkan lagi.

## 12. Setup Codex CLI lokal di `~/.codex/config.toml`
Untuk membuat perilaku Codex mirip eksperimen `sandbox-exec`, gue menyarankan konfigurasi user-level ini:

```toml
# ~/.codex/config.toml

sandbox_mode = "workspace-write"
approval_policy = "on-request"
approvals_reviewer = "user"

[sandbox_workspace_write]
network_access = false
writable_roots = []
exclude_tmpdir_env_var = true
exclude_slash_tmp = true

[shell_environment_policy]
inherit = "core"
ignore_default_excludes = false
exclude = [
  "*KEY*",
  "*TOKEN*",
  "*SECRET*",
  "*PASSWORD*",
  "*CREDENTIAL*",
  "AWS_*",
  "OPENAI_API_KEY",
  "GITHUB_TOKEN",
  "GH_TOKEN",
  "NPM_TOKEN",
  "DATABASE_URL",
  "PGPASSWORD"
]
include_only = []
set = {}
```

Konsepnya:

- `sandbox_mode = "workspace-write"` berarti Codex boleh baca/tulis workspace, bukan filesystem bebas.
- `approval_policy = "on-request"` berarti kalau butuh network atau akses di luar boundary, Codex harus minta izin.
- `inherit = "core"` membuat Codex hanya membawa variabel inti yang normal, bukan secret shell.
- `exclude` menolak glob env sensitif supaya secret env tidak ikut ke proses yang spawn dari Codex.

## 13. Kalau repo asing, lebih ketat dengan `inherit = "none"`
Untuk repo yang benar-benar tidak dipercaya, upgrade env policy menjadi lebih mirip `env -i`:

```toml
[shell_environment_policy]
inherit = "none"
ignore_default_excludes = false
include_only = [
  "HOME",
  "USER",
  "LOGNAME",
  "PATH",
  "SHELL",
  "TERM",
  "TMPDIR"
]
exclude = [
  "*KEY*",
  "*TOKEN*",
  "*SECRET*",
  "*PASSWORD*",
  "*CREDENTIAL*",
  "AWS_*",
  "OPENAI_API_KEY",
  "GITHUB_TOKEN",
  "GH_TOKEN",
  "NPM_TOKEN",
  "DATABASE_URL",
  "PGPASSWORD"
]
set = {}
```

Ini akan memaksa Codex spawn process dengan env yang jauh lebih kecil, tapi bisa juga bikin beberapa tool dev gagal. Kalau perlu, tambahkan env spesifik satu per satu.

## 14. Wrapper `codex-safe` tetap berguna
Meski sudah ada config, wrapper adalah pagar awal yang mencegah proses Codex sendiri lahir dari shell penuh secret.

Di `~/.zshrc`:

```bash
codex-safe() {
  env -i \
    HOME="$HOME" \
    USER="$USER" \
    LOGNAME="$LOGNAME" \
    PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" \
    SHELL="${SHELL:-/bin/zsh}" \
    TERM="${TERM:-xterm-256color}" \
    TMPDIR="${TMPDIR:-/tmp}" \
    codex --sandbox workspace-write --ask-for-approval on-request "$@"
}
```

Ini membuat dua layer:

- `codex-safe`: menghindari secret dari shell induk.
- `shell_environment_policy`: menghindari secret dari process yang Codex spawn.

## 15. Setup per-project hanya untuk root tambahan yang benar-benar perlu
Kalau repo perlu nulis ke sibling path, gunakan `.codex/config.toml` di project bukan `danger-full-access`.

Contohnya:

```toml
sandbox_mode = "workspace-write"
approval_policy = "on-request"

[sandbox_workspace_write]
network_access = false
writable_roots = [
  "/Users/zeihanaulia/workspace/shared-lib"
]
```

Catatan penting: project `.codex/config.toml` hanya boleh dipercaya kalau repo itu memang dipercaya; kalau repo tidak dipercaya, Codex bisa skip project-scoped config.

## 16. Verifikasi dan jangan pakai opsi berbahaya sebagai default
Setelah konfigurasi, tes dari dalam Codex:

```bash
env | grep -Ei 'key|token|secret|password|credential|aws|openai|github|npm|database'
pwd
ls .
ls "$HOME"
curl -I https://example.com
```

Ekspektasinya: env sensitif hilang, workspace bisa diakses, akses `HOME` dibatasi, dan network gagal atau butuh approval.

Hindari default berbahaya seperti:

```toml
sandbox_mode = "danger-full-access"
approval_policy = "never"
```

Atau env policy seperti:

```toml
inherit = "all"
ignore_default_excludes = true
```

## 17. Global vs per repo/project config
Codex lokal punya beberapa layer konfigurasi: global/user config, profile config, dan per-project config. Jangan anggap ini sebagai config yang sama; ini adalah hierarchy trust.

Global config di `~/.codex/config.toml` harus jadi sabuk pengaman default: baseline aman untuk semua repo. Contoh yang aman:

```toml
sandbox_mode = "workspace-write"
approval_policy = "on-request"
approvals_reviewer = "user"

[sandbox_workspace_write]
network_access = false
writable_roots = []

[shell_environment_policy]
inherit = "core"
ignore_default_excludes = false
exclude = [
  "*KEY*",
  "*TOKEN*",
  "*SECRET*",
  "*PASSWORD*",
  "*CREDENTIAL*",
  "AWS_*",
  "OPENAI_API_KEY",
  "GITHUB_TOKEN",
  "GH_TOKEN",
  "NPM_TOKEN",
  "DATABASE_URL",
  "PGPASSWORD"
]
```

Per-project config di `.codex/config.toml` adalah izin kerja khusus untuk repo tertentu. Gunakan hanya ketika repo itu dipercaya dan butuh exception yang jelas, misalnya writable root tambahan:

```toml
sandbox_mode = "workspace-write"
approval_policy = "on-request"

[sandbox_workspace_write]
network_access = false
writable_roots = [
  "/Users/zeihanaulia/workspace/shared-lib"
]
```

Profile config di `~/.codex/.config.toml` atau `~/.codex/paranoid.config.toml` cocok untuk mode kerja yang berbeda tanpa memodifikasi setiap repo. Misalnya profile `paranoid` untuk repo asing:

```toml
sandbox_mode = "read-only"
approval_policy = "untrusted"

[shell_environment_policy]
inherit = "none"
include_only = ["HOME", "USER", "LOGNAME", "PATH", "SHELL", "TERM", "TMPDIR"]
```

CLI flags paling tinggi prioritas. Pakai `--sandbox`, `--ask-for-approval`, atau `-c` untuk override sementara pada satu session.

Intinya:

- global = baseline aman
- per-project = exception spesifik untuk repo yang dipercaya
- profile = mode kerja yang berbeda
- CLI flag = override sekali jalan

Kalau global terlalu longgar, semua repo ikut longgar. Kalau per-project terlalu dipercaya, repo jahat bisa mencoba mengubah cara Codex bekerja. Itu kenapa project config harus ditaruh hanya untuk trusted repos dan kenapa Codex skip `.codex/` di project yang untrusted.

## 18. Kesimpulan praktis
Untuk Codex lokal di macOS, model aman yang masuk akal adalah:

- gunakan `workspace-write`, bukan `danger-full-access`
- pakai approval policy `on-request`
- jangan izinkan network sembarangan
- jangan jalankan dari shell yang penuh secret env
- selalu cek `git diff`
- untuk repo asing atau mencurigakan, pakai container/VM/remote sandbox

Untuk repo cukup dipercaya, sandbox lokal bisa nyaman dan meminimalkan risiko akses luar workspace.

## 13. Inti kepercayaan yang sehat
Yang paling benar dipahami adalah:

- sandbox membatasi akses,
- approval membatasi eskalasi,
- git diff membatasi perubahan diam-diam,
- env hygiene membatasi kebocoran token,
- container/VM membatasi risiko untuk kode yang tidak dipercaya.

Sandbox adalah blast-radius reducer, bukan jaminan selesai.
