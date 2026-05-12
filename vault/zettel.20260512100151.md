---
id: zettel.20260512100151
title: "OpenCode/vLLM errors sering karena context/KV pressure, bukan model atau prompt"
desc: "Saya menemukan bahwa runtime pressure dan stream state adalah penyebab utama error OpenCode/vLLM, terutama saat concurrent long-context requests." 
updated: 1778604107391
created: 1778604107391
tags:
  - zettel
  - ai
  - vllm
  - debugging
---

Gue sekarang melihat bahwa ketika OpenCode + LiteLLM + vLLM lempar `MidStreamFallbackError`, `ServiceUnavailableError`, atau `APIConnectionError`, itu jarang hanya karena prompt atau model.

Signalnya kuat: setelah ESC dan /compact, semuanya normal lagi. Itu menunjukkan issue runtime state atau KV cache pressure, bukan sekadar overflow statis.

Jadi diagnosis yang lebih berguna adalah: reduce concurrency, lower output, compact lebih agresif, dan treat `max_model_len` sebagai batas per request, bukan kapasitas concurrent.
