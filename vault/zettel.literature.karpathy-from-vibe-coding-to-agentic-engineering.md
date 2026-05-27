---
id: zettel.literature.karpathy-from-vibe-coding-to-agentic-engineering
title: "Karpathy — From Vibe Coding to Agentic Engineering"
desc: "Literature note tentang talk YouTube Andrej Karpathy dan pergeseran dari AI-asisten ke agentic engineering."
updated: 1779859715876
created: 1778126769000
tags:
  - zettel
  - literature-note
  - agentic-engineering
  - karpathy
---

Link: [[notes.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]

## Claim
Karpathy menunjukkan bahwa AI membuat detail implementasi bisa didelegasikan, tetapi justru meningkatkan nilai understanding, taste, spec, verifikasi, dan judgment manusia.

## Evidence
- Trust threshold yang dilewati pada akhir 2023 membuat workflow bergeser dari "AI assistant" ke "AI production".
- Dalam Software 3.0, prompt dan context window menjadi lever untuk interpreter LLM.
- Karpathy melihat Software 3.0 bukan cuma tentang menulis kode lebih cepat, tapi juga tentang mengotomasi general information processing: LLM bisa mengambil dokumen mentah dan "recompile" mereka menjadi wiki/knowledge base yang lebih mudah dipahami manusia.
- Vibe coding menaikkan floor sementara agentic engineering menjaga quality bar.
- Model LLM tetap jagged; kemampuan tinggi di domain verifiable tidak menjamin reasoning umum.
- Infrastruktur saat ini masih human-native; agen perlu environment yang dibangun untuk mereka.

## LLM knowledge base
- Karpathy menegaskan bahwa LLM knowledge base bukan hanya RAG atau vector database. Ia adalah proyek untuk membuat "wikis for your organization or for you in person" dari kumpulan dokumen, sehingga informasi mentah bisa direframing, dikelompokkan, dan dipresentasikan sebagai struktur pemahaman baru.
- Ini bukan sekadar "cari dokumen relevan". Ini tentang memproyeksikan ulang informasi supaya manusia dapat insight baru: outline, glossary, timeline, q&a, dependency graph, dan halaman konsep.
- Baginya, LLM knowledge bases membantu proses berpikir manusia—bukan menggantikan understanding. Oleh karena itu ia menambahkan: "you can outsource your thinking but you can't outsource your understanding." Tool ini mendukung understanding enhancement, bukan outsourcing pemahaman.

## External support
- Business Insider menulis bahwa Karpathy merasa "never felt more behind as a programmer" pada akhir **Desember 2025**, dan bahwa profesi programmer sedang "dramatically refactored" oleh AI tools.
- Business Insider mencatat Karpathy menulis bahwa agentic coding tools "crossed some kind of threshold of coherence around December 2025 and caused a phase shift in software engineering." Ini menguatkan bahwa Desember 2025 adalah pivot point, bukan sekadar framing pada talk April 2026.
- Business Insider juga menyebut pergeseran rasio Karpathy: dari sekitar 80% manual / 20% agent pada awal November 2025, menuju 80% agent / 20% manual editing setelah December 2025.
- Karpathy juga publish GitHub Gist `llm-wiki` awal April 2026, yang menjadi blueprint komunitas untuk membangun LLM knowledge bases sebagai markdown wiki yang terus disintesis, bukan sekadar RAG.
- Y Combinator talk "Software Is Changing (Again)" (Juni 2025) memberi konteks awal Software 3.0 dan membantu menempatkan talk Sequoia sebagai kelanjutan tesis tersebut.
- Karpathy Medium "Software 2.0" (11 November 2017) adalah akar historis untuk pergeseran paradigma yang dibawa ke Software 3.0.
- Referensi tambahan yang relevan: paper arXiv tentang vibe coding, agentic coding, dan trust/flow; TechRadar tentang bottleneck delivery; Denser.ai tentang ide LLM Wiki.

## Sources
- https://www.businessinsider.com/openai-founding-member-never-felt-so-behind-programmer-2025-12
- https://www.businessinsider.com/andrej-karpathy-claude-code-manual-skills-atrophy-software-engineering-tesla-2026-1
- https://www.youtube.com/live/LCEmiRjPEtQ
- https://karpathy.medium.com/

## Related notes
- [[notes.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]
- [[daily.journal.2026.05.07]]
- [[zettel.moc.agentic-engineering]]
- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.llm-wiki]]
- [[zettel.20260507100000]]
- [[zettel.20260507100100]]
- [[zettel.20260507100200]]
- [[zettel.20260507100900]]
