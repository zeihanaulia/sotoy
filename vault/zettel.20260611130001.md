---
id: zettel.20260611130001
title: "Loop as a Decision-Making Wrapper"
desc: "Loop bukan sekadar otomasi jadwal (cron), tapi sistem yang membungkus agent dengan kemampuan mengambil keputusan berdasarkan feedback."
updated: 1781148244816
created: 1781148244782
tags:
  - zettel
  - loop-engineering
---

Perbedaan mendasar antara otomasi biasa (cron job) dan Loop Engineering adalah adanya *decision-maker* di dalam siklusnya. 

Otomasi biasa hanya menjalankan perintah pada waktu tertentu. Loop Engineering menjalankan agent yang mampu:
1. Membaca state saat ini.
2. Memilih langkah berikutnya berdasarkan feedback.
3. Menentukan apakah stopping condition sudah terpenuhi.

Dengan demikian, loop mengubah agent dari sekadar alat eksekusi menjadi unit kerja yang memiliki otonomi terbatas namun terarah.

Relasi: [[notes.ai-agents.loop-engineering]]
