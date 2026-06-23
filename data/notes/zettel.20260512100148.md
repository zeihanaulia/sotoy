
Gue sekarang percaya model deployment yang paling masuk akal untuk organisasi biasa adalah hybrid: frontier model lewat API untuk tugas kompleks, lalu model lokal 7B/14B/32B/72B buat tugas murah dan sensitif.

Pola yang kelihatan paling sehat:
- API untuk hard coding agent, reasoning panjang, dan document generation.
- local model untuk summarization, extraction, PII masking, reranking, routing.
- internal gateway untuk masking, policy, audit, budget, dan fallback.

Kalau belum stabil volume dan belum jelas usage, self-host model besar harus ditunda sampai telemetry nyata mendukung. Sebelumnya fokusnya: bangun kontrol dan workflow.
