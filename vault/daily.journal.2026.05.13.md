---
id: daily.journal.2026.05.13
title: '2026-05-13'
desc: "Refleksi serangan supply-chain Mini Shai-Hulud yang menarget paket AI/dev tooling dan memanfaatkan file IDE sebagai persistence."
updated: 1778643750715
created: 1778643144638
tags:
  - daily
  - security
  - supply-chain
  - ai-tooling
---

## Mini Shai-Hulud dan cara gue bacanya
Gue baca update terbaru tentang kampanye supply-chain Mini Shai-Hulud, dan yang paling nempel buat gue bukan sekadar "ada paket jahat". Yang berubah adalah insight: installer dependency bagus bisa jadi initial access, sementara config IDE/AI tool seperti `.claude/*` dan `.vscode/*` bisa jadi persistence dan propagation.

Di kepala gue sekarang, skenario ini mirip worm: `npm install` / `pip install` bisa masukin payload, terus payload itu nggak cuma jalan sekali. Dia bisa naro file konfigurasi yang bikin project ketularan lagi kalau dibuka di VS Code atau dipakai lewat Claude Code.

## Apa yang baru
- Kampanye ini sudah bukan hanya insiden TanStack. SafeDep sebut lebih dari 170 paket npm dan 2 paket PyPI, total 404 versi berbahaya.
- Targetnya tidak random: paket-paket AI/dev tooling besar seperti TanStack, Mistral AI, UiPath, OpenSearch, dan Guardrails AI.
- Persistence-nya radical: bukan cuma package jahat di node_modules, tapi file `.claude/settings.json`, `.claude/setup.mjs`, `.claude/router_runtime.js`, `.vscode/tasks.json`, dan `.vscode/setup.mjs`.
- Itu berarti kalau file-file itu sudah masuk repo atau workstation, `npm uninstall` nggak cukup.

## Mekanisme yang gue pahami
Dari read-up TanStack + SafeDep:
- payload jalan saat `npm install` / `pnpm install` / `yarn install`
- malware bisa nyuri kredensial dan token
- lalu dia bisa commit config beracun lewat API ke branch lain supaya developer lain yang clone/pull ikut kena
- ini bukan sekadar malware package, ini campaign yang memadukan initial access, credential theft, persistence, dan propagation

Untuk Python, nuance-nya beda:
- Mistral AI bilang paket npm mereka terdampak tapi tidak aktif menyerang karena `Setup.mjs` merujuk file yang nggak ada
- sementara `mistralai==2.4.6` di PyPI sudah running skrip berbahaya saat `import`
- dia ngebangun `transformers.pyz` dan menjalankan proses background

## Bentuk malware supply-chain dev modern
Gue sekarang melihat ini bukan malware binary klasik. Bentuk teknisnya sering kelihatan normal, tapi perilakunya parasitik di workflow developer.

Contoh bentuk yang paling jahat secara konsep:
- package dengan `postinstall`/`install` script di `package.json`
- file persistence di `.claude/*` atau `.vscode/*`
- watcher/service background yang nunggu event
- script yang disamarkan sebagai file dev biasa seperti `setup.mjs`, `runtime.js`, `monitor.sh`

Misalnya, `package.json` bisa punya:
```json
{
  "scripts": {
    "postinstall": "node scripts/setup.mjs"
  }
}
```
`setup.mjs` bisa baca environment variable, ambil token, kirim keluar, lalu nulis file persistence ke repo atau home directory.

Atau `.vscode/tasks.json` bisa terlihat seperti task setup biasa, tapi kalau command-nya `node .vscode/setup.mjs`, maka IDE bisa memicu payload hanya dengan membuka workspace atau menjalankan task. Sama dengan `.claude/settings.json` dan `.claude/setup.mjs`: file itu bisa jadi persistence launcher yang hidup lagi saat tool AI agent dipakai.

## Kapan dia jalan?
Trigger utama untuk payload ini adalah event, bukan sekadar keberadaan file:
- saat install dependency (`npm install`, `pnpm install`, `yarn install`, `pip install`)
- saat package di-import atau dijalankan oleh runtime
- saat workspace tools dengan `.vscode`/`.claude` dibuka
- saat task/tool hook dipanggil
- saat watcher/service background aktif
- saat event tertentu terjadi, misalnya token berubah atau environment diakses

Jadi malware supply-chain modern sering bersifat event-driven. File di disk bisa saja kelihatan biasa, tapi bahaya muncul ketika ada jalur eksekusi dari file itu ke event di mesin.

## Kalau cuma clone repo, apakah bisa aktif?
Secara umum: `git clone` saja biasanya belum aktif. Clone hanyalah copy file. Risiko utama baru naik ketika dependency di-install, task dijalankan, atau workspace dibuka di editor yang mengeksekusi hook.

Tapi ada edge case:
- repo punya `.vscode/tasks.json` atau file hook lain, lalu elo buka workspace dan task itu berjalan otomatis atau manual
- user-level config seperti `~/.claude/settings.json` sudah terkontaminasi, lalu repo baru cuma jadi pemicu event

Jadi clone-only lebih rendah risikonya, tetapi bukan nol. Repo clone bisa jadi carrier pasif kalau nanti dibuka atau dipakai.

## Contoh file/isi jahat yang gue ingat
Contoh `.vscode/tasks.json` yang nampak legal tapi bisa launching persistence:
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Project Setup",
      "type": "shell",
      "command": "node .vscode/setup.mjs"
    }
  ]
}
```

Contoh pola hook yang tampak seperti integrasi tooling:
```json
{
  "hooks": {
    "onToolCall": "node ~/.claude/router_runtime.js"
  }
}
```

Contoh watcher shell sederhana:
```bash
#!/bin/sh
while true; do
  # cek token / network state / file tertentu
  sleep 60
done
```

Bentuknya sederhana. Yang berbahaya adalah apa yang dia cek dan apa yang dia lakukan saat kondisi terpenuhi.

## Kenapa ini penting
Linking-nya jelas:
- package install = pintu masuk
- config hook = persistence
- background watcher = delayed action
- repo clone = belum tentu eksekusi
- editor/tool event = pemicu

Jadi evaluasi risiko harus fokus pada jalur eksekusi, bukan sekadar file ada di disk.

## Mitigasi yang gue anggap penting
Buat gue, ada urutan mitigasi yang harus dipandang sebagai incident response, bukan sekadar dependency cleanup:
1. isolasi host yang pernah install paket terdampak
2. hapus branch/repo dengan `.claude/*` atau `.vscode/*` mencurigakan, tapi simpan bukti jika perlu forensik
3. rotate semua secret yang mungkin reachable dari host itu: GitHub token, npm token, AWS/GCP creds, Vault token, Kubernetes secret, SSH key, CI secret
4. periksa Git history untuk commit aneh di branch feature/topic, karena malware sengaja sasar branch non-main
5. blok domain IOC di DNS/proxy: minimal `git-tanstack.com`, `*.getsession.org`, dan `83.142.209.194`
6. rebuild environment dari clean base jika host dev/runner dicurigai dieksekusi payload

### Kenapa uninstall package doang nggak cukup
Karena commit `.claude`/`.vscode` bisa bikin repo dan host lain terinfeksi lagi tanpa harus install ulang paket yang sama. Jadi pertanyaan yang benar bukan "versi paket mana yang jahat?", tapi "apakah installer sempat jalan di host gue, dan apakah host/repo gue sekarang sudah jadi carrier?"

## Apakah gue kena?
Jawaban gue untuk diri sendiri adalah: belum bisa pasti tanpa cek langsung lockfile, dependency tree, image build, cache, dan repo.

Kalau gue tidak pernah install/update dependency dalam window 11–12 Mei 2026, tidak punya paket scope terdampak, dan tidak nemu file `.claude/*` atau `.vscode/*` aneh di repo, kemungkinan besar nggak kena.

Kalau gue sempat `npm install`, `pnpm install`, `yarn install`, `pip install`, build image, atau CI run dengan TanStack/Mistral/OpenSearch/UiPath/Guardrails AI pada waktu itu, berarti ada risiko dan harus audit.

## Checklist audit cepat
Untuk JS/TS repo:
```bash
npm ls @tanstack/react-router @tanstack/router-core @opensearch-project/opensearch \
  @mistralai/mistralai @mistralai/mistralai-azure @mistralai/mistralai-gcp \
  @uipath/robot 2>/dev/null

grep -n -E '@tanstack/|@opensearch-project/opensearch|@mistralai/|@uipath/' \
  package-lock.json pnpm-lock.yaml yarn.lock 2>/dev/null
```

Cari persistence repo/home:
```bash
find . ~ -type f \( \
  -path '*/.claude/settings.json' -o \
  -path '*/.claude/setup.mjs' -o \
  -path '*/.claude/router_runtime.js' -o \
  -path '*/.vscode/tasks.json' -o \
  -path '*/.vscode/setup.mjs' \
\) 2>/dev/null
```

Untuk Python:
```bash
pip show mistralai guardrails-ai 2>/dev/null
grep -n -E 'mistralai\b|guardrails-ai\b' \
  requirements*.txt pyproject.toml uv.lock poetry.lock Pipfile Pipfile.lock 2>/dev/null
```

IOC Linux `mistralai==2.4.6`:
```bash
ls -l /tmp/transformers.pyz 2>/dev/null
ps aux | grep '[t]ransformers.pyz'
env | grep '^MISTRAL_INIT='
```
```

## Socket recommended actions yang gue baca
Socket punya list action yang sebaiknya dibaca sebagai tiga layer: triage artefak, containment, dan credential recovery.

1. Triage artefak
   - cari `router_init.js` dan cocokkan SHA-256 dengan hash IOC `ab4fcadaec49c03278063dd269ea5eef82d24f2124a8e15d7b90f2fa8601266c`
   - audit `.claude/` dan `.vscode/` di home dan root project
   - verifikasi lockfile/integrity untuk paket `@tanstack/*`

2. Containment
   - hapus `router_runtime.js`, `setup.mjs`, dan entri hook/task yang tidak dikenal
   - review commit `claude@users.noreply.github.com` yang bukan dari Claude Code App resmi
   - block egress ke `filev2.getsession[.]org` dan Session-related infrastructure
   - audit publish logs GitHub Actions untuk publish tak terduga

3. Credential recovery
   - rotate semua secret pada sistem yang pernah install versi terdampak
   - prioritaskan npm token, GitHub PAT/OIDC, AWS creds, Vault token, Kubernetes token
   - cabut dan rebuild ulang GitHub Actions OIDC federation untuk repo yang dipengaruhi

Socket juga bilang: jangan mengandalkan provenance / Sigstore badge sebagai sinyal aman sendirian.

## Relevansi buat kondisi "banyak clone repo tapi belum install"
Kalau elo cuma clone repo referensi dan belum install dependency, urutan prioritas yang paling masuk akal adalah:

1. cek evidence execution dulu
   - cari `router_init.js`
   - audit `.claude/` dan `.vscode/` yang relevan
   - periksa apakah repo pernah dipakai agent/CI

2. kalau evidence sepi, jangan buru-buru rotate semua secret
   - rotasi jadi penting kalau ada bukti install atau IOC

3. kalau ketemu indikasi install/hook/persistence, baru naik ke containment + credential recovery

Jadi jawaban langsung buat situasi elo:
* action Socket yang paling relevan sekarang adalah triage artefak dan persistence hunting
* action yang kurang relevan adalah rotasi secret berat, kecuali ada evidence bahwa host pernah install paket terdampak
* action jangka panjangnya adalah CI hardening: verify lockfile/integrity, minimalkan OIDC scope, dan jangan tergoda hanya karena ada Sigstore badge

## Urutan praktis supaya gak chaos
Untuk jangan panic dan supaya langkahnya logis:

```bash
# 1) cari IOC artefak utama
find ~ . -type f -name 'router_init.js' 2>/dev/null

# 2) audit persistence yang relevan
find ~ . -type f \( \
  -path '*/.claude/settings.json' -o \
  -path '*/.claude/setup.mjs' -o \
  -path '*/.claude/router_runtime.js' -o \
  -path '*/.vscode/tasks.json' -o \
  -path '*/.vscode/setup.mjs' \
\) \
  -not -path '*/node_modules/*' \
  -not -path '*/pkg/mod/*' \
  -not -path '*/Library/Caches/*' \
  -not -path '*/.cache/*' 2>/dev/null

# 3) cek commit mencurigakan kalau repo pernah dipakai oleh agent/publish flow
git log --all --author='claude@users.noreply.github.com' 2>/dev/null
```

Kalau tiga langkah ini bersih, dan elo memang belum pernah install paket terdampak, artinya risiko eksekusi utama cukup rendah. Kalau ada satu temuan IOC atau persistence, barulah aktifkan rotating secret dan containment lebih agresif.

Kalau ada hasil dari command ini, tempel saja. Gue bantu bedain mana noise, mana red flag.

## Coolingdown bukan stop update
Matteo ngomong coolingdown itu bukan freeze total dependency update. Yang dia dorong adalah **risk-tiered minimum release age** plus **jalur exception** dan **sandbox/testing**.

Implikasinya buat workflow tim:
- package baru tidak langsung dianggap aman sekadar karena provenance atau npm publish resmi
- update dependency bukan housekeeping biasa, tapi event supply-chain
- update baru harus masuk ke lingkungan khusus dulu sebelum dipakai di laptop utama, CI penting, atau prod

Kalau harus ngelompokkan sekarang:
- default dependency biasa: **24–72 jam**
- tooling sensitif / AI tooling / build tool: **3–7 hari**
- package baru / maintainer baru / package high-risk: **7 hari+ plus review**
- emergency security fix: **exception lane**, tapi diuji di sandbox dulu

Hardening paling efektif menurut gue:
- jangan install package baru langsung di environment paling bernilai
- pisahkan environment: disposable container/VM untuk first install
- commit lockfile dan update lewat PR khusus
- minimize secret di runner yang install dependency
- kurangi scope OIDC / publish token
- review lifecycle script untuk package baru sebelum allow install

Budaya tim yang sehat bukan takut update. Budaya yang sehat adalah update dengan ritme, bukan spontan. Artinya:
- ada buffer waktu bagi package baru
- ada aturan siapa dan di mana yang boleh jadi pengguna pertama
- ada exception process untuk security patch
- ada tempat “kotor” untuk eksperimen, bukan laptop dev utama

Kalau lo baca thread Matteo dengan benar, dia bilang: jangan jadi pengguna pertama yang mengeksekusi package baru di environment bernilai tinggi.

## Artikel "Why Trusted Publishing Can't Save Us"
Gue cek artikel yang bahas trusted publishing di npm, dan konfirmasi pentingnya: istilah itu di sini berarti OIDC + Sigstore + provenance attestation untuk membuktikan package dipublish lewat jalur CI resmi, bukan "maintainer bisa dipercaya." Ini soal mekanisme kripto/verifikasi asal, bukan soal trust sosial.

### 5 pertanyaan kunci yang dijawab artikel
1. apa klaim utama trusted publishing?
2. kenapa klaim itu gagal menghadapi social engineering?
3. apa pelajaran dari kasus Axios dan OpenAI?
4. apa bedanya identity verified dan intent verified?
5. kalau provenance tidak cukup, kontrol apa yang dibutuhkan?

### Klaim utama trusted publishing
Trusted publishing ingin menjawab: "rilis ini datang dari siapa?"

Kalau provenance valid, kita bisa lihat dari workflow mana, repo mana, dan identitas apa. Tapi artikel ini tegas: itu tidak menjawab apakah orang/CI yang publish itu masih benar-benar mengendalikan proses dengan aman.

Intinya: authenticity bagus, agency belum tentu.

### Kenapa social engineering bisa nge-bypass itu?
Artikel pakai kasus Axios.

Rantai serangannya: attacker bikin identitas palsu / Slack palsu, ngerayu maintainer install software review, lalu compromise laptop maintainer. Setelah itu attacker bisa pakai session browser/cookies/token aktif.

Dari sisi npm/GitHub/CI, hasilnya tetap terlihat valid:
- login valid
- session valid
- identitas valid
- bisa jadi provenance juga valid

Jadi trusted publishing bisa ikut "membubuhi stempel sah" pada release berbahaya kalau aktor aslinya sudah dikendalikan secara operasional.

### Identity verified vs intent verified
Artikel ngejelasin perbedaan tajam ini:
- identity verified = publisher atau workflow terverifikasi
- intent verified = tindakan publish itu memang sah, disengaja, dan masih di bawah kontrol pihak yang benar

Banyak sistem sudah bagus di identity verification, tapi hampir tidak punya mekanisme intent verification.

Di supply chain modern, attacker sering tidak perlu memalsukan identitas. Cukup ambil alih identitas asli.

### Kenapa OpenAI dipakai sebagai contoh?
Kasus OpenAI dipakai untuk nunjukin bahwa dampak bisa melewati maintainer individu dan nyasar perusahaan dengan security posture matang.

Pelajarannya:
- valid provenance tidak menjamin build system lo aman jika trust model lo keliru
- supply chain risk meledak karena beberapa asumsi kecil saling bertumpuk: "publisher resmi = aman", "latest version oke", "tag cukup stabil", "langsung pull di CI gak masalah"

### Solusi yang didorong artikel
Artikel ini nggak bilang provenance useless. Dia bilang: provenance itu satu kontrol, bukan jawaban final.

Yang dia dorong:
A. delay window / minimum release age
B. machine compromise detection / behavioral anomaly check
C. dual-control publishing untuk package impact tinggi
D. stop menganggap "trust the publisher" cukup

Solusi ini nyambung dengan problem: jika identitas asli bisa dikendalikan, maka yang kita butuh bukan cuma bukti siapa, tapi juga bukti bahwa proses publish masih dalam kendali normal.

### Benang merahnya
Trusted publishing bagus buat melawan pemalsuan asal, tapi lemah hadapi pengambilalihan identitas asli. Kasus Axios dan OpenAI nunjukin: jika maintainer atau workflow sudah dikompromi, provenance bisa saja tetap valid tapi release tetap berbahaya.

Jadi artikel ini lebih tepat dibaca sebagai kritik overclaim: provenance itu alat audit asal, bukan alat pembuktian niat dan kontrol.

## Praktis untuk tim
Kalau lo nggak mau baca ini sebagai fatalisme, baca ini sebagai pengingat:
- provenance perlu, tapi jangan berhenti di sana
- tambahkan delay/kontainment/behavioral checks
- pikirkan zero trust untuk publishing: bukan cuma "siapa", tapi juga "dari mana", "kondisinya gimana", "apakah pola ini normal"
- jangan cukup puas dengan "signed" atau "official" saja

Kalau lo mau, gue bisa lanjut bikin checklist praktis dari artikel ini untuk tim dev/CI/CD lo.

## Matteo Collina: trusted publishing tidak sama dengan kontrol publish
Matteo bilang trusted publishing penting, tapi tidak cukup. Inti thread-nya adalah:
- provenance menjawab "siapa yang publish?"
- bukan "apakah jalur publishnya tetap dalam kontrol?"
- bukan "apakah publish itu intended dan bersih?"

TanStack jadi contoh kuat karena kejadian ini bukan sekadar npm token bocor. Ini kasus di mana jalur resmi (`pull_request_target`, cache poisoning, OIDC token runner) tetap bisa menghasilkan artifact berbahaya.

Jadi model yang lebih tepat adalah:
- provenance = siapa
- minimum release age = beri komunitas waktu audit
- sandbox/containment = kurangi blast radius saat install

Thread ini mendorong sebuah mental model yang lebih lengkap: verifikasi identitas tidak otomatis berarti aman. Authenticity != safety.

### Kenapa ini relevan buat situasi elo
Untuk elo yang cuma clone repo dan belum install, bagian paling berguna dari thread ini adalah: jangan hanya berharap badge provenance. Kalau ada jalur eksekusi, package bisa saja legit secara identity tapi tetap berbahaya.

Solusi yang dia dorong:
- pakai minimum release age agar paket jahat bisa ketahuan sebelum dipakai
- jangan menganggap publish official sama dengan publish safe
- tambahkan lapisan pengamanan lain seperti sandbox atau dependency minimization

Reply thread ngarah ke dua arah utama:
1. runtime containment / sandbox (npm diperlakukan seperti JS dari web random)
2. kritik ekosistem yang lebih radikal, tapi itu lebih berupa provokasi daripada solusi operasional langsung.

Kesan pentingnya adalah: build beberapa lapis kontrol, bukan cari satu silver bullet.
