
AI coding matang bukan sekadar menyuruh model menulis kode dan berharap benar.
Itu adalah vibe coding: output yang muncul cepat, tampak berhasil, dan dilanjutkan tanpa bukti.

Agentic engineering berbeda. Di sini AI boleh menghasilkan kode, tetapi setiap siklus kerja harus:

- kecil dan bounded,
- punya satu tujuan jelas,
- punya satu cara verifikasi jelas,
- tidak mencampur banyak keputusan sekaligus.

“Perubahan kecil” bukan berarti sedikit baris kode. Bisa saja 200 baris jika scope-nya masih satu konsep dengan satu risiko utama.
Yang kecil adalah ruang keputusan dan risiko, bukan jumlah baris.

Siklus kecil berarti:

- plan kecil → implement kecil → verify → review → lanjut.
- bukan: satu prompt besar lalu agent mengubah separuh repo.

Evidence:

- Martin Fowler: "A well-built outer harness serves two goals: it increases the probability that the agent gets it right in the first place, and it provides a feedback loop that self-corrects as many issues as possible before they even reach human eyes."
- Martin Fowler: "Separately, you get either an agent that keeps repeating the same mistakes (feedback-only) or an agent that encodes rules but never finds out whether they worked (feed-forward-only)."
- Google Small CLs: "In general, the right size for a CL is one self-contained change."
- Karpathy: "we're now kind of like cooperating with AIs and usually they are doing the generation and we as humans are doing the verification it is in our interest to make this loop go as fast as possible."
- Karpathy: "we have to keep the AI on the leash."
- Karpathy: "it's not useful to me to get a diff of 10,000 lines of code to my repo ... I'm still the bottleneck right even though that 10,000 lines come out instantly I have to make sure that this thing is not introducing bugs."
- Karpathy: "I'm always scared to get way too big diffs i always go in small incremental chunks i want to make sure that everything is good i want to spin this loop very very fast and I sort of work on small chunks of single concrete thing."

Terminology:

- Leash = batas kontrol terhadap AI agar output tetap bisa diaudit.
- Small incremental chunks = unit kerja kecil dengan scope jelas, verification jelas, dan diff yang bisa ditelusuri.
- Generation-verification loop = AI generate → verify → lanjut.
- Partial autonomy = autonomy slider yang disesuaikan dengan kompleksitas dan risiko task.

Pertanyaan kunci:

1. Kecil itu ukurannya apa?
   - satu tujuan, satu risiko utama, satu cara verifikasi.
2. Kenapa perubahan besar berbahaya?
   - review surface membesar, causal chain kabur, verification melemah.
3. Simulasi vibe coding vs agentic engineering?
   - vibe coding memberi agent scope besar; agentic engineering memecah fitur menjadi langkah-langkah kecil dengan boundary eksplisit.
4. Bagaimana membagi fitur besar?
   - data/model → core logic → API boundary → verify → UI → edge cases → cleanup.
5. Apa hubungan perubahan kecil dengan verification?
   - perubahan kecil membuat verifikasi lebih murah, lebih spesifik, dan lebih bisa ditelusuri.

> “The game is not ‘how fast can we build’ any more. It is ‘how fast can we tell whether this is right’.”

Related: [[zettel.literature.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.cloud-agent.handson.reference.martin-fowler-harness-engineering]]
- [[notes.agentic-engineering.cloud-agent.handson.reference.google-small-cls]]
- [[notes.agentic-engineering.cloud-agent.handson.reference.karpathy-keep-ai-on-the-leash]]
- [[zettel.moc.agentic-engineering]]
