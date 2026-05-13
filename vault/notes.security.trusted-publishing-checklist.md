---
id: notes.security.trusted-publishing-checklist
title: "Trusted publishing: kritik argumen dan checklist operasional"
desc: "Bedah argumen trusted publishing di situasi npm dan turunkan jadi checklist untuk maintainer, repo, CI, dan organisasi."
updated: 1778647325842
created: 1778643750715
tags:
  - notes
  - security
  - supply-chain
  - trusted-publishing
---

## Tesis utama
Trusted publishing memverifikasi asal rilis paket lewat OIDC, Sigstore, dan provenance attestation. Itu menjawab "siapa yang publish" dan "jalur CI mana". Tapi itu tidak menjawab apakah pihak yang publish itu masih dalam kontrol yang aman atau apakah intent publish itu sah.

## Bagian yang kuat
1. **Perbedaan authenticity vs agency**
   - authenticity = artefak datang dari jalur resmi
   - agency = identitas itu masih benar-benar mengendalikan proses
   Artikel kuat karena menunjukkan bahwa provenance valid tidak otomatis berarti kontrol publish tidak terkompromi.

2. **Failure mode realistis**
   - maintainer atau endpoint dikompromi lewat social engineering
   - session/token aktif diambil alih
   - provenance dan identity checks tetap hijau
   Ini bukan skenario teoretis; ini pola nyata yang menembus banyak supply chain incident.

3. **Solusi yang masuk akal**
   - minimum release age sebagai delay gate
   - anomaly detection pada perilaku publish
   - dual-control publishing untuk release high-impact
   Semua ini menambah lapisan selain provenance.

## Bagian yang berisiko misleading
1. **Argumen "provenance lebih buruk dari tidak berguna"**
   - itu terlalu retoris.
   - provenance tetap berguna untuk audit asal, policy enforcement, dan investigasi.
   - masalahnya adalah provenance **insufficient as a standalone trust signal**.

2. **Potensi overemphasis pada social engineering saja**
   - social engineering adalah ancaman besar, tapi bukan satu-satunya.
   - supply chain juga butuh mitigasi untuk misconfiguration, dependency hijacking, dan runtime compromise.

3. **Dual-control tanpa konteks operasional**
   - ideal secara prinsip, tapi bisa memberatkan project kecil dan memperlambat hotfix.
   - perlu risk-based penerapan, bukan aturan universal.

## Kontrol relevan untuk tim software
### Maintainer/releaser
- batasi device dan browser profile untuk aktivitas release
- jangan install software review/link DM/Slack tanpa verifikasi independen
- review sesi login aktif secara berkala
- dokumentasikan jalur publish resmi
- pertimbangkan dual approval untuk paket high-impact

### Repo & dependency consumption
- pin commit hash untuk GitHub Actions, base image, dan git-based dependency
- commit lockfile dan gunakan lockfile di CI
- jangan auto-approve latest release untuk jalur sensitif
- kasih buffer/cooling period untuk dependency baru
- klasifikasikan dependency berdasarkan blast radius

### CI/CD
- pisahkan runner/job untuk publishing/signing dari pipeline umum
- minimalkan secret scope dan egress di job sensitif
- review floating references dan install scripts
- gunakan provenance sebagai syarat minimum, bukan syarat cukup

### Organisasi/Process
- ajarkan bahwa identity validation bukan safety guarantee
- anggap compromise maintainer dan endpoint sebagai threat model nyata
- siapkan prosedur freeze dependency updates saat upstream incident
- simulasikan skenario maintainer compromise atau malicious upstream release

## Kontrol murah, impact besar
1. **Lockfile discipline**
   - commit lockfile, pastikan CI pakai lockfile yang sama
   - ini murah dan langsung memperkecil blast radius dependency drift

2. **Pinning floating references**
   - hindari `latest`, floating action versions, dan git tags di jalur sensitif
   - ini mencegah perubahan tak terduga di pipeline

3. **Review dependency update route**
   - jangan biarkan update dependency masuk prod cuma karena versi baru keluar
   - ini membantu memecah risiko update dari feature change

4. **Minimum release age / cooldown**
   - delay pakai package baru pada jalur sensitif selama 24–72 jam atau lebih untuk tooling sensitif
   - ini murah karena mostly policy, tapi sangat efektif untuk serangan epoch awal

5. **Least privilege secret scope**
   - batasi akses secret di hanya job yang perlu
   - ini mencegah dependency compromise dari menjalar ke publish/signing path

## Checklist operasional
### Level maintainer
- [ ] Device/browsing terpadu untuk aktivitas release dipisah dari aktivitas umum
- [ ] Tidak install software review dari link DM/Slack/email tanpa verifikasi lain
- [ ] Publish terlokalisir melalui workflow resmi, bukan session browser random
- [ ] Sesi login aktif diperiksa secara berkala
- [ ] Paket high-impact punya dual approval atau gate tambahan

### Level repo
- [ ] Lockfile committed dan dipakai di CI
- [ ] GitHub Actions dan git dependency dipin ke commit hash
- [ ] Floating tag/reference di release pipeline diminimalkan
- [ ] Update dependency sensitive lewat PR khusus dan review
- [ ] Buat kategori dependency berdasarkan risk/impact

### Level CI/CD
- [ ] Runner pipeline signing/release terpisah dari pipeline sehari-hari
- [ ] Secret hanya tersedia di job yang benar-benar perlu
- [ ] Egress low/no untuk job sensitif jika memungkinkan
- [ ] Release workflow punya approval step dan tidak langsung auto-publish
- [ ] Provenance/attestation diverifikasi, tapi tidak dijadikan satu-satunya syarat

### Level organisasi
- [ ] Threat model memasukkan kompromi maintainer dan session hijack
- [ ] Ada policy cooling period untuk dependency baru di jalur sensitif
- [ ] Ada proses incident freeze untuk upstream malicious release
- [ ] Ada latihan tabletop supply chain compromise
- [ ] Tim paham bahwa "signed" tidak otomatis berarti "safe"

## Level penggunaan checklist
Checklist ini paling berguna di beberapa level sekaligus:
- **maintainer**: kontrol endpoint dan publish behavior
- **repo**: dependency pinning, lockfile, update route
- **CI/CD**: pipeline isolation, secret scope, approval gate
- **organisasi**: threat model, policy, incident readiness

Untuk implementasi cepat, mulailah di layer repo/CI. Setelah itu, perluas ke maintainer hygiene dan organisasi policy.

## Related notes
- [[notes.security.overtrust]]
- [[notes.security.overtrust.workflow-detail]]
- [[notes.security.tanstack-postmortem]]

## Catatan penting
Trusted publishing tetap punya nilai. Nilainya adalah membantu memverifikasi asal dan membantu investigasi. Nilainya tidak sama dengan pembuktian bahwa publish itu aman.

Jadi janganlah menyimpulkan dari artikel ini bahwa provenance tidak penting. Kesimpulan yang lebih tepat adalah: provenance itu **satu lapis**, bukan **satu-satunya lapis**.
