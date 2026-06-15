---
id: til.national-finance.hedge-adalah-perlindungan-nilai
title: "Hedge adalah perlindungan nilai, bukan cari untung utama"
desc: "Perbedaan antara hedge, investasi, dan spekulasi dalam konteks rupiah dan aset valuta asing."
updated: 1778578353774
created: 1778577717472
tags:
  - til
  - national-finance
  - hedge
---

Gue baru ngeh bahwa hedge itu fungsi utamanya bukan untuk ngejar profit, tapi untuk nge-reduce risiko kalau sesuatu bergerak buruk.

Kalau semua uang gue 100% rupiah, dan rupiah melemah terhadap USD/SGD, maka nilai global uang gue runtuh. Jadi logikanya, sebagian harus disebar ke USD/SGD/emas agar kalau rupiah melemah, sebagian aset gue bisa "naik" dalam rupiah dan menahan kerugian daya beli.

Contohnya simpel: punya Rp100 juta.

Skenario A: semua di rupiah. Contoh historis, USD/IDR sekitar 16.207 pada 2 Jan 2025 naik ke sekitar 17.425 pada 11 Mei 2026. Saldo gue tetap Rp100 juta, tapi nilainya turun sekitar 7% dalam USD karena kurs rupiah melemah. Kalau dihitung ke USD, Rp100 juta pada awal era itu setara sekitar US$6.170, sementara pada kurs Mei 2026 nilainya cuma sekitar US$5.739 — hilang sekitar US$431 tanpa diapa-apain.

Skenario B: Rp70 juta di rupiah, Rp30 juta di USD. Kalau USD naik dari 16.207 ke 17.425, bagian USD gue naik menjadi sekitar Rp32,25 juta, sehingga kerugian daya beli dari rupiah bisa sebagian tertutup. Dengan hedge seperti ini, total portofolio gue jadi sekitar Rp102,25 juta di atas kertas, jadi loss-nya jauh lebih kecil daripada kalau semua cuma di rupiah.

Analoginya sama kayak asuransi. Asuransi kesehatan nggak dibeli supaya gue berharap sakit; dibeli supaya kalau sakit datang, kerusakannya nggak menghancurkan finansial. Hedge valas juga gitu. Gue beli USD/SGD bukan karena pengin rupiah hancur, tapi supaya kalau rupiah melemah, uang gue nggak semuanya terdampak.

Tapi hedge juga ada biaya dan risikonya. Kalau gue beli USD saat mahal, lalu rupiah menguat, nilai USD gue dalam rupiah bisa turun. Ada spread beli-jual dari bank. Makanya hedge biasanya sebagian, bukan all-in.

Intinya:

- Investasi = cari pertumbuhan.
- Hedge = cari perlindungan.
- Spekulasi = nebak harga naik-turun untuk profit cepat.

Sekarang, untuk kondisi rupiah sedang tertekan, yang gue butuh mungkin bukan spekulasi kurs, tapi hedge: sebagian rupiah tetap ada, sebagian disebar ke USD/SGD/emas/instrumen lain supaya risiko nggak numpuk di satu mata uang.

Data historis yang gue pakai sebagai ilustrasi: USD/IDR ~16.207 pada 2 Jan 2025 dan ~17.425 pada 11 Mei 2026. Angka ini bisa dicek dari API publik frankfurter.dev:
- https://api.frankfurter.dev/v1/2025-01-02?from=USD&to=IDR
- https://api.frankfurter.dev/v1/2026-05-12?from=USD&to=IDR
