
## Pertanyaan yang dibuka

1. Bagaimana struktur buku ini mencerminkan urutan kerja developer AI?
2. Apa batasan level buku ini dibandingkan dengan buku ML akademik?
3. Kapan teknik seperti prompt, RAG, fine-tuning, dan agent menjadi relevan menurut urutan buku ini?

## Ringkasan literatur

Buku ini tidak disusun sebagai silabus akademik AI. Struktur utamanya bergerak dari pengenalan LLM dan pembuatan aplikasi, lalu memasuki prompt engineering, memberi konteks lewat retrieval-augmented generation, menimbang fine-tuning, dan akhirnya mengorkestrasi agent.

Logika penyusunan buku ini adalah layering: setiap bagian muncul untuk menjawab keterbatasan bagian sebelumnya. Prompt engineering hadir sebelum RAG karena instruksi model adalah kontrol dasar. RAG hadir sebelum fine-tuning karena memberi konteks eksternal seringkali lebih murah dan lebih stabil. Fine-tuning muncul setelah karena model customization dianggap sebagai intervensi yang lebih mahal. Agent muncul paling akhir sebagai sintesis, bukan sebagai fondasi.

## Ide penting

* Buku ini lebih cocok dibaca sebagai applied AI engineering roadmap daripada referensi riset ML.
* Fokus utama adalah developer workflow: mengenali model, mengendalikan model, menambahkan konteks, menyesuaikan model, lalu membangun orkestrasi agent.
* Level buku ini berada di rentang beginner sampai early-intermediate untuk developer, bukan total beginner atau ML researcher advanced.

## Interpretasi

Dari struktur bagian-bagiannya, yang paling penting bukan isi detailnya, tapi pesan bahwa sistem AI modern harus dibangun secara berlapis. Ini buku untuk developer yang butuh peta dan urutan yang waras, bukan untuk orang yang butuh matematika atau teori training model.

## Lihat juga

* [[zettel.moc.ai-native]] — MOC AI-native engineering
* [[book-summaries.the-developers-guide-to-ai]] — overview struktur dan level buku sebagai peta praktis AI engineering untuk developer
