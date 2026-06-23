
Insight utama dari docs deepsec adalah bahwa AI security review yang matang tidak cukup cuma mengandalkan model. Sistem ini harus menjadi workspace orchestration dengan beberapa layer:

- radar awal lewat regex matcher untuk menemukan candidate site.
- konteks repo pendek dan relevan lewat `INFO.md`.
- investigasi agentic pada file candidate.
- revalidation terpisah untuk mengurangi false positive.
- state append-only di `data/` agar audit trail tetap ada.
- plugin ownership/notifier agar finding bisa masuk ke workflow manusia.

Jadi deepsec tidak ideal jika dipandang sebagai "AI bug scanner". Lebih tepat dipandang sebagai "security review workspace" yang mengelola dan menyalurkan output AI ke proses engineering nyata.
