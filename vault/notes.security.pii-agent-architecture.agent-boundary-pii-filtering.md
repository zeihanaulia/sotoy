---
id: notes.security.pii-agent-architecture.agent-boundary-pii-filtering
title: "PII guardrail antar-agent: dari x402 ke brainstorming + coding agent"
desc: "Menyambungkan motif pre-execution x402 ke arsitektur dua agent yang perlu menyaring PII sebelum context dan artifact berpindah.
"
updated: 1777882257031
created: 1777882257031
tags:
  - notes
  - security
  - pii
  - agent
---

Waktu gue baca `Hardening x402`, yang nyantol bukan blockchain-nya. Yang nyantol adalah pola arsitekturnya: data harus dicegat sebelum berpindah boundary, lalu disaring sebelum dia diproses lebih lanjut.

Itu yang bikin paper ini relevan buat sistem dua-agent gue/elo.

## Dua agent dan satu problem yang sama

Di sistem gue ada dua peran yang jelas:

- **Brainstorming Agent**: dia yang baca requirement, dokumen bisnis, meeting notes, screenshot, atau input user. Dia bikin PRD, Jira task, breakdown, atau desain solusi.
- **Coding Agent**: dia yang baca artifact dari brainstorming agent plus context repo, lalu output-nya jadi code, patch, test, review, atau implementasi teknis.

Kalau gue tidak pasang proteksi boundary, PII bisa turun dari user input ke artifact engineering lalu ke generated code / repo / trace.

Contoh yang gue lihat bisa bocor:

- prompt LLM berisi screenshot atau dokumen dengan NIK / nomor rekening,
- vector DB index malah menyimpan teks asli,
- Jira issue atau Confluence page berisi detail pribadi,
- coding agent nulis unit test pakai data nyata,
- trace Langfuse mencatat tool args berisi email atau nomor telepon.

## Mapping dari x402 ke agent case

Di paper, fokusnya bukan payment value atau settlement. Fokusnya adalah tiga field metadata x402 yang ikut melekat pada request dan bisa mengandung PII:

- `resource_url`: alamat atau identifier resource yang dibayar. Di situ bisa ada path/user id/slug yang membawa informasi sensitif.
- `description`: teks penjelasan transaksi. Ini sering jadi tempat “alasan bisnis”, dan bisa memuat nama, email, rekening, atau nomor invoice.
- `reason`: rationale pembayaran. Ini bisa berisi komentar bebas dari server yang sebenarnya tidak perlu diketahui payment facilitator.

Buat gue, inti paper ini adalah: metadata itu sendiri adalah vektor. Kalau request dikirim tanpa menyaring metadata, agent sudah mengirim PII sebelum action final dieksekusi.

Kalau saya terjemahkan ke sistem dua-agent, analoginya bukan lagi tiga nama field literal. Yang setara adalah semua konten yang bergerak dari satu agent ke boundary lain. Di workflow kita, bentuknya bisa muncul sebagai:

- `user_message`
- `uploaded_document_text`
- `retrieved_context`
- `tool_call_args`
- `agent_scratchpad`
- `generated_artifact`
- `jira_description`
- `confluence_body`
- `git_commit_message`
- `test_fixture`
- `trace_payload`

Jadi yang gue tarik dari paper ini adalah: bukan hanya `resource_url`/`description`/`reason` yang harus disaring. Prinsipnya adalah `metadata transport` — semua konten yang keluar dari boundary agent harus dicek dulu.

## Privacy boundary yang harus gue bangun

Adaptasi x402 buat sistem ini jadi layer berikut:

1. **Ingestion / Input Guard**
   - scan semua input awal untuk PII
   - jangan langsung teruskan raw text ke agent

2. **Context Sanitization Gateway**
   - mask / redact / pseudonymize / synthesize
   - pisahkan versi raw dengan versi aman

3. **Artifact Guard**
   - sebelum Brainstorming Agent output jadi input Coding Agent, scan ulang
   - pastikan artifact yang dipindahkan tidak mengandung raw PII

4. **Output Guard**
   - scan semua output sebelum disimpan atau dikirim ke Jira/Confluence/Git/trace

5. **Audit Log**
   - catat keputusan masking/filtering tanpa menyimpan raw PII

## Policy per agent menurut gue

Brainstorming Agent:
- boleh menerima context yang sudah `pseudonymized` atau `redacted`
- boleh menjaga konsistensi entitas dengan token stabil (`PERSON_001`, `ACCOUNT_001`)
- tidak boleh menerima raw NIK, nomor rekening, email, telepon, atau data reguler sensitif

Coding Agent:
- harus bisa bekerja dengan `synthetic` atau `placeholder` examples
- tidak butuh PII asli untuk bikin schema, validation, atau test
- raw PII tidak boleh masuk prompt, generated code, atau fixture

## Kenapa ini penting buat gue

Kalimat yang gue pakai kalau mau jelasin ke CISO:

> "Hardening x402 menjelaskan prinsip kontrol sebelum request dieksekusi. Di platform kita, prinsip yang sama berlaku ke semua agent boundary: data hanya boleh bergerak antar-agent setelah melewati PII gateway, bukan langsung dari brain dump ke prompt atau artifact." 

Yang penting bagi gue adalah bahwa ini bukan soal satu sanitizer. Ini soal menjadikan `agent boundary` sebagai bagian dari security architecture.

## Implementasi teknis yang gue anggap logis

Komponen minimal yang gue butuh:

- `pii_detector` (NER + regex + schema-aware rules)
- `pii_transformer` (mask / redact / pseudonymize / synthesize)
- `policy_engine` (destination-aware: brainstorming/coding/LLM/trace/storage)
- `privacy_gateway` (middleware sebelum agent dan sebelum artifact persist)
- `audit_logger` (keputusan, entitas, action)
- `safe_context_store` (versi sanitized)
- `raw_vault` (raw data terpisah, akses dibatasi)

## Prinsip yang gue pegang

- `Jangan anggap kalau agent sudah pakai LLM internal berarti data aman.`
- `Jangan hanya filter sekali; scan lagi saat data keluar boundary.`
- `Jangan letakkan raw data dan sanitized data di tempat yang sama.`
- `Pseudonymization sering lebih berguna daripada redaksi kasar untuk Brainstorming Agent.`
- `Untuk Coding Agent, synthetic data sering lebih aman dan lebih berguna.`

## Link

- [[notes.security.pii-agent-architecture]]
- [[notes.security.pii-agent-architecture.hardening-x402]]
- [[notes.security.pii-agent-architecture.camp.per-turn-masking]]
- [[notes.security.pii-agent-architecture.camp.indexed-masking]]
