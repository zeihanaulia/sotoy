---
id: zettel.20260420055619
title: "ADR sehat memaksa maintainer mengubah perilaku, bukan sekadar menambah dokumen"
desc: "Contoh nyata ADR yang efektif sebagai decision log dan pengarah implementasi di repo nyata."
tags:
  - permanent-note
  - architecture
  - adr
  - process
---

> ADR yang sehat bukan dokumen rapih; ia adalah mekanisme yang mengubah cara maintainer review, link issue/PR, dan buat supersede saat konteks berubah.

Catatan gue:

- Ketika sebuah repo memiliki kasus nyata seperti OpsTrack dengan Laravel + Blade + Alpine, ADR bukan sekadar "catatan frontend".
- ADR yang benar akan memaksa tim menyatakan:
  - masalah konkret yang dihadapi,
  - keputusan spesifik yang diambil,
  - alternatif yang benar-benar dipertimbangkan,
  - trigger kapan keputusan perlu direvisi.
- Hal paling penting: setelah ADR diterima, maintainer harus menerjemahkannya jadi aturan review dan referensi kerja.

Simulasi nyata:

1. Situasi proyek:
   - Produk SaaS internal: OpsTrack.
   - Stack: Laravel monolith, Blade + Alpine.js, PostgreSQL.
   - Tim: 5 engineer, mayoritas backend.
   - Problem: dashboard makin interaktif, tim bingung apakah harus pindah ke React SPA.

2. ADR yang expected:
   - File: `doc/adr/0007-use-htmx-for-high-interactivity-server-rendered-pages.md`
   - Isi: context, decision, alternatives, consequences, revisit triggers, related PR/RFC.
   - Keputusan: pakai HTMX untuk interaksi kaya di halaman server-rendered.

3. Apa maintainer lakukan setelah ADR accepted:
   - link ADR ke PR implementasi (`#1842`), issue, dan frontend guideline.
   - pakai ADR sebagai dasar review: tolak PR React yang melanggar keputusan.
   - buat guardrail operasional: HTMX untuk partial update dan modal, bukan untuk shared client state.
   - monitoring: amati duplikasi fragment dan konsistensi pola.
   - jika kondisi berubah, buat ADR baru dan supersede ADR lama.

4. Implementasi bagus vs jelek:
   - Bagus: ADR menjadi referensi review, ada guideline HTMX vs SPA, dan ada trigger revisi.
   - Jelek: ADR dibuat belakangan, tidak dirujuk saat PR, atau diedit diam-diam tanpa supersede.

5. Indikator ADR sehat:
   - decisions dipakai dalam review dan issue.
   - ada referensi PR/issue/RFC.
   - ada batasan scope yang jelas.
   - ada trigger revisi yang eksplisit.
   - tim bisa menjelaskan apakah ADR ini masih valid.

Failure mode paling umum:

- ADR hanya kosmetik: dokumen dibuat, tapi maintainer tetap pakai pola campur-aduk.
- ADR ditulis setelah implementasi selesai: jadi rasionalisasi, bukan keputusan.
- ADR diedit ulang: sejarah alasan hilang.
- ADR terlalu generic atau terlalu banyak: noise, bukan signal.

Implikasi:

- ADR harus dilekatkan ke perilaku maintainer, bukan cuma ke folder `doc/adr`.
- Review, issue, dan PR adalah area di mana ADR sehat tampil.
- Jika repo tidak berubah setelah ADR, berarti ADR itu belum bekerja.

→ Dikuatkan oleh [[zettel.literature.architecture-decision-records]]
