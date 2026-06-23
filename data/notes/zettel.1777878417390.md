
> Untuk agentic multi-turn conversation, lebih aman menyamarkan PII dengan token terindeks daripada menggantinya dengan nilai palsu yang bisa mengubah konteks.

Catatan gue:

- Fake pseudonymization bisa membuat model reasoning berdasarkan dunia palsu, bukan dunia pengguna.
- Indexed placeholders seperti `[PERSON_001]`, `[ORG_001]`, `[LOCATION_001]` menjaga struktur referensi tanpa menambahkan asumsi semantik.
- Mapping asli disimpan lokal, sehingga de-masking bisa dilakukan dengan kontrol.

Implikasi:

- Privacy layer harus memisahkan identity value dari task-relevant structure.
- Untuk entity yang punya makna task (lokasi, salary, medical condition), placeholder harus dilengkapi metadata abstraction, bukan hanya token polos.
- Ini membuat privacy protection lebih deterministik dan lebih mudah diaudit.

Hubungan:

- [[notes.security.pii-agent-architecture.camp.indexed-masking]]
- [[notes.security.pii-agent-architecture.camp]]
- [[notes.security.pii-agent-architecture]]
