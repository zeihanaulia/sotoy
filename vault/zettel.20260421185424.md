---
id: zettel.20260421185424
title: "Party Mode adalah mesin konflik terkontrol untuk menampilkan trade-off multi-agent"
desc: "BMAD Party Mode mengumpulkan banyak agent dalam satu percakapan untuk membuat perbedaan perspektif dan trade-off terlihat sekaligus." 
tags:
  - bmad
  - party-mode
  - ai-native
  - coordination
---

## Pertanyaan yang dibuka

1. Bagaimana Party Mode berbeda dari mode multi-agent biasa? 
2. Mengapa banyak perspektif dalam satu percakapan lebih berguna untuk keputusan trade-off? 
3. Kapan Party Mode jadi overkill daripada membantu?

## Klaim utama

Party Mode adalah format percakapan multi-agent di BMAD yang mengorkestrasi beberapa peran dalam satu ruang diskusi untuk menyalurkan konflik terkontrol dan membuat trade-off tersembunyi menjadi eksplisit.

Mode ini bukan sekadar "multi-bot". Ia menggabungkan banyak named agents dalam satu percakapan dan membiarkan BMAD Master memilih agent relevan untuk merespons setiap pesan.

## Penjelasan

Fungsi inti Party Mode adalah membuat perbedaan sudut pandang terlihat dalam satu tempat. Alih-alih memanggil satu agent atau satu fase saja, BMAD mengumpulkan beberapa peran sekaligus, misalnya:

* PM
* Architect
* Dev
* UX
* QA/TEA

Lalu masing-masing agent bisa setuju, tidak setuju, atau saling membangun argumen.

Ini membuat tegangan antar reasoning menjadi terlihat. Party Mode memungkinkan diskusi yang bersifat:

* keputusan besar yang penuh trade-off,
* brainstorming lintas persona,
* post-mortem lintas peran,
* retrospektif dan planning.

## Perbedaan terhadap konsep BMAD lain

* Named Agents = satu peran, satu mode kerja.
* Advanced Elicitation = satu model, lensa berpikir diganti.
* Adversarial Review = satu artefak, mode evaluasi dibuat curiga.
* Party Mode = banyak peran, banyak reasoning, satu percakapan.

## Implikasi

* Party Mode paling berguna untuk keputusan kompleks yang tidak bisa diselesaikan oleh satu perspektif.
* Ia adalah cara BMAD membuat diskusi internal eksplisit, bukan menyederhanakan jadi jawaban tunggal.
* Keuntungan utama adalah peta trade-off dan pemisahan konflik peran, bukan jawaban konsensus instan.
* Party Mode bisa overkill untuk masalah kecil atau task yang hanya perlu klarifikasi cepat.

## Lihat juga

* [[zettel.20260421184439]] — Adversarial Review memaksa reviewer beralih dari rasa aman ke pencarian kelemahan
* [[zettel.20260421184757]] — Advanced Elicitation memaksa model menggunakan lensa berpikir eksplisit untuk reconsider output
* [[zettel.literature.bmad-advanced-elicitation]] — literature note BMAD Advanced Elicitation
* [[zettel.moc.ai-native]] — MOC AI-native engineering
