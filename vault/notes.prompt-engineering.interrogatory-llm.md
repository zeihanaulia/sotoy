---
id: notes.prompt-engineering.interrogatory-llm
title: "Interrogatory LLM: LLM sebagai pewawancara konteks"
desc: "Analisis Martin Fowler tentang LLM yang mengekstraksi konteks dari manusia untuk membuat prompt final lebih akurat."
updated: 1778775961481
created: 1778773768305
tags:
  - notes
  - prompt-engineering
  - ai
  - context-engineering
  - knowledge-management
---

## Definisi

Interrogatory LLM adalah pola di mana LLM dipakai sebagai pewawancara aktif untuk menggali konteks dari manusia. Bukan sekadar menjawab pertanyaan, tetapi membuat pertanyaan terstruktur yang mengekstrak requirement, constraint, domain knowledge, dan asumsi penting.

Link: https://martinfowler.com/bliki/InterrogatoryLLM.html

Di artikel Martin Fowler, istilah ini bukan berarti interogasi kasar. Ini lebih dekat ke proses: LLM bertanya satu per satu, manusia menjawab, lalu model menyusun konteks yang bisa dipakai oleh sesi atau model lain.

## Mengapa perlu wawancara?

Fowler menunjukkan bahwa kegagalan task kompleks biasanya bukan karena modelnya bodoh. Kegagalannya karena konteks yang dikirim ke model tidak lengkap.

Dalam praktiknya, manusia sering tidak menulis semua detail penting di awal. Interrogatory LLM memindahkan beban itu dari "tulis semua requirement dulu" menjadi "jawab pertanyaan yang muncul".

## Kenapa satu pertanyaan dalam satu waktu?

Satu pertanyaan atomik menjaga percakapan terfokus.

Kalau LLM menanyakan banyak hal sekaligus, jawaban cenderung parsial, dangkal, atau hilang. Dengan satu pertanyaan, setiap respons jadi bahan untuk pertanyaan berikutnya.

Ini membuat elicitation jadi incremental dan lebih mirip wawancara manusia yang baik.

## Dokumen vs review

Fowler membedakan dua peran utama:

- `create`: LLM menginterview expert untuk membangun dokumen konteks dari nol.
- `review`: LLM membaca dokumen yang sudah ada, lalu mewawancarai expert untuk memeriksa akurasi dan gap.

Model lain bisa memakai dokumen itu sebagai input yang lebih stabil. Jadi interrogatory LLM bukan hanya cara membuat prompt lagi—dia juga bisa menjadi fasilitator review dokumen.

## Insight yang lebih besar

Interrogatory LLM adalah proses context engineering.

Kalau prompt biasa masih dipandang sebagai perintah sekali tembak, pola ini menempatkan prompt final sebagai hasil dari pipeline wawancara:

1. tacit knowledge →
2. elicitation oleh LLM →
3. context document →
4. execution / review

Dengan begitu, prompt bukan lagi ditulis langsung. Dia diproduksi dari percakapan yang benar.

## Korelasi konsep lain

- requirements elicitation: expert sering tidak tahu cara menulis kebutuhan, tetapi tahu domainnya. Interrogatory LLM mirip dengan analis yang menggali kebutuhan lewat pertanyaan.
- rubber duck debugging: bedanya, "bebek" di sini bertanya balik, bukan sekadar mendengar.
- knowledge management: ini cara ringan untuk mengeluarkan pengetahuan dari kepala orang yang tidak suka menulis.

## Kenapa ini penting

Artikel ini menggeser fokus dari "prompt engineering" ke "context engineering".

LLM terbaik sekalipun masih akan membuat keputusan buruk kalau konteksnya salah. Interrogatory LLM membantu memastikan konteks itu lebih lengkap, terstruktur, dan lebih mudah divalidasi.
