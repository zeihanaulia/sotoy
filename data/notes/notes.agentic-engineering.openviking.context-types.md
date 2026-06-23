
**context types** di OpenViking bukan "context window" LLM dan bukan prompt context biasa. Di OpenViking, context berarti semua bahan yang bisa dipakai agent untuk tahu, mengingat, dan bertindak.

## 1. Pertanyaan kunci yang gue pegang

Ada enam pertanyaan inti yang bikin konsep ini jelas buat gue:

1. Kenapa OpenViking membagi context jadi 3 tipe?
2. Apa itu Resource?
3. Apa itu Memory?
4. Apa itu Skill?
5. Kenapa Memory dibagi jadi 8 kategori?
6. Apa gunanya unified search lintas tiga tipe ini?

## 2. Kenapa harus dibagi jadi Resource, Memory, Skill?

OpenViking memisahkan konteks berdasarkan fungsi kognitif agent. Ini bukan sekadar taxonomy folder, tapi desain untuk mencegah agent mencampur "pengetahuan", "pengalaman", dan "kemampuan" ke satu tumpukan RAG yang kabur.

Kalau semua data masuk satu vector DB flat, agent bisa salah anggap antara:

- dokumen referensi,
- preferensi user,
- pengalaman historis,
- definisi kemampuan,
- aturan resmi.

OpenViking memilih:

- **Resource** = referensi,
- **Memory** = pembelajaran,
- **Skill** = aksi.

Ini mirip dengan cara manusia bekerja:

- buku/manual untuk tahu,
- pengalaman pribadi untuk ingat,
- keterampilan untuk bertindak.

## 3. Resource: pengetahuan dan aturan

Resource adalah external knowledge yang relatif statis. Ini sumber yang user atau developer masukkan supaya agent punya basis pengetahuan.

Karakteristik Resource:

- **User-driven**: biasanya ditambahkan oleh user.
- **Static content**: tidak berubah otomatis setiap session.
- **Structured storage**: disimpan dalam hierarchy seperti `viking://resources/...`.

Contoh Resource:

- API docs,
- product manual,
- FAQ,
- code repo,
- research paper,
- technical spec.

Jadi Resource itu bukan memori agent. Ini adalah knowledge base yang agent baca.

## 4. Memory: kognisi yang dipelajari agent

Memory adalah konteks yang dihasilkan dari interaksi. Ini bukan hanya preferensi user; ini juga pengalaman agent sendiri.

Karakteristik Memory:

- **Agent-driven**: diekstrak atau dicatat oleh agent.
- **Dynamic updates**: berubah seiring waktu.
- **Personalized**: bisa spesifik ke user atau agent.

Contoh user memory:

- User prefers structured explanations.
- User works on project Alpha.
- User dislikes vague answers.

Contoh agent memory:

- When debugging sandbox issues, check env variables first.
- For this repo, tests often fail due to fixture paths.

Kalau dibedakan:

- **User memory** = agent belajar tentang user.
- **Agent memory** = agent belajar dari pekerjaannya sendiri.

## 5. Delapan kategori Memory

Gue catat bahwa page ini memakai versi 8 kategori memory. Ini lebih rinci daripada overview 6 kategori.

- **profile**
- **preferences**
- **entities**
- **events**
- **cases**
- **patterns**
- **tools**
- **skills**

### 5.1 profile

Lokasi: `user/memories/profile.md`

Profile adalah kartu identitas ringkas. Informasi dasar user digabung, bukan dipecah-pecah.

### 5.2 preferences

Lokasi: `user/memories/preferences/`

Preferences adalah preferensi topikal yang appendable.

### 5.3 entities

Lokasi: `user/memories/entities/`

Entities adalah memory tentang orang, project, organisasi, produk.

### 5.4 events

Lokasi: `user/memories/events/`

Events adalah record historis. Biasanya tidak diperbarui.

### 5.5 cases

Lokasi: `agent/memories/cases/`

Cases adalah pengalaman task konkret. Sifatnya immutable.

### 5.6 patterns

Lokasi: `agent/memories/patterns/`

Patterns adalah generalisasi dari cases. Sifatnya mergeable.

### 5.7 tools

Lokasi: `agent/memories/tools/`

Tools adalah memory tentang penggunaan tools dan best practice.

### 5.8 skills

Lokasi: `agent/memories/skills/`

Skills memory adalah pengalaman/strategi menjalankan skill, bukan definisi skill itu sendiri.

## 6. Skill: kemampuan yang bisa dipanggil agent

Skill adalah capability yang dapat diinvoke. Definisi skill relatif statis, tapi memory tentang skill dapat berubah.

Skill memiliki sifat:

- **Defined capability**,
- **Relatively static**,
- **Callable**.

Ini berbeda dengan skill memory, yang adalah pengalaman menjalankan skill.

## 7. Resource vs Memory vs Skill secara tajam

Contoh satu task:

- Resource = dokumen dan kode yang dibaca.
- Memory = pengalaman historis dan preferensi.
- Skill = prosedur atau tool yang dipanggil.

Resource menjawab "agent tahu apa?"
Memory menjawab "agent belajar apa dari pengalaman?"
Skill menjawab "agent bisa melakukan apa?"

## 8. Unified search: kenapa penting?

Unified search adalah pencarian lintas Resource, Memory, dan Skill dalam satu sistem.

Satu query bisa menghasilkan tiga jenis jawaban sekaligus:

- resource relevan,
- memory relevan,
- skill relevan.

Ini membuat agent bisa memutuskan bukan hanya berdasarkan dokumen, tapi juga berdasarkan pengalaman dan kemampuan.

## 9. Insight penutup

Kesan terbesar gue: OpenViking membagi context bukan supaya lebih rumit, tapi supaya agent tidak salah kaprah. Resource, Memory, Skill adalah tiga mode kognitif yang berbeda. Agent yang matang harus tahu bedanya antara apa yang dia tahu, apa yang dia ingat, dan apa yang dia bisa lakukan.

## Related documents

- [[notes.agentic-engineering.openviking.context-database]]
- [[notes.agentic-engineering.openviking.architecture]]
- [[notes.agentic-engineering.openviking.storage-architecture]]
- [[notes.agentic-engineering.openviking.context-extraction]]
- [[notes.agentic-engineering.openviking.context-layers]]
- [[vault/daily.journal.2026.06.03|Daily 2026-06-03]]
