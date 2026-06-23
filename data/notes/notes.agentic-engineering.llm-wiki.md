
## Why this note

Gue butuh catatan ini karena Karpathy nggak cuma bicara tentang vibe coding. Awal April 2026 dia publikasi GitHub Gist `llm-wiki` sebagai blueprint, bukan repo aplikasi besar. Itu penting: ini pola operasional, bukan produk jadi.

Intinya, ini bukan sekadar transcript. Ini sumber primer yang mendefinisikan bagaimana Karpathy memikirkan LLM knowledge base sebagai:

raw source → LLM compile → structured markdown wiki → query/lint/update → wiki makin matang.

Note ini gue tulis untuk menangkap perbedaan kunci, arsitektur, dan ekosistem implementasi yang muncul setelahnya.

## Core idea

Dari gist itu, gue tangkap satu kontras jelas:

- mayoritas LLM+dokumen hari ini kayak RAG: upload file, ambil chunk sesuai query, jawab ulang dari awal setiap kali.
- LLM Wiki bukan begitu. Model membangun wiki markdown persisten yang terus dirawat.

Jadi ketika sumber baru masuk, LLM tidak cuma mengindeks. Ia membaca, mengekstrak, mengintegrasikan ke halaman yang sudah ada, memperbarui cross-link, dan menandai kontradiksi.

Quote penting dari gist:

- "The key difference: the wiki is a persistent, compounding artifact. The cross-references are already there. The contradictions have already been flagged. The synthesis already reflects everything you've read."
- "You never (or rarely) write the wiki yourself — the LLM writes and maintains all of it. You're in charge of sourcing, exploration, and asking the right questions."
- "Obsidian is the IDE; the LLM is the programmer; the wiki is the codebase."

## Why the gist matters

Gue lihat dua hal penting dari gist ini:

- Ini bukan repo produk launch. Ini idea file yang bisa kamu copy-paste ke agen kamu.
- Ia menegaskan bahwa wiki harus jadi lapisan terpisah yang dimiliki LLM, sementara sumber mentah tetap immutable.

Dengan kata lain: `llm-wiki` adalah pola operasional, bukan justifikasinya untuk bikin chat widget.

## What makes it different from RAG

1. RAG membaca ulang setiap kali. LLM Wiki menyimpan hasil kompilasi.
2. RAG stateless. LLM Wiki stateful dan kembangnya bersifat kumulatif.
3. RAG bekerja langsung pada sumber mentah. LLM Wiki menyelipkan lapisan wiki antara sumber dan query.
4. RAG fokus jawaban cepat. LLM Wiki fokus pemahaman yang bisa dibaca, diperiksa, dan dikembangkan.

Denser.ai menyebutnya pergeseran dari "cooking a meal from scratch every time" ke "compiled knowledge layer".

## Architecture

Menurut gist, ada tiga lapisan:

- Raw sources: sumber mentah yang tetap immutable. File aslinya tetap ada di sini.
- Wiki: markdown yang dihasilkan LLM. Halaman konsep, entitas, ringkasan, perbandingan, sintesis.
- Schema: file seperti `CLAUDE.md` atau `AGENTS.md` yang memberi aturan struktur, format halaman, dan workflow.

Tanpa schema, LLM cuma ngobrol. Dengan schema, ia jadi wiki maintainer.

## Operations

Gist menulis tiga operasi utama:

- Ingest: tambahkan sumber baru. LLM baca, ringkas, update halaman, perbarui index/log, dan jaga cross-link.
- Query: tanya langsung ke wiki. Jawabannya bisa jadi halaman markdown, tabel, slide deck, atau grafik. Yang bagus bisa difileback ke wiki.
- Lint: minta LLM cek kontradiksi, orphan page, klaim usang, gap konsep, dan broken link.

DAIR.AI merangkum ini sebagai fase: ingest → compile → query/enhance → lint/maintain.

## Supporting articles

### Denser.ai — From RAG to LLM Wiki

- Gist Karpathy muncul 4 April 2026 sebagai "idea file", bukan product launch.
- Artikelnya menegaskan bahwa ini bukan menggantikan RAG, melainkan menambahkan layer compiled knowledge di atasnya.
- Prinsip pentingnya: compile once, query many; knowledge should compound; provenance non-negotiable; human-readable markdown lebih tahan lama daripada vector store.

### DAIR.AI Academy — LLM Knowledge Bases

- Mereka menyebut LLM sebagai compiler yang baca raw source dan menghasilkan wiki terstruktur.
- Pendekatan ini bisa jalan tanpa embeddings atau vector search pada skala personal.
- Setiap query seharusnya bisa menambah basis pengetahuan jika outputnya difileback jadi halaman baru.

### Anthem Création — Karpathy’s LLM Wiki with Claude and Obsidian

- Workflow praktis: copy gist ke LLM, buka folder di Obsidian, simpan sumber di folder `sources/`, lalu biarkan LLM membangun wiki.
- Analogi utama: wiki itu executable; raw source itu source code; jangan recompile setiap kali.
- Karpathy disebut mengelola wiki pribadi lebih dari 100 artikel dan 400.000 kata.

## Why this matters untuk agentic engineering

- Ini memperluas pola agentic workflow dari "AI nulis kode" ke "AI nulis dan memelihara pengetahuan".
- Dalam Software 3.0, LLM jadi bukan hanya interpreter kode; ia juga compiler pengetahuan.
- Untuk Zettelkasten/second brain, LLM Wiki lebih mirip pra-prosesor yang mengorganisir dokumen mentah sebelum gue memilih insight atomik.
- Penting dicatat: manusia masih harus memilih sumber, merancang schema, review wiki, dan memutuskan apa yang benar-benar nyantol.

## Practical note

Kalau gue mau coba cepat:

- pisahkan folder `raw/` dan `wiki/`.
- bikin schema file (`CLAUDE.md` atau `AGENTS.md`) yang ngasih aturan page type, style, dan link.
- ingest sumber satu per satu, lalu review setiap perubahan wiki.
- jangan anggap query sebagai akhir. fileback hasil analisis ke wiki.
- jadikan `index.md` dan `log.md` sebagai kontrak sistem.

## Sources

- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- https://denser.ai/blog/llm-wiki-karpathy-knowledge-base/
- https://academy.dair.ai/blog/llm-knowledge-bases-karpathy
- https://anthemcreation.com/en/artificial-intelligence/karpathy-llm-wiki-claude-obsidian/

## Related notes

- [[zettel.literature.karpathy-from-vibe-coding-to-agentic-engineering]]
- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[zettel.20260507153000]]
