---
id: zettel.20260421193757
title: "Kapan struktur AI-native jadi layak dipakai dan kapan ia justru overkill"
desc: "Menjelaskan kriteria praktis untuk memilih level struktur yang tepat pada workflow AI-native, dari full operating model hingga task-level execution." 
tags:
  - ai-native
  - workflow
  - decision-making
  - risk
---

## Pertanyaan yang dibuka

1. Kapan pendekatan AI-native berstruktur layak dipakai?
2. Kapan struktur itu justru menjadi overkill?
3. Bagaimana menilai proporsionalitas antara risiko dan proses?

## Klaim utama

Kematangan AI-native engineering tidak ditandai oleh penggunaan semua tool dan proses. Ia ditandai oleh kemampuan merutekan task ke tingkat struktur yang paling kecil tetapi masih aman.

> Struktur bukan tujuan. Struktur adalah cara mengelola risiko.

## Kriteria layak dipakai

Pendekatan terstruktur layak ketika:

* biaya salah tinggi,
* blast radius perubahan besar atau multi-file,
* ada banyak agent/engineer yang terlibat,
* ada potensi konflik teknis atau bisnis,
* output harus konsisten dengan sistem lama,
* atau area yang disentuh sensitif (security, billing, public API, data schema).

Dalam konteks ini, struktur tambahan membantu menjaga drift agar tetap terkendali dan membuat reasoning dapat di-review.

## Kriteria overkill

Struktur menjadi overkill ketika:

* task kecil dan jelas,
* blast radius rendah,
* perubahan terisolasi dan mudah diverifikasi,
* artifak proses lebih mahal daripada benefitnya.

Contoh overkill:

* mengganti teks UI kecil,
* memperbaiki typo,
* update minor pada helper lokal,
* bug fix sederhana dengan scope terbatas.

Di situ, workflow ringan atau Quick Dev dengan context yang cukup sering lebih efisien.

## Menilai proporsionalitas

Tanya dulu:

* seberapa ambigu task ini?
* seberapa besar dampak salahnya?
* seberapa kompleks domain atau sistem yang terlibat?
* apakah tim bisa memvalidasi hasil dengan mudah?

Jika jawaban menunjukkan risiko besar, layak menambah struktur. Jika jawaban menunjukkan task kecil, struktur besar hanya menambah overhead.

## Implikasi

* AI-native bukan berarti selalu pakai proses berat.
* Ia berarti pakai proses yang sesuai dengan risiko.
* Struktur yang baik adalah struktur yang bisa ditarik mundur ketika task memungkinkan.

## Lihat juga

* [[zettel.20260421174123]] — BMAD Quick Dev mengoptimalkan attention manusia, bukan sekadar kecepatan model
* [[zettel.20260421180059]] — Checkpoint Preview membuat review manusia fokus pada pemahaman, bukan sekadar diff
* [[zettel.20260421185424]] — Party Mode adalah mesin konflik terkontrol untuk menampilkan trade-off multi-agent
* [[zettel.moc.ai-native]]
