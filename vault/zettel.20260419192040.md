---
id: zettel.20260419192040
title: "Executable governance di Copilot butuh dokumentasi, custom instructions, skills, dan agent behavior"
desc: "Prinsip Martin Fowler tentang mengeksekusi standar tim lewat AI diterjemahkan ke dalam lapisan Copilot: docs, custom instructions, skills, dan agent instructions."
tags:
  - permanent-note
  - copilot
  - ai
  - governance
  - workflow
---

> Untuk membuat judgement senior bisa digunakan secara konsisten, tim perlu membangun stack instruksi yang berlapis: dokumentasi untuk manusia, custom instructions untuk aturan umum, skills untuk workflow spesifik, dan agent behavior untuk task otonom.

Catatan gue:

- `documentation` tetap penting sebagai konteks panjang dan alasan. Ia membantu onboarding dan menjelaskan kenapa aturan ada.
- `custom instructions` (`.github/copilot-instructions.md` dan `.github/instructions/*.instructions.md`) meng-encode aturan repo-wide dan context-specific yang hampir selalu berlaku.
- `skills` adalah playbook task-specific yang dipanggil saat relevan, misalnya `systematic-debugging` atau `bug-reporting`.
- `agent instructions` / `AGENTS.md` mendefinisikan perilaku Copilot agent saat task lebih otonom.

### Bentuk praktis instruksi

Praktik yang benar bukan "tulisan panjang di dalam prompt", tapi file artefak yang berfungsi sebagai kontrak operasi.

- `.github/copilot-instructions.md` untuk hukum umum repo: tujuan utama, standar must/should/avoid, validasi akhir, dan dokumen onboarding yang harus dibaca.
- `.github/instructions/*.instructions.md` untuk aturan domain atau path-specific: kapan berlaku, apa yang harus diikuti di area itu, dan output yang diharapkan.
- `AGENTS.md` untuk agent behavior: bagaimana agent merencanakan, kapan berhenti, kapan eskalasi, dan kapan memprioritaskan bukti sebelum eksekusi.
- `.github/skills/<skill>/SKILL.md` untuk workflow task-specific: input yang diperlukan, langkah diagnosis/implementasi, dan format output yang konsisten.
- Konteks tambahan seperti `docs/onboarding/`, `docs/plans/tasks/`, dan tracker dipakai sebagai sumber niat dan batasan.

Bentuk praktis ini menekankan empat hal:
1. role dan orientasi keputusan (misalnya "bertindak sebagai senior engineer").
2. konteks wajib baca sebelum mulai (misalnya onboarding+plan).  
3. prioritas standar `Must / Should / Avoid` yang terstruktur.  
4. output terformat yang bisa diaudit.

### Referensi praktis

- GitHub Docs: Adding repository custom instructions for GitHub Copilot
  https://docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot
- GitHub Docs: Your first custom instructions
  https://docs.github.com/en/copilot/tutorials/customization-library/custom-instructions/your-first-custom-instructions
- GitHub Docs: Support for different types of custom instructions
  https://docs.github.com/en/copilot/reference/custom-instructions-support
- GitHub Docs: Adding agent skills for GitHub Copilot
  https://docs.github.com/en/copilot/how-tos/use-copilot-agents/cloud-agent/add-skills
- GitHub Docs: About agent skills
  https://docs.github.com/en/copilot/concepts/agents/about-agent-skills
- Martin Fowler: Encoding Team Standards
  https://martinfowler.com/articles/reduce-friction-ai/encoding-team-standards.html

Implikasi:

- Ini jadi arsitektur governance, bukan sekadar prompt collection.
- Tanpa pemisahan ini, repo Copilot mudah jadi berantakan: aturan umum, aturan khusus, dan workflow bisa saling tumpang tindih.
- Paling baik mulai dari satu global instruction, satu atau dua path-specific instructions, dan satu skill penting. Setelah itu selalu kalibrasi berdasarkan penggunaan.

→ Dikuatkan oleh [[zettel.literature.encoding-team-standards]]
→ Berhubungan dengan [[notes.copilot.custom-instructions-best-practices]]
