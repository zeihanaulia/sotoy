
## Pertanyaan yang dibuka

1. Sebenarnya artikel ini sedang ngomongin apa?
2. Kenapa “vibe coding” dianggap tidak cukup?
3. Apa saja lima building block yang dimaksud?
4. Gimana kelima block itu saling nyambung jadi workflow nyata?
5. Di mana titik gagal paling umum saat tim coba pakai AI buat engineering?

## Klaim utama

Artikel Thoughtworks ini bukan membahas AI yang bisa menulis kode. Ia membahas bagaimana membangun **operating model engineering** yang menjadikan AI sebagai bagian terstruktur dari proses software delivery.

> “AI should be treated as an engineering stack, bukan chatbot yang diajak ngobrol santai.”

## Apa yang dibahas?

Project yang dibahas adalah kerangka pemikiran untuk AI-native engineering. Bukan repositori spesifik, bukan software tertentu, melainkan:

* memilih agent yang bisa mengeksekusi kerja,
* memilih model yang bisa berpikir,
* memilih methodology yang membatasi chaos,
* menulis spec yang jelas,
* memberikan context yang membuat output AI relevan dengan tim dan arsitektur.

Jadi fokusnya adalah: **AI bukan sekadar tool, tapi bagian dari workflow engineering yang harus diorkestrasikan.**

## Mengapa "vibe coding" tidak cukup?

“Vibe coding” dianggap kegagalan untuk software serius karena ia:

* terlalu mengandalkan prompt mentah,
* berharap hasil benar tanpa struktur,
* memperbaiki kesalahan secara manual berulang,
* tidak memberikan audit trail,
* tidak memastikan konsistensi arsitektur,
* tidak mendukung maintainability di sistem nyata.

Atomic insight:

> Kode yang jalan tidak sama dengan kode yang bisa dipelihara. Vibe coding memberi ilusi produktivitas, tetapi untuk enterprise engineering nilai terbesarnya adalah repeatability, safety, dan alignment.

## Lima building block

1. **Agent**
   * Lapisan eksekusi otonom.
   * Bisa baca project, run command, install dependency, edit file, jalankan test, dan refactor multi-file.
   * Ini lebih dari chatbot; ini “tangan” yang bisa pakai alat.

2. **Model**
   * Mesin reasoning.
   * Berbeda dengan agent: model adalah otak, agent adalah aktornya.
   * Pasar sudah terfragmentasi menjadi model spesialis untuk code gen, architectural reasoning, QA, dokumentasi, dan security.

3. **Methodology**
   * Aturan main untuk mencegah agent thrashing.
   * Menegakkan struktur: prompt yang terarah, CI/CD integration, test-driven AI, versioning, audit, human review.
   * Contoh yang relevan: BMAD Method sebagai framework workflow AI-native engineering.
   * Tanpa ini, AI cepat tapi liar.

4. **Spec**
   * Jembatan dari niat manusia ke eksekusi AI.
   * Menjadikan requirement yang buram menjadi acceptance criteria, batasan, dan tujuan yang bisa diinterpretasi AI.
   * AI-native engineering memindahkan bottleneck biaya mental ke kualitas spesifikasi.

5. **Context**
   * Pengetahuan institusional dan guardrail yang menetapkan cara kerja di lingkungan khusus tim.
   * Berisi aturan coding, arsitektur, security, design system, dependency policy, dan persistent instruction.
   * Tanpa context, AI cenderung menghasilkan solusi generik yang tidak fit dengan codebase.

## Bagaimana kelima block menyatu?

Serangkaian ini saling tergantung:

* Tanpa **agent**, model cuma bisa menjawab teks.
* Tanpa **model** yang tepat, agent bergerak tanpa reasoning yang sesuai.
* Tanpa **methodology**, agent akan muter-muter dan sulit diaudit.
* Tanpa **spec**, agent bergerak ke tujuan yang salah.
* Tanpa **context**, output agent bisa tidak sesuai standar tim dan arsitektur.

Jadi rangkaian yang benar adalah:

* agent = siapa yang mengeksekusi
* model = mesin yang berpikir
* methodology = aturan main proses
* spec = apa yang harus dilakukan
* context = bagaimana melakukannya dengan benar

## Titik gagal paling umum

Kegagalan paling berbahaya menurut artikel ini bukan sekadar bug syntax. Melainkan:

* AI menghasilkan solusi yang nampak rapi tapi salah domain.
* Spec kabur atau bertentangan.
* Context tidak cukup.
* Agent diberi kebebasan tanpa metodologi.
* Review manusia melemah karena AI terlihat produktif.

Inti penting:

> Masalah AI-native engineering bukan model terbaik. Masalahnya adalah membangun workflow AI yang bisa dipercaya.

## Relevansi untuk engineer

Peran engineer bergeser dari:

* penulis kode langsung

ke:

* penyusun intent,
* pengarah constraint,
* reviewer AI,
* architect of flow,
* penjaga kualitas sistem.

Skill yang naik nilainya bukan lagi sekadar menulis kode cepat, tapi juga:

* membuat spec yang tajam,
* memahami boundary arsitektural,
* mendesain guardrail,
* memverifikasi output AI.

## Hubungan ke catatan lain

* [[zettel.20260421161001]] — AI-native adalah jargon strategi yang menandai asumsi desain AI sebagai fondasi, bukan sekadar fitur tambahan
* [[zettel.20260421162253]] — Classic, Modern, dan AI-native Software Engineering adalah tiga mode kerja, bukan disiplin formal
* [[zettel.moc.software-architecture]]
