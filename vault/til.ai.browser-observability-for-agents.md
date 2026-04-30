---
id: til.ai.browser-observability-for-agents
title: "Agent browser observability itu bukan sekadar klik-klik"
desc: "Insight bahwa agent browser yang bisa mengakses network, DOM, screenshot, dan CDP logs berubah dari automation murni ke observability-driven debugging."
updated: 1777456708827
created: 1777456708827
tags:
  - til
  - ai
  - browser
  - observability
---

- TIL: kalau agent browser diberi kemampuan baca browser runtime, itu bukan sekadar membuat klik otomatis. Ini berarti agent bisa melihat telemetry browser seperti **network requests, DOM content, screenshots, dan CDP logs**.
- Perbedaan utama dengan agent browser biasa:
  - agent browser biasa fokus ke aksi: buka halaman, klik tombol, isi form, submit.
  - agent dengan browser observability tambah fokus ke diagnosis: request mana yang gagal, apa isi DOM, apa yang tampak di layar, dan event browser apa yang terjadi.
- Ini penting karena banyak kegagalan web modern tidak terlihat dari permukaan.
  - tombol tersembunyi di balik overlay,
  - request 401 diam-diam,
  - redirect loop,
  - hydration gagal,
  - elemen belum ready.
- Use case paling nyata:
  - debugging automation failure,
  - reverse engineering flow web app,
  - autoresearch dengan bukti yang bisa diaudit,
  - incident monitoring dari sisi browser,
  - QA / regression testing yang lebih explainable,
  - fraud / abuse investigation,
  - evaluasi dan improvement loop untuk agent sendiri.
- Kenapa ini menarik untuk engineering:
  - observability memberi agent ground truth yang lebih kaya.
  - screenshot + DOM + network + CDP adalah triangulasi kebenaran.
  - agent jadi tidak hanya operator, tapi juga sensor.
- Batasannya:
  - observability banyak data, bukan jaminan pemahaman.
  - noise bisa sangat besar.
  - raw data browser bisa sensitif; perlu sanitization dan access control.
  - tidak semua failure terlihat di browser runtime (misalnya server-side decision atau anti-bot behavior).
- Insight: agent browser yang punya telemetry mirip dengan sistem instrumented; dia tidak cuma melakukan action, tapi bisa belajar kenapa action gagal.
