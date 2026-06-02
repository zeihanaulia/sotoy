---
id: notes.agentic-engineering.honcho.stateful-memory
title: Stateful Memory
desc: >-
  Catatan tentang Honcho sebagai memory library/managed service untuk stateful
  agent dan model entity-centric memory.
updated: 1780422974833
created: 1780422974833
tags:
  - notes
  - agentic-engineering
---

Yang gue pegang dari dokumentasi Honcho adalah satu hal sederhana: ini bukan cuma "database chat". Honcho adalah usaha membuat agent bisa punya state panjang dengan model yang mengerti entitas berubah dari waktu ke waktu.

## Masalah yang Honcho pecahkan

Masalah dasarnya: AI agent sering tidak punya kontinuitas. Agent bisa pintar dalam satu sesi, tapi begitu sesi berubah, dia sering kehilangan konteks. User harus mengulang preferensi, histori keputusan, gaya kerja, batasan, relasi project, dan perubahan dari waktu ke waktu.

Page-nya bilang:

> “Honcho is an open source memory library with a managed service for building stateful agents.”

Kata pentingnya adalah stateful agents. Agent stateless itu seperti kasir yang tiap hari lupa elo siapa. Agent stateful itu seperti partner kerja yang ingat konteks, tapi juga tahu bahwa konteks bisa berubah.

Honcho ingin agent bisa mempertahankan state tentang:

- user
- agent lain
- grup
- ide
- objek
- entitas apa pun yang berubah dari waktu ke waktu

Page-nya eksplisit:

> “It enables agents to build and maintain state about any entity—users, agents, groups, ideas, and more.”

Jadi unit utamanya bukan “dokumen”, tapi entitas.

## Kenapa RAG biasa dianggap kurang cukup?

Honcho mengkritik siklus umum ketika orang membangun agent. Awalnya agent oke. Lalu user mulai komplain: agent lupa, kontradiktif, kehilangan konteks. Developer lalu bikin RAG. Masalah membaik sedikit, tapi muncul masalah baru: chunking, embedding, retrieval strategy, eval, rerank, dan seterusnya.

Page-nya menyimpulkan:

> “Eventually you realize the issue isn’t engineering—it’s that you’re not extracting all the latent information from your data.”

Itu inti argumen Honcho.

Mereka bilang problemnya bukan cuma retrieval pipeline kurang rapi. Problemnya adalah data mengandung latent information: informasi tersembunyi yang tidak tertulis eksplisit, tapi bisa disimpulkan.

Contoh sederhana:

- “Gue lebih suka solusi yang langsung bisa dicoba.”
- “Jangan terlalu banyak teori dulu.”
- “Bikin step-by-step aja.”
- “Kalau bisa pakai contoh real.”

RAG biasa mungkin mengambil kalimat-kalimat itu kalau query-nya cocok. Tapi Honcho ingin menyimpulkan:

“User prefers practical, stepwise explanations with concrete examples over abstract theory.”

Itu bukan kutipan langsung. Itu representasi hasil reasoning.

Atomic idea-nya:

RAG mencari yang pernah dikatakan.

Honcho mencoba membangun apa artinya dari waktu ke waktu.

Kalau ada dua cara melihatnya:

- RAG tradisional fokus ke dokumen dan retrieval.
- Honcho fokus ke entitas dan reasoning.

Itu perbedaan yang bikin gue sadar Honcho bukan alternatif RAG biasa. Honcho mau jadi mesin model sosial/historis, bukan sekadar lemari arsip.

## Model data Honcho

Page menjelaskan empat storage primitives: `workspace`, `peer`, `session`, dan `message`.

### Workspace

Workspace adalah container paling atas.

Page menyebut:

> “Workspaces - Top-level containers that isolate different applications or environments”

Artinya workspace memisahkan environment. Misalnya:

- workspace untuk app customer support
- workspace untuk personal assistant
- workspace untuk coding agent
- workspace untuk organisasi tertentu

Analogi: workspace itu gedung. Di dalamnya ada orang, ruangan, percakapan, dan arsip.

Kenapa penting? Karena memory harus punya boundary. Tanpa boundary, konteks bisa bocor. Agent untuk project A bisa mengambil memory project B. Workspace mencegah campur-aduk level tertinggi.

### Peer

Peer adalah entitas yang punya kontinuitas tapi bisa berubah.

Page menyebut:

> “Peers - Any entity that persists but changes over time (users, agents, objects, and more)”

Ini konsep paling penting di Honcho.

Peer bisa:

- user
- AI agent
- tim
- organisasi
- konsep
- produk
- project
- bahkan ide

Kenapa namanya peer, bukan user? Karena Honcho tidak menganggap hanya manusia yang perlu dimodelkan. Agent juga bisa punya identitas. Grup juga bisa punya state. Ide juga bisa berubah.

Contoh:

- User peer: “Raka”
- Agent peer: “Hermes coder”
- Project peer: “payment migration”
- Team peer: “backend team”

Masing-masing bisa punya representation sendiri.

Ini desain yang kuat untuk multi-agent system. Karena dalam multi-agent, memory bukan cuma “apa yang user suka”, tapi juga:

- agent A tahu apa tentang user
- agent B punya konteks berbeda
- project X punya histori keputusan sendiri
- grup Y punya pola kerja sendiri

## Kenapa konsep peer kuat?

Konsep peer membuat memory lebih simetris.

Banyak sistem memory memperlakukan user sebagai satu-satunya objek yang dimodelkan. Honcho lebih luas: semua entitas bisa dimodelkan sebagai peer.

Ini penting untuk multi-agent.

Misalnya elo punya tiga agent:

- coder agent
- writer agent
- research agent

User-nya sama, tapi tiap agent punya hubungan berbeda dengan user.

Coder agent mungkin tahu:

- “User sering minta security boundary dan sandboxing.”

Writer agent mungkin tahu:

- “User suka gaya gue-elo, tajam, dan Zettelkasten.”

Research agent mungkin tahu:

- “User suka verifikasi sumber dan curiga terhadap klaim tanpa sitasi.”

Kalau semua agent memakai satu memory datar, konteks bisa tercampur. Dengan peer, masing-masing agent bisa punya representation sendiri terhadap user, sambil tetap berbagi workspace.

Ini yang di page Hermes disebut sebagai multi-peer setup: satu user peer, satu AI peer per profile, semua dalam workspace yang sama.

### Session

Session adalah thread interaksi dengan batas temporal.

Page menyebut:

> “Sessions - Interaction threads between peers with temporal boundaries”

Session itu percakapan atau episode.

Misalnya:

- sesi diskusi bug hari Senin
- sesi planning sprint
- sesi debugging production incident
- sesi review dokumen

Session penting karena memory butuh waktu dan konteks. Kalimat yang sama bisa punya arti berbeda tergantung sesi.

Contoh:

“Ini jangan dipakai dulu.”

Kalau di sesi debugging, artinya fitur tertentu berisiko. Kalau di sesi design, artinya ide belum matang. Session membantu Honcho menempatkan pesan ke konteks waktunya.

### Message

Message adalah unit data yang memicu reasoning.

Page menyebut:

> “Messages - Units of data that trigger reasoning (conversations, events, activity, documents, and more)”

Ini juga penting: message tidak harus chat.

Message bisa berupa:

- percakapan
- event
- activity log
- dokumen
- update project
- catatan meeting
- perubahan status

Jadi Honcho bisa menerima data lebih luas dari chat log.

Atomic idea-nya:

Workspace memberi batas.

Peer memberi identitas.

Session memberi konteks waktu.

Message memberi bahan mentah.

Representation adalah hasil olahannya.

## Peer sebagai kunci

Honcho menyebut semua entitas itu "peer" karena mereka diperlakukan setara: semua bisa dimodelkan, semua bisa berubah, semua bisa punya representation sendiri.

Gue suka konsep ini karena dia pas untuk multi-agent. Dalam sistem dengan banyak agent, user bukan satu-satunya pihak yang butuh state. Agent juga perlu model terhadap user, terhadap agent lain, terhadap project, bahkan terhadap ide.

Jadi memory-nya jadi lebih simetris dan bukan cuma "user-centric".

## Dari messages ke representations

Flow dasarnya begini:

1. Agent menulis messages ke Honcho.
2. Honcho menyimpan messages.
3. Background process memproses messages itu.
4. Reasoning model menghasilkan conclusions tentang peer.
5. Conclusions disimpan sebagai representations.
6. Developer atau agent bisa query representation itu untuk memberi konteks ke respons berikutnya.

Page-nya bilang:

> “When you write messages to Honcho, they’re stored and processed in the background.”

Lalu:

> “Custom reasoning models perform formal logical reasoning to generate conclusions about each peer.”

Dan:

> “These conclusions are stored as representations that you can query to provide rich context for your agents.”

Ini berarti Honcho memisahkan data mentah dan hasil interpretasi.

- Message = bukti mentah.
- Conclusion = hasil penalaran.
- Representation = model yang bisa dipakai ulang.

Analogi:

Kalau elo punya transcript meeting, itu message.

Kalau dari transcript itu disimpulkan “client tidak nyaman dengan deadline Q2”, itu conclusion.

Kalau semua conclusion tentang client digabung jadi profil “client ini sensitif terhadap risiko deadline dan butuh komunikasi proaktif”, itu representation.

Ini lebih maju daripada cuma menyimpan transcript dan melakukan semantic search.

## Memory system that reasons

Klaim Honcho adalah: "Honcho is a memory system that reasons."

Maksudnya: Honcho tidak hanya menyimpan dan mengambil. Ia juga memproses data untuk menemukan:

- pola
- kontradiksi
- perubahan preferensi
- relasi antar entitas
- kesimpulan implisit
- prediksi di bawah ketidakpastian

Di bagian "Why Reasoning?", page bilang:

> "Traditional RAG systems retrieve what was explicitly said, but they miss what matters most—the insights only accessible by rigorously thinking about your data."

Ini penting. Honcho mengasumsikan bahwa banyak memory penting tidak pernah muncul sebagai satu kalimat eksplisit. Ia tersebar di banyak interaksi.

Contoh yang bikin gue klik:

- Sesi 1: user minta jawaban ringkas.
- Sesi 2: user mengeluh "ini terlalu textbook."
- Sesi 3: user menyukai analogi konkret.
- Sesi 4: user meminta struktur step-by-step.

Dari situ, sistem bisa menyimpulkan gaya komunikasi user.

RAG bisa retrieve potongan-potongan itu. Tapi reasoning mencoba membuat satu model preferensi yang ringkas.

Jadi "reasoning" di sini adalah upaya mengubah banyak event kecil menjadi state yang lebih bermakna.

## Apa bedanya Honcho dengan memory biasa?

Memory biasa sering berbentuk:

- “User likes dark mode.”
- “User uses Python.”
- “User works on project X.”

Itu fact memory.

Honcho tampaknya ingin naik satu level:

- “User tends to prefer practical explanations, tolerates technical depth, but rejects vague middle-ground answers.”

Ini bukan satu fakta. Ini pola.

Memory biasa menjawab: “Apa yang pernah disimpan?”

Honcho menjawab: “Apa model terbaik tentang entitas ini berdasarkan semua bukti?”

Itulah kenapa di Hermes page sebelumnya Honcho disebut punya:

- user representation
- peer cards
- session-scoped context
- dialectic reasoning
- conclusions

Dalam integrasi Hermes, Honcho bukan cuma provider pencarian memory. Ia menjadi sistem modelling user-agent.

## Apa kelebihan Honcho dibanding provider lain?

Dari page Hermes dan page Honcho, Honcho paling kuat di tiga hal:

Pertama, entity-centric memory.

Fokusnya bukan dokumen, tapi entitas yang berubah.

Kedua, reasoned representation.

Bukan cuma retrieve memory, tapi membangun kesimpulan.

Ketiga, cross-session continuity.

Ia memang didesain untuk agent yang perlu ingat lintas sesi dan tetap coherent.

Jadi Honcho cocok kalau masalah elo adalah:

- “Agent gue sering lupa gue siapa.”
- “Agent gue tidak paham perubahan konteks dari waktu ke waktu.”
- “Agent gue punya banyak sesi dan banyak profile.”
- “Gue butuh agent yang bukan cuma cari fakta, tapi membangun pemahaman tentang user/project.”

## Trade-off dan risiko Honcho

Ini bagian penting. Sistem seperti Honcho powerful, tapi tidak gratis secara desain.

### Risiko 1: Salah menyimpulkan

Kalau reasoning model menyimpulkan hal yang keliru, agent bisa membawa asumsi salah ke banyak sesi berikutnya.

Contoh:

User sekali bilang “gue males teori panjang.”

Honcho bisa salah menyimpulkan “user tidak suka teori.”

Padahal konteksnya mungkin cuma saat itu user sedang buru-buru.

Ini masalah utama memory berbasis reasoning: ia bisa membuat generalisasi terlalu cepat.

### Risiko 2: Memory jadi terlalu otoritatif

Kalau representation disuntikkan ke context, model bisa terlalu percaya pada memory.

Misalnya representation bilang:

“User prefers concise answers.”

Lalu saat user minta dive deep, agent tetap menjawab pendek karena memory lama terlalu dominan.

Memory harus membantu, bukan mengunci user dalam profil lama.

### Risiko 3: Privacy dan data moat

Page Honcho menyebut:

> “help you build data moats”

Secara bisnis ini menarik. Tapi dari sisi user, ini berarti memory menjadi aset data yang sangat berharga dan sensitif.

Kalau Honcho dipakai cloud, data user dan interaction history bisa menjadi bagian dari infrastruktur eksternal. Jadi perlu jelas:

- data apa yang dikirim
- bagaimana disimpan
- bisa dihapus atau tidak
- bagaimana isolasi workspace
- siapa yang punya akses

### Risiko 4: Latency dan cost

Reasoning lebih mahal daripada retrieval biasa. Honcho page memang menyebut developer diberi kontrol atas:

> “token usage, latency, and reasoning depth.”

Artinya sistem ini sadar bahwa reasoning punya biaya.

Di Hermes, ini muncul sebagai knob seperti:

- `contextCadence`
- `dialecticCadence`
- `dialecticDepth`

Semakin sering dan dalam reasoning, semakin kaya konteksnya, tapi semakin mahal/lambat.

Ini juga alasan kenapa Honcho terasa lebih mahal dan lebih berisiko daripada sekadar pipeline retrieval. Jika model reasoning salah, kesimpulan yang disimpan bisa jadi bias dan ditarik ulang ke banyak sesi berikutnya.

## Kapan Honcho cocok

Honcho cocok kalau elo membangun:

1. Personal assistant jangka panjang.
2. Multi-agent system.
3. Agent dengan banyak profile.
4. Customer support agent yang perlu memahami user history.
5. Coaching/tutoring agent yang perlu melacak perkembangan learner.
6. Coding agent yang perlu ingat keputusan project lintas sesi.
7. Research assistant yang perlu membangun model tentang ide, bukan cuma dokumen.

Contoh konkret:

Elo punya Hermes profile:

- `hermes.coder`
- `hermes.writer`
- `hermes.researcher`

Dengan Honcho, tiap profile bisa punya AI peer berbeda. Mereka melihat user yang sama, tapi membangun representation berbeda.

Ini masuk akal karena konteks “gue sebagai programmer” beda dari “gue sebagai penulis” atau “gue sebagai researcher.”

Menurut gue, Honcho paling pas kalau masalahnya adalah:

- agent yang harus mengingat lintas sesi,
- user atau entitas yang berubah seiring waktu,
- multi-agent dengan berbagai profile,
- kebutuhan untuk membangun model preferensi, nilai, atau relasi,
- konteks yang tidak bisa diselesaikan hanya dengan dokumen dan search.

Kalau lo cuma perlu satu fakta sederhana, atau hanya ingin search dokumen, Honcho terasa terlalu besar.

## Kapan Honcho mungkin overkill?

Honcho bisa terlalu berat kalau kebutuhan elo cuma:

- menyimpan beberapa fakta sederhana
- mencari dokumen
- local-only memory sederhana
- tidak butuh user modeling
- tidak butuh multi-agent
- tidak mau data ke cloud
- tidak mau konfigurasi reasoning/cadence/depth

Kalau cuma mau memory lokal sederhana, Holographic atau ByteRover bisa lebih masuk.

Kalau cuma mau semantic recall cloud yang otomatis, Mem0 atau Supermemory bisa lebih simpel.

Kalau mau knowledge base structured, OpenViking atau Hindsight mungkin lebih natural.

Honcho paling masuk kalau masalah elo adalah statefulness + evolving entities + reasoning over time.

## Linking: hubungan antar ide

Sekarang kita sambungkan.

Honcho mulai dari masalah agent stateless.

Untuk membuat agent stateful, ia butuh model data. Model data itu adalah Workspace → Peer → Session → Message.

Message adalah input. Tapi Honcho tidak berhenti di penyimpanan message. Ia melakukan reasoning untuk menghasilkan conclusions. Conclusions itu menjadi representations. Representations lalu dipakai untuk memberi konteks ke agent.

Jadi chain-nya:

**interaksi → message → reasoning → conclusion → representation → context injection → respons agent lebih stateful**

Di sinilah Honcho berbeda dari RAG.

RAG chain-nya biasanya:

**dokumen → chunk → embedding → retrieve → context injection**

RAG kuat untuk menemukan teks relevan. Honcho mencoba membangun state yang lebih abstrak.

Maka pola besarnya:

RAG = memory sebagai pencarian.

Honcho = memory sebagai penalaran berkelanjutan.

## Insight yang penting buat gue

★ Insight ─────────────────────────
Kesalahan umum memahami Honcho adalah mengira ia “RAG yang lebih bagus”.

Lebih tepat: Honcho adalah usaha mengubah memory dari **arsip pasif** menjadi **model aktif tentang entitas**.

Orang sudah mulai paham Honcho kalau ia bisa membedakan tiga lapis ini:

1. Message: apa yang terjadi.
2. Conclusion: apa yang bisa disimpulkan.
3. Representation: model stabil yang dipakai agent ke depan.

Kalau tiga lapis ini belum kebedakan, Honcho akan terlihat seperti database memory biasa.
───────────────────────────────────

Honcho bukan "RAG yang lebih canggih." Honcho adalah sistem yang mencoba mengubah memory dari arsip pasif menjadi model aktif tentang entitas.

Kalau gue belum bisa membedakan tiga lapis ini, maka Honcho akan terasa sama seperti memory biasa:

- message = apa yang terjadi,
- conclusion = apa yang bisa disimpulkan,
- representation = apa yang agent ingat dan pakai.

Itu yang bikin Honcho relevan untuk agent yang harus hidup lebih dari satu sesi.

## Korelasi dengan konsep lain

Konsep paling dekat pertama: CRM.

Kenapa? CRM menyimpan interaksi customer, history, preferensi, status, dan peluang. Honcho mirip CRM untuk agent, tapi lebih fleksibel karena entitasnya bukan cuma customer. Bisa user, agent, ide, project, grup.

Bedanya: CRM biasanya manusia yang membaca dan menyimpulkan. Honcho mencoba membuat reasoning backend menyimpulkan otomatis.

Konsep kedua: Zettelkasten.

Zettelkasten bukan cuma catatan, tapi jaringan ide. Honcho mirip dalam hal ia tidak puas dengan raw note. Ia ingin hubungan, pola, dan representasi.

Bedanya: Zettelkasten biasanya ide-centric. Honcho entity-centric. Pusatnya bukan cuma “ide apa terhubung ke ide apa”, tapi “entitas ini berkembang menjadi apa dari waktu ke waktu.”

Konsep ketiga: event sourcing.

Dalam event sourcing, state aplikasi dibangun dari rangkaian event. Honcho juga mirip: representation adalah state yang dibangun dari messages/events.

Bedanya: event sourcing deterministik. Kalau event-nya sama, state-nya sama. Honcho memakai reasoning model, jadi hasilnya probabilistik dan interpretatif.

Kesimpulan pendeknya: Honcho adalah memory layer untuk agent yang ingin punya kontinuitas, bukan cuma retrieval. Ia cocok ketika “mengingat” berarti memahami perubahan entitas dari waktu ke waktu.

## Related documents

- [[notes.agentic-engineering.hermes-agent.memory-providers]]
- [[notes.agentic-engineering.honcho.architecture]]
- [[notes.agentic-engineering.honcho.reasoning]]
- [[notes.agentic-engineering.honcho.peer-representations]]
