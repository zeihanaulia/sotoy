
Claim: Agent dapat mengisi detail implementasi, tetapi manusia harus menjaga invariant desain sistem seperti identity stability.

Evidence:
- Karpathy: agent di Menugen mencoba mengaitkan Stripe email dengan Google email, padahal user identity harus pakai persistent ID.

Why it matters:
- Menunjukkan bahwa kegagalan AI sering berada di level domain model, bukan syntax.
- Mempertegas peran manusia sebagai penjaga invariant sistem.

See also:
- [[notes.youtube.andrej-karpathy-from-vibe-coding-to-agentic-engineering]]
