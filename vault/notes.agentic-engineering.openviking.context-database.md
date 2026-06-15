---
id: notes.agentic-engineering.openviking-context-database
title: Context Database
desc: >-
  POV catatan tentang bagaimana OpenViking memandang context sebagai filesystem
  yang menggabungkan memory, resource, dan skill.
updated: 1780427822720
created: 1780426580293
tags:
  - notes
  - agentic-engineering
  - openviking
  - context-database
---

Hari ini gue baca page OpenViking, dan yang paling ngena buat gue adalah saat mereka tidak cuma menyebutnya sebagai produk memory. Di catatan gue, OpenViking itu adalah **context database**: database yang nggak cuma nyimpan data, tapi menyusun data supaya agent bisa ambil konteks yang tepat saat bekerja.

## Pertanyaan kunci yang gue pegang

Ada tujuh pertanyaan inti yang bikin gue bisa bedain OpenViking dari memory provider biasa:

1. OpenViking sebenarnya menyelesaikan masalah apa?
2. Kenapa dia pakai paradigma file system?
3. Apa bedanya Resource, Memory, dan Skill?
4. Gimana sistem L0/L1/L2 bekerja?
5. Apa itu directory recursive retrieval?
6. Kenapa retrieval trace penting?
7. Gimana OpenViking bikin agent "smarter with use"?

## Istilah yang gue kunci

Gue pakai makna ini ketika baca page OpenViking:

- **Context database** = database yang bukan cuma nyimpen data, tapi menyusun data supaya agent bisa mengambil konteks yang tepat.
- **Resource** = pengetahuan relatif statis seperti docs, repo code, FAQ, atau halaman web.
- **Memory** = cognition agent/user: preferensi, pengalaman task, keputusan, dan pola yang berubah.
- **Skill** = capability yang bisa dipanggil agent: tools, MCP, instruksi, atau workflow.
- **viking:// URI** = alamat unik untuk menemukan context di virtual filesystem OpenViking.
- **L0/L1/L2** = layer konteks bertingkat: abstract, overview, detail.

## Masalah yang OpenViking ingin selesaikan

OpenViking nggak datang sebagai solusi "kami punya vector DB lebih bagus". Ini lebih ke masalah manajemen konteks yang kacau: memory di satu tempat, resource di tempat lain, skill tersebar di plugin atau endpoint.

Gue suka bahwa page-nya mendefinisikan problem secara jelas:

- **Context fragmentation**
- **Context explosion**
- **Poor retrieval quality**
- **Context opacity**
- **Limited memory iteration**

Kalau dibandingin sama RAG tradisional, OpenViking ngeliat ini bukan sekadar potong dokumen jadi chunk. Context harus punya struktur, path, folder, level ringkasan, dan jejak retrieval.

## Kenapa pakai paradigma filesystem?

OpenViking mendorong agent berpikir dalam bentuk file system, bukan tumpukan chunk.

Buat gue, tiga keuntungan utamanya adalah:

- **Path deterministik**: agent bisa refer ke `viking://resources/my_project/docs/api.md`, bukan cuma berharap similarity search nemu chunk yang tepat.
- **Hierarki**: project, docs, memories, skills punya tempat masing-masing.
- **Navigasi**: agent bisa `ls`, `read`, `abstract`, `overview` — mirip browsing folder.

Ini membuat OpenViking lebih ke sistem navigasi konteks. Vector DB menjawab "chunk mana yang mirip?". OpenViking menjawab "lokasi konteksnya di mana, dan detail mana yang harus dibuka?".

## Resource, Memory, Skill: tiga jenis konteks yang harus dibedakan

Page ini bikin gue lebih jelas tentang batas-batasnya.

- **Resource** = pengetahuan statis. Project docs, code repo, FAQ, API docs. Kalau lo lagi ngebangun coding agent atau support agent, resource ini adalah basis pengetahuan.
- **Memory** = learning yang dinamis. User preferences, pengalaman task, keputusan, pola. Ini mirip Honcho, tapi di OpenViking memory dipisahin sebagai konteks yang berubah seiring waktu.
- **Skill** = capability yang bisa dipanggil. Tool, MCP endpoint, instruksi, workflow. Bukan isi dokumen, tapi fungsi / kemampuan.

Gue suka bahwa OpenViking menyatukan ketiganya ke satu filesystem, sebab itu bikin konteks agent nggak tercerai-berai.

## L0/L1/L2: cara mereka ngehindarin context stuffing

Ini bagian yang paling masuk akal buat gue.

- **L0 = Abstract**: ringkas banget, cukup untuk filtering awal.
- **L1 = Overview**: lebih panjang, sekitar 2.000 token, cukup untuk paham struktur dan bagian penting.
- **L2 = Detail**: full content, dibuka kalau perlu.

Kalau agent bekerja, modelnya mirip manusia:

- lihat judul / abstrak dulu
- baca overview untuk tahu bagian mana yang penting
- baru baca detail kalau perlu

Dengan cara ini, OpenViking menghindari prompt stuffing dan membuat retrieval jadi bertahap.

## Directory recursive retrieval

Gue nangkep ini sebagai salah satu fitur paling khas mereka.

Bukan cuma mencari chunk top-k. OpenViking pertama menempatkan query ke direktori relevan, lalu mengeksplorasi isi folder itu secara bertahap.

Prosesnya kira-kira:

- analisis intent
- cari direktori kandidat
- eksplorasi file dalam direktori
- turunin ke subdirectory jika perlu
- agregasi hasil

Jadi retrieval-nya mirip browsing rak buku, bukan ngacak-ngacak tumpukan fotokopi.

## Kenapa retrieval trace penting

Ini yang bikin OpenViking beda dari RAG biasa.

Kalau retrieval gagal, lo bisa lihat: directory mana dibuka, file mana yang dipilih, kenapa kandidat itu muncul. Itu penting buat debug agent production.

Tanpa trace, agent cuma kasih jawaban. Dengan trace, lo bisa audit kenapa jawaban itu muncul.

## Memory self-iteration dan agent yang belajar dari use

OpenViking nggak cuma nyimpen memory user. Dia juga punya loop extraction untuk agent:

- hasil task
- feedback user
- outcome session

Lalu dia update memory directories secara async.

Ini bikin agent bisa belajar dari kasus dan pola, bukan cuma ingat preferensi user.

## OpenViking vs Honcho

Karena gue juga lagi baca Honcho, ini perbandingannya penting.

- Honcho = **peer-centric**. Fokus ke siapa peer itu, apa representation-nya, gimana dia berubah.
- OpenViking = **context-filesystem-centric**. Fokus ke di mana konteksnya, jenisnya apa, level detail mana yang dibuka.

Keduanya bisa saling melengkapi, tapi filosofinya beda.

## Kapan OpenViking cocok?

OpenViking masuk akal kalau lo perlu:

- self-hosted context database
- knowledge base yang terstruktur
- project docs / repo besar
- retrieval yang bisa diaudit
- hierarchical context loading
- memory user + memory agent

Kalau problem lo cuma preferensi user sederhana, mungkin ini bisa overkill.

## Related documents

- [[notes.agentic-engineering.openviking.architecture]]
- [[notes.agentic-engineering.openviking.storage-architecture]]
- [[notes.agentic-engineering.openviking.context-extraction]]
- [[notes.agentic-engineering.openviking.context-types]]
- [[notes.agentic-engineering.openviking.context-layers]]
- [[notes.agentic-engineering.hermes-agent.memory-providers]]
- [[notes.agentic-engineering.honcho.architecture]]
- [[notes.agentic-engineering.honcho.stateful-memory]]
- [[vault/daily.journal.2026.06.03|Daily 2026-06-03]]
