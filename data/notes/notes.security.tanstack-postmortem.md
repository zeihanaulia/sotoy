
## Inti kejadian
11 Mei 2026, attacker berhasil mempublish 84 versi malicious di 42 paket `@tanstack/*` dalam sekitar 19:20–19:26 UTC.

Postmortem TanStack menyebut rangkaian ini bukan credential theft tradisional: npm token tidak dicuri. Yang pecah adalah chain trust di depan jalur publish resmi.

Kunci insiden ini:
- `pull_request_target` request yang mengeksekusi code PR di konteks base repo
- GitHub Actions cache poisoning yang memindahkan payload ke workflow resmi
- ekstraksi token OIDC dari memori runner untuk publish npm

## Kenapa trusted publishing OIDC tidak menyelamatkan
Gue baca bagian ini sebagai bukti bahwa kita sering terlalu cepat menganggap "jalan publish resmi = aman".
Trusted publishing memang memberi bukti bahwa paket dipublish dari workflow resmi.

Namun dalam kasus ini, attacker tidak perlu memalsukan workflow. Mereka mendapatkan code execution di runner yang sudah punya hak `id-token: write`.

Jadi dari sisi npm, publish itu tetap sah. Tapi dari sisi kontrol, runner sudah dimanipulasi.

Ini membuktikan:
- provenance = "siapa publish"
- provenance ≠ "apakah kontrol publish sah"
- trusted publishing tidak sama dengan sandbox

## Rantai serangan teknis
### 1. PR jahat dengan `pull_request_target`
Attacker membuat fork repo TanStack/router, lalu PR normal-looking.

Workflow yang jalan adalah `bundle-size.yml` dan `labeler.yml`, kedua-duanya memakai `pull_request_target`.

Masalahnya:
- `pull_request_target` berjalan di konteks base repo
- build checkout PR merge result
- jadi code PR untrusted bisa ikut dieksekusi

Dalam praktiknya, menjalankan code PR ini sering berarti melakukan build/install langkah seperti `npm install` / `pnpm install` / `yarn install` di konteks PR.
Itu penting karena install lifecycle bisa memicu hook, script, atau dependency jahat yang kemudian membaca token/kredensial dan mengeksekusi payload.

Intinya: ini bukan PR contributor biasa yang sudah dimerge.
PR berbahaya ini bisa takeover tanpa harus masuk ke `main` terlebih dulu. PR hanya perlu diterima enough untuk menjalankan workflow yang trusted.

Proses yang sebenarnya bermasalah adalah:
- attacker buka PR dari fork
- workflow trusted di base repo jalan karena trigger `pull_request_target`
- workflow itu kini menjalankan kode yang ada di PR atau dependency PR
- pada titik itu, PR sudah bisa memengaruhi pipeline resmi meski belum dimerge

Jadi analoginya:
- normal: PR dibuat → review → merge → kode jalan di main
- TanStack issue: PR dibuat → trusted workflow jalan → kode PR dieksekusi sebelum merge

Ini adalah definisi pwn request: trusted trigger menjalankan untrusted code.

### 2. Cache poisoning
PR jahat menaruh payload ke `pnpm store` dengan key yang sama dengan cache key workflow resmi.

Pada akhirnya cache yang dikendalikan attacker bisa direstore oleh workflow `main`.

Pelajaran teknis:
- cache adalah trust boundary
- cache bukan sekadar optimisasi performa
- cache bisa jadi kendaraan eksekusi lintas boundary

### 3. Token OIDC di memori runner
Workflow resmi punya `id-token: write` untuk npm trusted publishing.

Payload tidak menggunakan step publish resmi. Sebaliknya, dia mengekstrak token OIDC dari memori runner dan hit `registry.npmjs.org` langsung.

Jadi attacker berhasil mem-push paket karena ia mendapatkan token valid yang dikeluarkan untuk workflow tersebut. Token itu sudah sah bagi npm, sehingga request publikasi terlihat datang dari workflow resmi meskipun eksekusinya berjalan lewat payload jahat di runner.

Ini menunjukkan:
- publish resmi bisa dilewati
- trusted publishing memverifikasi identitas workflow, bukan jalur eksekusi token di dalam runner

## Apa malware-nya lakukan
Payload aktif saat install (`npm install`, `pnpm install`, `yarn install`).

Fungsinya:
- ambil kredensial: AWS, GCP, Kubernetes, Vault, `~/.npmrc`, GitHub token, SSH key
- exfiltrate via Session/Oxen messenger
- cari package lain korban dan republish dengan injeksi serupa

Intinya, host yang install affected version harus diasumsikan compromised.

## Kelemahan desain sistem paling fatal
### `pull_request_target` dijalankan tanpa batasan execution code
Workflow ini seharusnya hanya dipakai untuk trust-safe operations. Namun ia mengeksekusi PR code dan dependency PR.

Contoh simulasi sebelumnya:
- Repo punya job `labeler` atau `bundle-size` yang perlu membaca PR metadata dan komentar.
- Developer menggunakan `pull_request_target` karena job itu harus punya akses token base repo yang tidak tersedia pada fork.
- Job tersebut juga checkout hasil merge PR dan menjalankan script build/install dependency untuk menghitung ukuran bundle atau assign label.
- Pada dasarnya, workflow trusted ini jadi mengeksekusi code PR yang belum diverifikasi.

Seharusnya model yang lebih aman seperti ini:
- `pull_request_target` hanya melakukan operasi metadata yang tidak bergantung pada kode PR, misalnya membaca komentar atau menulis label.
- Semua kode PR yang perlu dieksekusi harus dijalankan di job terpisah dengan `pull_request` atau `pull_request_target` yang sangat terbatas dan tanpa akses ke secret/base repo.
- Jika perlu build PR, gunakan workflow yang membangun PR di konteks fork saja dan tidak memberikan akses sensitif pada base repo.
- Atau gunakan `pull_request_target` dengan strict guardrail: jangan checkout PR code, jangan install dependency PR, dan jangan restore cache yang bisa dipengaruhi PR.

Dengan cara ini, trigger trusted tidak lagi menjadi jalur eksekusi untuk code untrusted.

### Cache dianggap bukan attack surface
Cache restore pada scope base repo jadi jalur terpenting. Tim sering lupa bahwa restore cache mempengaruhi apa yang dieksekusi selanjutnya.

### `id-token: write` dipercaya sebagai safe capability
Token OIDC aman secara desain, tapi jika runner sudah dieksekusi code asing, token itu bisa diambil dari memori.

### Kurangnya monitoring publish internal
TanStack tahu dari luar. Artinya observability internal terhadap publish yang abnormal masih lemah.

## Pelajaran praktis
### Review workflow secara behavioral, bukan hanya YAML
Tanya:
- kode apa yang benar-benar dieksekusi?
- apakah untrusted code bisa mempengaruhi workflow trusted?
- apakah cache/restore masuk dalam trust boundary?

### Perlakukan `pull_request_target` sebagai high-risk
Bukan larangan total, tapi wajib audit jika ia checkout PR code, build PR, atau install dependency PR.

### Perlakukan cache sebagai artefak supply-chain
Jangan anggap cache sekadar kecepatan. Cache yang restore dalam workflow resmi perlu perlakuan yang sama seperti binary dependency.

### Jangan anggap OIDC/trusted publishing sebagai sandbox
Ini bagus untuk provenance, tapi tidak mencegah code execution jahat di runner.

### Siapkan deteksi internal untuk publish gak biasa
Minimal:
- publish dari workflow yang tidak expected
- step publish yang dilewati
- request npm yang aneh

### Kurangi blast radius maintainer
Semakin banyak maintainer dengan hak luas, semakin banyak target. Hak publikasi yang lebar perlu dikurangi dan dijaga.

## Koherensi dengan mental model yang lebih sehat
Insiden TanStack ini mendukung pemikiran:
- trusted publishing itu satu lapis
- tidak berarti trust penuh
- masih perlu delay gate, behavioral checks, approval, isolation
- boundary antar stage harus dipahami, bukan hanya fitur permukaan

## Konkret: apa yang perlu dicek besok pagi
- `pull_request_target` jobs yang checkout PR code
- cache key/restore yang bisa dipengaruhi PR
- `id-token: write` di runner yang bisa dieksekusi code eksternal
- apakah publish workflow punya approval/monitoring tambahan
- apakah package baru di pipeline sensitif punya cooling period

Catatan: postmortem ini penting bukan karena bug tunggal, tapi karena menyusun beberapa asumsi trust yang masing-masing kelihatan kecil menjadi rantai serangan fatal.

## Related notes
- [[notes.security.trusted-publishing-checklist]]
- [[notes.security.overtrust]]
- [[notes.security.overtrust.workflow-detail]]
- [[zettel.trusted-publishing-authenticity-vs-agency]]
- [[zettel.pull-request-target-takeover]]
- [[zettel.cache-as-trust-boundary]]
