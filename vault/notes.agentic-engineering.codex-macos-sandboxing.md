---
id: notes.agentic-engineering.codex-macos-sandboxing
title: "Codex macOS sandboxing dengan Seatbelt"
desc: "Eksperimen dan konsep sandbox lokal Codex di macOS menggunakan Seatbelt sebagai permission boundary."
updated: 1780042596747
created: 1780041829450
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

## 4. Profile menentukan aturan akses
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

## 17. Kesimpulan praktis
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
