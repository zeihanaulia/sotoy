---
id: zettel.20260420055413
title: "ADR adalah decision log yang merekam alasan, bukan dokumentasi desain"
desc: "Architectural Decision Record (ADR) lebih fokus pada jejak alasan dan konteks keputusan daripada detail implementasi arsitektur."
tags:
  - permanent-note
  - architecture
  - adr
  - decision-making
---

> ADR adalah catatan singkat tentang satu keputusan arsitektur, lengkap dengan konteks dan konsekuensi, supaya tim tidak kehilangan "kenapa" di balik "apa".

Catatan gue:

- Dokumen arsitektur besar sering menjelaskan struktur, tapi tidak selalu merekam alasan di balik pilihan.
- Fowler menekankan ADR sebagai harga untuk menyimpan jejak alasan yang murah dan bisa dibaca cepat.
- Ringkasnya, ADR menjadi semacam "commit message" untuk keputusan arsitektur: bukan apa yang berubah, tapi kenapa arah itu dipilih.

Implikasi:

- Tim harus memilih keputusan mana yang benar-benar layak dicatat sebagai ADR.
- ADR tidak boleh berubah menjadi dokumentasi panjang yang sulit dikonsumsi.
- Nilai ADR muncul saat nanti tim ingin memahami alasan historis, bukan sekadar melihat diagram atau kode.

→ Dikuatkan oleh [[zettel.literature.architecture-decision-records]]
