---
id: zettel.20260419192541
title: "Praktisnya instruksi standar tim untuk AI: role, konteks, prioritas, dan format"
desc: "Bentuk praktis instruksi standar tim yang bisa dieksekusi oleh AI dan memastikan konsistensi output di tim engineering."
tags:
  - permanent-note
  - ai
  - copilot
  - governance
  - workflow
---

> Instruksi standar tim yang efektif bukan sekadar daftar aturan. Ia harus jelas peran, eksplisit konteks, terstruktur berdasarkan prioritas, dan menghasilkan output yang konsisten.

Catatan gue:

- Instruksi harus memuat **role definition** agar AI diposisikan sebagai engineer yang benar: senior, arsitek, reviewer, atau maintainer.
- Semua konteks penting harus eksplisit: file terkait, arsitektur, libraries, batasan, dan batas scope task.
- Standar harus **dikategorikan menurut urgency/severity**, misalnya critical / important / advisory.
- Output harus terstruktur: summary, categorized findings, next steps.

Kenapa ini penting:

- Role definition memberi AI baseline judgment dan gaya kerja yang relevan.
- Konteks eksplisit mengurangi asumsi dan membuat prompt lebih deterministik.
- Prioritas menjaga output tidak noise dan fokus pada yang mesti dikerjakan.
- Format terstruktur membuat hasil bisa dibandingkan dan divalidasi.

Implikasi:

- Ini bukan sekadar template prompt; ini adalah desain artefak instruksi yang bisa dikelola tim.
- Tim perlu menyimpan instruksi ini di repo sebagai artefak versioned, bukan hanya di memo pribadi.
- Sebuah instruksi yang terstruktur mempermudah penambahan skills atau agent behavior di atasnya.

→ Dikuatkan oleh [[zettel.literature.encoding-team-standards]]
→ Terkait dengan [[notes.copilot.custom-instructions-best-practices]]
