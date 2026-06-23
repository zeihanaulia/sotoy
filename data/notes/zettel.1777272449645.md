
## Ide inti

Yang gue tangkap dari quote ini adalah bahwa ada perbedaan fundamental antara dua hal: model belajar selama training, dan model menjalankan apa yang sudah dipelajari selama inference. Ini penting supaya kita tidak salah menafsirkan prompt sebagai "training kecil-kecilan" atau mengira request run-time mengubah model.

## Quote baseline

> The process ... when given new, unseen data ... is referred to as inference.

## Kenapa ini core

Quote ini penting karena dia membantu membedakan dua jalur utama AI:

- training = membangun kemampuan umum dari data,
- inference = menggunakan kemampuan itu pada input baru.

Perbedaan ini langsung nge-link ke beberapa keputusan lain:

- prompt vs training: prompt mengarahkan model saat inference, training mengubah model sebelumnya.
- RAG vs pretraining: RAG menambahkan konteks runtime, pretraining membentuk kemampuan umum.
- fine-tune vs runtime context: fine-tune adalah perubahan model, runtime context adalah memberi info baru saat inference.

Kalau kita tidak paham ini, kita bisa salah kaprah dan terlalu cepat menganggap "train something" adalah jawaban pertama.

## Sumber

- Chapter 1
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
