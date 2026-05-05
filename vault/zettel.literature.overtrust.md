---
id: zettel.literature.overtrust
title: "Overtrust sebagai literature note: audit local trust boundary"
desc: "Literature note untuk repo Overtrust yang menggabungkan deteksi secret, manifest, dan process dalam konteks workstation trust boundary."
tags:
  - literature-note
  - security
  - agentic-coding
  - trust-boundary
source: https://github.com/cheese-cakee/overtrust
---

## Klaim

Overtrust bukan sekadar secret scanner; dia lebih menyerupai local audit untuk trust boundary developer workstation.

## Catatan

- Repo Overtrust fokus pada scan offline yang menggabungkan file, manifest, dan process.
- Source code utama menunjukkan workflow deterministik: filesystem walk, file classifier, manifest parser, secret detector, process scanner, lalu build report.
- Deteksi secret memakai kombinasi keyword, regex, entropy, dan false-positive guard.
- Deteksi risk process mencakup privilege tinggi, sensitive file descriptors, dan AI tool process identification.
- Overtrust mempertimbangkan ekstensi editor, NPM/Docker manifest, shell history, kredensial lokal, dan run-time process sebagai bagian dari trust boundary.

## Implikasi

- Audit security agentic coding harus memperhitungkan environment lokal, bukan hanya repository atau pipeline.
- Local trust boundary check paling efektif sebagai preflight signal, bukan sebagai verdict final.
- Rule-based local scanner dapat berguna untuk deteksi awal tetapi perlu maintenance jika threat landscape berubah.
- Tool yang memeriksa workstation harus diintegrasikan dengan workflow triage, bukan hanya sebagai alert pada CI.

## Hubungan

- [[notes.security.overtrust]]
- [[notes.security.overtrust.workflow-detail]]
- [[notes.security.overtrust-evaluation]]
- [[zettel.20260505179971]]
- [[zettel.20260505179972]]
- [[zettel.20260505179983]]
