
## Gagasan

Erosi konteks di AI bukan kebetulan; ini memang konsekuensi cara LLM memproses konteks.

Model transformer mengkonsumsi konteks sebagai rangkaian token yang dihadapkan ke attention layer. Dalam praktik, itu berarti:

- informasi awal dan akhir cenderung mendapat bobot lebih tinggi,
- informasi yang berada di tengah konteks panjang mudah "terlupakan",
- reasoning dan alasan panjang adalah konten yang paling rentan hilang,
- context window besar bukan solusi magis karena degradasi perhatian tetap terjadi.

Penelitian seperti "Lost in the Middle" menunjukkan bahwa model language melakukan jauh lebih buruk pada informasi yang muncul di tengah konteks panjang dibandingkan yang ada di awal atau akhir.

## Mengapa Ini Penting

Kehilangan konteks pada AI adalah konsekuensi arsitektural, bukan kebetulan. Jadi solusinya harus arsitektural juga.

Dalam konteks transformer, ini berarti kita tidak bisa berharap percakapan panjang tetap menjadi tempat penyimpanan keputusan yang andal. Chat adalah medium berpikir. Jika konteks penting hanya ada di dalamnya, maka setiap sesi baru berisiko mengulang asumsi atau kehilangan alasan. External memory seperti feature document adalah cara untuk memindahkan konteks dari medium yang rapuh ke medium yang lebih tahan lama.

## Literatur Pendukung

- "Context Anchoring" — Rahul Garg, Martin Fowler (2026): https://martinfowler.com/articles/reduce-friction-ai/context-anchoring.html
- "Lost in the Middle: How Language Models Use Long Contexts" — Liu et al. (2023): https://arxiv.org/abs/2307.03172
- "Attention Is All You Need" — Vaswani et al. (2017): https://arxiv.org/abs/1706.03762

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 4.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 4
