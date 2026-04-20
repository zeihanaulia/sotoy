---
id: zettel.literature.context-anchoring
title: "Context Anchoring — memindahkan konteks keputusan dari chat ke dokumen hidup"
desc: "Literature note dari artikel "Context Anchoring" oleh Rahul Garg yang membahas mengapa chat tidak cukup untuk menyimpan keputusan engineering dan bagaimana feature document menjadi external memory." 
tags:
  - literature-note
  - ai-collaboration
  - decision-making
  - knowledge-management
---

## Tentang Sumber

- **Judul**: Context Anchoring
- **Penulis / Author**: Rahul Garg
- **Tahun**: 2026
- **Jenis**: artikel
- **Link / ISBN**: [Thoughtworks / Martin Fowler blog](https://martinfowler.com/articles/reduce-friction-ai/context-anchoring.html)

---

## Catatan Per Gagasan

### Paragraf 0 — pembuka mendefinisikan problem dan solusi

> AI conversations are ephemeral by design — decisions made early fade as sessions lengthen, and nothing survives the session boundary. Developers hold on to long conversations not because long sessions are productive, but because the context lives nowhere else. I propose externalizing decision context into a living document — external memory that persists what the context window cannot, turning transient alignment into durable shared understanding.

Catatan gue: pembuka ini langsung menegaskan tesis utama artikel. Percakapan AI itu fana; keputusan awal memudar; developer mempertahankan sesi panjang karena konteks tidak hidup di tempat lain. Solusinya adalah memindahkan konteks keputusan ke dokumen hidup.

Atomic idea: percakapan AI bukan tempat penyimpanan keputusan jangka panjang; konteks penting harus die-eksternalisasi.

Kenapa penting: ini tesis utama seluruh artikel. Semua paragraf berikutnya pada dasarnya menjelaskan dan membuktikan klaim ini.

### Atomic idea — dokumen bersama sebagai external memory di kolaborasi manusia

> When I work with a colleague on a feature that spans several days, we keep a shared document. Not formal documentation: a working record. What we decided, why, what we rejected, what questions remain open. If either of us is absent for a day, the other picks up where we left off. Neither of us relies on memory alone. The document is our external memory — it persists what individual recall cannot.

Penulis merujuk ini dari paragraf 1.

Catatan gue: penulis memulai dari praktik engineering manusia-manusia. Untuk fitur multi-hari, tim secara alami memindahkan memori kerja penting ke dokumen bersama yang merekam keputusan, alasan, penolakan, dan pertanyaan terbuka.

Atomic idea: dalam kolaborasi manusia, memori kerja penting secara alami dipindahkan ke dokumen bersama.

Kenapa penting: ini baseline. Penulis tidak mulai dari AI, tapi dari praktik yang sudah normal. Jadi ketika dia mengusulkan hal serupa untuk AI, itu bukan ide aneh—itu perpanjangan dari kebiasaan engineer.

### Atomic idea — memory tool AI sekarang mayoritas hanya project-level

> With AI coding assistants, the conversation is still largely the record. Some tools now offer persistent memory features (Claude's project memory, Cursor's rules files, Copilot's workspace indexing) but these operate at the project level, not the feature level. They remember that the project uses Fastify, not that yesterday's session rejected a RetryQueue abstraction for specific reasons.

Penulis merujuk ini dari paragraf 2.

Catatan gue: AI tools modern punya “memory”, tapi itu kebanyakan konteks proyek: stack, pola umum, konvensi. Mereka masih gagal menyimpan keputusan fitur spesifik, terutama alasan dan keputusan yang ditolak.

Atomic idea: tool memory saat ini gagal menyimpan keputusan fitur; akibatnya developer terjebak mempertahankan chat panjang yang justru makin merusak kualitas konteks.

Kenapa penting: di sini artikel mulai menyempitkan problem. Bukan sekadar “AI lupa”, tapi AI tidak punya tempat yang tepat untuk menyimpan reasoning fitur.

### Atomic idea — kecemasan menutup chat sebagai heuristik context leakage

> Here is a test I find revealing: could I close this conversation right now and start a new one without anxiety? If that question creates discomfort, if I feel I would lose something important — my context is trapped inside a medium that was never designed to preserve it.

Penulis merujuk ini dari paragraf 3.

Catatan gue: rasa cemas saat menutup chat adalah sinyal bahwa konteks masih terjebak dalam medium yang salah. Itu berarti Anda sedang bergantung pada percakapan sebagai tempat penyimpanan, bukan sekadar alat berpikir.

Atomic idea: rasa cemas saat menutup chat adalah sinyal bahwa konteks masih hidup di tempat yang salah.

Kenapa penting: ini mengubah problem teknis jadi heuristik praktis. Lo tidak perlu teori token untuk mendeteksi masalah—cukup cek rasa “sayang nutup chat”.

### Atomic idea — erosi konteks AI adalah isu arsitektural, bukan bug acak

> The degradation is not random. It follows from how large language models process context.

Penulis merujuk ini dari paragraf 4.

Catatan gue: kehilangan konteks pada AI bukan akibat kebetulan atau limit kecil. Ini adalah konsekuensi arsitektural dari cara LLM memprioritaskan token, sehingga reasoning menengah mudah menguap.

Atomic idea: kehilangan konteks pada AI adalah konsekuensi arsitektural, bukan sekadar bug acak.

Kenapa penting: penulis menggeser pembahasan dari gejala ke mekanisme. Ini penting supaya solusi yang ditawarkan tidak terasa seperti workaround asal-asalan.

### Atomic idea — context window besar tetap cepat habis dalam praktik engineering

> Every model has a finite context window: a hard limit on how many tokens it can attend to at once. Current models offer windows ranging from hundreds of thousands to over a million tokens. These numbers sound generous, but a productive development session generates context quickly: code snippets, design discussions, decision rationale, file contents. The window fills faster than most developers expect.

Penulis merujuk ini dari paragraf 5.

Catatan gue: semua model memang punya context window terbatas. Walau angka token terlihat besar, kerja engineering nyata mengonsumsi konteks sangat cepat karena banyaknya kode, diskusi, dan reasoning.

Atomic idea: context window besar tetap cepat habis dalam kerja engineering nyata.

Kenapa penting: ini membongkar ilusi umum bahwa context window yang besar sudah cukup. Penulis bilang: besar di atas kertas belum tentu besar di praktik.

### Context anchoring adalah memindahkan konteks keputusan dari chat yang sementara ke dokumen yang hidup

> Penulis mengusulkan "externalizing decision context into a living document" dan menjadikannya "external memory".

Catatan gue: context anchoring bukan sekadar ringkasan chat atau wiki projek. Ini adalah dokumen fitur yang menyimpan:

- keputusan yang dibuat,
- alasan di baliknya,
- alternatif yang ditolak,
- constraint yang harus dihormati,
- apa yang masih terbuka,
- status pekerjaan.

Ini membuat alignment menjadi lebih tahan waktu, karena chat hanya medium berpikir sementara.

### Kelemahan kontekstual AI adalah rapuhnya memori kerja model, bukan kurangnya "kecerdasan"

> Erosi konteks AI terjadi karena token window terbatas, diskusi engineering padat, dan model cenderung kehilangan reasoning yang dibahas di tengah sesi.

Catatan gue: masalahnya bukan AI tidak lulus fakta. Yang paling mahal hilang adalah "why". Model bisa masih ingat "pakai PostgreSQL", tapi lupa kenapa PostgreSQL dipilih dan apa konsekuensi komprominya.

Ini mirip dengan failure mode di mana junior dev tahu aturan permukaan, tapi tidak paham tujuan desain.

### Codebase hanya menunjukkan hasil, bukan rentang keputusan yang dilewati

> Codebase memberi jejak outcome. Itu tidak menunjukkan alternatif, pertanyaan terbuka, atau constraint yang melahirkan keputusan.

Catatan gue: ini alasan utama kenapa feature document perlu ada. Code memberi tahu apa yang dipakai, tetapi tidak mengungkap proses berpikir.

Ini relevan dengan ADR: catatan arsitektur menyimpan reasoning, sedangkan repo hanya menyimpan implementasi. Artikel ini mengajak membuat ADR ringan di level fitur.

### External memory praktisnya adalah feature document yang hidup, bukan dokumentasi formal besar

> Contoh Notification Service v1 menunjukkan format ringkas:

- Decisions (dengan reason dan rejected alternative)
- Constraints
- Open questions
- State

Catatan gue: struktur ini membuat dokumen menjadi state container, bukan dokumentasi pasif. Dokumen fitur harus cepat di-update setiap sesi dan mudah dibaca kembali.

### Ada dua lapisan konteks: project-level priming dan feature-level anchoring

> Priming document = konteks proyek yang relatif stabil.
> Feature document = konteks fitur yang dinamis.

Catatan gue: dua lapisan ini tidak saling menggantikan. Priming memberi norma dan bahasa, sementara feature document memberi riwayat keputusan lokal.

Jika hanya ada priming, AI tahu proyek tapi tidak tahu alasan keputusan spesifik. Jika hanya ada feature doc, AI tahu keputusan sekarang tapi tidak tahu nilai-nilai proyek.

### Praktik ini worth it ketika pekerjaan lintas sesi atau lintas tim

> Uji sederhana: "Could I close this conversation right now and start a new one without anxiety?"

Catatan gue: context anchoring paling berguna untuk fitur multi-hari, fitur yang akan direvisit, atau ketika satu fitur dikerjakan oleh lebih dari satu developer. Untuk quick fix atau debugging singkat, overheadnya bisa lebih besar dari manfaat.

---

## Zettels yang Dibuat dari Sumber Ini

- [[zettel.20260420131310]] — Percakapan AI adalah medium berpikir, bukan tempat penyimpanan keputusan
- [[zettel.20260420131311]] — Kolaborasi manusia multi-hari memindahkan memori kerja ke dokumen bersama
- [[zettel.20260420131312]] — AI memory tools sekarang kebanyakan project-level, bukan feature-level
- [[zettel.20260420131400]] — Kecemasan menutup chat adalah indikator context leakage
- [[zettel.20260420131401]] — Erosi konteks AI adalah isu arsitektural, bukan bug acak
- [[zettel.20260420131402]] — Context window besar tetap cepat habis dalam praktik engineering
- [[zettel.20260420131403]] — Posisi informasi memengaruhi recall; tengah konteks adalah zona rawan hilang
- [[zettel.20260420131404]] — Dalam erosi konteks, "why" hilang sebelum "what"
- [[zettel.20260420131405]] — Kalau medium lupa, pindahkan memori ke luar medium itu
- [[zettel.20260420131406]] — Summarization otomatis menyelamatkan what, bukan why
- [[zettel.20260420131407]] — Alignment tanpa persistence tetap rapuh
- [[zettel.20260420131408]] — Context anchoring adalah durability layer untuk alignment manusia-AI
- [[zettel.20260420131409]] — Decision context harus menjadi external state, bukan jejak chat
- [[zettel.20260420131410]] — Project context dan feature context punya fungsi berbeda
- [[zettel.20260420131411]] — Priming document adalah memori stabil level proyek
- [[zettel.20260420131412]] — Feature document adalah memori dinamis level pekerjaan yang sedang berlangsung
- [[zettel.20260420131413]] — Agar efektif, AI butuh dua lapis konteks: fondasi stabil dan riwayat lokal
- [[zettel.20260420131414]] — Membaca codebase tidak sama dengan memahami keputusan
- [[zettel.20260420131415]] — Code menyimpan outcome; reasoning dan rejected history tidak tampak di sana
- [[zettel.20260420131416]] — Feature document lebih semantik-padatan dan token-efisien daripada mengekstrak reasoning dari kode
- [[zettel.20260420131417]] — Context anchoring untuk AI adalah versi kontemporer dari kebutuhan yang melahirkan ADR
- [[zettel.20260420131418]] — Feature document adalah ADR hidup selama proses, bukan catatan pasca-fakta
- [[zettel.20260420131419]] — Feature document bisa jadi jembatan antara kerja harian dan dokumentasi formal
- [[zettel.20260420131420]] — Context anchoring adalah infrastruktur koordinasi tim, bukan hanya memori individu
- [[zettel.20260420131421]] — Dokumen adalah mekanisme persistence yang menggantikan keterbatasan model
- [[zettel.20260420131422]] — Solusi ini bisa dipasang ke contoh praktis, bukan sekadar teori
- [[zettel.20260420131423]] — Begitu keputusan desain terkristal, pindahkan ke dokumen bersama alasannya
- [[zettel.20260420131424]] — Feature document yang efektif itu ringkas dan operasional
- [[zettel.20260420131425]] — Struktur minimal feature document jelas dan praktis
- [[zettel.20260420131426]] — Nilai anchoring muncul saat sesi baru bisa warm start
- [[zettel.20260420131427]] — Maintenance dokumen harus menempel ke ritme kerja alami
- [[zettel.20260420131428]] — Feature document memaksa reasoning menjadi lebih jelas
- [[zettel.20260420131429]] — Feature document mengompresi hari kerja menjadi konteks yang bisa diakses ulang cepat
- [[zettel.20260420131430]] — Context anchoring adalah alat yang harus dikalibrasi, bukan default universal
- [[zettel.20260420131431]] — Kebutuhan anchoring naik seiring durasi, revisit, dan jumlah orang
- [[zettel.20260420131432]] — Nilai anchoring ditentukan oleh overhead dokumentasi versus biaya kehilangan konteks
- [[zettel.20260420131433]] — Keinginan mempertahankan chat adalah indikator anchoring belum cukup
- [[zettel.20260420131434]] — Chat adalah medium berpikir; dokumen adalah medium penyimpanan keputusan
- [[zettel.20260420131435]] — Keberhasilan context anchoring diukur dari murahnya restart
## Pertanyaan Terbuka

- Bagaimana workflow terbaik untuk menulis feature document agar tetap ringan tapi berguna?
- Seberapa sering feature document harus ditinjau atau dikonversi menjadi ADR formal?
- Bagaimana memadukan context anchoring dengan tool memory AI tanpa menjadikan dokumen sebagai "summary dump"?
- Apa batasannya untuk tim kecil atau pekerjaan one-off?
