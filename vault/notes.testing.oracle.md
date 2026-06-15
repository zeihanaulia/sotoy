---
id: notes.testing.oracle
title: "Oracle dalam software testing"
desc: "Penjelasan konsep test oracle sebagai sumber kebenaran independen untuk menilai hasil program."
updated: 1778468084908
created: 1778467692668
tags:
  - notes
  - testing
  - software-testing
  - oracle
  - validation
  - rust
  - bun
---

## Apa itu oracle?

Di konteks thread ini, "oracle" bukan Oracle perusahaan atau database.
Oracle adalah sumber kebenaran yang dipakai test untuk memutuskan apakah hasil program benar atau salah.

Kalau lo punya fungsi:

```text
input -> program -> output
```

oracle adalah mekanisme yang ngecek:

"untuk input ini, output yang benar harusnya apa?"

Kalau inputnya `2 + 2`, oracle-nya bisa berupa `4`.

## Asal kata oracle

Secara harafiah, "oracle" berasal dari pengertian lama tentang sumber jawaban yang dipercaya.
Di mitologi, oracle adalah orang atau tempat yang dianggap memberi nasihat bijak, ramalan, atau keputusan dari kekuatan lebih tinggi.

Jadi bukan karena bulan, bukan karena perusahaan Oracle.
Istilah ini dipakai karena fungsinya mirip: memberikan jawaban atau keputusan yang dianggap sahih.

## Makna oracle dalam konteks testing

Dalam software testing, istilah itu dipakai sebagai metafora.
Oracle bukan pelaksana program; dia adalah otoritas yang menjawab apakah output sudah sesuai.

Dengan kata lain:

- di dunia nyata, oracle = penasehat atau lembaga yang mengeluarkan keputusan benar/salah
- di testing, oracle = sumber yang menentukan kebenaran hasil program

Jadi di konteks thread Rhys:

- implementasi baru itu eksekutor
- test itu prosedur pemeriksaan
- oracle itu yang bilang "ini lulus" atau "ini gagal"

## Beda oracle dengan test

Sering kedengerannya sama, padahal beda.

- test = prosedur yang menjalankan pengecekan
- oracle = sumber kebenaran yang dipakai test untuk menilai hasil

Analogi:

- test = guru yang ngasih soal dan ngecek jawaban
- oracle = kunci jawaban

Jadi test tanpa oracle cuma jalanin program, tapi belum bisa bilang benar atau salah.

## Contoh oracle

A. Expected value langsung

```text
input: add(2, 3)
expected: 5
```

Oracle-nya: `5`.

B. Golden file / snapshot

```text
input: transpile(file.js)
expected: output cocok dengan file snapshot
```

Oracle-nya: snapshot/golden output.

C. Behavior-level oracle

```text
request HTTP tertentu
expected: status 200 + body tertentu
```

Oracle-nya: kontrak API.

D. Differential oracle

```text
jalankan implementasi lama dan baru
hasil harus sama
```

Oracle-nya: implementasi lama yang dipercaya.

## Kenapa oracle penting di rewrite Bun?

Karena rewrite besar berarti implementasi berubah total.
Pertanyaannya jadi:

"gimana kita tahu hasil baru masih benar?"

Jawabannya: karena ada oracle yang tidak ikut ditulis ulang bareng implementasinya.

Kalau implementasi dan oracle ditulis ulang dalam "bahasa mental" yang sama, verifikasi jadi rentan:

- bukan verifikasi yang independen
- tapi dua bug yang saling setuju

## Ketika oracle bisa jelek

Oracle juga bisa salah atau terlalu lemah.
Contoh oracle jelek:

- test cuma cek program tidak crash
- snapshot gampang di-update tanpa dipahami
- mock berlebihan sampai behavior asli tidak diuji
- test terlalu nempel ke struktur internal, bukan behavior
- oracle ikut diubah supaya test hijau

Di kasus rewrite, inilah yang mau dihindari.

## Ringkasnya

Oracle adalah sumber kebenaran yang dipakai test untuk menilai apakah software berperilaku benar.
Kalau lo lagi rewrite besar, kualitas oracle sering lebih penting daripada kecepatan nulis implementasi baru.

## Kaitan

- [[notes.software-architechture.bun-rewrite-oracle]]
