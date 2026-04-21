---
id: zettel.20260421183954
title: "Preventing Agent Conflicts membangun shared context, bukan mengandalkan agent tunggal"
desc: "BMAD mencegah konflik multi-agent dengan membuat technical standards eksplisit dan shared context sebelum implementasi multi-epic." 
tags:
  - bmad
  - agent-conflicts
  - architecture
---

## Pertanyaan yang dibuka

1. Mengapa konflik agent muncul meski masing-masing keputusan lokal masuk akal?
2. Bagaimana BMAD menggunakan architecture documentation untuk menahan divergensi teknis?
3. Apa jenis konflik praktis yang paling sering muncul dalam AI-native multi-agent development?

## Klaim utama

Preventing Agent Conflicts bukan tentang membuat agent lebih pintar. Ia tentang menyediakan shared standards dan konteks teknis yang membuat banyak agent tetap bergerak bersama.

Konflik muncul karena tiap agent cenderung mengoptimalkan task lokal dengan informasi lokal. Tanpa shared context eksplisit, local reasoning ini mudah bertabrakan secara sistemik.

## Penjelasan

Page ini menurunkan masalah solutioning ke friksi nyata:

* API style conflict (REST vs GraphQL)
* naming convention conflict (snake_case vs camelCase)
* state management conflict (Redux vs Context)

Semua contoh ini tampak masuk akal saat dilihat secara lokal. Masalahnya adalah tidak adanya agreement global, sehingga sistem menjadi tidak kohesif.

BMAD mencegah konflik itu dengan tiga mekanisme utama:

* explicit ADRs yang menetapkan shared standards,
* FR/NFR-specific guidance yang menerjemahkan requirement ke teknik,
* conventions yang menjaga konsistensi sehari-hari.

## Implikasi

* Shared context lebih penting daripada sosok architect.
* Documentation berfungsi sebagai alat sinkronisasi agent, bukan hanya catatan sejarah.
* Konflik teknis kecil bisa berlipat menjadi biaya besar saat tersebar lintas epic.
* Solutioning harus menghasilkan keputusan teknis bersama sebelum agent mulai mengimplementasikan.

## Lihat juga

* [[zettel.20260421182826]] — Solutioning mengunci keputusan teknis bersama sebelum agent mulai bergerak sendiri-sendiri
* [[zettel.literature.bmad-why-solutioning-matters]] — literature note BMAD Why Solutioning Matters
* [[zettel.literature.checkpoint-preview]] — literature note BMAD Checkpoint Preview
* [[zettel.moc.ai-native]] — MOC AI-native engineering
