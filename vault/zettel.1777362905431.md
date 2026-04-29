---
id: zettel.1777362905431
title: "Grounding adalah menyuplai konteks yang hilang saat inference tanpa mengubah model"
desc: "Kalau model tidak punya pengetahuan yang dibutuhkan, kita bisa menutup gap dengan konteks saat inference, bukan dengan memodifikasi model."
updated: 1777362905431
created: 1777362905431
tags:
  - zettel
  - ai
  - grounding
  - inference-vs-training
  - the-developers-guide-to-ai
  - part-i
---

## Ide inti

Yang gue tangkap dari quote ini adalah: kalau model nggak tahu sesuatu, itu nggak selalu berarti kita harus melatih ulang atau ganti model. Kita bisa memberi model konteks yang hilang pada saat inference agar jawabannya terikat ke fakta dan domain yang benar.

## Quote baseline

> “You can work around this constraint by providing the missing context within your prompt at inference time. This is referred to as AI grounding.”

## Kenapa ini core

Quote ini penting karena dia memindahkan solusi dari perubahan model ke perubahan input. Sebelum ini, gampang berpikir bahwa knowledge gap harus diatasi dengan fine-tuning, model baru, atau data training tambahan. Di sini buku bilang: tunggu dulu, coba dulu tambahkan konteks pada runtime.

## Apa yang bikin ini beda

- "work around this constraint" artinya batasan model tetap ada.
- "missing context" artinya yang hilang bukan kemampuan bahasa, tapi fakta domain, data privat, atau informasi terbaru.
- "within your prompt" artinya grounding awalnya masih sederhana: letakkan informasi relevan langsung di prompt.
- "at inference time" artinya ini adalah intervensi runtime, bukan training time.

## Implikasi

- Grounding adalah strategi runtime, bukan perubahan model.
- Ini jauh lebih cepat, murah, dan aman untuk data privat dibanding fine-tuning.
- Ini cocok untuk hal-hal yang dinamis seperti dokumen produk terbaru, ticket state, atau kebijakan internal.
- Ini memberi batas yang jelas antara knowledge injection dan model skill change.
- Manual grounding yang bekerja pada tahap awal nanti bisa diskalakan menjadi RAG.

## Mengapa ini penting untuk arsitektur AI

Momen ini buat gue adalah pergeseran dari "model-centric" ke "system-centric". Ada kemampuan model, tapi bukan itu satu-satunya variabel. Arsitektur sistem di sekeliling model punya peran utama dalam memastikan outputnya grounded.

## Hubungan

- [[zettel.1777272449641]] — grounding umum
- [[zettel.1777272449651]] — local model sebagai media belajar integrasi
- [[zettel.1777272449645]] — inference vs training
- [[zettel.1777272449647]] — hallucination
- [[zettel.1777349193467]] — knowledge limit dan grounding

## Sumber

- Part I
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
