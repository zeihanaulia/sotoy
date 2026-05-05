---
id: notes.security.pii-agent-architecture.camp.why-camp
title: "CAMP: apa yang baru dari solusi session-aware PII middleware"
desc: "Analisis komponen CAMP yang membuatnya berbeda dari per-turn masking biasa untuk agentic LLM." 
updated: 1777878070887
created: 1777878070887
tags:
  - notes
  - security
  - pii
  - agent
  - camp
  - architecture
---

## Inti jawaban
Pertanyaan terakhir adalah: apa yang baru dari CAMP?

Jawaban pendeknya: CAMP baru karena ia membuat PII protection menjadi stateful, session-aware, dan retroactive.

Masking biasa berhenti pada satu pesan. CAMP hidup sepanjang percakapan.

## Alur mekanisme CAMP
CAMP menggabungkan urutan mekanisme berikut:

1. **detect** – per-turn PII extraction dengan Presidio + custom recognizer.
2. **remember** – simpan semua hasil deteksi di session registry.
3. **score** – hitung CPE agar sistem tahu kapan akumulasi PII sudah berbahaya.
4. **rewrite history** – saat threshold tercapai, tulis ulang seluruh conversation history yang akan dikirim ke model.
5. **send synthetic context** – kirim context synthetic, bukan asli, ke external LLM.
6. **de-mask response** – kembalikan jawaban ke nilai asli sebelum user melihatnya.

Ini yang membuat CAMP lebih dari sekadar mask-redact pipeline.

## Komponen utama yang membedakan CAMP
### 1. Stateful session registry
Registry menyimpan Person, Location, Organization, Salary, Medical Condition, dan PII lain sepanjang sesi.
Tanpa registry, sistem kembali ke per-turn masking biasa.

### 2. CPE scorer sebagai trigger
CAMP tidak selalu agresif. Ia memonitor cumulative risk dan hanya intervensi setelah skor melewati threshold, kecuali hard-blocked identifiers.

### 3. Retroactive pseudonymization
Saat threshold terlampaui, data lama juga ditulis ulang. Ini krusial untuk agentic LLM yang mengirim ulang history.
Tanpa langkah ini, history lama tetap bisa bocor.

### 4. Synthetic context + de-masking
External model melihat data palsu yang konsisten. User tetap menerima jawaban personal setelah de-masking.

### 5. Hard block rules
Beberapa PII sangat sensitif untuk dikirim dalam bentuk apa pun: SSN, credit card, bank account. Ini langsung diblok, tidak menunggu threshold.

## Kenapa ini bukan sekadar "masking baru"
Masking biasa menjawab: "apakah pesan ini mengandung PII?"
CAMP menjawab: "apakah percakapan ini, setelah semua pesan digabung, sudah berbahaya?"

Itu adalah pergeseran dari filter stateless ke middleware stateful.

## Kritik yang perlu dinilai
### A. Apakah pseudonymization menjaga privacy tanpa merusak task?
- Nama dan email relatif aman diganti.
- Salary, location, dan medical condition bisa merusak makna jika diganti sembarang.
- Pseudonymization harus preserve task-relevant semantics, bukan hanya string substitution.

### B. Apakah de-masking reliable?
- LLM bisa memparafrase synthetic values.
- De-masking literal saja tidak cukup jika output variatif.
- Ini menuntut mekanisme post-processing lebih robust.

### C. Apakah pre-threshold exposure tetap jadi masalah?
- CAMP melindungi future context setelah trigger.
- Data asli yang sudah pernah dikirim sebelum trigger mungkin tetap tercatat oleh adversary.
- Jadikan klaim privacy CAMP lebih presisi: ia mengurangi cumulative exposure ke model, bukan selalu mencegah semua PII asli keluar.
- Lihat juga [[zettel.1777881085671]] untuk insight tentang pre-trigger exposure sebagai gap privacy.

### D. Apakah CAMP mencakup agent leakage yang lebih luas?
- CAMP fokus pada prompt/history ke external LLM.
- Agent nyata punya leakage channel lain: tools, memory store, logs, sub-agent messages.
- CAMP bagus sebagai privacy firewall context, tapi bukan full-stack privacy solution.

## Positioning
CAMP adalah arsitektur pipeline, bukan algoritma baru. Kontribusinya adalah desain middleware untuk conversation context di agentic LLM.

Bila dilihat sebagai pattern, CAMP itu:
- detector + state tracker + risk scorer + rewriter + synthetic context + de-mask.

Bila dilihat sebagai level proteksi, CAMP setara dengan "session-aware context firewall".

## Related notes
- [[notes.security.pii-agent-architecture.camp]]
- [[notes.security.pii-agent-architecture.camp.cpe]]
- [[notes.security.pii-agent-architecture.camp.per-turn-masking]]
- [[notes.security.pii-agent-architecture]]
