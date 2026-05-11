---
id: notes.prompt-engineering.hunk-terminal-diff-reviewer
title: "Hunk: review-first terminal diff viewer untuk changeset"
desc: "Catatan tentang Hunk, tool terminal diff review yang lebih fokus pada review changeset daripada sekadar print diff."
updated: 1778467298945
created: 1778467298945
tags:
  - notes
  - prompt-engineering
  - devtools
  - diff
  - terminal
  - jj
  - jujutsu
  - x
  - twitter
---

## Apa itu Hunk?

Gue lihat Hunk sebagai terminal diff viewer yang bukan sekadar `git diff` berwarna.
Hunk lebih mirip **local code review UI untuk changeset**, dengan:

- sidebar file navigation
- multi-file review stream
- split/stack layout
- mouse + keyboard support
- auto-reload/watch mode
- agent/AI annotation workflow

Di dokumentasinya dia menyebut diri sebagai "review-first terminal diff viewer for agent-authored changesets". Itu kena banget: fokusnya bukan tampilan patch, tapi membuat diff terasa seperti sesi review.

## Kenapa Mitchell mengganti diff viewer lain?

Di thread Mitchell dia bilang beberapa hal penting:

- looks good
- speedy
- good keyboard shortcuts
- good mouse support for fallback

Itu bukan pujian default buat tool terminal.
Gue baca sebagai sinyal bahwa dia dapat pengalaman yang lebih mulus ketimbang viewer lain: navigasinya lebih enak, layout-nya tidak bikin kepala pusing, dan dia bisa pakai mouse kalau perlu.

Plus, Hunk memang menjanjikan workflow yang dekat dengan review hasil agent, bukan cuma comparing file.

## Apa itu `jj` / Jujutsu di konteks ini?

`jj` bukan alias diff tool. `jj` adalah Jujutsu: sebuah version control system yang punya command seperti `jj diff`, `jj show`, `jj rebase`, dan lain-lain.

Jujutsu mencoba mengemas ulang UX VCS sambil tetap kompatibel dengan Git. `jj diff` dan `jj show` di thread Hunk artinya orang pengen Hunk bisa dipakai sebagai viewer untuk workflow Jujutsu, bukan cuma Git.

Jadi bagian `JJ` di note ini bukan sekadar integrasi pager. Dia adalah integrasi antara:

- **engine version control** (`jj`/Jujutsu)
- dan **review UI diff** (Hunk)

Itu penting supaya lo ngerti kenapa thread Hunk ada banyak referensi ke `jj`.

## Use case paling cocok buat apa?

Use case Hunk yang paling pas menurut gue:

1. **Review changeset lokal di repo Git**
   - `hunk diff` untuk working tree
   - `hunk show` untuk commit
   - cocok buat pre-commit review dan melihat perubahan multi-file

2. **Review live saat coding**
   - `hunk diff --watch`
   - Hunk auto-reload saat file berubah
   - pas banget buat buka editor di satu terminal dan review di terminal lain

3. **Review patch atau stdin diff**
   - `git diff --no-color | hunk patch -`
   - cocok buat skrip, patch generator, atau output tool lain

4. **Review output agent / AI-generated changes**
   - Hunk punya workflow agent notes
   - bisa pakai `hunk diff` sambil agent bantu anotasi
   - ini sesuai positioning resmi mereka

## Cara pakainya

### Dasar

Install:

```bash
npm i -g hunkdiff
# atau
brew install modem-dev/tap/hunk
```

Jalankan:

```bash
hunk
hunk --version
```

### Review repo Git

```bash
hunk diff
hunk show
hunk show HEAD~1
```

### Live watch mode

```bash
hunk diff --watch
hunk diff before.ts after.ts --watch
```

### Review patch dari pipe

```bash
git diff --no-color | hunk patch -
```

### Integrasi Git pager

Kalau mau pakai Hunk sebagai pager Git:

```bash
git config --global core.pager "hunk pager"
```

Atau alias opt-in:

```bash
git config --global alias.hdiff "-c core.pager=\"hunk pager\" diff"
git config --global alias.hshow "-c core.pager=\"hunk pager\" show"
```

Lalu pakai:

```bash
git hdiff
git hshow
```

### Integrasi Jujutsu (JJ)

Hunk bisa auto-detect JJ workspace dan support `hunk diff [revset]` / `hunk show [revset]`.
Kalau mau paksa VCS:

```toml
# ~/.config/hunk/config.toml
vcs = "jj"
```

Untuk JJ pager:

```toml
[ui]
pager = ["hunk", "pager"]
diff-formatter = ":git"
```

## Limitasi dibanding tool diff lain

Hunk punya keunggulan di sisi review-first UI, tapi bukan pakar structural diff.
Kalau lo butuh AST-aware diff atau syntax-aware structural comparison, tool lain seperti `difftastic` masih lebih tepat.

Beberapa limitasi yang gue tangkap:

- **bukan structural diff tool** seperti difftastic
- **UI review lebih penting daripada algoritma diff**
- integrasi JJ dulu sempat agak kurang jelas, meski sekarang dokumentasinya sudah mendingan

## Kesimpulan

Hunk paling kuat kalau lo mau memposisikan changeset sebagai objek review, bukan cuma text patch.
Kalau workflow lo butuh:

- navigasi file cepat,
- preview diff multi-file,
- live watch mode,
- keyboard + mouse terminal UI,
- dan review hasil AI/agent,

maka Hunk bisa jadi tool yang benar-benar menggantikan `git diff` biasa.

Kalau lo cuma butuh structural syntax diff, mungkin Hunk bukan tool utama.
