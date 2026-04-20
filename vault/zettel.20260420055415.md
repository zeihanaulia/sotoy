---
id: zettel.20260420055415
title: "ADR accepted harus disupersede, bukan diedit ulang"
desc: "Menjaga sejarah keputusan arsitektur utuh berarti keputusan lama tidak diubah; jika konteks berubah, buat ADR baru yang supersede."
tags:
  - permanent-note
  - architecture
  - adr
  - history
---

> Setelah ADR diterima, dokumen itu harus dibiarkan sebagai fakta historis. Perubahan dibuat dengan ADR baru yang supersede, bukan dengan memodifikasi catatan lama.

Catatan gue:

- Mengedit ADR lama sama dengan menghapus jejak alasan dan asumsi yang pernah berlaku.
- Sejarah keputusan penting untuk memahami mengapa arah lama pernah dipilih, terutama saat konteks berubah.
- Pola ini mirip event sourcing: fakta lama tetap ada, dan status baru ditambahkan sebagai supersede.

Implikasi:

- Tim sebaiknya memelihara status ADR (proposed, accepted, superseded) sebagai bagian dari workflow.
- Supersede membuat audit trail keputusan arsitektur lebih dapat dipercaya.
- Ini juga membantu saat evaluasi retrospectif atau onboarding anggota baru yang butuh tahu evolusi keputusan.

→ Dikuatkan oleh [[zettel.literature.architecture-decision-records]]
