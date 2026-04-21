---
id: zettel.20260421180059
title: "Checkpoint Preview membuat review manusia fokus pada pemahaman, bukan sekadar diff"
desc: "Checkpoint Preview mengembalikan manusia ke loop akhir dengan urutan review yang dirancang untuk comprehension, bukan file order git diff." 
tags:
  - bmad
  - checkpoint-preview
  - review
  - ai-native
---

## Pertanyaan yang dibuka

1. Mengapa git diff saja tidak cukup untuk review perubahan AI-native?
2. Bagaimana Checkpoint Preview membantu reviewer membangun model mental perubahan?
3. Apa perbedaan antara review sebagai bug hunt dan review sebagai comprehension workflow?

## Klaim utama

Checkpoint Preview bukan alat bug hunt otomatis. Ia adalah workflow review interaktif yang menyusun ulang perubahan agar manusia bisa memahami intent dan desain sebelum mengambil keputusan.

Review ini penting karena diff tradisional mempresentasikan perubahan berdasarkan file order, bukan berdasarkan cara manusia membangun pemahaman.

## Penjelasan

Dalam BMAD, Quick Dev mengurangi interupsi manusia saat implementasi. Checkpoint Preview membawa manusia kembali ke loop saat keputusan akhir diperlukan.

Checkpoint Preview mendorong reviewer untuk memulai dari:

* orientasi scope dan surface area,
* walkthrough berdasarkan concern,
* detail pass pada risiko tinggi,
* observasi perilaku melalui testing,
* wrap-up keputusan.

Ini membuat review lebih seperti membentuk model mental daripada membaca daftar perubahan.

## Implikasi

* Reviewer tidak lagi bergantung pada urutan file atau hunk di git diff.
* Attention manusia dialokasikan ke area blast radius tinggi, bukan semua perubahan sekaligus.
* Review menjadi activity of judgment, bukan activity of reconstruction.

## Lihat juga

* [[zettel.literature.checkpoint-preview]] — literature note BMAD Checkpoint Preview
* [[zettel.20260421174123]] — BMAD Quick Dev mengoptimalkan attention manusia, bukan sekadar kecepatan model
* [[zettel.20260421174751]] — Quick Dev diagram: node-by-node diagnosis layer dan alur koreksi
