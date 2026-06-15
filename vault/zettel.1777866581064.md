---
id: zettel.1777866581064
title: "Knowledge graph + blast radius mengurangi context waste dalam agent code review"
desc: "Graph struktur persistent dan blast radius membantu memilih subset file relevan untuk agent, sehingga reasoning lebih fokus dan token tidak terbuang."
updated: 1777866657847
created: 1777866601530
tags:
  - zettel
  - knowledge-graph
  - code-review
  - agent
---

Masalah yang dicek oleh repo seperti code-review-graph bukan sekadar "bisa baca kode". Ini masalah "berapa banyak kode yang harus dibaca sebelum agen mulai berpikir".

Pendekatannya adalah:

- simpan struktur repo sebagai graph persistent, termasuk function, class, import, dan dependency.
- update graph secara incremental ketika file berubah.
- hitung blast radius untuk perubahan tertentu: caller, callee, dependent, test terkait, dan file terdampak.
- beri agen subset file yang relevan, bukan seluruh repo.

Kalau konteks dipilih dengan lebih pintar, model bisa fokus pada problem sebenarnya. Ini menjadikan graph bukan sekadar artefak teknis, tapi "filter konteks" yang mengurangi noise dan memperkecil token budget.

Intinya:

- context waste adalah bottleneck nyata di code review otomatis.
- persistent graph + incremental update adalah cara logis untuk mengurangi overhead pemilihan konteks.
- blast radius menempatkan agent pada area yang mungkin terdampak, bukan pada seluruh kodebase.
