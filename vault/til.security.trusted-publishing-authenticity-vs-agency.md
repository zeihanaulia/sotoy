---
id: til.security.trusted-publishing-authenticity-vs-agency
title: "Trusted publishing membuktikan origin, tapi tidak membuktikan kontrol publish"
desc: "Trusted publishing di npm/GitHub adalah kriptografi provenance, bukan jaminan bahwa publish terjadi di bawah kontrol yang aman."
updated: 1778643607960
created: 1778643607960
tags:
  - til
  - security
  - supply-chain
  - provenance
---

TIL: trusted publishing di konteks npm berarti OIDC + Sigstore + provenance attestation untuk memverifikasi identitas dan workflow CI saat publish. Itu jawaban untuk "percaya siapa yang publish", bukan "percaya bahwa publish itu dilakukan dengan kontrol yang aman."

Kasus Axios/OpenAI menunjukkan bahwa kalau attacker berhasil mengambil alih maintainer atau session, provenance bisa tetap valid sementara intent/kontrol sudah hilang.

Intinya:
- authenticity = rilis datang dari jalur resmi
- agency = publisher masih mengendalikan proses secara sah

Provenance hanya kuat terhadap pemalsuan origin. Ia lemah terhadap kompromi identitas asli dan social engineering.
