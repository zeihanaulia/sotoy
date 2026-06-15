---
id: zettel.1777866581065
title: "Bottleneck agen coding sering ada pada pemilihan konteks, bukan kapasitas model"
desc: "Menyaring dokumen dan file relevan sebelum model berpikir membuat reasoning lebih efisien daripada hanya memperbesar model."
updated: 1777866657847
created: 1777866606501
tags:
  - zettel
  - agent
  - context-selection
  - workflow
---

Dalam workflow coding agent, yang sering jadi masalah bukan seberapa pintar modelnya, tapi seberapa tepat konteks yang diberikan padanya.

Kalau agen diberi terlalu banyak file, token terbuang buat membaca hal-hal yang tidak relevan. Kalau agen diberi terlalu sedikit konteks penting, ia bisa membuat asumsi keliru.

Jadi cara yang lebih bijak adalah punya "petugas arsip" atau layer seleksi konteks sebelum model mulai berpikir. Layer ini mengurus:

- mencari file dan struktur dependensi yang relevan,
- mempersempit ruang problem ke blast radius perubahan,
- mengeluarkan only the files needed untuk task tertentu.

Dengan begitu, model bisa bekerja pada informasi yang paling mungkin mempengaruhi solusi, dan bukan pada semua data yang ada di repo.

Principle-nya: efisiensi reasoning datang dari kualitas konteks, bukan dari ukuran model semata.
