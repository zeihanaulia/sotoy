---
id: notes.agentic-engineering.openviking.architecture
title: "OpenViking architecture"
desc: "Catatan POV tentang struktur internal OpenViking: client, service layer, core modules, storage layer, dan data flow."
updated: 1780427822719
created: 1780426998171
tags:
  - notes
  - agentic-engineering
  - openviking
  - architecture
---

Link: https://docs.openviking.ai/en/concepts/01-architecture

Hari ini gue nulis ulang pemahaman gue tentang arsitektur OpenViking, bukan deployment cloud-nya. Yang gue catat adalah struktur internal: client, service layer, modul retrieve/session/parse/compressor, storage layer, dan data flow.

## Arsitektur besar OpenViking menurut gue

Kalau digambarkan sederhana, OpenViking itu punya tiga wilayah utama:

- **Client** sebagai pintu masuk.
- **Service Layer** sebagai business logic reusable.
- **Core Modules** sebagai mesin pencari, ingestion, session, dan kompresi.
- **Storage Layer** sebagai tempat konten dan indeks disimpan.

Jadi modelnya bukan "SDK wrapper ke vector DB". Dia lebih seperti sistem internal yang memisahkan ingestion, retrieval, session memory, compression, dan storage.

## Client = pintu masuk tunggal

Gue lihat OpenViking memposisikan Client sebagai unified entry. Dari luar, developer cukup interaksi lewat satu interface: `find`, `ls`, `read`, `add_resource`, `commit session`, dan lain-lain.

Client itu remote control. Dia nggak melakukan banyak logika sendiri. Dia menyalurkan perintah ke service layer.

## Service Layer = bisnis logic tanpa nempel ke transport

Gue suka konsep ini karena bikin logika intinya bisa dipakai di HTTP server, CLI, atau SDK lain tanpa rewrite.

Di page ini, service layer dipilah jadi beberapa service seperti:

- `FSService` untuk operasi filesystem: `ls`, `read`, `overview`, `abstract`, `glob`.
- `SearchService` untuk semantic search: `search`, `find`.
- `SessionService` untuk manajemen session: `session`, `commit`, `archive`.
- `ResourceService` untuk import resource/skill.
- `RelationService` untuk relasi konteks antar item.
- `PackService` untuk import/export/backup.
- `DebugService` untuk observability dan retrieval trace.

Jadi intinya: transport layer itu bebas, logika intinya tetap di service layer.

## Core modules = mesin internal

Bagian paling penting buat gue adalah modul retrieve, parse, session, dan compressor.

### Retrieve

Retrieve itu bukan cuma vector search. Dia modul pencarian konteks yang terdiri dari:

- intent analysis,
- hierarchical retrieval,
- rerank.

Untuk query kompleks, OpenViking tidak langsung ke top-k chunk. Dia dulu cari direktori relevan, eksplor hierarki, lalu rerank kandidat.

Kalau gue rangkum:

- `FSService` tahu path yang sudah ada.
- `SearchService` pakai makna untuk menemukan path.
- `Retrieve` menjembatani keduanya.

### Parse

Parse adalah ingestion pipeline. Dia membaca dokumen, membuat struktur tree, lalu menyalin ke AGFS sebelum semantic generation.

Yang penting:

- parsing dokumen itu dilakukan tanpa LLM,
- tree structuring dibuat dulu,
- semantic generation (L0/L1/L2) berjalan async.

Jadi input mentah pertama-tama menjadi context filesystem, bukan langsung vectorized.

### Session

Session module yang bikin OpenViking terasa bukan sekadar store. Dia ngurus:

- message recording,
- compress history,
- archive,
- memory extraction,
- commit ke storage.

Session commit adalah proses yang mengubah interaksi jadi memory yang bisa dicari kembali.

### Compressor

Compressor adalah penjaga quality memori. Dia bertugas kompresi dan deduplikasi agar memory jangka panjang tidak jadi noisy.

Gue catat bahwa ini penting supaya preferensi dan pola agent tidak hanya menumpuk, tapi juga dirapikan.

## Storage layer: AGFS + Vector Index

Ini bagian yang paling bikin arsitektur OpenViking jelas bagi gue.

### AGFS

AGFS adalah storage konten/file. Dia menyimpan isi sebenarnya: L0/L1/L2, multimedia, dan relations.

Kalau agent butuh content, sumber kebenarannya adalah AGFS.

### Vector Index

Vector Index hanya menyimpan URI, vector, dan metadata. Bukan isi file penuh.

Ini mirip katalog perpustakaan. Kalau vector index selesai, agent tahu lokasi konteks. Konten lengkapnya tetap di AGFS.

Gue catat bahwa ini menjaga consistency: AGFS sebagai single source of truth, vector index sebagai peta semantic.

## Data flow menambahkan konteks

Flow yang gue tangkap untuk adding context adalah:

```
Input → Parser → TreeBuilder → AGFS → SemanticQueue → Vector Index
```

Prosesnya:

1. input masuk,
2. parser membentuk struktur tree,
3. tree disimpan ke AGFS,
4. semantic layer dibangun async,
5. vector index dibuat dari URI + metadata.

Ini kebalikan dari pipeline RAG biasa yang biasanya: chunk → embed → vector DB.

## Data flow mengambil konteks

Flow retrievalnya:

```
Query → Intent Analysis → Hierarchical Retrieval → Rerank → Results
```

Jadi OpenViking tidak sekadar cari chunk paling mirip. Dia menelusuri struktur direktori, lalu mengurutkan hasilnya.

## Session commit dan memory lifecycle

Setelah sesi selesai, OpenViking mengeksekusi:

```
Messages → Compress → Archive → Memory Extraction → Storage
```

Yang gue catat: session commit bukan cuma arsip chat. Dia mengubah history menjadi memory yang bisa dipanggil lagi.

## Mode deployment: embedded vs HTTP

OpenViking mendukung dua mode:

- **Embedded**: library lokal, cocok untuk prototipe dan lokal development.
- **HTTP**: service terpisah, cocok untuk tim, multi-client, dan production.

Embedded itu langsung dan murah. HTTP itu lebih fleksibel untuk banyak client.

## Insight arsitektur utama

Gue narik dua dunia utama dari OpenViking:

1. dunia deterministic: path, directory, file, URI, AGFS.
2. dunia semantic: vector search, intent analysis, rerank, L0/L1/L2.

OpenViking menggabungkan keduanya: filesystem yang bisa dicari secara semantic.

## Related documents

- [[notes.agentic-engineering.openviking.context-database]]
- [[notes.agentic-engineering.openviking.storage-architecture]]
- [[notes.agentic-engineering.openviking.context-extraction]]
- [[notes.agentic-engineering.openviking.context-types]]
- [[notes.agentic-engineering.openviking.context-layers]]
- [[notes.agentic-engineering.honcho.architecture]]
- [[vault/daily.journal.2026.06.03|Daily 2026-06-03]]
