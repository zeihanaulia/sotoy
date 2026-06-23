
## Overview

Gue lihat Overtrust sebagai proof-of-concept yang menarik: dia fokus ke workstation trust boundary, bukan cuma secret scanning. Itu ide bagus dan agak under-explored di dunia agentic tooling.

Tapi jangan salah: implementation-nya memang hardcoded, dan itu bikin dia lebih cocok sebagai scanner rule-based dibandingkan produk mature yang comprehensive.

## Apa yang sudah dia cover

Dari kode dan README, Overtrust ngelakuin beberapa hal penting:

- scan filesystem lokal dan ignore path dengan rule `.overtrustignore` / `.trustignore`
- klasifikasi file lewat path heuristik dan magic bytes (`classifier.cpp`)
- parse manifest VS Code, npm, Dockerfile untuk deteksi ekstensi, install script, dan `curl | bash` (`manifest.cpp`)
- secret detection dengan keyword pre-filter + regex + entropy + false-positive guard (`secrets.cpp`)
- process scan di Linux untuk capabilities, seccomp, sensitive FD, dan AI tool detection (`procscanner_linux.cpp`)
- output report + trust score + JSON export + optional exit-code

Itu kombinasi yang menarik karena dia nyambungin dua domain: file-level exposure dan runtime process privilege.

## Apakah ini sudah meng-cover semua?

Jawabannya: nggak. Overtrust sengaja hardcoded, jadi dia hanya cover apa yang sudah dituliskan di kodenya.

Contoh coverage yang dipastikan:
- `aws credentials` di `~/.aws/`
- `kubeconfig` di `~/.kube/config`
- shell history file
- SSH private key patterns
- Dockerfile root / `curl | bash`
- VS Code extension auth providers, terminal access, debugger, always-on activation
- known AI tool names seperti Cursor, Copilot, Codeium
- pattern secret seperti `sk-`, `ghp_`, `xoxb-`, `PEM`, dan lain-lain

Karena semua itu hardcoded, risiko utamanya:

- kalau secret atau tool baru muncul, Overtrust nggak akan tangkep sampai rulesnya diupdate
- kalau file disimpan di lokasi tak terduga atau pakai nama nggak standar, classifier bisa miss
- `is_ai_tool()` hanya berdasarkan nama proses yang disebutkan di kode
- process scan cuma lihat privilege dan sensitive FDs, bukan apakah data benar-benar keluar lewat jaringan
- tidak ada threat intel/reputation, jadi hanya indikator statis

Jadi jangan kira ini all-cover. Dia cover sejumlah domain penting dengan cara deterministik, tapi dia bukan oracle workstation security.

## Flaw utama yang gue tangkep

### 1. Rule-based, bukan learning
Bukan flaw kalau memang tujuannya deterministik. Tapi efeknya adalah maintenance burden dan blind spot. `secrets.cpp` pake regex + entropy + FP guard — bagus, tapi kalau format secret baru atau prefix baru muncul, lo harus patch kodenya.

### 2. Heuristik path bisa dilewati
Kalau attacker/misal dev menyimpan credential di `~/config/aws.config` bukan `~/.aws/credentials`, Overtrust bisa saja miss. Sama dengan manifest: kalau extension pakai nama package lain dan ngasih auth capability tanpa kebiasaan `contributes.authentication`, tool ini bisa terlewat.

### 3. AI tool detection terbatas
`is_ai_tool()` cuma cek nama dan command line matching string seperti `copilot`, `cursor`, `claude`. Ini gampang dilewati dengan nama proses lain atau wrapper script.

### 4. Process scan masih statis
Proses yang buka sensitive FD atau punya `CAP_SYS_ADMIN` itu warning bagus, tapi belum berarti exploit path selesai. Kalau process sudah punya akses tapi tidak benar-benar menggunakan data, nilai signal masih sulit.

### 5. Kurang konteks jaringan dan runtime
Overtrust fokus workstation, tapi dia nggak lihat koneksi jaringan aktif, service binding, atau apakah app sedang mengekspose data. Di banyak threat model, itu penting.

### 6. No policy/config customization beyond ignore
Dia punya ignore file. Tapi kalau lo butuh whitelist, severity tuning, atau custom rules, nggak jelas tersedia.

## Tools sejenis yang lebih mature

Kalau dilihat domainnya, Overtrust sejatinya berdiri di tengah beberapa kategori yang jauh lebih matang.

### Secret/file scanning
- [truffleHog](https://github.com/trufflesecurity/trufflehog): scanner yang fokus ke history Git dan file system untuk pattern secret, credentials, dan konfigurasi sensitif.
- [gitleaks](https://github.com/zricethezav/gitleaks): secret scanner untuk repo dan pipeline dengan rules library yang bisa di-custom.
- [detect-secrets](https://github.com/Yelp/detect-secrets): pre-commit secret detection engine yang lebih kuat karena bisa integrate ke workflow Git.
- [git-secrets](https://github.com/awslabs/git-secrets): AWS-centric secret prevention di Git hooks.
- [betterleaks](https://github.com/betterleaks/betterleaks): secrets scanner modern dengan fokus performa dan konfigurabilitas.
- [rusty-hog](https://github.com/newrelic/rusty-hog): secret scanning berbasis Rust untuk kecepatan dan rule set yang kuat.

Overtrust punya overlap di bagian secret detection, tapi targetnya beda. Overtrust bukan cuma scan file; dia juga hubungkan secret dengan file type, manifest, dan process lokal. Tool mature di atas lebih bagus untuk scan repo/commit history, aturan secret yang kontinu, dan false-positive tuning.

### Manifest/script auditing
- [hadolint](https://github.com/hadolint/hadolint): Dockerfile linter yang cek best practice, compliance, dan potensi risk.
- `npm audit`: built-in audit untuk package dependency dan vulnerability di ekosistem npm.
- [dockerfilelint](https://github.com/replicatedhq/dockerfilelint): linter Dockerfile lain dengan rule-based audit.
- `npm-package-arg`: tooling parse/manipulasi package spec, berguna untuk audit package manifest.

Overtrust juga parse manifest dan cari pola berbahaya seperti `curl | bash`, extension auth provider, dan npm install script. Bedanya: tool khusus seperti `hadolint` atau `npm audit` punya coverage rule library jauh lebih luas, sementara Overtrust fokus ke kondisi lokal developer yang bisa jadi trigger eksfiltrasi atau build-time risk.

### Host/process monitoring
- [Falco](https://github.com/falcosecurity/falco): real-time runtime security monitoring dengan rule untuk proses, syscall, dan perilaku host.
- [osquery](https://github.com/osquery/osquery): query-based visibility untuk state host, proses, dan konfigurasi.
- [sysdig](https://github.com/draios/sysdig): observability runtime untuk proses, network, dan system call.
- `auditd`: Linux audit daemon untuk event security dan perubahan file.
- `Process Explorer`: tool Windows Sysinternals untuk inspeksi runtime process dan handle.

Bagian process scan Overtrust paling mirip domain ini, tapi sangat terbatas. Overtrust lebih ke snapshot lokal dan flags privilege/sensitive FD; bukan continuous detection atau alerting runtime. Falco/osquery/sysdig/auditd punya observability jauh lebih kaya dan mature untuk threat hunting.

### Workstation / endpoint security
- CrowdStrike dan SentinelOne: EDR komersial dengan agent, telemetry, threat intelligence, dan respons otomatis.
- GitGuardian Desktop: desktop-focused secret monitoring yang mendeteksi secret di file lokal dan clipboard.

Di sini perbedaan paling besar: Overtrust adalah open-source audit prototype yang jalan sekali dan lokal. EDR produk mature punya cloud intelligence, deteksi behaviour, dan policy enforcement. GitGuardian Desktop lebih dekat secara goal secret detection, tapi bukan trust boundary audit yang menggabungkan process + manifest + secret dalam satu scan.

Dari pencarian GitHub, ada juga beberapa open-source lokal workstation/config scanners, tapi belum besar dan biasanya sangat spesifik. Contohnya `Host-Config-Review-Scanner` atau proyek audit config workstation; mereka lebih niche dan belum mature sebagai produk umum.

Intinya: komponen dasar Overtrust bukan baru. Yang unik adalah packaging file, manifest, secret, dan process scan jadi satu audit lokal untuk developer workstation. Itu masih niche, bukan benar-benar tanpa precedent.

## Apakah ini ide bagus yang gak kepikiran banyak orang?

Iya dan nggak.

Iya, karena ide "scan workstation sebelum ngasih agentic tool akses" itu bagus. Kebanyakan engineering security masih fokus ke repo atau pipeline, sementara agentic tools benar-benar memperluas attack surface ke workstation. Itu masih relatif under-explored.

Tidak, karena komponennya sendiri bukan ide baru. Secret scanners, manifest auditors, dan process/host monitoring sudah ada, dan bahkan ada beberapa repo open-source yang mulai ngejar local workstation audit. Yang agak lebih unik adalah packaging keduanya jadi satu "local trust boundary scanner" untuk developer.

Jadi kalau lo tanya apakah ini sepenuhnya out-of-the-box: tidak. Kalau lo tanya apakah ini arah yang layak diseriusin di konteks agentic coding, jawabannya iya.

## Kesimpulan gue

Overtrust itu bagus sebagai eksperimen dan direction.

- Strength: local, deterministic, berjalan tanpa cloud, fokus trust boundary.
- Weakness: rule-based, hardcoded, blind spot untuk format/penamaan baru, dan tidak punya runtime network context.
- Posisi: lebih layak disebut prototype/tool audit kerja daripada produk mature.

Kalau lo mau ambil pelajaran dari Overtrust, hal yang worth diadopsi adalah:
- audit lokal itu penting untuk agentic workflows
- jangan cuma cek secret files; cek process privilege dan tool ownership juga
- hardcoded rules bisa cepat deployment, tapi butuh pipeline update kalau threat berubah

## Referensi
- `https://github.com/cheese-cakee/overtrust`
- `.references/overtrust` (local clone dari repo Overtrust)
- `https://github.com/trufflesecurity/trufflehog`
- `https://github.com/zricethezav/gitleaks`
- `https://github.com/Yelp/detect-secrets`
- `https://github.com/falcosecurity/falco`
- `https://github.com/osquery/osquery`
- `https://www.gitguardian.com/desktop`

## Rekomendasi note

- `notes.security.overtrust` jadi summary high-level,
- `notes.security.overtrust.workflow-detail` jadi detail implementasi,
- note ini cocok jadi evaluasi kekuatan vs flaw.

## Related Notes
- [[notes.security.overtrust]]
- [[notes.security.overtrust.workflow-detail]]
- [[notes.security.agentic-coding-permission-boundary]]
- [[notes.security.deepsec-docs]]
- [[notes.security.deepsec-harness]]
