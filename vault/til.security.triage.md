---
id: til.security.triage
title: "TIL: apa itu triage di security review"
desc: "Triage adalah proses menyaring dan memprioritaskan temuan keamanan setelah tool atau agent menghasilkan alert."
updated: 1777995719366
created: 1777992865532
tags:
  - til
  - security
  - triage
---

Triage secara harfiah berarti proses mengelompokkan dan memprioritaskan berdasarkan tingkat urgensi. Dalam konteks security atau technical review, triage dipakai untuk menyortir temuan setelah tool atau agent menghasilkan alert.

Di security review, triage berada setelah deteksi: tool/agent mengeluarkan daftar issue, lalu tim atau sistem melakukan verifikasi, klasifikasi, dan prioritas. Ini bukan hanya soal menghitung jumlah alert, tapi soal membuat keputusan yang bisa ditindaklanjuti.

Contoh kasus:
- Agent menemukan 40 alert di satu scan.
- Tim triage memeriksa dan menemukan 8 issue valid dengan severity critical/high, 12 issue valid dengan severity medium/low, 10 false positive, dan 10 alert yang perlu investigasi lebih lanjut.
- Hasil triage: 8 issue critical/high dijadikan prioritas perbaikan sekarang, 12 issue medium/low dimasukkan backlog, 10 false positive ditutup, dan 10 alert lain dicatat untuk follow-up.

Jadi, triage di security review adalah proses menyaring dan memprioritaskan alert supaya tim tahu mana yang benar-benar penting, mana yang bisa ditunda, dan mana yang tidak perlu ditindaklanjuti.

## Related Notes
- [[daily.journal.2026.05.05]]
