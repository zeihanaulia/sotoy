---
id: notes.agentic-engineering.honcho.architecture
title: Architecture
desc: >-
  Catatan tentang arsitektur data, flow, dan prinsip desain Honcho untuk
  stateful agent memory.
updated: 1780424113432
created: 1780424113432
tags:
  - notes
  - agentic-engineering
  - memory
---

Link: https://honcho.dev/docs/v3/documentation/core-concepts/architecture

"arsitektur Honcho" = cara Honcho menyusun data, memproses message, menjalankan reasoning, lalu menghasilkan context yang bisa dipakai agent. Ini bukan sekadar diagram teknis, tapi juga peta konseptual untuk memahami bagaimana Honcho membangun stateful memory agent yang bisa terus belajar dari interaksi.

Istilah yang perlu dipahami,

- "Peer" = entitas yang dimodelkan Honcho. Bisa user, AI agent, customer, student, NPC, object, atau entity lain.
- "Representation" = model/representasi tentang peer, dibangun dari message lintas session.
- "Session" = konteks interaksi dengan batas waktu, misalnya chat, support ticket, meeting, learning session.
- "Message" = unit data yang masuk ke Honcho. Tidak harus chat; bisa email, dokumen, action log, system notification.
- "Reasoning" = proses background yang mengolah message menjadi logic, summary, insight, conclusion, lalu memperbarui representation.

## 1. Pertanyaan kunci

Untuk ngerti arsitektur Honcho, ada 6 pertanyaan inti:

1. Unit data Honcho apa saja?
2. Kenapa peer jadi pusat arsitekturnya?
3. Bagaimana session membatasi konteks?
4. Bagaimana message masuk lalu diproses?
5. Di mana reasoning terjadi?
6. Bagaimana hasil reasoning dipakai balik oleh agent?

★ Insight ─────────────────────────
Arsitektur Honcho itu bisa dibaca sebagai event-sourcing untuk memory agent, tapi dengan reasoning di tengahnya.

Event-sourcing biasa: event masuk → state diperbarui.

Honcho: message masuk → reasoning jalan → representation peer diperbarui → agent bisa mengambil context yang lebih kaya.

Jadi yang disimpan bukan cuma "riwayat percakapan", tapi juga "state hasil penalaran tentang entitas".
───────────────────────────────────

## 2. Model data: Workspace → Peer / Session → Message

Page-nya bilang Honcho punya hierarchical data model. Relasinya kira-kira begini:

```
Workspace
├── Peers
├── Sessions
└── Messages live inside Sessions, attributed to Peers
```

Tapi relasinya bukan sekadar pohon biasa.

Lebih tepat:

```
Workspace has many Peers
Workspace has many Sessions

Peer can join many Sessions
Session can contain many Peers

Message belongs to a Session
Message is authored/attributed to a Peer
```

Jadi ada relasi many-to-many antara Peers dan Sessions.

Ini penting karena satu user bisa muncul di banyak session, dan satu session bisa melibatkan banyak peer.

Contoh:

```
Workspace: "Customer Support App"

Peer:
- user_123
- support_agent_ai
- billing_agent_ai

Session:
- ticket_001
- ticket_002
- refund_discussion

Messages:
- user_123: "Tagihan gue dobel."
- billing_agent_ai: "Gue cek invoice-nya."
```

Dari message-message itu, Honcho bisa membangun representation tentang `user_123`, `billing_agent_ai`, atau bahkan relasi antar peer.

## 3. Workspace: batas isolasi paling atas

Workspace adalah container paling atas.

Page menjelaskan workspace sebagai:

> "top-level containers"
> "complete isolation between different applications or environments"
> "namespace to keep different workloads separate"

Artinya workspace dipakai untuk memisahkan data.

Misalnya:

```
workspace_dev
workspace_staging
workspace_production
```

Atau untuk SaaS multi-tenant:

```
workspace_customer_A
workspace_customer_B
workspace_customer_C
```

Atomic idea-nya:

Workspace menjawab pertanyaan: **memory ini hidup di dunia yang mana?**

Tanpa workspace, memory mudah bocor antar aplikasi, customer, atau environment.

Jadi workspace bukan cuma folder. Ia juga boundary untuk:

- data isolation
- authentication
- workspace-wide configuration
- multi-tenant separation

Kalau elo bikin app AI untuk banyak customer, workspace bisa jadi cara menjaga agar memory customer A tidak nyampur ke customer B.

## 4. Peer: pusat dari seluruh arsitektur

Page-nya bilang:

> “Peers are the most important entity in Honcho—everything revolves around building and maintaining their representations.”

Jadi arsitektur Honcho itu **peer-centric**.

Bukan document-centric.
Bukan conversation-centric.
Bukan user-only-centric.

Tapi peer-centric.

Peer adalah entitas yang bisa berubah dari waktu ke waktu dan perlu direpresentasikan.

Contoh peer:

```
Human:
- user_raka
- customer_392
- student_17

Agent:
- coding_agent
- writing_agent
- support_agent

Other entity:
- project_alpha
- backend_team
- npc_blacksmith
- product_checkout_flow
```

Kenapa ini desain yang kuat?

Karena memory agent sering salah kalau cuma disusun sebagai chat history. User bisa ngobrol di banyak session. Agent bisa muncul di banyak context. Project bisa berkembang lintas percakapan.

Peer membuat Honcho bisa bilang:

“Semua interaksi tentang entitas ini, walau tersebar di banyak session, tetap bisa menyumbang ke representation entitas itu.”

Contoh:

```
Session 1:
User bilang suka jawaban praktis.

Session 2:
User menolak jawaban yang terlalu normatif.

Session 3:
User meminta breakdown teknis.

Representation user:
User prefers practical, direct, technically grounded explanations.
```

Itu lintas session. Kuncinya ada di peer.

## 5. Session: batas temporal untuk interaksi

Session adalah thread atau konteks interaksi.

Page-nya bilang session memberi:

> “temporal boundaries for when a set of interactions starts and ends”

Jadi session menjawab: **interaksi ini terjadi dalam episode apa?**

Contoh session:

```
support_ticket_778
meeting_transcript_2026_06_03
learning_session_math_01
chat_about_architecture
incident_review_payment_api
```

Kenapa session penting?

Karena message yang sama bisa punya makna berbeda tergantung konteks.

Contoh kalimat:

```
"Jangan deploy dulu."
```

Di session incident, itu bisa berarti ada risiko produksi.
Di session planning, itu bisa berarti requirement belum siap.
Di session experiment, itu bisa berarti tunggu benchmark.

Session menjaga konteks lokal. Tapi peer menjaga kontinuitas global.

Jadi relasinya:

```
Session = konteks episode
Peer = identitas lintas episode
```

Ini link penting.

Kalau cuma ada session, agent ingat episode tapi tidak punya identitas jangka panjang.

Kalau cuma ada peer tanpa session, semua event tercampur tanpa konteks temporal.

Honcho pakai dua-duanya.

## 6. Message: unit atomik yang memicu reasoning

Message adalah unit data paling dasar.

Page-nya bilang message bisa berupa:

> “emails, documents, files, user actions, system notifications, or rich media content.”

Jadi message di Honcho bukan hanya chat bubble.

Ini penting karena Honcho bisa dipakai sebagai ingestion layer untuk banyak data:

```
Chat:
User: "Gue lebih suka jawaban step-by-step."

Email:
Subject: "Project deadline moved to Friday."

Action log:
User clicked "cancel subscription."

Document:
Meeting notes about product roadmap.

System notification:
Payment failed twice.
```

Setiap message punya dua properti penting:

Pertama, ia **diatribusikan ke peer tertentu**.

Kedua, ia **diurutkan secara kronologis dalam session**.

Jadi Honcho tahu:

```
siapa mengatakan/melakukan apa

di session mana

dalam urutan waktu apa
```

Begitu message dibuat, ia memicu background reasoning.

Ini inti flow arsitektur.

## 7. Data flow: dari message ke representation

Arsitektur runtime Honcho bisa dipahami dalam dua jalur:

1. Write path: data masuk.
2. Read path: context keluar.

### Write path

Saat elo membuat message:

```
Message created
→ written immediately to PostgreSQL
→ reasoning task masuk background queue
→ background worker memproses
→ logic / summaries / insights dibuat
→ conclusions disimpan
→ peer representation diperbarui
→ vector collection diisi untuk retrieval
```

Page-nya bilang:

> “When you create messages, they’re immediately written to PostgreSQL and reasoning tasks are added to background queues.”

Ini menunjukkan desain **async by default**.

Kenapa async?

Supaya write cepat. Agent/app tidak perlu menunggu semua reasoning selesai hanya untuk menyimpan message.

Misalnya user baru mengirim chat. Sistem langsung simpan dulu. Reasoning yang lebih berat jalan di belakang.

Atomic idea:

```
PostgreSQL = source of raw interaction data
Background queue = buffer untuk kerja berat
Workers = mesin reasoning
Vector collections = tempat hasil reasoning dicari ulang
Representations = state tentang peer
```

### Read path

Saat agent butuh context:

```
Agent calls Chat endpoint / Get Context endpoint
→ Honcho retrieves relevant conclusions from vector storage
→ Honcho also pulls recent messages
→ Honcho assembles coherent context
→ context injected into agent prompt
```

Page-nya bilang:

> “Honcho retrieves relevant conclusions from vector storage along with recent messages, then assembles everything into coherent context ready to inject into agent prompts.”

Ini penting.

Honcho tidak cuma mengembalikan memory mentah. Ia menggabungkan:

- recent messages
- relevant conclusions
- peer representation
- context yang sudah dirakit

Jadi output-nya bukan sekadar search result, tapi context package untuk agent.

## 8. Dua jenis data: regular data vs reasoned-over data

Di diagram page, dijelaskan:

- black arrows = read/write regular data
- red arrows = read/write reasoned-over data

Terjemahan gampangnya:

Regular data:

```
messages
sessions
peers
workspace records
raw storage
```

Reasoned-over data:

```
logic
summaries
insights
conclusions
peer representations
```

Ini pemisahan penting.

Karena Honcho memisahkan:

```
apa yang benar-benar terjadi
vs
apa yang disimpulkan dari yang terjadi
```

Contoh:

Regular data:

```
User said: "Gue gak suka jawaban yang muter-muter."
```

Reasoned-over data:

```
User values directness and dislikes hedging.
```

Keduanya beda.

Yang pertama bukti.
Yang kedua interpretasi.

Arsitektur yang sehat harus menjaga dua lapis ini terpisah, karena interpretasi bisa salah dan perlu diperbarui.

## 9. Configuration: cascade dari workspace ke peer ke session

Page bilang setting Honcho:

> “cascade hierarchically from workspace to peer to session”

Artinya konfigurasi bisa punya default di atas, lalu dioverride di bawah.

Strukturnya:

```
Workspace config
  ↓
Peer config override
  ↓
Session config override
```

Contoh:

```
Workspace:
reasoning enabled by default

Peer: support_agent_ai
reasoning depth = medium

Session: urgent_ticket_999
perspective tracking disabled
```

Ini penting karena tidak semua konteks butuh reasoning yang sama.

Misalnya:

- production support ticket butuh detail tinggi
- casual chat tidak perlu reasoning berat
- agent tertentu boleh dimodelkan
- agent lain tidak perlu dimodelkan
- session tertentu butuh perspective-taking
- session lain cukup raw recall

Atomic idea:

Konfigurasi Honcho mengikuti prinsip **default global, override lokal**.

## 10. Extensibility: bawa LLM sendiri, metadata sendiri

Page menyebut Honcho bisa:

- pakai OpenAI
- pakai Anthropic
- pakai custom endpoints
- memakai metadata JSON
- batch create sampai 100 messages per API call

Artinya arsitekturnya tidak dikunci ke satu model provider.

Ini penting untuk dua alasan:

Pertama, cost control. Elo bisa pilih model reasoning yang lebih murah atau lebih kuat.

Kedua, compliance/control. Company mungkin butuh endpoint sendiri.

JSON metadata juga penting. Karena use case memory tidak selalu sama.

Contoh metadata:

```
{
  "source": "gmail",
  "thread_id": "abc123",
  "importance": "high",
  "document_type": "meeting_notes"
}
```

Atau:

```
{
  "source": "app_event",
  "event_type": "subscription_cancelled",
  "plan": "pro"
}
```

Dengan JSONB-style metadata, message tidak cuma teks; dia bisa membawa struktur.

## 11. Design principles Honcho

Page menyebut beberapa prinsip desain. Kita bedah satu-satu.

### Peer-centric

Semua berputar pada representation peer.

Maknanya:

```
memory bukan disusun berdasarkan file atau chat,
tapi berdasarkan entitas yang perlu dipahami.
```

Ini cocok untuk agent yang harus memahami manusia, agent lain, grup, project, atau customer.

### Reasoning-first

Page bilang memory bukan cuma storage, tapi continual learning.

Maknanya:

```
data masuk bukan hanya disimpan,
tapi diproses untuk memperbaiki representation.
```

Ini beda dari database biasa.

### Async by default

Long-lived operation jalan di background.

Maknanya:

```
user interaction tetap cepat,
reasoning berat tidak memblokir request utama.
```

Trade-off-nya: representation mungkin tidak langsung update sempurna saat itu juga.

### Provider-agnostic

Bisa pakai berbagai LLM provider.

Maknanya:

```
Honcho tidak sepenuhnya bergantung pada satu vendor model.
```

### Multi-tenant

Dibangun untuk isolasi dan scalability.

Maknanya:

```
workspace bisa memisahkan customer/app/environment.
```

### Unified paradigm

User dan agent sama-sama peer.

Maknanya:

```
Honcho tidak memakai model kaku "user vs assistant",
tapi semua entitas diperlakukan sebagai peer.
```

Ini membuka skenario multi-agent dan group interaction.

## 12. Contoh arsitektur dalam kasus nyata

Misal elo bikin coding assistant jangka panjang.

```
Workspace:
personal_dev_assistant

Peers:
- user_raka
- coding_agent
- project_codex_sandbox

Sessions:
- session_debug_sandbox_exec
- session_review_security
- session_setup_codex
```

Message masuk:

```
user_raka:
"Sandbox macOS bisa block file access tapi env variable tetap kebaca."

coding_agent:
"Workaround-nya bersihkan environment sebelum menjalankan proses."

user_raka:
"Setup codex harus global atau per repo?"
```

Honcho menyimpan messages ke PostgreSQL.

Lalu background reasoning bisa menyimpulkan:

```
Representation user_raka:
- cares about sandbox boundaries
- concerned with secret leakage
- prefers practical setup guidance
- is comparing per-project vs global config
```

Representation project_codex_sandbox:

```
- focus: macOS sandbox-exec profiles
- unresolved concern: env secret isolation
- next likely need: repo-level config strategy
```

Saat session baru dimulai seminggu kemudian dan user nanya:

```
"lanjut yang sandbox kemarin"
```

Agent bisa query Honcho, lalu mendapat context bahwa “sandbox kemarin” terkait file access boundary, env secret leak, dan Codex setup.

Ini yang dimaksud stateful.

## 13. Perbandingan dengan RAG biasa

RAG biasa:

```
Documents
→ chunks
→ embeddings
→ vector search
→ retrieved text
→ prompt injection
```

Honcho:

```
Messages
→ peer/session attribution
→ PostgreSQL storage
→ background reasoning
→ conclusions/insights
→ vector retrieval
→ peer representation
→ coherent context
→ prompt injection
```

Bedanya bukan cuma ada vector search. Honcho tetap pakai vector collections, tapi vector search-nya dipakai atas **hasil reasoning**, bukan cuma raw chunks.

Atomic distinction:

```
RAG retrieves evidence.
Honcho maintains state.
```

Atau lebih tajam:

```
RAG menjawab: "bagian mana yang relevan?"
Honcho menjawab: "apa yang sekarang kita pahami tentang peer ini?"
```

## 14. Trade-off arsitektur Honcho

Arsitektur ini kuat, tapi punya konsekuensi.

### Trade-off 1: Async berarti eventual consistency

Karena reasoning jalan di background, representation bisa tertinggal sedikit dari message terbaru.

Kalau user baru saja menyampaikan preferensi penting, belum tentu representation langsung berubah pada detik itu juga.

### Trade-off 2: Reasoned data bisa salah

Raw message lebih objektif. Conclusion lebih berguna, tapi interpretatif.

Kesalahan bisa terjadi di tahap:

```
message interpretation
summary generation
logic extraction
insight creation
representation update
retrieval
context assembly
```

Jadi developer perlu mekanisme audit, correction, atau feedback.

### Trade-off 3: Peer-centric bagus untuk entity modelling, tapi butuh desain ID yang rapi

Kalau peer ID berantakan, memory juga berantakan.

Misalnya user yang sama dibuat sebagai:

```
raka
user_raka
raka_123
raka@gmail.com
```

Honcho bisa membangun representation terpisah padahal entitasnya sama.

Jadi identity management penting.

### Trade-off 4: Workspace isolation bagus, tapi bisa bikin memory fragmented

Kalau terlalu banyak workspace, memory yang seharusnya saling membantu bisa terpisah.

Kalau terlalu sedikit workspace, risiko data campur.

Jadi boundary workspace harus dirancang matang.

## 15. Linking: satu peta utuh

Sekarang kita sambungkan semua.

Workspace memberi batas dunia.

Di dalamnya ada peer, yaitu entitas yang mau dipahami.

Peer masuk ke banyak session, karena entitas yang sama bisa muncul di banyak episode.

Di setiap session, peer mengirim message.

Message disimpan sebagai raw data di PostgreSQL.

Message juga memicu background reasoning.

Reasoning menghasilkan logic, summary, insight, conclusion.

Hasil ini masuk ke vector collections dan memperbarui representation peer.

Saat agent butuh menjawab, agent mengambil context dari Chat/Get Context endpoint.

Honcho menggabungkan recent messages + relevant conclusions + representation menjadi context yang siap disuntikkan ke prompt.

Jadi loop besarnya:

```
interaction
→ message
→ reasoning
→ representation
→ context
→ better interaction
→ more message
→ refined representation
```

Itulah kenapa Honcho disebut continual learning system.

## 16. Insight penutup

★ Insight ─────────────────────────
Kesalahan umum memahami arsitektur Honcho adalah mengira “message disimpan, lalu nanti dicari lagi”.

Itu cuma separuh cerita.

Arsitektur Honcho sebenarnya membuat message menjadi bahan baku untuk membangun **state tentang peer**. Jadi unit paling penting bukan message, tapi representation yang terus diperbarui.

Elo sudah paham arsitektur Honcho kalau bisa membedakan:

1. raw interaction: message
2. temporal boundary: session
3. identity boundary: peer
4. isolation boundary: workspace
5. learned state: representation
6. runtime output: context untuk agent
───────────────────────────────────

## 17. Korelasi dengan konsep lain

Yang paling dekat: **event sourcing**.

Kesamaannya: state dibangun dari event.

```
Event sourcing:
events → projection/state

Honcho:
messages → reasoning → peer representation
```

Bedanya: event sourcing biasanya deterministik. Honcho memakai reasoning model, jadi state-nya interpretatif.

Korelasi kedua: **CRM**.

CRM menyimpan customer history dan membantu manusia memahami customer. Honcho melakukan hal mirip untuk agent, tapi lebih generik: bukan cuma customer, semua peer bisa dimodelkan.

Korelasi ketiga: **Zettelkasten**.

Zettelkasten membangun pemahaman dari relasi antar catatan. Honcho membangun pemahaman dari relasi antar message, session, dan peer. Bedanya, Zettelkasten biasanya note-centric; Honcho peer-centric.

Kesimpulan singkatnya: **arsitektur Honcho adalah sistem memory berbasis peer, session, message, dan background reasoning untuk membangun representation yang bisa dipakai agent sebagai context lintas sesi.**

## Related documents

- [[notes.agentic-engineering.honcho.stateful-memory]]
- [[notes.agentic-engineering.honcho.reasoning]]
- [[notes.agentic-engineering.honcho.peer-representations]]
- [[notes.agentic-engineering.honcho.design-patterns]]
