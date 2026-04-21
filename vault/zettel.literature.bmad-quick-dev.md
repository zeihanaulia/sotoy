---
id: zettel.literature.bmad-quick-dev
title: "BMAD Quick Dev sebagai literature note"
desc: "Catatan literature dari halaman BMAD Quick Dev yang menjelaskan desain workflow, intent compression, dan review triage." 
tags:
  - bmad
  - quick-dev
  - literature
  - workflow
---

## Pertanyaan yang dibuka

1. Apa klaim utama halaman BMAD Quick Dev tentang human attention dan model autonomy?
2. Bagaimana Quick Dev membedakan antara PATCH, BAD SPEC, dan INTENT GAP?
3. Mengapa review di Quick Dev dirancang sebagai triage, bukan exhaustive bug hunt?

## Ringkasan literatur

Halaman BMAD Quick Dev menjelaskan desain workflow yang membiarkan model berjalan lebih lama setelah intent dikompresi dan boundary disetujui.

Klaim utamanya adalah bahwa human attention adalah bottleneck utama, bukan sekadar latency model. Workflow ini memindahkan kontrol manusia ke momen-momen bernilai tinggi:

* intent clarification,
* spec approval,
* final review.

Review Quick Dev tidak hanya mencari bug. Ia berfungsi sebagai diagnosis layer kegagalan, memilih apakah koreksi harus terjadi di implementasi, spec, atau intent.

## Ide penting dari halaman

* Compress intent first — request awal dipadatkan menjadi goal coherent sebelum model berjalan.
* Route to the smallest safe path — kecil dan aman bisa one-shot, yang lain butuh plan/spec.
* Run longer with less supervision — model dapat ruang lebih lama setelah boundary disetujui.
* Diagnose failure at the right layer — jangan patch code jika failure berasal dari spec atau intent.
* Bring the human back only when needed — kurangi checkpoint rendah nilai.

## Interpretasi

Catatan ini bukan hanya menyalin isi. Halaman Quick Dev membentuk kerangka pemikiran yang berguna untuk menilai apakah sebuah task AI-native layak diberi jalur cepat atau harus diperlakukan sebagai perubahan berisiko.

Dengan menandai titik PATC, BAD SPEC, dan INTENT GAP, BMAD menyediakan bahasa yang membantu memetakan jenis koreksi yang tepat.

## Sumber

* Halaman BMAD Quick Dev: https://docs.bmad-method.org/explanation/quick-dev/

## Lihat juga

* [[zettel.20260421174123]] — BMAD Quick Dev mengoptimalkan attention manusia, bukan sekadar kecepatan model
* [[zettel.20260421174751]] — Quick Dev diagram: node-by-node diagnosis layer dan alur koreksi
* [[zettel.20260421175034]] — simulasi Quick Dev: reset password via email menunjukkan PATCH, BAD SPEC, dan INTENT GAP
