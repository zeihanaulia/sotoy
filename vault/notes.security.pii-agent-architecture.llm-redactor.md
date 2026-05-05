---
id: notes.security.pii-agent-architecture.llm-redactor
title: "LLM-Redactor: Privacy-Preserving LLM Requests"
desc: "Deep dive LLM-Redactor: evaluasi strategi permintaan privacy untuk agen berbasis LLM." 
updated: 1777873618660
created: 1777871740192
tags:
  - notes
  - security
  - pii
  - llm
---

## Problem
LLM-Redactor mengangkat problem yang sangat praktis: ketika aplikasi, coding agent, atau workflow LLM-powered mengirim prompt ke cloud API, isi prompt itu bisa mengandung PII, secret, kode proprietary, nama organisasi, konteks internal, atau informasi sensitif lain.

Paper ini menegaskan bahwa TLS tidak cukup. TLS hanya melindungi dari network observer, bukan dari vendor LLM, log vendor, telemetry pihak ketiga, subpoena, atau kemungkinan data dipakai ulang untuk training dan debugging.

## Threat model
Yang mereka fokuskan bukan sekadar hacker di jaringan. Ancaman utama yang mereka modelkan adalah:

- vendor log exfiltration;
- training contamination;
- third-party telemetry;
- timing side channel;
- placeholder leakage;
- adversarial input yang sengaja mem-bypass detector.

Untuk gue, bagian paling penting adalah training contamination.

Itu bukan hanya soal data dipakai buat training model utama. Itu soal kehilangan kontrol penuh setelah prompt keluar dari boundary kita dan masuk ke sistem vendor.

Training contamination artinya:

- prompt bisa tersimpan di log vendor atau database debugging (retention contamination);
- prompt bisa dibuka di dashboard internal, annotation tool, atau bug review (review contamination);
- prompt bisa dipakai sebagai contoh untuk menguji model di masa depan (evaluation contamination);
- prompt bisa masuk ke dataset untuk fine-tuning, reward model, classifier, atau policy model (fine-tuning contamination);
- prompt bisa membuat model menghafal pola unik dan regurgitate data mirip nanti (memorization/regurgitation risk).

Di threat model paper ini, vendor dianggap curious tapi tidak jahat: data bisa disimpan, dianalisis, atau diproses untuk improvement tanpa ada niat nyerang. Kalau data sensitif kita masuk ke jalur itu, organisasi kita kehilangan kontrol atas nasib data tersebut.

Dari sini jelas: privacy request LLM bukan fitur tunggal. Itu kombinasi threat model, workload, cost, latency, dan utility.

## Delapan teknik yang dievaluasi

Paper ini membandingkan delapan pendekatan privacy untuk request LLM.

### A — Local-only inference

Ini pendekatan paling aman: jangan kirim request ke cloud kalau bisa dijawab lokal.

Menariknya, paper ini tidak memaknai Option A sebagai "semua request harus diproses lokal." Mereka menempatkannya sebagai gatekeeper atau classifier yang memutuskan:

```text
Incoming prompt
      ↓
Local classifier / triage model
      ↓
Apakah request cukup sederhana?
      ↓
Ya → jawab pakai local model
Tidak → lanjut ke cloud pipeline
```

Kelebihan: untuk request yang di-handle lokal, leak rate = 0 secara konstruksi karena tidak ada data outbound ke vendor.
Kekurangan: kualitas model lokal terbatas; kalau classifier salah memilih lokal, user bisa dapat jawaban jelek.

Angka 94.4% muncul dari Table 6 di paper untuk WL1 PII-heavy prose: 472 prompt local dari 500 total, yaitu 94.4%. Itu bukan klaim umum untuk semua sistem. Itu adalah hasil paper pada dataset sintetis WL1, yang berisi prompt bahasa natural bertemplate dan PII eksplisit.

Jadi insight yang lebih aman adalah: untuk dataset PII-heavy prose sederhana, local routing dapat menghindari sebagian besar cloud calls. Untuk workload lain, angka itu turun drastis.

### B — Redaction dengan placeholder restoration

Sensitive span dideteksi lalu diganti placeholder, misalnya `⟨PERSON_1⟩` atau `⟨EMAIL_1⟩`. Mapping disimpan lokal sehingga response bisa direstore.

Kelebihannya jelas: efektif untuk data dengan pola eksplisit seperti email, phone, IP, SSN, AWS key, dan bearer token.
Kelemahannya: sangat bergantung pada recall detector. Jika detector gagal menangkap nama organisasi, proprietary code, atau implicit identity, data masih bocor.

### C — Semantic rephrasing

Di sini prompt direwrite oleh model lokal supaya detail identitas dihilangkan.

Contoh: `The CFO of Acme Corp whose wife works at a competitor...` jadi `A senior executive with a potential conflict of interest...`

Masalahnya: identitas kadang memang bagian dari makna prompt. Kalau konteks yang dihapus terlalu banyak, prompt jadi tidak berguna.

Paper ini menunjukkan bahwa semantic rephrasing membantu di beberapa workload, terutama proprietary code, tetapi gagal di implicit identity. Untuk WL3, leak rate semantiknya tetap 95-100%.

### D — TEE-hosted inference

Prompt masih dikirim plaintext, tetapi diproses di enclave terpadu yang diverifikasi.

Privacy datang dari hardware isolation, bukan dari encrypting prompt. Ini cocok untuk konteks sensitif di mana mask tidak cukup.

Trade-off: infra kompleks, need attestation, dan masih butuh trust pada hardware vendor.

### E — Split inference

Model dibagi dua: layer awal jalan lokal, lalu activation dikirim ke remote.

Ide bagus: token asli tidak dikirim. Namun activation itself bisa bocor lewat attack inversion, jadi ini bukan santapan privasi instan.

### F — Fully Homomorphic Encryption

Secara teori kuat: data tetap terenkripsi. Tapi untuk LLM penuh, belum praktis. Paper hanya mendemonstrasikan classifier kecil, bukan full chat model.

### G — Secure Multi-Party Computation

Input dipecah menjadi secret shares dan diproses oleh server non-colluding.

Privacy-nya kuat jika asumsi non-collusion benar, tetapi overhead dan setup-nya tinggi. Untuk full LLM inference, masih lebih research proof-of-concept.

### H — Differential Privacy noise

Menambahkan noise pada kata tertentu. Paper pakai ε=4 dan 1.8% kata eligible diganti.

Intinya: DP noise bisa membantu sebagai lapisan tambahan, tapi tidak efektif sebagai solusi utama untuk request LLM. Kalau yang bocor adalah API key atau identifier khusus, random substitution belum tentu tepat sasaran.

## Benchmark mereka

Benchmark sintetis berisi 1.300 prompt dengan 4.014 annotation sensitive spans.

Empat workload:

- WL1 — PII-heavy prose (500 sample, 1.946 annotation)
- WL2 — Secret-heavy configuration (300 sample, 730 annotation)
- WL3 — Implicit identity (200 sample, 220 annotation)
- WL4 — Proprietary code (300 sample, 1.118 annotation)

Di Table 6, paper juga menunjukkan local routing rate Option A:

- WL1 PII: 472 local / 500 total = 94.4%
- WL2 Secrets: 224 local / 300 total = 74.7%
- WL3 Implicit: 108 local / 200 total = 54.0%
- WL4 Code: 114 local / 300 total = 38.0%

Itu memperjelas bahwa 94.4% hanya berlaku untuk WL1 yang relatif ringan, dan kemampuan local routing turun saat task jadi lebih semantik atau kode-heavy.

Kelemahan benchmark: sintetis dan lebih rapi daripada prompt dunia nyata. Real prompt jauh lebih messy, dengan bahasa campur, typos, screenshot OCR, log production, dan kode panjang.

## Hasil utama

Yang paling penting: tidak ada teknik tunggal yang menang di semua kondisi.

Paper ini menyimpulkan kombinasi praktis terbaik adalah:

```text
A + B + C
```

Artinya:
1. route lokal kalau bisa,
2. kalau harus ke cloud, lakukan redaction,
3. lalu semantic rephrasing.

Hasilnya:
- WL1 PII: combined leak ~0.6%, zero exact leak across 500 samples.
- WL2 secret: combined leak ~6.4%.
- WL4 proprietary code: combined leak ~31.3%.
- WL3 implicit identity: combined leak ~43.6%, dengan semantic leak masih 95-100% failure untuk redaction/rephrasing.

Intinya: untuk PII eksplisit, local+redaction+rephrase efektif. Untuk implicit identity dan proprietary code, masking saja tidak cukup.

## Insight paling kuat

Paper ini tidak terjebak klaim simplistik seperti “pakai redaction, privacy solved.”

Redaction kuat untuk level 1 kebocoran: email, phone, IP, SSN, hostname, employee ID setelah custom recognizer.

Tapi lemah untuk:
- person name,
- organization name,
- address,
- implicit identity,
- proprietary context.

Kalau disederhanakan:
- Level 1: direct identifiers — redaction efektif.
- Level 2: quasi-identifiers — perlu detector dan contextual rules.
- Level 3: semantic identity — rephrase bisa membantu, tapi tidak cukup.
- Level 4: proprietary context — mungkin perlu local model, TEE, atau refusal.

## Relevansi ke agent system

Untuk sistem agent, relevance-nya besar karena agent punya surface area lebih luas daripada chatbot biasa.

Agent tidak cuma mengirim prompt awal. Agent bisa:
- retrieve konteks dari repo atau doc,
- memanggil tool,
- menyusun prompt intermediate,
- menyimpan memory,
- melakukan subagent handoff,
- menulis artifact.

Jadi kebocoran bisa terjadi di prompt request, tool args, scratchpad, trace, memory store, atau generated artifact.

Paper ini fokus pada outbound LLM request pipeline. Tapi idenya bisa diperluas jadi privacy gateway di depan semua LLM call dan agent boundary.

## Praktik arsitektur yang gue ambil

Pipeline praktis yang gue tarik adalah:

```text
User request / Agent context
        ↓
Sensitivity classifier
        ↓
Policy decision
        ↓
Local route / Redact / Rephrase / TEE / Refuse
        ↓
Cloud LLM or Local LLM
        ↓
Post-processing + Placeholder restoration
        ↓
Response
```

Untuk agent system, gue tambahkan layer:

```text
Input
  ↓
Document/context scanner
  ↓
PII + secret + proprietary detector
  ↓
Risk scoring
  ↓
Policy router
  ├── local model
  ├── cloud redaction
  ├── cloud redaction + rephrase
  ├── TEE
  └── refuse / approval
  ↓
Trace sanitizer
  ↓
Output sanitizer
```

Trace sanitizer penting, karena banyak sistem agent sekarang pakai Langfuse, LangSmith, atau observability custom. Kalau raw prompt masuk trace, mask saja tidak cukup.

## Kritik paper

- benchmark sintetis, tidak mewakili messy prompt dunia nyata.
- utility evaluation terbatas pada local Qwen 3.5 4B dan Llama 3.2 3B.
- Option D–G lebih berupa demonstrasi proofof-concept daripada deployment production.
- beberapa klaim tampak ambigu, terutama pada angka implicit identity.
- semantic leak analysis hanya pada subset kecil WL3.

## Takeaway

LLM-Redactor menguatkan satu prinsip yang gue pegang:

> privacy-preserving LLM request bukan hanya soal masking, itu soal routing, detection, transformation, trust boundary, dan policy.

Praktis hari ini: kombinasi local routing + redaction + semantic rephrasing adalah baseline yang layak. Untuk implicit identity dan proprietary context, solusi paling aman adalah jangan kirim ke cloud biasa.

Original paper: https://arxiv.org/abs/2604.12064

Link: [[notes.security.pii-agent-architecture]]
