---
id: notes.agentic-engineering.cloud-agent.handson.serialized-memory-cache
title: "Hands-on Serialized Memory Cache untuk HeavySkill Workflow"
desc: "Contoh hands-on reproduce serialized memory cache di luar model menggunakan Python + OpenAI-compatible API / Ollama."
updated: 1778206145482
created: 1778206145482
tags:
  - notes
  - agentic-engineering
  - cloud-agent
  - handson
  - heavy-thinking
---

## Overview
Gue bikin note ini sebagai hands-on untuk nge-reproduce ide `serialized memory cache` di paper HeavySkill tanpa harus bikin model atau framework baru.

Targetnya jelas:
- punya satu pertanyaan,
- jalankan beberapa thinker secara terpisah,
- simpan output-nya di cache,
- serialize cache jadi prompt,
- reviewer membaca cache dan bikin jawaban final.

Intinya: ini bukan soal melatih model. Ini soal merasakan bentuk mekanisme agent/workflow.

## Kenapa ini penting
Di paper, `serialized memory cache` sering dimaknai salah. Ini bukan memori internal model (KV-cache). Ini adalah artefak eksternal yang dibuat oleh orchestrator.

Kalau lo bisa bikin script kecil yang:
1. memanggil model beberapa kali,
2. menyimpan output tiap panggilan,
3. mengubah output itu jadi string prompt,
4. lalu memanggil model lagi sebagai reviewer,
maka lo sudah reproduce konsep utamanya.

## Setup minimal
Yang lo butuhkan:
- Python 3.11+
- `pip install openai`
- Ollama lokal atau endpoint OpenAI-compatible lain
- model lokal atau remote yang bisa dipanggil via OpenAI API

Kalau pake Ollama lokal, jalankan:

```bash
ollama run qwen3:8b
```

Kalau pake OpenAI remote, tinggal ganti endpoint/nama model sesuai provider.

## Contoh script reproduksi
Script ini sengaja sederhana. Lo bisa copy-paste dan jalanin.

```python
import json
import random
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"
)

MODEL = "qwen3:8b"
QUESTION = """
API checkout kadang double charge ketika user refresh halaman setelah pembayaran.
Apa root cause paling mungkin dan fix paling tepat?
"""

THINKER_PROMPTS = [
    "Analisis masalah ini dari sudut backend/API design. Fokus pada idempotency, retry, dan boundary transaksi.",
    "Analisis masalah ini dari sudut frontend/user interaction. Fokus pada refresh, double submit, dan race condition UI.",
    "Analisis masalah ini dari sudut payment integration/webhook. Fokus pada duplicate webhook, retry provider, dan reconciliation.",
    "Analisis masalah ini dari sudut reliability engineering. Fokus pada failure mode, observability, dan cara verifikasi root cause."
]


def call_model(system_prompt: str, user_prompt: str) -> str:
    resp = client.chat.completions.create(
        model=MODEL,
        temperature=1.0,
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt},
        ],
    )
    return resp.choices[0].message.content.strip()


def run_thinker(thinker_id: int, thinker_prompt: str, question: str) -> dict:
    system_prompt = f"""
Kamu adalah Thinker {thinker_id}.
Jawab secara independen.
Jangan membayangkan ada thinker lain.
Output HARUS format JSON valid dengan field:
- hypothesis
- evidence
- weakness
- suggested_verification
- confidence
"""
    user_prompt = f"Problem:\n{question}\n\n{thinker_prompt}"
    raw = call_model(system_prompt, user_prompt)

    try:
        parsed = json.loads(raw)
    except Exception:
        parsed = {
            "hypothesis": raw[:300],
            "evidence": "Model tidak mengikuti format JSON sepenuhnya.",
            "weakness": "Perlu parsing/manual review.",
            "suggested_verification": "Baca output mentah thinker.",
            "confidence": 0.3,
            "_raw": raw,
        }

    parsed["thinker_id"] = thinker_id
    return parsed


def prune_cache_item(item: dict) -> dict:
    return {
        "thinker_id": item.get("thinker_id"),
        "hypothesis": item.get("hypothesis"),
        "evidence": item.get("evidence"),
        "weakness": item.get("weakness"),
        "suggested_verification": item.get("suggested_verification"),
        "confidence": item.get("confidence"),
    }


def serialize_memory_cache(question: str, cache_items: list[dict]) -> str:
    items = cache_items[:]
    random.shuffle(items)

    sections = [f"Original Question:\n{question}\n", "Serialized Memory Cache:\n"]
    for item in items:
        sections.append(
            f"""[Thinker T{item['thinker_id']}]
Hypothesis:
{item['hypothesis']}

Evidence:
{item['evidence']}

Weakness:
{item['weakness']}

Suggested Verification:
{item['suggested_verification']}

Confidence:
{item['confidence']}

"""
        )
    return "\n".join(sections)


def deliberate(question: str, serialized_cache: str) -> str:
    system_prompt = """
Kamu adalah reviewer/deliberator.
Tugasmu:
1. Evaluasi setiap hypothesis berdasarkan evidence.
2. Jangan memilih hanya karena mayoritas.
3. Cari root cause paling fundamental, bukan trigger populer.
4. Jika beberapa hypothesis saling melengkapi, sintesislah.
5. Output final harus singkat dengan format:
   - Final diagnosis
   - Why this is most likely
   - What to verify next
   - Best fix
"""
    user_prompt = serialized_cache
    return call_model(system_prompt, user_prompt)


def main():
    thinkers = []
    for i, thinker_prompt in enumerate(THINKER_PROMPTS, start=1):
        result = run_thinker(i, thinker_prompt, QUESTION)
        thinkers.append(result)

    print("\n=== RAW THINKER OUTPUT ===\n")
    print(json.dumps(thinkers, indent=2, ensure_ascii=False))

    pruned_cache = [prune_cache_item(x) for x in thinkers]
    print("\n=== PRUNED CACHE OBJECT ===\n")
    print(json.dumps(pruned_cache, indent=2, ensure_ascii=False))

    serialized_cache = serialize_memory_cache(QUESTION, pruned_cache)
    print("\n=== SERIALIZED MEMORY CACHE ===\n")
    print(serialized_cache)

    final_answer = deliberate(QUESTION, serialized_cache)
    print("\n=== FINAL DELIBERATION ===\n")
    print(final_answer)


if __name__ == "__main__":
    main()
```

## Apa yang harus lo rasakan
Kalau script ini jalan:
1. lo memanggil model beberapa kali untuk tiap thinker,
2. lo menyimpan output-nya sebagai object eksternal,
3. lo membuat serialized cache dari output itu,
4. lo memanggil model lagi sebagai reviewer.

Itu sudah membuktikan `serialized memory cache` berjalan di level workflow, bukan di parameter model.

## Tips agar lebih nyata
Kalo lo mau ngerasain bias dan batasan, coba ubah ini:

1. Matikan `random.shuffle(items)` dan lihat apakah reviewer lebih condong ke thinker posisi awal.
2. Samakan semua prompt thinker, lalu bandingkan dengan role-based thinker.
3. Tambahkan field `tool_feedback` di cache dan lihat apakah reviewer jadi lebih grounded.
4. Bandingkan dengan majority voting sederhana untuk lihat perbedaannya.

## Kapan ini berguna
Contoh paling nancep buat agen coding:
- debugging bug bug N+1 query,
- security review multi-angle,
- failure mode analysis,
- patch ranking dengan evidence.

Kalau lo mau, gue bisa lanjut bikin versi kedua yang lebih dekat ke repo/code review: `grep`, `pytest`, `git diff`, dan hasil command masuk ke serialized memory cache.
