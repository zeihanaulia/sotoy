
## Tentang Sumber

- **Judul**: Encoding Team Standards
- **Penulis / Author**: Rahul Garg
- **Tahun**: 2026
- **Jenis**: artikel
- **Link / ISBN**: Martin Fowler

---

## Catatan Per Gagasan

### 1. Problem utama: kualitas AI tergantung siapa yang menulis instruksi

> “The gap is not in what the AI knows about the project. It is in what the AI is told to do with that knowledge.”

Catatan gue: masalah utama bukan hanya model atau konteks repo. Masalahnya adalah bahwa judgement senior masih tersimpan di kepala seseorang, lalu diterjemahkan secara tidak konsisten lewat prompt.

- Senior tahu heuristic tim: arsitektur, error handling, folder placement, kapan refactor valid.
- Junior sering nulis prompt generik seperti “buat notification service” tanpa judgement tim.
- Hasil berbeda padahal tool, konteks, dan repo sama.

### 2. Dokumentasi biasa tidak cukup karena sifatnya pasif

> “A checklist on a wiki depends on someone reading it, remembering it, and applying it consistently under time pressure.”

Catatan gue: wiki / guideline / checklist masih bergantung pada manusia untuk memindahkan aturan ke tindakan.

- Dokumentasi memberi tahu, tapi tidak mengeksekusi.
- Dalam workflow AI, aturan harus melekat ke prompt dan model, bukan disimpan di halaman terpisah.
- Ini mirip lint/CI/IaC: sukses karena sistem menjalankan aturan, bukan karena orang mengingatnya.

### 3. Executable governance = membuat standar tim jadi artefak yang dijalankan AI

Eksekusi governance berarti standar tidak berhenti di tulisan. Ia harus:

- ditulis dan disimpan,
- direview oleh tim,
- di-PR-kan,
- lalu dipakai langsung oleh AI.

Intinya:

- tacit judgment jadi explicit.
- dokumentasi jadi instruction set.
- instruksi itu sendiri adalah aplikasi dari governance.

### 4. Bentuk praktis instruksi standar tim

Artikel mengusulkan empat elemen penting:

- Role definition: beri framing seperti "you are a senior engineer yang mengikuti pola arsitektur tim".
- Context requirements: sebutkan file, constraints, library, dan konteks yang diperlukan.
- Categorized standards: bagi cek ke level critical / important / advisory untuk menjaga prioritas.
- Output format: minta hasil yang terstruktur agar review konsisten.

Catatan gue: ini bukan sekadar template prompt. Ini mengencode judgement yang biasanya ada di kepala senior.

→ [[zettel.20260419192541]] — Praktisnya instruksi standar tim untuk AI: role, konteks, prioritas, dan format

### 5. Trade-off dan batasannya

Risiko utama:

- biaya awal tinggi: interview senior, drafting, kalibrasi.
- bisa terlalu preskriptif jika dibuat kaku.
- maintenance burden, karena tim dan arsitektur berubah.
- risiko over-engineering jika setiap hal kecil dibuat aturan khusus.

Catatan gue: pendekatan ini cocok kalau tim sudah mulai bergantung pada prompt tertentu dan standar kualitas team output AI belum stabil.

### 6. Batasan use case

Artikel menyebut cocok untuk:

- Generation: pencegahan misalignment sejak awal.
- Refactoring: encode filosofi tim tentang kontrak publik dan simplifikasi.
- Security: threat model tim sendiri, bukan checklist generik.
- Review: quality gate dengan severity konsisten.
- Optional CI: kalau bisa dibuat cepat dan tidak noisy.

### 7. Implementasi Copilot: dokumentasi, custom instructions, skills, agent behavior

Catatan gue: kalau ingin menerapkan prinsip artikel secara nyata di GitHub Copilot, lo perlu memetakan fungsi tiap layer.

- `documentation` menjelaskan alasan dan konteks untuk manusia.
- `custom instructions` (`.github/copilot-instructions.md`, `.github/instructions/*.instructions.md`) meng-encode aturan yang hampir selalu berlaku.
- `skills` adalah workflow task-specific yang dipanggil saat relevan.
- `agent instructions` / `AGENTS.md` mendefinisikan cara agent bertindak ketika pekerjaan lebih otonom.

Ini membuat struktur tim menjadi lebih rapi: docs untuk "kenapa", instructions untuk "apa yang harus diikuti", skills untuk "bagaimana melakukan", dan agent behavior untuk "bagaimana seharusnya agent mengambil keputusan".

## Zettels yang Dibuat dari Sumber Ini

- [[zettel.20260419190800]] — Judgement senior harus di-infrastrukturkan sebagai executable instruction AI
- [[zettel.20260419192040]] — Executable governance di Copilot butuh dokumentasi, custom instructions, skills, dan agent behavior
- [[zettel.20260419192239]] — Executable governance adalah standar tim yang bukan hanya ditulis, tapi dijalankan oleh AI
- [[zettel.20260419192541]] — Praktisnya instruksi standar tim untuk AI: role, konteks, prioritas, dan format
- [[zettel.20260419192952]] — Plan, onboarding, dan tracker adalah artefak governance AI, bukan dokumentasi pasif
- [[zettel.20260419193541]] — Plan AI bukan sekadar to-do list; ia adalah artefak governance operasional
- [[zettel.20260419193542]] — Onboarding docs penting untuk agent karena mereka menyediakan mental model repo
- [[zettel.20260419193543]] — Tracker adalah artefak observabilitas untuk workflow AI dan developer
- [[zettel.20260419193544]] — Agent eksplorasi codebase harus struktural, bukan sekadar search random

## Pertanyaan Terbuka

- Apa struktur terbaik untuk menaruh instruction this repo? (misal `ai/instructions/generation.md`, `review.md`, `security.md`)
- Bagaimana tim menjaga fleksibilitas tanpa jadi kaku saat semua instruksi di-commit ke repo?
- Kapan sebuah instruction sebaiknya dipisah menjadi beberapa unit kecil?
