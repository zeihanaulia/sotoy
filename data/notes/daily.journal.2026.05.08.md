
## AI slop sebagai eksperimen disposable
Gue tulis note baru dari thread Mitchell Hashimoto: [[notes.agentic-engineering.ai-slop-disposable-experimentation]]. Intinya, "AI slop" dia pakai untuk output kasar yang berguna sebagai eksperimen, bukan sebagai kode final yang masuk ke customer.

### Ringkasannya
- Ngeslop dan ngevibing code tidak otomatis bermasalah selama posisinya jelas sebagai eksplorasi atau prototype.
- Slop bagus kalau buat eksperimen cepat dan paralel, terutama kalau fungsinya menghasilkan insight, bukan jadi produk final.
- Slop berbahaya kalau jadi fondasi, customer-facing, atau menyentuh boundary kritikal.
- Skill baru AI coding adalah tahu mana yang boleh disposable dan mana yang harus bersih.
- Frontend bisa dikasih slop dulu; core workflow, auth, billing, data contract, dan security tidak boleh dianggap aman hanya karena berjalan di demo.
- Quality gate customer-facing harus lebih dari sekali manual test: behavior, error handling, data, security, observability, rollback, dan tim paham.
- Analogi yang gue pakai: slop itu scaffolding atau triplek sementara di lokasi konstruksi.

## HeavySkill paper
Gue juga catat paper baru arXiv 2605.02396v1: "HeavySkill: Heavy Thinking as the Inner Skill in Agentic Harness." Intinya, pola agentic yang kuat bukan cuma framework rumit, melainkan "parallel reasoning → deliberation" yang dipaketkan sebagai skill file.

Link: [[notes.agentic-engineering.heavyskill-heavy-thinking-as-inner-skill]]

### 4 pertanyaan kunci
1. Kalau input-nya satu pertanyaan, kenapa sistem bikin banyak jawaban dulu?
   - Karena satu reasoning path rapuh dan mudah terjebak asumsi awal.
2. Apa bedanya parallel reasoning dengan tanya model berkali-kali biasa?
   - Parallel reasoning membuat jawaban independen. Bukan sekadar ulangi model yang sama.
3. Apa yang terjadi di tahap sequential deliberation?
   - Model reviewer membaca semua trajectory, membandingkan reasoning, mencari error, lalu synthesize jawaban final.
4. Kenapa hasil akhirnya bisa lebih baik daripada jawaban tunggal?
   - Karena reviewer punya banyak hipotesis dan evidence, jadi bisa memilih minoritas benar atau menggabungkan insight.

### Kenapa ini penting
- Workflow Heavy Thinking bukan "AI mikir panjang." Itu adalah process desain inferensi.
- Ini lebih mirip mini review board: banyak solusi independen, satu reviewer menyimpulkan yang terbaik.
- Kunci success-nya: thinker harus setidaknya berbeda, bukan sekadar keluaran model yang sama 8 kali.
- Kunci kedua: reviewer bias tidak hanya soal posisi; reviewer juga LLM yang bisa pilih jawaban fasih atau mayoritas.
- Paper ini sadar bias itu, tapi solusinya masih parsial: sampling, shuffling cache, pruning, dan prompt-style review.
- Serialized memory cache di paper ini adalah memory eksternal workflow, bukan internal KV-cache model. Bayangin itu sebagai notulen sementara bagi reviewer.

### Pertanyaan lanjutan
- task mana di workflow kita yang cocok buat heavy thinking?
- apakah kita punya skill file yang bisa merepresentasikan deliberation pattern?
- apakah kita cukup modular untuk menggunakan beberapa trajectory tanpa menumpuk noise?
- apakah kita perlu membedakan role reasoner vs deliberator dalam workflow?
- apa yang jadi evidence utama agar deliberator nggak cuma ikut mayoritas?

### Komentar penting yang nambah batasan
- Devin Stein: slop bisa jadi alat personal, tapi review dari orang lain bisa jadi beban. Itu berarti boundary-nya bukan cuma teknis, tapi juga sosial.
- Manoj: slop sering kali bukan produk gagal; dia adalah riset murah. Kalau 18 dari 20 eksperimen gagal, 18 itu masih punya nilai sebagai cara menemukan 2 arah yang benar.
- Clément Miao: slop debt bisa berguna kalau dicatat, dibatasi, dan dibayar. Kalau tidak, itu berubah jadi tech debt tersembunyi.
- Hanzi: bahaya terbesar muncul ketika Friday prototype bertahan lama dan tegangannya berubah jadi arsitektur.
- Misael & Felipe: modularity adalah containment strategy. Slop lebih aman kalau sistem modular; lebih berbahaya di monolith besar.
- WiscJohnson / Yaroslav: banyak orang akan abaikan aturan boundary. Argumen Mitchell bergantung pada maturity dan disiplin developer.

### Pertanyaan penting
Sekarang gue mau tanya ke diri sendiri:
- mana area sistem ini yang bisa kita generate kasar dulu?
- mana boundary yang harus tetap rapi dari awal?
- siapa yang akan menanggung biaya kalau ini jadi PR tim?
- apa rencana kita untuk bayar utang slop sebelum ia jadi arsitektur?
- apakah sistem kita modular cukup untuk mengurung slop?

Konteks tambahan: gue baca istilah "yapping" di thread ini sebagai "lagi ngomong panjang soal poin utama," bukan sekadar ngoceh tanpa isi.
