---
id: zettel.20260421174751
title: "Quick Dev diagram: node-by-node diagnosis layer dan alur koreksi"
desc: "Analisis per node diagram Quick Dev, termasuk fungsi, input-output, failure mode, dan koneksi antar node." 
tags:
  - bmad
  - quick-dev
  - workflow
  - review
---

## Pertanyaan yang dibuka

1. Apa fungsi setiap node utama dalam diagram Quick Dev?
2. Bagaimana node-node itu membedakan jenis kegagalan berdasarkan layer?
3. Mengapa review Quick Dev membutuhkan jalur PATCH, BAD SPEC, INTENT GAP, DEFER, dan VOID?

## Klaim utama

Diagram Quick Dev adalah sistem kompresi keputusan: setiap node berfungsi sebagai stasiun penyaringan yang memetakan input kasar ke hasil yang dapat diterima.

Review bukan hanya QA. Review adalah diagnosis untuk menentukan apakah koreksi harus dilakukan di implementasi, spec, atau intent.

## Node breakdown

### Initial Intent
State awal, bukan aksi.

Fungsi: menandai bahwa input manusia biasanya masih kabur dan bukan goal eksekusi langsung.
Input: request awal apa pun.
Output: bahan baku untuk klarifikasi.
Failure mode: memperlakukan intent awal sebagai spesifikasi yang cukup.

### Clarify & Route
Node ini memurnikan intent dan memilih jalur.

Fungsi: menjadikan niat coherent dan memutuskan apakah task aman ke one-shot atau perlu plan.
Input: Initial Intent, interview manusia.
Output: intent lebih jelas dan rute eksekusi.
Failure mode: under-clarification atau misrouting.

### Plan
Node aksi untuk task berisiko.

Fungsi: membentuk strategi kerja terkompresi dan area yang akan disentuh.
Input: intent yang diklarifikasi.
Output: arah kerja untuk spec.
Failure mode: plan terlalu dangkal, terlalu berat, atau berbasis framing yang salah.

### Spec
Artefak boundary yang dibeku.

Fungsi: membekukan pemahaman yang cukup matang menjadi referensi eksekusi.
Input: plan.
Output: spec yang disetujui.
Failure mode: spec lemah atau salah, memicu jalur BAD SPEC.

### Implement
Eksekusi model terhadap spec atau intent one-shot.

Fungsi: menerjemahkan boundary ke perubahan nyata.
Input: spec atau intent.
Output: hasil implementasi.
Failure mode: bug lokal, atau kegagalan yang sebenarnya berasal dari spec/intent.

### Review
Pusat diagnosis dan routing koreksi.

Fungsi: menilai hasil implementasi dan menentukan layer koreksi.
Input: produk implementasi dan temuan reviewer.
Output: PATCH, BAD SPEC, INTENT GAP, DEFER, atau REJECT.
Failure mode: salah diagnosis atau triage buruk.

### Present
Packaging hasil untuk keputusan manusia.

Fungsi: mengubah artefak teknis menjadi ringkasan yang bisa dinilai.
Input: hasil review yang lolos.
Output: presentasi hasil.
Failure mode: presentasi buruk membuat decision expensive.

## Lihat juga

* [[zettel.20260421174123]] — BMAD Quick Dev mengoptimalkan attention manusia, bukan sekadar kecepatan model
* [[zettel.20260421175034]] — simulasi Quick Dev: reset password via email menunjukkan PATCH, BAD SPEC, dan INTENT GAP

### Result
Keputusan akhir manusia.

Fungsi: titik terima/tolak akhir.
Input: presentasi hasil.
Output: keputusan run.
Failure mode: informasi tidak cukup jelas atau artefak sulit dinilai.

## Review helper nodes

### Reviewers / Subagents
Fungsi: menyediakan sudut pandang spesifik tanpa membebani Review utama.

### PATCH
Fungsi: perbaikan lokal untuk masalah implementasi.

### BAD SPEC
Fungsi: kembali ke Spec saat boundary eksekusi salah.

### INTENT GAP
Fungsi: kembali ke Clarify & Route saat goal awal disalahtafsirkan.

### DEFER
Fungsi: menunda temuan incidental yang tidak kausal terhadap run saat ini.

### deferred_work.md
Fungsi: menyimpan temuan deferred agar tidak hilang.

### REJECT / VOID
Fungsi: menghentikan run yang tidak layak diteruskan.

## Sistem kompresi keputusan

Diagram Quick Dev mengompres layer kegagalan:

* kabut awal menjadi intent,
* intent menjadi plan/spec,
* spec menjadi perubahan kode,
* perubahan kode menjadi keputusan akhir.

Itu membuat workflow lebih disiplin: jika salah, dia tahu di mana harus kembali.

## Lihat juga

* [[zettel.20260421174123]] — BMAD Quick Dev mengoptimalkan attention manusia, bukan sekadar kecepatan model
* [[zettel.20260421171633]] — BMAD brainstorming memperjelas ide sebelum requirement
* [[zettel.20260421172430]] — BMAD named agents membangun AI coworker model, bukan sekadar persona lucu
