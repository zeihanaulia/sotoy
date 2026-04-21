---
id: zettel.literature.bmad-preventing-agent-conflicts
title: "BMAD Preventing Agent Conflicts sebagai literature note"
desc: "Catatan literature dari halaman BMAD Preventing Agent Conflicts tentang shared standards dan conflict-prone choices." 
tags:
  - bmad
  - agent-conflicts
  - literature
---

## Pertanyaan yang dibuka

1. Mengapa BMAD menempatkan shared standards di pusat pencegahan konflik agent?
2. Apa contoh konflik praktis yang sering muncul di environment multi-agent?
3. Bagaimana architecture documentation berfungsi sebagai shared context dalam BMAD?

## Ringkasan literatur

Halaman BMAD Preventing Agent Conflicts menyoroti bahwa konflik agent bukan karena agent bodoh, tetapi karena kurangnya shared context teknis.

Agent bisa membuat keputusan lokal yang logis, tetapi saat mereka bekerja pada bagian berbeda dari sistem tanpa standar bersama, hasilnya bisa terfragmentasi.

Contoh konflik yang diangkat mencakup:

* API Style: REST vs GraphQL
* Naming: snake_case vs camelCase
* State management: Redux vs React Context

BMAD menyarankan solusi praktis melalui explicit ADRs, FR/NFR-specific guidance, dan conventions yang dapat dibaca semua agent.

## Ide penting

* Shared standards, bukan sosok architect, adalah kunci konsistensi agent.
* Decision teknis yang eksplisit harus diwariskan ke banyak executor.
* Konvensi sehari-hari sama pentingnya dengan keputusan besar.
* Architecture documentation adalah medium koordinasi, bukan hanya catatan pasif.

## Interpretasi

Catatan ini menegaskan bahwa dalam AI-native engineering, context engineering harus mencakup berbagai conflict-prone choices. Tanpa itu, banyak agent dapat menghasilkan sistem yang secara lokal masuk akal tapi secara global tidak koheren.

## Sumber

* https://docs.bmad-method.org/explanation/preventing-agent-conflicts/

## Lihat juga

* [[zettel.20260421183954]] — Preventing Agent Conflicts membangun shared context, bukan mengandalkan agent tunggal
* [[zettel.literature.bmad-why-solutioning-matters]] — literature note BMAD Why Solutioning Matters
* [[zettel.literature.bmad-quick-dev]] — literature note BMAD Quick Dev
* [[zettel.literature.checkpoint-preview]] — literature note BMAD Checkpoint Preview
