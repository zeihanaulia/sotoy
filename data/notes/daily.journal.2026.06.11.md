

## AI Model Reliability: Antirez on Claude (Fable) vs GPT 5.5


Gue baru aja baca thread dari antirez di X soal perbandingannya antara GPT 5.5 dan Claude (khususnya model "Fable" yang lagi dia uji). Menarik banget karena dia nggak bahas benchmark, tapi bahas *reliability* sebagai partner kerja.

Yang gue tangkap, antirez tadinya udah "sold" banget sama GPT 5.5, tapi Fable bikin dia balik lagi ke Claude. Poin utamanya bukan cuma soal "jawabannya bener", tapi soal **proses kerja**. Fable menurut dia lebih terstruktur, punya langkah-langkah yang rapi, dan pemahaman masalah yang lebih dalam.

Ada satu trade-off yang dia highlight: **Speed vs Depth**. Fable itu lambat, bahkan bisa 5-10x lebih lambat dari GPT 5.5. Tapi buat antirez, lambat itu nggak masalah asal hasilnya bermakna. Dia lebih milih nunggu lama daripada dapet "nonsense loop"—kondisi di mana AI kelihatan produktif tapi sebenarnya cuma muter-muter nggak nyelesain masalah.

Satu hal yang gue suka dari sikap dia adalah pragmatismenya. Dia nggak mau "menikah" sama satu provider AI. Prinsipnya jelas: pakai model terbaik yang ada saat ini, jangan sampai terkunci (*vendor lock-in*).

Intinya, kriteria "model terbaik" buat gue sekarang bergeser. Bukan lagi soal siapa yang paling cepat atau paling pintar di benchmark, tapi siapa yang paling bisa dipercaya proses berpikirnya untuk kerjaan kompleks.

Referensi: 

  - https://x.com/antirez/status/2064448256113873281

### Antirez on Fable & AI Governance

Lanjutan thread antirez soal "Fable" (model Claude/Anthropic baru). Intinya, dia lagi ngelakuin koreksi posisi. Dia mengakui secara teknis Fable itu impresif banget—rapi, punya deep understanding, dan stabil buat reasoning (thinking workhorse)—tapi dia menolak keras arah governance Anthropic.

Ada beberapa poin yang nyantol banget buat gue:

1. **Capability vs Governance**: Antirez misahin antara "seberapa jago modelnya" dan "siapa yang kontrol". Dia bakal pake inovasi apa pun yang berguna, tapi dia nggak setuju kalau aksesnya di-gate terlalu ketat (paternalistik), bahkan buat riset LLM yang harmless atau pertanyaan medis.
2. **Reciprocity dalam Training**: Ini argumen paling tajam. Dia bilang nggak masalah AI dilatih pake public data (bukan copying), ASALKAN hasilnya nggak dipake buat melawan kultur terbuka yang memungkinkan teknologi itu lahir. Analogi "minum dari sumur publik, terus setelah punya pabrik air, sumurnya dipagar" itu kena banget.
3. **The "Escape"**: Dia ngeliat open-weights models dari China sebagai jalan keluar dari duopoly/triopoly lab tertutup di Barat. Tapi dia juga ngingetin kalau kapasitas China itu sebenernya berdiri di atas struktur open science yang dulu dibangun Barat.
4. **Krisis Kapasitas Industri**: Dia nyentil Eropa/Barat yang kayaknya kehilangan "industrial ethics"—terlalu nyaman jadi konsumen dan nerima narasi kalau mereka "direbus pelan-pelan" daripada berani bangun infrastruktur terbuka sendiri.

**Sintesis gue:**
Semakin bagus modelnya, semakin besar masalah kalau aksesnya tertutup. Kalau modelnya biasa aja, filter itu cuma gangguan. Tapi kalau model itu bener-bener bisa ningkatin kapasitas programmer/researcher, maka gating berubah jadi masalah distribusi kekuasaan.

Antirez nggak benci Anthropic, dia cuma bilang: "Fable justru membuktikan betapa pentingnya akses terbuka."

Referensi: 
  - https://x.com/antirez/status/2064766429887352971

## Loop Engineering: Berhenti Jadi "Tukang Prompt", Mulai Jadi "Sistem Designer"

Selanjutnya gue baca tulisan Addy Osmani soal "Loop Engineering", dan jujur ini ngerubah cara gue ngelihat coding agent kayak Claude Code atau Codex. 

Selama ini gue (dan mungkin banyak orang) pakai AI coding agent itu polanya masih manual: gue prompt, gue baca hasilnya, gue koreksi, prompt lagi. Capek juga kalau harus megangin AI-nya tiap detik. Nah, Addy bilang kita udah masuk ke fase baru: **Loop Engineering**.

Intinya, loop engineering itu bukan lagi soal "gimana nulis prompt yang bagus", tapi "gimana mendesain sistem yang bikin AI kerja, ngecek dirinya sendiri, nyimpen progress, dan jalan terus sampai goal-nya tercapai tanpa gue harus standby di depan layar."

Analogi yang paling nempel buat gue: dulu gue nyetir AI kayak motor manual, sekarang gue mulai desain jalur, rambu, checkpoint, dan mekanik otomatisnya. Gue nggak lagi jadi operator, tapi jadi insinyur sistemnya.

Ada beberapa komponen yang bikin loop ini jalan:
1. **Automations**: Detak jantungnya. Biar agent nggak nunggu gue buat mulai (misal: jalan tiap pagi cek CI failure).
2. **Worktrees**: Biar kalau ada banyak agent jalan paralel, mereka nggak saling tabrak file. Masing-masing punya "meja kerja" sendiri.
3. **Skills**: Biar agent nggak kayak ikan mas yang lupa konteks tiap session baru. Pengetahuan proyek ditulis jadi artefak (SKILL.md) yang bisa dibaca agent.
4. **Connectors (MCP)**: Biar agent nggak cuma bisa baca file, tapi bisa interaksi sama Linear, Slack, atau database.
5. **Sub-agents**: Ini yang paling krusial. Pisahin yang *nulis* kode sama yang *ngecek* kode. Jangan biarkan AI menilai PR-nya sendiri karena dia pasti bakal terlalu "baik".

Tapi ada peringatan keras dari Addy yang bikin gue mikir: **Comprehension Debt**. 

Kalau loop ini jalan terlalu kencang dan gue cuma asal merge karena test-nya hijau, gue bakal kehilangan pemahaman soal codebase gue sendiri. Kodenya ada, tapi pemahaman gue tertinggal. Ini bahaya banget karena gue bisa terjebak dalam *cognitive surrender*—berhenti punya opini dan cuma terima apa pun yang dikasih AI.

Kesimpulan gue: Loop engineering itu leverage besar, tapi tanggung jawab verifikasinya tetap di gue. Gue harus tetap jadi engineer yang paham arsitektur, bukan cuma orang yang pencet tombol "Go".

Referensi: https://x.com/addyosmani/status/2064127981161959567

### Loop Engineering: Bukan Cuma Otomasi, tapi Manajemen Kekacauan

Gue baru aja baca reply-reply di bawah artikel Addy Osmani soal Loop Engineering, dan ternyata diskusinya jauh lebih "berdarah" dan praktis daripada artikel aslinya. Kalau Addy kasih framing besarnya, orang-orang di reply ini kasih "operating manual"-nya.

Satu hal yang paling ngena buat gue: loop engineering itu kuat, tapi kalau nggak ada *verification, memory, security boundary,* dan *human judgment*, dia cuma memindahkan kekacauan satu layer lebih jauh dari manusia.

Ada beberapa poin tajam dari para reply yang bikin gue mikir:

#### 1. Verifikasi itu Harus Bertingkat (Gaurav Albal & Gaurav Singh)
Gue tadinya mikir verifikasi itu cukup pakai "AI Reviewer". Tapi Gaurav Albal ngingetin kalau *maker/checker subagent split* itu layer paling mahal. Verifikasi yang sehat itu harus deterministik dulu sebelum pakai model judge.
- **Deterministic Check**: Pakai JSON schema, jalankan test, cek `git diff`, atau validasi OpenAPI spec. Ini murah dan pasti.
- **Model Judge**: Dipakai terakhir untuk hal yang butuh judgment semantik.
Intinya: jangan tanya AI "apakah JSON ini valid?", tapi pakai validator JSON.

#### 2. Memory adalah Fondasi, Bukan Fitur (Infomly & Jalkarna)
Addy naruh memory di urutan keenam, tapi Infomly bilang memory itu harusnya nomor satu. Tanpa memory, loop itu cuma "one-shot mewah" yang diulang-ulang. 
Jalkarna juga nekenin pentingnya *memory on disk* (kayak `AGENTS.md` atau Linear board) daripada cuma ngandelin context window. Prompt mengarahkan satu run, tapi memory mengarahkan sistem lintas waktu.

#### 3. Bahaya "Comprehension Debt" (KV)
Ini yang paling nakutin. Kalau loop makin halus, output kode makin banyak, tapi pemahaman gue terhadap kode itu nggak otomatis naik. Gue bisa terjebak dalam *cognitive surrender*—asal merge karena test hijau, padahal gue nggak paham apa yang terjadi. 
Solusinya? Harus ada "comprehension engineering": ritual review yang didesain, audit architectural diff mingguan, dan learning notes dari setiap run.

#### 4. Security: Loop Mewarisi Attack Surface Manusia (Abhijoy Sarkar)
Ini poin security yang brutal. Kalau loop baca issue eksternal atau web, setiap input itu potensi *injection point*. Kalau prompter diganti loop, maka loop harus punya filter yang lebih ketat dari manusia. Loop yang aman butuh permission minimal, sandbox, dan approval boundary untuk aksi berbahaya.

#### 5. Pragmatisme: Loop Bisa Jadi Overengineering (Sead & Ashley)
Nggak semua kerjaan butuh loop kompleks. Untuk solo dev atau task kecil, prompt manual + skill engineer jauh lebih efisien. Loop punya *minimum viable scale*. Di bawah itu, loop cuma jadi ritual mahal yang bakar token dan bikin tumpukan sampah yang harus dibersihkan.

Kesimpulan gue: Loop engineering itu bukan soal "berapa banyak agent yang bisa gue jalanin paralel", tapi "state apa yang harus disimpan, gate apa yang harus dilewati, dan kapan gue sebagai manusia wajib intervensi".

Referensi: https://x.com/addyosmani/status/2064127981161959567

## Loop: Dari Mana Istilah Ini Datang dan Kenapa Semua Orang Ribut?

Setelah baca artikel Addy Osmani soal "Loop Engineering", gue lanjut baca tulisan Matt Van Horn yang judulnya "WTF Is a Loop?". Kalau artikel Addy itu kayak "manual engineering" (gimana cara bangunnya), artikel Matt ini lebih ke "sejarah dan definisi medan perang" (apa itu sebenarnya dan kenapa orang debat).

Yang gue tangkap, banyak orang salah paham soal "loop" karena istilah ini dipakai buat banyak hal sekaligus. Matt ngejelasin spektrum evolusinya:
- Ada loop akademik kayak **ReAct**.
- Ada goal loop kayak **AutoGPT**.
- Ada **ralph loop** yang ngulang prompt dengan context anchor tetap.
- Ada **`/goal`** yang jalan sampai kondisi terpenuhi.
- Sampai ke **orchestration loop** yang ngawasin banyak agent/thread sekaligus.

Jadi pas gue baca reply-reply di thread Addy kemarin, gue baru sadar kenapa mereka debat. Mereka sebenarnya nggak selalu ngomongin level loop yang sama. Ada yang ngomongin cron job sederhana, ada yang ngomongin sistem orchestrator kompleks.

Satu poin yang paling ngena buat gue: loop itu bukan cuma cron job. Matt bilang loop itu kayak "cron plus a decision-maker in the body". Kalau cuma schedule, itu belum menarik. Yang baru adalah ada model di dalam jadwal itu yang bisa baca state, milih langkah berikutnya, bertindak, lalu ngecek feedback.

Ini juga memperkuat bahasan Addy soal *skills*. Matt bilang loop itu cuma "plumbing" (pipa), tapi aset aslinya adalah *skill* yang dipanggil. Loop tanpa reusable skill itu cuma `while true` di sekitar "orang asing". Tapi loop dengan named skills bisa *compound*—pengetahuannya numpuk dan makin tajam.

Terakhir, Matt juga nyentuh soal biaya. Biaya mahalnya sekarang bukan lagi di nulis kodenya, tapi di mengelola agent loop-nya. Ini sinkron banget sama keluhan soal token burn dan cleanup work yang gue baca di reply-reply Addy.

Intinya, prompt manual sekarang lagi turun level jadi bagian kecil dari sistem. Yang naik nilainya adalah desain loop: *stopping condition, feedback, state, budget cap, skill library,* dan *orchestration*.

Referensi: 

  * https://x.com/mattvanhorn/status/2064127981161959567
  * https://x.com/mvanhorn/status/2063865685558903149

## Siapa yang Pegang Kendali? Evolusi Siklus Kerja AI

Gue baru aja bedah materi soal evolusi coding agent, dan satu hal yang paling nempel buat gue: evolusinya itu bukan soal "modelnya makin pinter", tapi soal **siapa yang mengendalikan siklus kerja**.

Arah geraknya jelas banget: dari LLM yang cuma menjawab -> bertindak -> bekerja berulang -> diverifikasi -> sampai akhirnya dikoordinasikan sebagai sistem kerja.

Gue coba petakan perjalanannya:

1. **ReAct (Reason + Act)**: Ini fondasi awal. Model nggak cuma mikir di kepala, tapi disuruh cek dunia luar (tool call). Polanya: *Thought -> Action -> Observation*. Ini nyelesain masalah halusinasi, tapi masih butuh pengawasan manusia tiap detik.
2. **AutoGPT**: Di sini agent mulai dikasih goal besar dan mencoba ngatur dirinya sendiri. Masalahnya, autonomy tanpa disiplin itu bahaya. Agent sering merasa sibuk (bikin 40 to-do list) tapi nggak produktif, bahkan sering muter-muter (*stuck in loops*).
3. **Ralph Loop**: Solusinya adalah disiplin. Jangan percaya chat history sebagai otak utama, tapi pakai repo/filesystem sebagai memory. Agent jalan berulang dengan anchor file yang sama. Lebih stabil, tapi masih "bodoh" soal kapan harus berhenti.
4. **`/goal`**: Di tahap ini, loop dikasih validator atau *stopping condition* yang eksplisit. Agent nggak berhenti karena "merasa" selesai, tapi karena validator (test, diff, atau model lain) bilang "DONE".
5. **Multi-agent Orchestration**: Level tertinggi saat ini. Bukan cuma satu agent, tapi ada *orchestrator* yang bagi tugas ke banyak worker, reviewer, dan security checker. Ini udah kayak mini engineering team.

Insight paling tajam buat gue: tiap tahap itu sebenarnya respons terhadap *failure mode* sebelumnya. ReAct lawan halusinasi, AutoGPT lawan micromanagement, Ralph lawan chaos autonomy, `/goal` lawan loop abadi, dan Orchestration lawan keterbatasan satu agent.

Tapi gue juga sadar, makin tinggi levelnya, makin mahal biayanya dan makin besar risiko *comprehension debt*-nya. Kalau kita cuma jadi "tukang approve" tanpa paham apa yang dikerjakan orchestrator, kita sebenarnya lagi numpuk hutang pemahaman.

Referensi: Artikel Matt Van Horn & Diskusi Loop Engineering.

## AI as Engineering Accelerator, Not Replacement: Allen Holub's Approach

Terakhir, gue baca thread dari Allen Holub yang jadi *counterweight* banget buat hype "loop engineering". Kalau Addy dan Matt bahas sistem dan orkestrasi, Allen balik lagi ke disiplin engineering dasar.

Intinya, Allen ngelawan kultur "AI = 20x output kode". Buat dia, AI bukan mesin buat muntahin fitur sebanyak mungkin, tapi alat bantu yang harus dikurung sama arsitektur, test, dan judgment manusia.

Beberapa poin yang bikin gue klik:
- **Incremental & Small Batches**: Jangan kasih prompt raksasa. Pecah jadi vertical slice kecil yang bisa dites sebagai black box.
- **Human-Led Architecture**: AI boleh bantu implementasi, tapi arah arsitektur, API, dan boundary tetap di tangan engineer. Jangan biarkan AI jadi arsitek utama.
- **Tests as Human Contract**: Ini yang paling keras. Allen nggak biarkan AI nulis test. Kenapa? Karena AI cenderung bikin test yang "membenarkan" kode salahnya sendiri (*self-justification*). Test harus ditulis manusia dulu (TDD), baru AI diminta bikin kode yang bisa pass test itu.
- **Productivity $\neq$ Volume**: Produktivitas itu soal *time to complete a story* dengan kualitas tinggi, bukan berapa banyak baris kode yang di-generate.

Sintesis gue: Loop engineering itu leverage besar, tapi syarat mutlaknya adalah disiplin engineering kayak yang ditekankan Allen. Loop boleh jalan, tapi arsitektur tetap dipegang manusia, komponen harus kecil, dan verifikasi (test) nggak boleh diserahkan ke pembuat kode.

Referensi: https://x.com/allenholub/status/2064743466693751082

## Loop Driven Development (LDD): The Oracle Problem

Setelah baca Allen, gue nemu tulisan Nuno Campos soal **Loop Driven Development (LDD)**. Kalau Allen bilang "jangan biarkan AI nulis test", Nuno ngasih teori formalnya: masalah utamanya adalah **The Oracle Problem**.

Intinya, di era agent, nulis kode dan scaffolding test itu udah "gratis" (murah banget). Yang mahal adalah **mengetahui jawaban yang benar** (Oracle). Kalau feedback-nya salah, agent cuma bakal looping lebih cepat menuju arah yang salah.

Poin-poin yang paling ngena buat gue:
- **Behavior Coverage vs Code Coverage**: Coverage 100% nggak berarti sistem benar. Itu cuma berarti semua baris pernah dilewati. Yang penting adalah *behavior coverage*—apakah skenario domain yang krusial sudah dipin dalam test?
- **Ranking Feedback**: Nuno nge-rank sumber feedback dari yang paling lemah (self-review) sampai yang paling kuat (**Oracle to Mimic**—sistem nyata yang mau ditiru, deterministic, dan queryable).
- **LDD Workflow**: Bukan sekadar "loop sampai pass", tapi desain sumber feedback dulu $\rightarrow$ freeze jawaban oracle jadi test $\rightarrow$ biarkan agent looping implementasi sampai pass.

Sintesis akhir gue: Loop engineering (Addy/Matt) adalah mesinnya, disiplin engineering (Allen) adalah remnya, dan LDD (Nuno) adalah kompasnya (sumber kebenaran).

Referensi: https://x.com/nfcampos/status/2064746971944956299

## Practical Loop Setup: From Theory to Claude Code

Terakhir, gue baca thread dari @0x_rody yang membumikan semua teori loop engineering ini jadi setup praktis di Claude Code. Kalau Addy/Matt bahas sistem besar, Rody kasih "resep" 3 file supaya Claude nggak jadi "sekali tulis lalu kabur".

Intinya, Rody mengubah definisi **Done**. Done bukan berarti "kode sudah ditulis", tapi **"kode sudah diverifikasi"**.

Setup 3 filenya:
1. **`CLAUDE.md` (Protocol)**: Aturan main. Wajib run checks, max 5 retry, dan dilarang keras melemahkan test supaya terlihat pass.
2. **`.claude/settings.json` (Enforcement)**: Menggunakan hooks (`PostToolUse` dan `Stop`) untuk memaksa typecheck dan test jalan otomatis. Jadi feedback masuk ke session tanpa perlu gue paste manual.
3. **`.claude/agents/fixer.md` (Escalation)**: Sub-agent khusus diagnosis kalau loop utama stuck (error yang sama muncul 2x). Fresh context buat cari root cause tanpa baggage dari percobaan gagal.

Sintesis final gue hari ini:
- **Addy/Matt**: Loop Engineering (Sistem/Infrastruktur).
- **Allen**: Engineering Discipline (Guardrail/Rem).
- **Nuno**: LDD (Oracle/Kompas).
- **Rody**: Practical Implementation (Enforcement/Eksekusi).

Siklus lengkap: Desain Oracle $\rightarrow$ Pasang Guardrail $\rightarrow$ Bangun Loop $\rightarrow$ Paksa Verifikasi.

Referensi: https://x.com/0x_rody/status/2064728139314389073


