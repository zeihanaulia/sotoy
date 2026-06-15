---
id: notes.agentic-engineering.openviking.context-extraction
title: "OpenViking context extraction"
desc: "POV catatan tentang proses OpenViking mengubah input mentah menjadi konteks viking:// yang terstruktur, searchable, dan navigable."
updated: 1780427875512
created: 1780427768298
tags:
  - notes
  - agentic-engineering
  - openviking
  - context-extraction
---

Link: https://docs.openviking.ai/en/concepts/06-extraction

**Context Extraction di OpenViking adalah proses mengubah input mentah seperti PDF, Markdown, HTML, repo code, image, video, audio, skill, atau session history menjadi struktur `viking://...` yang punya L0/L1, bisa dibaca dari AGFS, dan bisa dicari lewat Vector Index**.

Ini bukan cuma summarization. Lebih tepat: **pipeline ingestion + structuring + semantic generation + vectorization**.

## 1. Pertanyaan kunci yang gue pegang

1. Kenapa OpenViking memisahkan parsing dan semantic generation?
2. Apa yang dilakukan Parser?
3. Apa yang dilakukan TreeBuilder?
4. Apa yang dilakukan SemanticQueue?
5. Bagaimana L0/L1 dibuat secara bottom-up?
6. Bagaimana code repository diproses lewat AST Mode?
7. Bagaimana Resource, Memory, dan Skill punya flow extraction yang berbeda?

## 2. Kenapa parsing dan semantic generation dipisah?

Page ini menegaskan satu prinsip: parsing dan semantics harus dipisah.

- `Parser` hanya membaca format, memecah struktur, dan menulis hasil sementara.
- `SemanticQueue` menghasilkan makna: L0/L1, embeddings, vector index.

Kenapa? Karena parsing harus deterministik, cepat, dan bebas biaya LLM. Semantic generation mahal, lambat, dan harus bisa berjalan async.

Atomic idea:

```
Parser membangun bentuk.
SemanticQueue membangun makna.
```

Kalau dua ini dicampur, ingestion jadi lambat, mahal, dan debugging jadi susah.

## 3. Parser = reader + temp structurer

Parser membaca format input dan mengubahnya jadi struktur file sementara di temp directory.

Page bilang:

> “Parser handles document format conversion and structuring, creating file structure in temp directory.”

Parser tidak memanggil LLM.

Hasilnya adalah `ParseResult` yang mencakup:

- `temp_dir_path`
- `source_format`
- `parser_name`
- `parse_time`
- `meta`

Jadi setelah parsing, OpenViking tahu di mana hasil sementara ada dan format asalnya.

### Format input yang didukung

- Markdown (.md, .markdown)
- Plain text (.txt)
- PDF (.pdf)
- HTML (.html, .htm)
- Code (.py, .js, .go, dsb.)
- Image (.png, .jpg, dsb.)
- Video (.mp4, .avi, dsb.)
- Audio (.mp3, .wav, dsb.)

Untuk code repository, parser juga hormat `.gitignore` dan mengabaikan direktori non-code yang umum.

Atomic rule:

```
Parser tahu apa yang harus dimasukkan.
Parser juga tahu apa yang harus diabaikan.
```

## 4. TreeBuilder = temp → AGFS + queue semantic jobs

Setelah Parser selesai, `TreeBuilder` memindahkan struktur sementara ke AGFS dan mendaftarkan pekerjaan semantic.

Page menjelaskan flow utama:

```
1. Find document root
2. Determine target URI
3. Recursively move directory tree
4. Clean up temp directory
5. Queue semantic generation
```

### Find document root

TreeBuilder memastikan result punya satu root konteks. Jika parsing menghasilkan banyak root tanpa struktur, konteks jadi ambigu.

### Determine target URI

TreeBuilder menempatkan hasil ke base URI sesuai scope:

- `resources` → `viking://resources`
- `user`      → `viking://user`
- `agent`     → `viking://agent`

Scope ini menentukan world context: Resource, Memory, atau Skill.

### Move + cleanup + queue

TreeBuilder memindahkan file ke AGFS, kemudian menghapus temp.
Dia tidak membuat L0/L1. Itu pekerjaan `SemanticQueue`.

Atomic idea:

```
TreeBuilder = pemindah struktur.
SemanticQueue = pembuat makna.
```

## 5. SemanticQueue = async L0/L1 + vectorization

`SemanticQueue` adalah pipeline async yang membangun L0/L1 dan menghasilkan embeddings.

Pesanannya biasanya berupa `SemanticMsg` yang membawa:

- `uri`
- `context_type`
- `status`
- `job id`

Kenapa pakai queue?

Karena L0/L1 sering perlu LLM/VLM call. Itu lebih lambat dan lebih mahal. Dengan queue, AGFS bisa terisi terlebih dahulu, lalu semantic processing berjalan di belakang layar.

Atomic idea:

```
AGFS ready dulu.
Semantic search menyusul.
```

## 6. L0/L1 dibuat secara bottom-up

SemanticQueue memproses directory dari bawah ke atas:

- buat L0/L1 untuk leaf nodes,
- kumpulkan abstract child,
- buat overview parent,
- naik ke root.

Ini penting karena parent overview perlu tahu isi child sebelum bisa dirangkum.

Contoh:

- `oauth.md` → buat `oauth/.abstract.md` dan `oauth/.overview.md`
- `jwt.md` → buat `jwt/.abstract.md` dan `jwt/.overview.md`
- `api-keys.md` → buat `api-keys/.abstract.md` dan `api-keys/.overview.md`
- lalu folder `auth/` → buat `.abstract.md`/`.overview.md` dari child abstracts

Atomic idea:

```
Anak diringkas dulu.
Orang tua merangkum anak-anaknya.
```

## 7. AST Mode untuk code repository

OpenViking punya mode khusus untuk repo code: AST Mode.

Page menulis bahwa code processing bisa pakai tree-sitter untuk mengekstrak skeleton tanpa LLM, supaya proses lebih murah.

### `code_summary_mode`

- `ast`: pakai AST skeleton untuk file besar, tidak memanggil LLM.
- `llm`: selalu pakai LLM untuk code.
- `ast_llm`: buat skeleton dulu, lalu ringkas dengan LLM.

### Mengapa AST Mode penting?

Code repo bisa besar. Jika setiap file diringkas lewat LLM,

- biaya jauh lebih tinggi,
- proses lebih lambat,
- rate limit lebih berisiko.

AST Mode membantu ketika agent hanya butuh struktur:

- imports
- class names
- method signatures
- function signatures
- docstring first lines

Contoh:

```
class AuthClient(BaseClient):
  def refresh_token(self, token: str) -> Optional[str]:
```

Untuk pertanyaan struktur code, AST sering sudah cukup.

## 8. Tiga mode code summary

`ast` = murah dan struktural.
`llm` = kaya semantik tapi mahal.
`ast_llm` = struktur dulu, lalu semantic summary.

AST adalah optimasi, bukan single point of failure. Kalau AST gagal, pipeline fallback ke LLM.

## 9. Resource, Memory, dan Skill punya flow berbeda

Flow extraction dasarnya sama, tapi target dan `context_type` berbeda.

- Resource → `viking://resources/...`
- Memory   → `viking://user/memories/...` atau `viking://agent/memories/...`
- Skill    → `viking://agent/skills/...`

Resource biasanya berasal dari file/link eksternal.
Skill biasanya sudah berupa definisi capability.
Memory lahir dari session commit.

## 10. Kenapa Context Extraction lebih dari summarization?

Context Extraction adalah pabrik bahan mentah OpenViking.

Input mentah belum berguna sampai dia:

1. punya alamat `viking://...`,
2. punya struktur folder,
3. punya L0/L1 untuk navigasi,
4. punya L2 sebagai detail asli,
5. masuk Vector Index agar bisa retrieval.

Jadi extraction adalah pipeline ingestion + structuring + semantic generation + vectorization.

## 11. Hubungan extraction dengan storage

Flow lengkap:

```
Parser → temp tree
TreeBuilder → AGFS
SemanticQueue → L0/L1 ke AGFS
EmbeddingQueue → Vector Index
```

Storage Architecture menyediakan tempat. Context Extraction menyediakan proses.

## 12. Hubungan extraction dengan context layers

Context Layers adalah hasil:

- `L0` = `.abstract.md`
- `L1` = `.overview.md`
- `L2` = original content

Context Extraction adalah cara menghasilkan hasil itu.

## 13. Hubungan extraction dengan retrieval

Retrieval bergantung pada kualitas extraction.

```
bad parsing → bad tree → bad L0/L1 → bad index → bad retrieval
```

## 14. Failure mode extraction

- Parser terlalu agresif split.
- Parser kurang split.
- `TreeBuilder` tidak menemukan root yang jelas.
- `SemanticQueue` tertunda.
- LLM summary salah.
- AST skeleton kehilangan logic penting.
- Memory extraction salah kategori.

## 15. Insight penutup

★ Insight ─────────────────────────

Context Extraction adalah titik di mana data mentah berubah menjadi context agent yang terstruktur, searchable, navigable, dan reusable. OpenViking tidak cukup hanya “menyimpulkan ringkasan”. Dia perlu menjadikan input mentah punya format `viking://`, folder tree, L0/L1, L2, dan index semantic.

## Related documents

- [[notes.agentic-engineering.openviking.architecture]]
- [[notes.agentic-engineering.openviking.storage-architecture]]
- [[notes.agentic-engineering.openviking.context-types]]
- [[notes.agentic-engineering.openviking.context-layers]]
- [[notes.agentic-engineering.openviking.context-database]]
- [[vault/daily.journal.2026.06.03|Daily 2026-06-03]]
