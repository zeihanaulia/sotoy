---
id: notes.security.pii-agent-architecture
title: "Arsitektur PII filter dan security agent"
desc: "Riset arsitektur PII detection, baseline scan, dan modular plugin untuk security agent."
updated: 1777874908001
created: 1777869503130
tags:
  - notes
  - security
  - pii
  - agent
---

- Riset ini fokus pada desain security agent yang bisa deteksi dan redaksi PII, bukan sekadar menebak entitas sensitif dengan satu regex.

## Referensi utama
- `microsoft/presidio`: SDK modular untuk identifikasi dan de-identifikasi PII di teks dan gambar.
- `Yelp/detect-secrets`: model baseline+diff untuk fokus pada perubahan baru dalam repositori kode.
- `piisa/pii-extract-base`: engine infrastruktur yang menyediakan framework, sementara deteksi aktual disuplai oleh plugin eksternal.

## Apa yang penting dari Presidio
- Memisahkan peran utama: analyzer, anonymizer, image redactor, dan structured PII.
- Menggabungkan teknologi: NER, regex, rule-based logic, checksum, dan konektor ke model eksternal.
- Menekankan bahwa deteksi otomatis membantu, tapi tidak bisa menjamin semua sensitive info terdeteksi.
- Ini cocok untuk agent privacy filter yang perlu:
  - identifikasi PII yang bisa di-redaksi,
  - support multi-format (text + image),
  - custom recognizer dan policy per domain.

## Apa yang penting dari detect-secrets
- Pattern utamanya: buat baseline, lalu cek perubahan baru.
- Fokus pada "baru masuk" mengurangi noise dan false positive dari artefak lama.
- Untuk security agent, ini berarti:
  - agent harus bisa mengenali konteks perubahan, bukan scan penuh setiap saat,
  - audit daftar sensitif bisa dipisah antara item lama dan item baru,
  - ini lebih efisien untuk pipeline yang dipakai terus-menerus.

## Apa yang penting dari pii-extract-base
- Engine ini tidak melakukan deteksi sendiri; dia hanya menyediakan infrastruktur untuk task PII.
- Bukti arsitektur: `core engine` + `detector plugin` + `data base`.
- Artinya desain terbaik adalah memisahkan platform dari aturan deteksi.
- Dengan begitu, kita bisa menambahkan:
  - plugin baru untuk tipe PII khusus,
  - model external untuk nama/alamat/organisasi,
  - fallback regex/checksum untuk angka dan format tertentu.

## Pelajaran arsitektur
- Desain pipeline modular:
  1. collector (kumpulkan teks/dokumen/image),
  2. detector (identifikasi kemungkinan PII),
  3. policy engine (tentukan apakah flag, mask, redact, atau audit),
  4. redactor/anonymizer (hasilkan output aman).
- Gunakan plugin atau registry untuk model dan pola PII; jangan hardcode semua jenis entitas di satu layer.
- Minimal dua output penting:
  - `flagged item` untuk audit dan logging,
  - `redacted output` untuk data yang boleh diteruskan.
- Tambahkan kemampuan incremental update kalau agent jalan terus: jangan rebuild seluruh index setiap input.

## Takeaway
- Security agent untuk PII paling kuat kalau dibangun sebagai sistem, bukan skrip tunggal.
- Presidio memberi pola deteksi + redaksi; detect-secrets memberi pola change-focused scan; pii-extract-base memberi pola engine-plugin.
- Fokus arsitektur harus pada modularitas, auditability, dan pemisahan antara deteksi dan tindakan.
- Jika ingin lanjut, review dokumentasi resmi masing-masing repo karena akses riset masih partial dari batas rate limit/API.

## Riset terbaru 2026
- `CAMP (2604.16521)`: fokus pada PII cross-turn dalam percakapan agentik, tidak cukup hanya mask tiap pesan. Sistem ini menjawab tiga pertanyaan: kelemahan per-turn masking, formalization risiko cumulative exposure melalui CPE, dan desain middleware untuk session-aware protection. [[zettel.1777875390302]] (detail note)
  - `camp.*` notes: [[notes.security.pii-agent-architecture.camp.md]], [[notes.security.pii-agent-architecture.camp.per-turn-masking]], [[notes.security.pii-agent-architecture.camp.cpe]], [[notes.security.pii-agent-architecture.camp.why-camp]], [[notes.security.pii-agent-architecture.camp.indexed-masking]]
- `LLM-Redactor (2604.12064)`: evaluasi empiris 8 teknik request privacy untuk LLM, termasuk local inference, redaction, semantik rephrasing, TEE, split inference, FHE, MPC, dan DP. Kombinasi paling praktis: local + redact + rephrase. [[notes.security.pii-agent-architecture.llm-redactor]] (detail note)
- `Hardening x402 (2604.11430)`: contoh nyata PII-safe agentic payment, dengan middleware pre-execution filter untuk metadata x402 agar URL/deskripsi/reason string yang mengandung PII ter-redact sebelum request dikirim. [[notes.security.pii-agent-architecture.hardening-x402]] (detail note)
- `PII boundary antara agent`: adaptasi pola x402 ke dua-agent workflow, di mana brainstorming agent dan coding agent dipisahkan oleh PII guardrail dan sanitized artifact. [[notes.security.pii-agent-architecture.agent-boundary-pii-filtering]] (detail note)
- `PII Shield (2603.24895)`: browser overlay yang memberi pengguna kontrol langsung atas redaction prompt AI, termasuk local LLM untuk deteksi entitas dan aktivitas smokescreen untuk mitigasi profiling. [[notes.security.pii-agent-architecture.pii-shield]] (detail note)
- `WebPII (2603.17357)`: benchmark visual PII detection untuk screenshot UI agent/computer-use, yang menyorot kebutuhan sanitasi PII di visual pipeline, bukan hanya teks. [[notes.security.pii-agent-architecture.webpii]] (detail note)

## Temuan tambahan: user-supplied PII dan personal AI
- `Opal: Private Memory for Personal AI (2604.02522)`: relevant untuk agent yang menyimpan konteks personal user secara lokal, membantu memisahkan informasi pengguna dari prompt yang dikirim ke model. [[notes.security.pii-agent-architecture.opal]] (detail note)
- `SafeClaw-R: Towards Safe and Secure Multi-Agent Personal Assistants (2603.28807)`: fokus pada keamanan dan privasi pada personal assistant multi-agent, cocok untuk kasus user request yang berisi data sensitif. [[notes.security.pii-agent-architecture.safeclaw-r]] (detail note)
- `Separable Expert Architecture: Toward Privacy-Preserving LLM Personalization via Composable Adapters and Deletable User Proxies (2604.21571)`: desain LLM personalization yang bisa meminimalkan exposure data personal dengan adapter yang bisa dihapus. [[notes.security.pii-agent-architecture.separable-expert-architecture]] (detail note)
- `RePAIR: Interactive Machine Unlearning through Prompt-Aware Model Repair (2604.12820)`: relevan untuk fallback ketika user-supplied PII sudah terlanjur mendarat di model, dengan prompt-aware model repair sebagai mekanisme mitigate. [[notes.security.pii-agent-architecture.repair]] (detail note)
- `Privacy as Permissible Operations: An ABAC Framework for Policy-Law Compliance (2604.10832)`: memberi kerangka akses kontrol terhadap data personal pada aplikasi berbasis AI, penting untuk mendefinisikan policy sebelum agent mengeksekusi query.
- `An AI Agent Execution Environment to Safeguard User Data (2604.19657)`: model lingkungan eksekusi yang memisahkan akses data sensitif dari pipeline utama model. [[notes.security.pii-agent-architecture.agent-execution-environment]] (detail note)
- `Are Chatbots Ready for Privacy-Sensitive Applications? An Investigation into Input Regurgitation and Prompt-Induced Sanitization (2305.15008)`: bukti bahwa input sensitif masih sering bocor kembali lewat respons dan sanitization sisi prompt tidak cukup andal. [[notes.security.pii-agent-architecture.chatbot-privacy-sensitivity]] (detail note)
- `Memory for Autonomous LLM Agents: Mechanisms, Evaluation, and Emerging Frontiers (2603.07670)`: memori lintas sesi jadi titik penting seandainya agent menyimpan PII dari user secara terpisah. Paper ini menguatkan bahwa agent memory harus diperlakukan sebagai layer governance tersendiri, dengan filtering sebelum store, retention policy, access scoping, dan audit, bukan sekadar ditangani sebagai chat history. [[notes.security.pii-agent-architecture.memory-autonomous-agents]] (detail note)

- [[zettel.1777874908001]] — cross-session agent memory harus dilihat sebagai sumber sensitif yang butuh policy, bukan sekadar log percakapan.

## Use case hands-on untuk security agent
1. Agen pembayaran autonomous: intercept request metadata sebelum dikirim ke payment gateway, redaksi nama, email, nomor akun, dan reason text.
2. Multi-turn customer support chatbot: pantau percakapan sepanjang sesi, simpan fragmen PII dalam registry, dan jalankan retroactive masking saat kombinasi entitas melewati ambang risiko.
3. Browser-based personal AI assistant: jalankan local redaction overlay pada prompt sebelum diteruskan ke model cloud, sehingga data sensitif tidak meninggalkan perangkat.
4. Visual UI automation: deteksi PII di screenshot aplikasi atau form yang diisi pengguna, sehingga agen yang membaca layar hanya melihat versi anonymized.

## Langkah bukti keamanan agent
1. Definisikan threat model secara eksplisit: apakah ancamannya data leakage, reidentifikasi, atau payment metadata exposure?
2. Pisahkan pipeline menjadi: input collector → detector → policy engine → redactor/anonymizer → audit logger.
3. Terapkan session-level state untuk kasus multi-turn dan cross-input, bukan hanya scan stateless per request.
4. Tambahkan audit trail yang merekam entitas PII, keputusan policy, dan output yang dikirim agent.
5. Evaluasi dengan benchmark sintetis + skenario nyata: percakapan multi-turn, metadata pembayaran, screenshot UI, dan permintaan cloud LLM.
6. Verifikasi utilitas agent tidak rusak secara drastis: bandingkan output sebelum dan sesudah redaction, lalu pastikan tidak ada PII mentah tertinggal.

## Contoh snippet PII-safe agent
```python
from typing import List, Dict

class PiiItem:
    def __init__(self, entity_type: str, text: str, score: float):
        self.type = entity_type
        self.text = text
        self.score = score

    def to_dict(self):
        return {"type": self.type, "text": self.text, "score": self.score}


class PiiRegistry:
    def __init__(self):
        self.items: List[PiiItem] = []

    def update(self, new_items: List[PiiItem]):
        self.items.extend(new_items)

    def compute_cpe(self) -> float:
        weights = {
            "NAME": 0.5,
            "EMAIL": 0.7,
            "CREDIT_CARD": 1.0,
            "ADDRESS": 0.8,
            "PHONE": 0.6,
        }
        return sum(weights.get(item.type, 0.4) * item.score for item in self.items)


class SafeAgent:
    def __init__(self, detector, redactor, threshold: float = 1.5):
        self.detector = detector
        self.redactor = redactor
        self.threshold = threshold
        self.registry = PiiRegistry()

    def step(self, text: str) -> Dict:
        found = self.detector.scan(text)
        self.registry.update(found)
        cpe = self.registry.compute_cpe()

        if cpe >= self.threshold:
            safe_text = self.redactor.rewrite_history(self.registry, text)
            status = "review_required"
        else:
            safe_text = self.redactor.redact(text, found)
            status = "ok"

        return {
            "status": status,
            "safe_text": safe_text,
            "pii_items": [item.to_dict() for item in found],
            "cpe": cpe,
        }
```

- `detector.scan(text)` bisa menggabungkan NER, regex, dan domain-specific rules.
- `redactor.redact(...)` menghasilkan placeholder terstruktur.
- `rewrite_history(...)` adalah analog CAMP: retroactive masking untuk seluruh session ketika skor risiko terlalu tinggi.

## Catatan praktis
- Gunakan model atau rule yang bisa dijalankan lokal untuk menjaga data tetap di dalam perimeter.
- Audit log adalah bukti bahwa agent sudah menjalankan pemeriksaan PII; penting untuk security review.
- Untuk hands-on, mulai dari case `x402 metadata` karena ada penerapan yang jelas: filter sebelum execution.
- Untuk pembuktian keamanan, buat dua suite: `privacy tests` (no PII leak) dan `utility tests` (agent masih bisa menyelesaikan tugas).

## Prinsip PII-safe untuk LLM agent
- **Masking harus terjadi sebelum prompt dikirim ke LLM**. Ini adalah lapisan pertama dan paling penting.
- **Output filtering hanya safety net**, bukan satu-satunya pertahanan. Jika model sudah menerima PII mentah, risiko exposure tetap ada.
- **Jangan pakai prompt-level safety saja** tanpa state-aware policy. Multi-turn agent harus menilai PII cross-turn, seperti `CAMP`.
- **Pseudonymization dan placeholder replacement** lebih baik dari sekadar redaksi kasar karena menjaga konteks utilitas.
- **Audit dan traceability** harus mencatat:
  - entitas PII yang ditemukan,
  - transformasi yang dilakukan (mask/redact/pseudonymize),
  - apakah data dikirim ke LLM langsung atau melalui trusted local rewriting.
- **Threat model harus eksplisit**: data leakage, reidentification, payment metadata exposure, dan model memorization.
- **Jika mungkin, gunakan local inference untuk filtering** sebelum call ke remote LLM. Ini meminimalkan jumlah informasi sensitif yang meninggalkan perimeter.

## Menangani user-supplied PII
- User boleh memasukkan PII secara eksplisit, tetapi agent tidak boleh langsung meneruskan PII itu ke model.
- **Pisahkan data access dari generative reasoning**:
  - data sensitif (rekening, tagihan, kondisi kesehatan) diambil melalui backend atau storage yang terkontrol,
  - query ke LLM dibuat dalam bentuk aman / abstrak.
- **Contoh pola**:
  1. user: "Berapa tunggakan saya?"
  2. agent: ambil `account_id` dan data billing secara lokal dari sistem internal
  3. agent: buat prompt aman seperti "Tampilkan status tagihan untuk Customers A" atau gunakan template internal non-identifiable
  4. kirim prompt ke LLM untuk memformat jawaban, bukan untuk mencari data mentah
- Untuk kesehatan, gunakan `patient_case_123` atau label serupa, bukan nama/NIK/identitas yang bisa direidentifikasi.
- **Jika PII ingin digunakan langsung dalam reasoning** (mis. diagnosis spesifik), lakukan itu di perimeter yang trusted dan jangan kirim mentah ke cloud LLM.
- `output filter` tetap digunakan, tapi dalam skenario ini fungsinya sebagai pengaman kedua, bukan deteksi utama.
- **Kunci**: agent dapat melayani request personal, tetapi model tidak boleh pernah mendapatkan PII mentah yang bisa bocor.
