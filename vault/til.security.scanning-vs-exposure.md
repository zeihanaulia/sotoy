---
id: til.security.scanning-vs-exposure
title: "TIL: Bedain Security Scan Internal vs Exposure OSINT"
desc: "Tools OSINT itu berguna buat lihat apa yang kebuka dari luar, tapi bukan pengganti scan code dan config internal."
updated: 1776964817689
created: 1776964817689
tags:
  - til
  - security
  - osint
---

Lo harus pisahin dua dunia ini:

1. **OSINT / external exposure** — lihat apa yang kelihatan dari luar.
   Tools kayak Shodan, Censys, crt.sh, HIBP, URLScan, grep.app, dan semacamnya
   berguna buat cek apakah asset lo kebuka, cert/domains bocor, atau code publik udah
   terekspos.

2. **Code scanning internal** — cek apa yang salah di dalam repo dan deployment
   lo.
   Ini yang lebih relevan buat deteksi bug, secret hardcoded, dependency vulnerable,
   dan konfigurasi IaC/container yang nyerempet bahaya.

3. **Exposure scanning** — area di tengah:
   internal scan bisa ngasih sinyal masalah, tapi exposure scan ngasih bukti kalau ada
   sesuatu yang benar-benar sudah kelihatan di internet.

Kalau lo cuma pake tools di post itu, lo bisa tahu "ada yang kebuka dari luar,"
namun bisa miss masalah fundamental di dalam repo. Kalau lo cuma ngandelin scanner
internal, lo bisa miss fakta bahwa secret lama udah bocor atau ada layanan publik
yang nggak sengaja kebuka.

Jadi singkatnya: **osint jadi pelengkap yang lihat dampaknya, bukan pengganti scan
code internal**.

Stack minimal yang masuk akal buat scan code secara realistis:

* Gitleaks untuk secret scanning.
* Semgrep untuk SAST.
* osv-scanner / package manager audit untuk dependency.
* Trivy untuk container + config/IaC.
* Shodan/Censys + HIBP untuk cek exposure dari luar.

Kalau target lo adalah "scan semua code gue secara realistis," jangan tanya
"tool terbaik satu buat semuanya." Tanyain dulu: lo mau deteksi risiko di layer
mana?
