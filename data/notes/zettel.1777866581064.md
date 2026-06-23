
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
