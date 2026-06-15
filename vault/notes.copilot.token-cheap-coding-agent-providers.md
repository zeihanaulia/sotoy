---
id: notes.copilot.token-cheap-coding-agent-providers
title: "Token murah untuk coding agent"
desc: "Rekomendasi provider dan model API/token murah yang relevan untuk agent coding."
updated: 1777989957034
created: 1777983433360
tags:
  - notes
  - copilot
  - pricing
  - ai
---

Dalam catatan ini, gue mendefinisikan "token murah" sebagai model yang bisa dipakai lewat LiteLLM/OpenAI-compatible endpoint untuk agent/harness, dengan biaya per 1M token rendah. Bukan sekadar paket chat murah atau subscription diskon.

Intinya: menurut gue, kalau goal lo adalah agent coding murah, jangan hanya cari model dengan tarif per token terendah. Cari kombinasi:

- murah per token,
- cukup kuat untuk coding,
- context panjang memadai,
- kompatibel dengan agent/tool calling,
- tidak memaksa loop panjang karena kualitas rendah.

Gue pakai daftar ini supaya lo nggak terjebak model murah yang ujung-ujungnya malah ngabisin token karena harus retry terus.

## Opsi utama

### 1. OpenRouter — eksperimen provider-agnostik yang paling praktis

OpenRouter adalah tempat paling cepat untuk membandingkan model dengan tool calling support tanpa bikin integrasi baru untuk setiap provider.

- bukti: OpenRouter docs `Tool & Function Calling` menjelaskan cara kerja tool calling secara generik dan cara filter model yang mendukung tools.
  - https://openrouter.ai/docs/guides/features/tool-calling
  - https://openrouter.ai/collections/tool-calling-models
- kenapa penting: ini berarti tool calling adalah fitur API, bukan hanya klaim marketing model tertentu.
- kelebihan: bisa explore banyak model sekaligus, termasuk non-Qwen model, dan test apakah tool calling sebenarnya berjalan di provider tersebut.
- kekurangan: harga dan reliability bisa berbeda antar provider, jadi harus dicek per model.

Rekomendasi pakai OpenRouter untuk:

- membandingkan model tool calling
- cek apakah model juga support function calling sekaligus
- melihat provider yang punya interface OpenAPI/tool schema standar

### 2. Groq — throughput, harga prediktif, dan compound AI

Groq memperlihatkan bahwa ada jalan lain selain hanya harga per token: infrastruktur inference dan model mix matter.

- bukti: Groq pricing page mencantumkan model seperti GPT OSS 20B, Llama 4 Scout 17B 16E, Qwen3 32B, dan Llama 3.1 8B Instant.
  - [Groq pricing](https://groq.com/pricing)
- kenapa penting: model yang sama bisa dipakai dalam compound AI systems dengan built-in tools, yang lebih relevan untuk workflow agentic daripada sekadar model chat.
- kelebihan: harga token terukur, latency tinggi, dan dukungan compound systems berarti provider memikirkan tool selection + multi-model orchestration.
- kekurangan: tidak semua model open weight tersedia tanpa enterprise access, jadi perlu cek daftar model secara manual.

### 3. DeepSeek — tool/function calling eksplisit

DeepSeek punya dokumentasi tool calls dan function calling sendiri, yang berarti provider ini memang dibangun untuk agentic workflows.

- bukti: DeepSeek API docs memiliki halaman `Tool Calls` dan `Function Calling`.
  - [DeepSeek Tool Calls](https://api-docs.deepseek.com/guides/tool_calls)
  - [DeepSeek Function Calling](https://api-docs.deepseek.com/guides/function_calling)
- kenapa penting: provider ini tidak hanya menjual model murah; mereka juga menyediakan layer tool-calling sebagai fitur API.
- kelebihan: cocok untuk coding agent yang butuh call external tools secara eksplisit.
- kekurangan: bisa ada kekhawatiran reliability dan data route untuk use case sensitif.

### 4. DeepInfra / Qwen3 — strong reasoning plus agent capability

DeepInfra masih penting karena modelnya jelas menyebut agent capabilities, reasoning, instruction following, dan function calling.

- bukti: halaman DeepInfra Qwen3-14B menulis bahwa Qwen3 menawarkan reasoning, instruction-following, agent capabilities, multilingual support, dan function calling support.
  - [DeepInfra Qwen3-14B](https://deepinfra.com/Qwen/Qwen3-14B)
- kenapa penting: ini menunjukkan bahwa Qwen3 bukan hanya model sekenanya, tapi diposisikan untuk use case agentic.
- kelebihan: context panjang besar, tool/agent-oriented messaging, dan entrypoint ke model Qwen3/3.5.
- kekurangan: masih Qwen-centric, jadi gunakan sebagai salah satu opsi, bukan satu-satunya opsi.

### 5. Kimi / GLM / MiniMax — frontier open-weight agent models

Sekarang ada juga layer model frontier yang perlu dipertimbangkan, terutama kalau lo butuh model open-weight yang memang dibangun untuk agent/tool workflows.

- Kimi K2.5: model 1.04T parameter dengan klaim `Agent Swarm`, paralel agent orchestration, dan benchmark coding/ browsing yang kompetitif. Dokumentasi komunitas menyebutnya sebagai model open-weight dengan kualitas agentic.
  - bukti: [Hugging Face blog Kimi K2.5](https://huggingface.co/blog/kimi-k2.5), Feb 23 2026.
  - klaim: `Agent Swarm`, open model, kodepen, dan benchmark yang menempatkannya di kelasnya.
- GLM-5: model open frontier yang explicitly didesain untuk function calling, large context 200K, dan agent-style reasoning. Banyak dokumentasi memperlihatkan dukungan function calling / tool calling, termasuk Milvus dan Z.ai.
  - bukti: [Z.ai GLM-5 model page](https://z.ai/models/GLM-5-1.0), [Milvus `What is GLM-5`](https://milvus.io/blog/what-is-glm-5), dan [Unsloth GGUF deployment](https://unsloth.dev/models/glm-5-1.0-gguf).
- MiniMax M2.5: model yang disebut dalam benchmark perbandingan Kimi/GLM dan membawa skor BrowseComp ~76.3%. Namun saat ini domain resmi minimax.ai terparkir, jadi bukti publik langsung terbatas.
  - bukti: perbandingan benchmark pada artikel Kimi K2.5 yang mencantumkan MiniMax M2.5.
- kenapa penting: ini menambah opsi non-Qwen dengan fokus pada agent/tool workflows dan open-weight deployment.
- kelebihan: alternatif model frontier yang bisa jadi lebih murah dibandingkan vendor besar dan tetap support function calling secara praktis.
- kekurangan: bisa lebih sulit dipakai langsung lewat API karena provider/hosting spesifik belum sebanyak Qwen.

### 6. RunPod / local hybrid — saat lo butuh kontrol penuh

Jika goal lo bukan cuma token murah tapi juga control + zero cloud token cost, RunPod dan local deployment masih masuk akal.

- contoh harga: RTX 4090 di Secure Cloud ~$0.69/jam, Community Cloud ~$0.34/jam.
- catatan: ini bukan harga token API, melainkan harga compute; harus siap konfigurasi Ollama/vLLM/llama.cpp, endpoint, dan keamanan.
- kelebihan: cocok buat benchmark model 14B/30B lokal tanpa investasi hardware.
- kekurangan: setup lebih kompleks, dan cost-nya jadi compute/time, bukan token saja.

## Ranking model/provider untuk coding agent tool calling + reasoning

1. OpenRouter
   - terbaik untuk eksperimen dan dengan cepat benchmark tool calling across providers
   - evidence: generic tool calling docs dan model filter di OpenRouter
2. Groq
   - terbaik untuk throughput + predictable pricing dan compound AI/tool orchestration
   - evidence: pricing page yang memuat model open source + compound systems
3. DeepSeek
   - terbaik untuk provider yang eksplisit memposisikan diri sebagai tool-calling API
   - evidence: DeepSeek tool calls / function calling docs
4. DeepInfra Qwen3 / Qwen3.5
   - terbaik untuk agent-oriented model dengan reasoning capabilities dan function calling support
   - evidence: DeepInfra model page
5. Kimi / GLM / MiniMax
   - terbaik untuk frontier open-weight agent models dengan benchmark dan function/tool calling evidence
   - evidence: Hugging Face Kimi blog, Z.ai GLM-5 docs, Milvus GLM-5 article, Kimi article mention MiniMax M2.5
6. Local fallback / RunPod
   - terbaik untuk kontrol lokal / hybrid ketika cloud token cost ingin ditekan

## Prinsip ranking

Terkadang model termurah tidak berguna kalau tool calling dan agent orchestration-nya jelek. Jadi urutan ini mengutamakan:

- dukungan tool calling atau function calling
- kemampuan reasoning/agent-oriented workflows
- kemudahan integrasi dengan agent harness
- harga per token yang masuk akal untuk use case coding
- ketersediaan model selain Qwen, supaya tidak bias ke satu keluarga model

## Kenapa tidak hanya lihat harga token

Model murah tapi tanpa tool calling atau tanpa workflow agent yang matang sering membuat biaya sebenarnya lebih besar.

- loop panjang + retry = cost driver utama
- output token bisa lebih mahal daripada input
- kalau model tidak paham tool schema, lo habisin token buat narik hasil yang sama

Jadi strategi terbaik tetap: pakai OpenRouter untuk validasi provider, lalu pilih Groq/DeepSeek/DeepInfra tergantung apakah lo butuh throughput, tool support, atau reasoning.

## Evidence links

- [OpenRouter tool calling docs](https://openrouter.ai/docs/guides/features/tool-calling)
- [OpenRouter tool-calling model collection](https://openrouter.ai/collections/tool-calling-models)
- [OpenRouter free router](https://openrouter.ai/openrouter/free)
- [DeepSeek tool calls docs](https://api-docs.deepseek.com/guides/tool_calls)
- [DeepSeek function calling docs](https://api-docs.deepseek.com/guides/function_calling)
- [DeepInfra Qwen3 agent/ reasoning page](https://deepinfra.com/Qwen/Qwen3-14B)
- [Kimi K2.5 open-weight agent blog](https://huggingface.co/blog/kimi-k2.5)
- [Z.ai GLM-5 model page](https://z.ai/models/GLM-5-1.0)
- [Milvus `What is GLM-5`](https://milvus.io/blog/what-is-glm-5)
- [Unsloth GLM-5 GGUF deployment](https://unsloth.dev/models/glm-5-1.0-gguf)
- [Groq pricing + compound AI](https://groq.com/pricing)

## Catatan praktis

- mulai dari OpenRouter untuk tahu model mana yang benar-benar support tool calling
- kalau butuh predictable token cost dan model open source, cek Groq
- kalau butuh API-first tool calling, cek DeepSeek
- kalau butuh reasoning + agent capabilities, cek DeepInfra Qwen3 / Qwen3.5
- kalau lo butuh local control, hitung RunPod compute cost daripada token cost semata
