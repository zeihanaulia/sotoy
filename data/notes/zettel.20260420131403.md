
## Gagasan

Posisi informasi dalam konteks memengaruhi seberapa baik model mengingatnya. Tengah percakapan itu paling rawan hilang.

## Mengapa Ini Penting

Bukan semua konteks diperlakukan sama. Ini bikin kita sadar kenapa chat panjang bisa gagal, meski model masih "dengar" banyak.

## Apa Itu Posisi Informasi?

Posisi informasi berarti di mana sebuah fakta, alasan, atau keputusan muncul dalam urutan token yang diumpankan ke model. Model transformer memberi perhatian berbeda terhadap token berdasarkan posisi dan fokus akhir-awal.

- `Awal konteks`: informasi yang masuk pertama sering mendapat bobot yang stabil sebagai context primer.
- `Akhir konteks`: informasi terbaru masih segar dan biasanya punya bobot penting karena relevansi langsung.
- `Tengah konteks`: informasi ini harus bersaing dengan banyak token sebelum dan sesudahnya. Itulah yang jadi zona paling rawan hilang.

Dalam artikel "Context Anchoring", penelitian "Lost in the Middle" disebutkan sebagai bukti bahwa model long-context lebih buruk ketika relevansi muncul di tengah konteks panjang, dibandingkan ketika berada di awal atau akhir.

## Simulasi Posisi Informasi

Bayangkan urutan chat development seperti ini:

1. `Token 1-200`: setup proyek, stack, tujuan fitur.
2. `Token 201-600`: diskusi detail desain, argumentasi kenapa memilih pendekatan A.
3. `Token 601-1000`: contoh kode, review snippet, tanggapan error.
4. `Token 1001-1200`: keputusan akhir dan next step.

Sekarang bandingkan:

- Jika `kenapa memilih A` muncul di token 50, model masih punya peluang baik untuk mengaitkannya dengan keputusan akhir.
- Jika `kenapa memilih A` muncul di token 550, itu berada di tengah. Model harus menyimpan reasoning tersebut sambil memproses token 551–1200. Informasi ini lebih mudah kehilangan perhatian.
- Jika `kenapa memilih A` muncul lagi di token 1150 sebagai ringkasan, model bisa mengingatnya lebih kuat.

Intinya: bukan sekadar berapa banyak token, tapi `di mana` informasi penting berada. Tengah percakapan adalah titik paling rawan karena attention dan penggunaan konteks mengikisnya.

## Literasi Pendukung

- Study: "Lost in the Middle: How Language Models Use Long Contexts" — https://arxiv.org/abs/2307.03172
- Sumber utama: "Context Anchoring" — https://martinfowler.com/articles/reduce-friction-ai/context-anchoring.html

## Hubungan ke Zettel Lain

- Mendukung [[zettel.literature.context-anchoring]] — klaim diambil dari Paragraf 6.
- Lihat juga [[zettel.20260420131310]] — tesis utama bahwa chat AI adalah medium berpikir, bukan tempat penyimpanan keputusan.
- Lihat juga [[zettel.20260420131311]] — baseline kolaborasi manusia yang transfer konteks ke dokumen.

## Sumber

- [[zettel.literature.context-anchoring]] — Paragraf 6
