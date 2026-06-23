
Gue sekarang melihat bahwa ketika OpenCode + LiteLLM + vLLM lempar `MidStreamFallbackError`, `ServiceUnavailableError`, atau `APIConnectionError`, itu jarang hanya karena prompt atau model.

Signalnya kuat: setelah ESC dan /compact, semuanya normal lagi. Itu menunjukkan issue runtime state atau KV cache pressure, bukan sekadar overflow statis.

Jadi diagnosis yang lebih berguna adalah: reduce concurrency, lower output, compact lebih agresif, dan treat `max_model_len` sebagai batas per request, bukan kapasitas concurrent.
