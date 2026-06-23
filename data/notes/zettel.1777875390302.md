
> Dalam multi-turn agent, risiko PII bukan hanya dari satu pesan; risiko muncul dari akumulasi fragmen kecil yang bisa digabung menjadi profil identitas.
>
> Source: https://arxiv.org/html/2604.16521v1

Catatan gue:

- Proteksi PII per-turn pada dasarnya stateless. Ia hanya melihat message sekarang dan mengabaikan history yang akan dikirim ulang ke model.
- Cumulative PII Exposure (CPE) membuat unit analisis pindah dari "message" ke "session".
- Konsekuensinya: jika threshold terlampaui, sistem harus menulis ulang seluruh history dengan pseudonym konsisten sebelum mengirim ke LLM.

Impak:

- Ini bukan hanya soal deteksi data sensitif, tetapi soal governance atas representasi data sepanjang sesi.
- Bagi security agent, berarti stateful PII registry, co-occurrence graph, dan retroactive masking adalah pola arsitektur yang penting.

Link:
- [[notes.security.pii-agent-architecture.camp]]
- [[notes.security.pii-agent-architecture]]
