---
id: til.security.trusted-publishing-not-safety
title: "Trusted publishing tidak menjamin safety"
desc: "Trusted publishing/provenance bisa membuktikan siapa yang publish, tetapi tidak membuktikan apakah publish itu terjadi di jalur kontrol yang aman."
updated: 1778643308114
created: 1778643308114
tags:
  - til
  - security
  - supply-chain
  - provenance
---

TIL: trusted publishing di npm/GitHub adalah sinyal identitas publisher, bukan bukti bahwa proses publish tetap berada di bawah kendali yang aman. Matteo Collina menekankan bahwa provenance menjawab "who published", tetapi tidak menjawab "whether they were in control".

Itu berarti: kamu masih butuh lapisan tambahan seperti minimum release age, sandbox/containment, dan observabilitas komunitas.
