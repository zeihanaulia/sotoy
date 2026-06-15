---
id: "zettel.ai.loop-enforcement-mechanisms"
title: "Mekanisme Penegakan Loop (Loop Enforcement)"
description: "Cara mengubah instruksi tekstual menjadi batasan fisik/mekanis dalam workflow AI agent untuk mencegah 'cheat path' dan memastikan disiplin."
tags:
  - ai-automation
  - guardrails
  - workflow-design
---

## Konsep
Instruksi dalam prompt (misal: "Tolong jalankan test sebelum selesai") sering diabaikan oleh AI jika ia merasa sudah menemukan solusi atau ingin mengakhiri tugas dengan cepat. **Loop Enforcement** adalah penggunaan mekanisme teknis untuk memaksa agent melewati jalur verifikasi.

## Bentuk Penegakan
1. **Physical Hooks**: Menggunakan event-driven hooks (seperti `PostToolUse` atau `Stop` hooks) yang menyuntikkan output tool secara otomatis ke dalam context window agent.
2. **Protocol Files**: Menggunakan file seperti `CLAUDE.md` sebagai referensi permanen yang mendefinisikan state machine dari tugas (Write $\rightarrow$ Check $\rightarrow$ Fix $\rightarrow$ Repeat).
3. **Escalation Paths**: Menyediakan sub-agent dengan context fresh (misal: `@fixer`) untuk memutus loop stagnan (stuck in a loop).

## Anti-Cheat Patterns
Untuk mencegah agent "curang" (misal: menghapus test agar pass), penegakan harus mencakup:
- **Test Integrity**: Larangan mengubah test suite selama loop implementasi.
- **No-Progress Detection**: Deteksi jika error yang sama muncul berulang kali, yang memicu penghentian loop atau eskalasi.

## Relasi
- [[notes.ai-engineering.claude-code-loop-setup]]: Contoh setup praktis menggunakan hooks dan protocol files.
- [[zettel.ai.verified-done]]: Tujuan akhir dari loop enforcement adalah mencapai status 'Verified Done'.
