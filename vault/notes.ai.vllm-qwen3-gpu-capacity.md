---
id: notes.ai.vllm-qwen3-gpu-capacity
title: "Qwen3.5-397B-A17B-FP8 di vLLM: kebutuhan H100 dan kapasitas runtime"
desc: "Ringkasan angka VRAM dan kapasitas H100 untuk Qwen3.5-397B-A17B-FP8 serta implikasi run concurrent di vLLM." 
updated: 1778604565146
created: 1778604565146
tags:
  - notes
  - ai
  - vllm
  - qwen
  - gpu
---

Dari riset singkat yang gue lakukan, ada angka konkret yang penting buat memperjelas kenapa 40 GPU H100 belum otomatis menjamin stabilitas.

### Temuan utama

- Untuk `Qwen3.5-397B-A17B-FP8`, berat bobot model di FP8 sekitar **397 GB**.
- Runtime footprint naik jadi sekitar **457–476 GB** saat termasuk overhead aktivasi dan framework.
- Untuk vLLM, ini artinya konfigurasi paling realistis adalah **8×H100 80GB** (640 GB total VRAM) dengan sekitar **100–119 GB** tersisa untuk KV cache setelah `vLLM` cap 576 GB.

### Implikasi untuk self-host

- Angka ini menunjukkan bahwa satu replica model besar Qwen3.5 FP8 saja memerlukan **8 GPU H100**, bukan 1 atau 2.
- Kalau lo bicara banyak concurrent coding sessions, GPU count bukan satu-satunya pertimbangan. Masih butuh:
  - admission control / queueing
  - pool isolation
  - limit output tokens
  - limit concurrency per replica
  - monitoring KV cache usage
### Sumber eksternal

- [Deploy Qwen 3.5 on GPU Cloud: Hardware Requirements and Setup Guide (2026)](https://www.spheron.network/blog/deploy-qwen-3-5-gpu-cloud/) — menyebut runtime footprint FP8 sekitar **457–476 GB** dan butuh **8×H100 80GB** dengan sisa KV cache sekitar **100–119 GB** setelah batas vLLM 576 GB.
- [Qwen/Qwen3.5-397B-A17B-FP8 di Hugging Face](https://huggingface.co/Qwen/Qwen3.5-397B-A17B-FP8) — model card referensi.
- [ModelScope Qwen3.5-397B-A17B-FP8](https://www.modelscope.cn/models/Qwen/Qwen3.5-397B-A17B-FP8) — halaman model China yang juga mencatat model FP8.
### Kenapa ini relevan

Di konteks diskusi kita, data ini menguatkan bahwa masalah utama bukan cuma "40 GPU apakah cukup?". Masalah yang nyata adalah:

- `Qwen3.5-397B-A17B-FP8` sudah butuh 8×H100 untuk satu deployment replica
- stabilitas multi-user juga bergantung pada runtime kebijakan dan vLLM scheduler
- manual `/compact` adalah workaround state, bukan bukti bahwa GPU sudah cukup

Kalau lo mau, gue bisa tambahkan juga catatan singkat ini ke `til.ai.vllm-opencode-context-pressure.md` sebagai bukti angka kapasitas. 