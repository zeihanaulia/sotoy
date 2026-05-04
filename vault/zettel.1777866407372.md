---
id: zettel.1777866407372
title: "Batasan stealth dalam browser automation"
desc: "Stealth mode mereduksi fingerprint browser, tetapi deteksi tetap bisa terjadi lewat perilaku, jaringan, dan konsistensi sinyal."
updated: 1777866407372
created: 1777866407372
tags:
  - zettel
  - stealth
  - browser-automation
---

Stealth mode dalam browser automation tidak membuat bot menjadi manusia. Ia bekerja dengan cara menutupi atau merapikan sinyal fingerprint browser yang mudah dikenali, seperti `navigator.webdriver`, WebGL fingerprint, dan property JS yang umum dipakai detektor.

Klaim yang paling aman dipahami adalah bahwa stealth mode **mengurangi kemungkinan deteksi dari permukaan browser**. Itu termasuk:

- property masking dan API spoofing
- randomisasi fingerprint per session
- patching native function agar inspeksi JS terlihat normal
- blocking tracker/anti-bot domains yang menambah observability

Namun deteksi bot modern bukan hanya soal fingerprint browser. Ada tiga lapisan sinyal yang sering diterapkan:

1. `Browser-level fingerprint`
   - nilai property JS, canvas/WebGL output, audio fingerprint, device memory, dan konfigurasi hardware.
2. `Behavioral signal`
   - pola klik/scroll, timing interaksi, fokus window, durasi sesi, dan ritme navigasi.
3. `Operational/network signal`
   - reputasi IP/proxy, TLS fingerprint, session continuity, cookie reuse, dan dependency pada layanan pihak ketiga.

Dua failure mode utama:

- `Inconsistency`: stealth patch memperbaiki satu sinyal tetapi meninggalkan kontradiksi di sinyal lain, sehingga detektor akhirnya lebih mudah mengenali bot.
- `Behavioral/network fallback`: browser fingerprint tampak normal, tetapi pola perilaku atau network tetap bot-like, sehingga deteksi tetap terjadi.

Intinya:

- Stealth mode adalah bentuk **risk reduction**, bukan **invisibility**.
- Ia membantu bot lolos dari pintu depan, tetapi bisa tetap ketahuan dari jalan, suara, atau alamat rumahnya.
- Untuk use case seperti AI agent internal, stealth bisa cukup untuk menundukkan permukaan deteksi.
- Untuk scraping situs pihak ketiga dengan anti-bot kuat, stealth hanya satu bagian dari strategi yang lebih besar.
