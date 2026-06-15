---
id: zettel.moc.local-llm
title: "MOC Local LLM dan Copilot agent"
desc: "Peta topik untuk catatan tentang local LLM, Copilot agent overhead, billing token, dan hardware upgrade."
updated: 1777985390775
created: 1777983980703
tags:
  - moc
  - local-llm
  - copilot
  - ai-native
---

## Apa yang terkandung di sini

Catatan ini mengumpulkan insight praktis tentang local LLM untuk coding agent, termasuk:

- problem ekonomi billing Copilot yang sekarang berbasis token,
- perbedaan antara model murah dan total cost-per-task,
- kinerja lokal di Mac M1 dan pentingnya menghindari swap,
- hardware upgrade 4090/3090 sebagai total ownership decision,
- peran agent harness dan workflow yang benar.

## Permanent note lokal LLM

* [[zettel.20260505180207]] — Copilot agent overhead sering jadi penyebab latency, bukan kualitas model lokal
* [[zettel.20260505180208]] — Mac M1 16GB realistis untuk local coding agent, tapi 30B bukan daily driver
* [[zettel.20260505180209]] — Copilot billing berubah dari message budget ke compute/token budget
* [[zettel.20260505180210]] — Total ownership cost local LLM mencakup listrik, PSU, casing, dan maintenance
* [[zettel.20260505180211]] — API pricing ditentukan oleh active parameter dan optimisasi provider, bukan usia model
* [[zettel.20260505180212]] — Efektivitas coding agent lebih tergantung workflow dan state management daripada ukuran model
* [[zettel.20260505180229]] — Swap adalah pembunuh kinerja utama untuk LLM lokal di Mac M1 16GB
* [[zettel.20260505180230]] — Hitung biaya coding agent berdasarkan total task cost, bukan hanya harga per token
* [[zettel.20260505180231]] — Cloud GPU rental sering lebih rasional daripada beli 4090 untuk penggunaan eksperimental

## Catatan terkait di vault

* [[notes.copilot.raptor-mini-sml-budgeting]] — local SML, billing Copilot, dan agent coding konteks
* [[notes.copilot.local-llm-hardware-upgrade]] — detail hardware upgrade dan total ownership cost untuk local LLM
* [[notes.copilot.token-cheap-coding-agent-providers]] — provider-token murah untuk agent coding

## MOC terkait

* [[zettel.moc.ai-native]] — MOC AI-native engineering
* [[zettel.moc.software-architecture]] — entry point arsitektur yang lebih luas
