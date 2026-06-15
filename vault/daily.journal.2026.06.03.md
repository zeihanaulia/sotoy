---
id: daily.journal.2026.06.03
title: "2026-06-03"
desc: "Catatan baca Hermes Agent Memory Providers dan Honcho stateful memory."
updated: 1780427822719
created: 1780422819041
---

Hari ini gue baca dokumentasi Hermes Agent tentang memory provider. Yang menarik adalah perbedaan antara memori bawaan (`MEMORY.md` / `USER.md`) dan provider eksternal. Built-in memory tetap aktif, dan provider eksternal berfungsi sebagai lapisan tambahan untuk persistent memory lintas sesi.

Inti yang gue tangkap:

- External provider bukan sekadar penyimpanan chat, tapi backend untuk retrieval dan context injection.
- Hanya satu provider eksternal yang bisa aktif sekaligus, supaya konflik sumber, biaya, latency, dan governance tetap terkendali.
- Pilihan provider adalah keputusan epistemik: agent bisa diatur untuk mengingat preferensi user, struktur knowledge project, atau relasi antar entitas.

Beberapa provider yang dicatat:

- `Honcho`: user modeling / cross-session context.
- `OpenViking`: filesystem knowledge hierarchy.
- `Mem0`: automatic memory extraction.
- `Hindsight`: knowledge graph + synthesis.
- `Holographic`: local SQLite + trust scoring.
- `RetainDB`: hybrid cloud search + compression.
- `ByteRover`: local-first CLI memory tree.
- `Supermemory`: semantic memory + context fencing.
- `Memori`: structured long-term memory dengan tool-aware recall.

Sekarang ada catatan terpisah tentang OpenViking sebagai context database di [[notes.agentic-engineering.openviking-context-database]], arsitektur OpenViking di [[notes.agentic-engineering.openviking.architecture]], storage architecture di [[notes.agentic-engineering.openviking.storage-architecture]], context extraction di [[notes.agentic-engineering.openviking.context-extraction]], dan context layers OpenViking di [[notes.agentic-engineering.openviking.context-layers]].

Kalau nanti mau nulis lebih panjang, ada `vault/notes.agentic-engineering.hermes-agent.memory-providers.md` yang merangkum pilihan provider dan trade-off-nya. Ini membantu gue ingat bahwa pilihan provider Hermes Agent lebih dari sekadar "storage".

Hari ini gue juga baca dokumentasi Honcho. Yang bikin beda menurut gue:

- Honcho bukan cuma menyimpan chat, tapi membangun state model tentang entitas yang berubah.
- Dia pakai konsep `peer`, bukan cuma `user`, sehingga bisa memodelkan manusia, agent, grup, ide, atau objek.
- Honcho ingin reasoning, bukan sekadar retrieval. Pesan menjadi evidence, lalu disimpulkan menjadi representation.
- Ini paling cocok untuk agent stateful, multi-agent, atau use case yang perlu memahami perubahan konteks dari waktu ke waktu.

Jadi hari ini ada dua level pemahaman: Hermes memory provider sebagai peta arsitektur memory, dan Honcho sebagai model stateful agent dengan entity-centric reasoning.
## Related documents

- [[notes.agentic-engineering.hermes-agent.memory-providers]]
- [[notes.agentic-engineering.openviking-context-database]]
- [[notes.agentic-engineering.openviking.architecture]]
- [[notes.agentic-engineering.openviking.storage-architecture]]
- [[notes.agentic-engineering.openviking.context-extraction]]
- [[notes.agentic-engineering.openviking.context-types]]
- [[notes.agentic-engineering.honcho.stateful-memory]]
- [[notes.agentic-engineering.honcho.architecture]]
- [[notes.agentic-engineering.honcho.reasoning]]
- [[notes.agentic-engineering.honcho.peer-representations]]
- [[notes.agentic-engineering.honcho.design-patterns]]
