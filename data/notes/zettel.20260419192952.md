
> Dokumentasi tetap perlu, tapi fungsinya untuk manusia: menjelaskan kenapa aturan itu ada, memberi contoh, jadi referensi onboarding, menyimpan konteks yang lebih panjang.

Catatan gue:

- Plan bukan sekadar to-do list. Ia adalah dokumen kerja sebelum eksekusi yang berisi tujuan, scope, asumsi, langkah, dan bukti progres.
- Agent exploration codebase harus dipaksa membaca struktur, file penting, relasi modul, dan alur sistem. Ini bukan search random.
- Dengan plan, tracker, dan onboarding docs, lo membangun operating system kerja tim, bukan hanya docs pendukung Copilot.
- Artifact ini menjadi:
  - alat berpikir,
  - kontrak kerja untuk agent,
  - logika audit,
  - memori tim.
- Risiko terbesar adalah jika plan jadi dokumentasi mati: tidak sinkron dengan kerja nyata, tracker basi, agent jalan sendiri, docs tidak digunakan.

### Zettel atomik terkait

- [[zettel.20260419193541]] — Plan AI bukan sekadar to-do list; ia adalah artefak governance operasional
- [[zettel.20260419193542]] — Onboarding docs penting untuk agent karena mereka menyediakan mental model repo
- [[zettel.20260419193543]] — Tracker adalah artefak observabilitas untuk workflow AI dan developer
- [[zettel.20260419193544]] — Agent eksplorasi codebase harus struktural, bukan sekadar search random

Implikasi:

- Ini adalah bentuk executable governance yang lebih luas: bukan hanya rules untuk AI, tapi artefak niat dan observabilitas.
- Struktur yang sehat adalah:
  - orientation (`docs/onboarding/*`),
  - intention (`docs/plans/analisa`, `docs/plans/tasks`),
  - execution governance (instructions, skills, agents),
  - traceability (`docs/plans/tracker`).

→ Dikuatkan oleh [[zettel.literature.encoding-team-standards]]
