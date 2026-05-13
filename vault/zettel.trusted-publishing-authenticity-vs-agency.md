---
id: zettel.trusted-publishing-authenticity-vs-agency
title: "Trusted publishing memverifikasi origin, bukan kontrol publish"
desc: "Trusted publishing di npm/GitHub memverifikasi identitas dan workflow CI, tetapi tidak membuktikan bahwa publish dilakukan di bawah kontrol yang aman."
updated: 1778645837051
created: 1778645837051
tags:
  - zettel
  - security
  - supply-chain
  - provenance
---

Trusted publishing di konteks npm adalah mekanisme kriptografis untuk membuktikan siapa yang menerbitkan paket dan melalui workflow CI mana. Itu menjawab pertanyaan "siapa" dan "dari mana", bukan pertanyaan "apakah actor masih memegang kontrol".

Karena attacker bisa mengendalikan maintainer atau runner yang sah, provenance tetap bisa valid meskipun intent dan kontrol sudah hilang. Maka provenance adalah sinyal authenticity, bukan jaminan safety.
