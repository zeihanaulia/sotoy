---
id: notes.security.pii-agent-architecture.camp.per-turn-masking
title: "Per-turn masking gagal untuk agentic multi-turn chat"
desc: "Penjelasan kenapa proteksi PII yang hanya memeriksa satu pesan per turn tidak cukup untuk agent yang membawa history penuh ke setiap panggilan model." 
updated: 1777876488237
created: 1777876488237
tags:
  - notes
  - security
  - pii
  - agent
  - memory
---

## Inti masalah
Per-turn masking hanya menilai privacy risk pada satu pesan di satu waktu. Kalau agent mengirim ulang seluruh conversation history ke model setiap turn, solusi ini melewatkan risiko yang terbentuk dari akumulasi fragmen PII.

Dalam agentic multi-turn chat, data lama bukan benar-benar "lalu". Itu bagian dari prompt yang dikirim ulang dan menjadi bahan inferensi model.

## Contoh klasikal
- Turn 1: "Gue lagi cari saran financial planning."
- Turn 2: "Nama gue Raka."
- Turn 3: "Gue tinggal di BSD."
- Turn 4: "Gue kerja di Gojek."
- Turn 5: "Gaji gue 35 juta."

Per-turn masking bisa saja membersihkan setiap pesan secara individu.
Namun jika history ini dipakai lagi pada turn 6, kombinasi Raka + BSD + Gojek + salary membuat profil yang lebih sensitif daripada setiap pesan tunggal.

## Kenapa ini salah unit analisis
Per-turn masking memodelkan privacy risk sebagai properti dari message.

Tapi dalam agentic conversation, privacy risk adalah properti dari session yang mengandung banyak message.

Perbedaannya:
- Message-level: "Apakah pesan ini mengandung entitas sensitif?"
- Session-level: "Apakah kombinasi informasi yang terkumpul sampai sekarang sudah cukup untuk mengidentifikasi pengguna?"

## Dampak praktis
- Agent memory atau retrieval history membuat per-turn masking semakin berbahaya.
- Tool use dan handoff antar sub-agent memperbesar exposure karena history lama bisa tersebar ke lebih banyak channel.
- Stateless filter bisa saja benar untuk satu pesan, tetapi tetap salah secara keseluruhan jika history terus diteruskan.

## Relevansi ke desain security agent
Desain agent privacy harus memikirkan state session dan cumulative exposure.

Ini berarti:
- menyimpan registry PII lintas turn,
- menghitung risiko dari kombinasi entitas,
- memutuskan apakah history lama perlu ditulis ulang atau dipseudonymize.

## Related notes
- [[notes.security.pii-agent-architecture.camp]]
- [[notes.security.pii-agent-architecture]]
