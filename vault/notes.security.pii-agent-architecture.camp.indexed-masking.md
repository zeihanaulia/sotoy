---
id: notes.security.pii-agent-architecture.camp.indexed-masking
title: "Indexed masking untuk agentic PII protection"
desc: "Catatan tentang tokenized placeholder sebagai alternatif pseudonymization dalam proteksi PII untuk multi-turn agent." 
updated: 1777948651876
created: 1777878435588
tags:
  - notes
  - security
  - pii
  - agent
  - camp
  - masking
---

## Inti ide
Untuk agentic multi-turn, pseudonymization palsu bisa memancing model membuat asumsi atas dunia yang salah. Indexed masking atau tokenized pseudonymization lebih aman karena menjaga struktur dan referensi tanpa memasukkan fakta baru.

## Apa bedanya dengan fake pseudonymization
Fake pseudonymization mengganti data asli dengan nilai yang tampak natural:
- "Raka" → "Daniel"
- "Tokopedia" → "Acme Corp"
- "Bandung" → "Surabaya"

Indexed masking mengganti dengan placeholder terindeks:
- "Raka" → `[PERSON_001]`
- "Tokopedia" → `[ORG_001]`
- "Bandung" → `[LOCATION_001]`

Mapping asli disimpan lokal, tidak pernah dikirim ke external LLM.

## Kelebihan indexed masking
- tidak menambahkan fakta palsu yang bisa mengubah konteks,
- lebih transparan terhadap model,
- konsistensi referensi antar turn terjaga,
- de-masking lebih deterministik,
- lebih mudah di-audit.

## Kekurangan indexed masking
- teks menjadi lebih kaku,
- model kehilangan beberapa sinyal semantik,
- context-dependent entity seperti lokasi dan salary bisa jadi terlalu abstrak jika placeholder terlalu polos.

## Hybrid yang lebih kuat
Untuk menjaga utility, indexed masking bisa ditambahkan metadata semantic ringkas:
- `[LOCATION_001: city in West Java, Indonesia]`
- `[ORG_001: Indonesian e-commerce company]`
- `[SALARY_001: monthly income 30–40M IDR]`

Dengan cara ini model tetap mendapat konteks yang relevan tanpa mengetahui value asli.

## Apa yang perlu ditulis lebih lengkap
Note sebelumnya terlalu ringkas dan belum menangkap ruang lingkup desain ini.
Sekarang gue perlu menjelaskan:
- apa itu indexed masking secara teknis,
- bagaimana dia berbeda dari fake pseudonymization dan redaction,
- struktur mapping/local registry,
- kapan pake placeholder polos vs placeholder berlabel semantics,
- risiko semantic drift, utility loss, dan false sense of privacy,
- contoh implementasi arsitektur,
- literatur yang benar-benar relevan.

## Indexed masking / tokenized pseudonymization
Indexed masking adalah strategi anonymization di mana entity sensitif diganti dengan token terindeks yang konsisten di seluruh session.

Contoh:
- `Raka` → `[PERSON_001]`
- `Tokopedia` → `[ORG_001]`
- `Bandung` → `[LOCATION_001]`
- `35 juta` → `[SALARY_001]`

Token ini hanyalah placeholder. Mapping asli disimpan secara lokal di middleware, tidak dikirim ke external LLM.

### Perbedaan utama
| Teknik | Model lihat | Risiko masuknya fakta palsu | Coherence | De-masking |
|---|---|---|---|---|
| redaction kasar | `[PERSON]`, `[ORG]` | rendah | rendah | mudah |
| fake pseudonymization | `Daniel`, `Acme Corp` | tinggi | tinggi | rentan paraphrase |
| indexed masking | `[PERSON_001]` | rendah | sedang | mudah dan deterministic |

## Kenapa ini lebih aman daripada fake pseudonymization
Fake pseudonymization memasukkan detail palsu yang model bisa gunakan untuk reasoning.
Itu berbahaya karena konteks palsu bisa mengubah asumsi domain, hukum, budaya, dan task.

Contoh:
- `Tokopedia` → `Acme Corp` membuat model berpikir konteks US/tech company
- `Bandung` → `Surabaya` bisa mengubah inferensi transportasi, regulasi, dan biaya hidup

Indexed masking menghindari hal ini dengan tidak memberi model nilai dunia nyata yang salah.

## Kapan placeholder polos cukup
Placeholder polos seperti `[LOCATION_001]` cocok ketika:
- entity hanya berperan sebagai identifier,
- task tidak membutuhkan informasi jenis, letak, atau nilai,
- kita ingin maximal privacy.

Tapi kalau task membutuhkan semantik, placeholder polos bisa terlalu abstrak.

## Kapan perlu semantic placeholders
Kalau entity punya makna task, tambahkan label ringkas.
Contoh:
- `[LOCATION_001: West Java city]`
- `[ORG_001: Indonesian e-commerce company]`
- `[SALARY_001: monthly income 30–40M IDR]`

Ini masuk ke kategori semantic-preserving anonymization: data asli tidak terlihat, tetapi model masih punya sinyal penting.

## Arsitektur implementasi
Bagian utama yang harus ada:
1. **PII extractor** — deteksi entity di setiap pesan.
2. **Mapping generator** — buat token stabil untuk setiap entitas baru.
3. **Local registry** — simpan mapping asli ↔ token, metadata, jenis entity, dan timestamp.
4. **Context rewriter** — ganti entity di prompt dengan token.
5. **LLM inference** — kirim masked prompt ke external model.
6. **Response de-masking** — ganti token kembali ke nilai asli bila aman.
7. **Policy enforcer** — putuskan apakah placeholder boleh dide-mask atau disimpan.

## Contoh end-to-end
Original history:
```
Nama gue Raka.
Gue kerja di Tokopedia.
Gue tinggal di Bandung.
Gaji gue 35 juta.
```
Masked history:
```
Nama gue [PERSON_001].
Gue kerja di [ORG_001].
Gue tinggal di [LOCATION_001].
Gaji gue [SALARY_001].
```
Local registry:
```
[PERSON_001] -> Raka
[ORG_001] -> Tokopedia
[LOCATION_001] -> Bandung
[SALARY_001] -> 35 juta
```
Kalau model menjawab:
"[PERSON_001] should consider saving more from [SALARY_001]..."
De-masking:
"Raka should consider saving more from 35 juta..."

## Risiko yang harus dicatat
- **Utility loss**: placeholder polos menghilangkan nilai task-relevant.
- **Semantic drift**: fake pseudonym bisa memasukkan konteks palsu.
- **Pre-trigger exposure**: kalau history asli sudah pernah dikirim, masternya tetap bocor.
- **Mapping security**: registry lokal harus aman dan dihapus sesudah session.
- **Partial de-masking**: jika model membuat variasi nama token, backmapping harus robust.

## Literatur yang lebih lengkap
Ini bukan istilah khusus, tapi ide ini cocok dengan beberapa konsep literatur:
- **reversible pseudonymization** atau **surrogate identifiers**,
- **entity masking with backmapping**,
- **contextualized anonymization**,
- **privacy gateway / prompt gateway**.

Papers serta sumber relevan:
- NISTIR 8053 — de-identification/pseudonymization sebagai fondasi.
  - https://nvlpubs.nist.gov/nistpubs/ir/2015/NIST.IR.8053.pdf
- Portcullis — privacy gateway untuk LLM inference dengan input rewriting dan response reconstruction.
  - https://ojs.aaai.org/index.php/AAAI/article/view/32088/34243
- Balancing Privacy and Utility in Personal LLM Writing Tasks — evaluasi masking vs pseudonymization.
  - https://arxiv.org/abs/2408.12345
- Operationalizing Data Minimization for Privacy-Preserving LLM Prompting — prinsip minimum data yang cukup.
  - https://openreview.net/forum?id=rpcnvW33EG

## Contoh
Original:
- "Nama gue Raka."
- "Gue kerja di Tokopedia."
- "Gue tinggal di Bandung."
- "Gaji gue 35 juta."

Indexed masking:
- "Nama gue [PERSON_001]."
- "Gue kerja di [ORG_001]."
- "Gue tinggal di [LOCATION_001]."
- "Gaji gue [SALARY_001]."

Hybrid indexed masking:
- "Nama gue [PERSON_001]."
- "Gue kerja di [ORG_001: Indonesian e-commerce company]."
- "Gue tinggal di [LOCATION_001: West Java city]."
- "Gaji gue [SALARY_001: monthly income 30–40M IDR]."

## Implementasi
Arsitektur ideal:
1. extractor PII menemukan entity,
2. mapper membuat token stabil dan typed,
3. local registry menyimpan mapping asli,
4. writer mengganti entity di context,
5. model menerima masked context,
6. output de-mask ke user jika aman.

## Kapan gunakan
- ketika identity asli harus disembunyikan sepenuhnya,
- ketika fake pseudonym berisiko membuat dunia palsu,
- ketika kita butuh determinisme dan auditability,
- ketika task masih bisa dijalankan dengan metadata abstraction.

## Related notes
- [[notes.security.pii-agent-architecture.camp]]
- [[notes.security.pii-agent-architecture.camp.cpe]]
- [[notes.security.pii-agent-architecture.camp.why-camp]]
- [[notes.security.pii-agent-architecture.camp.per-turn-masking]]
