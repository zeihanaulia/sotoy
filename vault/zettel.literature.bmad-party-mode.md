---
id: zettel.literature.bmad-party-mode
title: "BMAD Party Mode sebagai literature note"
desc: "Ringkasan halaman BMAD Party Mode tentang mengumpulkan banyak AI agent dalam satu percakapan untuk menampilkan trade-off dan perspektif berbeda." 
tags:
  - bmad
  - party-mode
  - literature
  - ai-native
---

## Pertanyaan yang dibuka

1. Mengapa BMAD mengumpulkan banyak agent dalam satu percakapan? 
2. Bagaimana Party Mode membuat trade-off lebih eksplisit dibandingkan mode agent tunggal? 
3. Dalam situasi apa Party Mode paling bernilai?

## Ringkasan literatur

Party Mode adalah fitur BMAD untuk mengumpulkan banyak agent dalam satu percakapan yang sama, lalu membiarkan BMAD Master memilih agent relevan untuk merespons setiap pesan.

Fungsi utamanya adalah membuat perbedaan perspektif terlihat sekaligus. Alih-alih satu agent memberi satu garis reasoning, Party Mode menciptakan percakapan yang menunjukkan tegangan antar reasoning:

* PM
* Architect
* Dev
* UX
* QA/TEA

Halaman tersebut menempatkan Party Mode sebagai alat yang cocok untuk:

* keputusan besar dengan trade-off,
* sesi brainstorming,
* post-mortem,
* sprint retrospectives/planning.

## Ide penting

* Party Mode adalah "mesin konflik terkontrol"; bukan untuk berseteru, tapi untuk memunculkan trade-off.
* Keuntungan utama adalah peta keputusan dari banyak perspektif, bukan jawaban konsensus instan.
* Party Mode komplementer dengan Named Agents, bukan menggantikannya.
* Mode ini efektif ketika masalah kompleks dan multi-peran, tetapi overkill untuk isu kecil.

## Interpretasi

Dengan menggabungkan banyak peran dalam satu ruang diskusi, BMAD Party Mode mengeksternalisasi perbedaan framing yang biasanya tetap tersembunyi di kepala satu pembuat keputusan atau satu reviewer.

Itu membuat keputusan lebih transparan sekaligus lebih sulit dipaksa oleh satu bias tunggal.

## Sumber

* https://docs.bmad-method.org/explanation/party-mode/

## Lihat juga

* [[zettel.20260421185424]] — Party Mode adalah mesin konflik terkontrol untuk menampilkan trade-off multi-agent
* [[zettel.literature.bmad-adversarial-review]] — literature note BMAD Adversarial Review
* [[zettel.literature.bmad-advanced-elicitation]] — literature note BMAD Advanced Elicitation
* [[zettel.moc.ai-native]] — MOC AI-native engineering
