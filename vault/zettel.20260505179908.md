---
id: zettel.20260505179908
title: "AI security review perlu harness dan triage, bukan hanya agent"
desc: "Nilai utama review keamanan berbasis AI ada pada orkestrasi, kontrol hasil, dan verifikasi, bukan hanya pada model agen."
updated: 1777992186558
created: 1777990836176
tags:
  - zettel
  - ai-security
  - security-review
---

Gue menangkap bahwa transformasi penting di AI security review bukan sekadar "agent yang lebih pintar", tapi "sistem yang bisa menjalankan, mengumpulkan, menguji, dan men-triage output agent".

Dalam konteks `deepsec`, value proposition-nya lebih kuat ketika:
- ada sandbox untuk menjalankan agent secara terisolasi,
- ada parallelism untuk menguji banyak hipotesis sekaligus,
- ada traceability agar setiap finding bisa dilacak ke run/prompt/model tertentu,
- ada proses triage untuk memilah false positive dan menggabungkan duplicate.

Kalau hanya mengandalkan agent tunggal, maka hasilnya cenderung eksploratif dan berisik. Tanpa harness yang disiplin, output AI security review bisa berubah jadi tumpukan noise yang malah membebani maintainer.
