
Verifikasi dalam loop AI tidak boleh hanya mengandalkan *model judge* (AI yang mengecek AI). Model judge adalah layer termahal dan paling rentan terhadap bias.

Strategi verifikasi yang sehat adalah bertingkat:
1. **Deterministic Checks**: Menggunakan JSON schema, menjalankan unit test, atau validasi contract. Jika ini gagal, tidak perlu memanggil model judge.
2. **Model Judge**: Digunakan hanya untuk aspek semantik atau kualitas yang tidak bisa diukur secara biner.

Relasi: [[notes.ai-agents.loop-engineering]]
