
## Ide inti

Yang gue tangkap dari quote ini adalah bahwa buku sengaja memisahkan "belajar integrasi LLM" dari kompleksitas provider komersial. Local Llama dipilih sebagai media pembelajaran karena dia membuat fokus tetap pada arsitektur request/response, streaming, dan UX—bukan pada auth, billing, atau quirks vendor.

## Quote baseline

> You will do the same, but using a locally running Llama instance.

## Kenapa ini core

Quote ini penting karena dia mengandung keputusan pedagogis dan arsitektural: buku memilih jalur lokal untuk memperkenalkan pola dasar LLM integration, bukan untuk membahas provider-specific details. Ini menjelaskan kenapa latihan awal di chapter ini dirancang agar learning path-nya lebih bersih dan lebih developer-first.

## Implikasi

- Local model di chapter awal bukan klaim bahwa itu pilihan production terbaik, tapi pilihan belajar terbaik.
- Pendekatan ini mengurangi friction awal: nggak perlu mikir API key, quota, billing, atau network dependency.
- Ini membantu pembaca menangkap bahwa inti aplikasi AI adalah pola integrasi LLM, bukan vendor tertentu.
- Model/provider bisa diganti nanti—yang penting adalah arsitektur yang dipelajari terlebih dulu.

## Sumber

- Chapter 2
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
