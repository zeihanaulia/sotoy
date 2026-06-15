---
id: notes.agentic-engineering.honcho.design-patterns
title: "Honcho Design Patterns"
desc: "Panduan desain practical untuk memetakan aplikasi nyata ke struktur Honcho: workspace, peer, session, dan observation."
updated: 1780426513418
created: 1780426228424
tags:
  - notes
  - agentic-engineering
  - memory
---

Arti yang gue pakai: **“design pattern” di page ini = pola desain praktis untuk memetakan aplikasi nyata ke struktur Honcho: workspace, peer, session, observe_me, observe_others, dan cross-session context**. Bukan design pattern klasik software seperti Factory, Observer, Strategy.

Istilah yang perlu dikunci dulu:

- “Workspace” = batas isolasi keras. Kalau beda workspace, memory tidak saling campur.
- “Peer” = entitas persisten yang ingin diberi identitas dan bisa direasoning: user, agent, customer, student, NPC.
- “Session” = konteks interaksi aktif: chat thread, channel, support ticket, project, import batch.
- “observe_me” = Honcho membangun representation tentang peer itu sendiri.
- “observe_others” = peer membangun representation tentang peer lain berdasarkan interaksi yang ia saksikan.
- “peer_target” = cara membuat `session.context()` memasukkan memory lintas sesi dari peer tertentu, bukan cuma konteks session lokal.

## 1. Pertanyaan kunci

Ada 7 pertanyaan inti dari page ini:

1. Kapan bikin workspace baru?
2. Kapan beberapa agent harus berbagi workspace?
3. Siapa yang harus dijadikan peer?
4. Bagaimana memilih peer ID yang benar?
5. Session harus diskop berdasarkan apa?
6. Kapan pakai `observe_me` dan `observe_others`?
7. Apa kesalahan desain paling sering?

★ Insight ─────────────────────────
Page ini sebenarnya ngajarin satu prinsip besar: **memory yang bagus bukan dimulai dari retrieval, tapi dari boundary design**.

Kalau boundary workspace salah, memory bocor atau terfragmentasi.
Kalau peer ID salah, identitas pecah.
Kalau session terlalu kecil, reasoning tidak jalan efektif.
Kalau observation salah, agent bisa jadi terlalu tahu atau reasoning compute kebuang.

Jadi “design pattern” Honcho bukan kosmetik. Ini fondasi supaya memory agent tidak jadi lumpur konteks.
───────────────────────────────────

## 2. Quick reference: satu kalimat inti

Page-nya memberi ringkasan yang sangat padat:

> “Workspaces isolate, peers persist, and sessions scope the active context.”

Ini kalimat paling penting di seluruh page.

Pecahannya:

```
Workspace = memisahkan dunia
Peer = menjaga identitas lintas waktu
Session = membatasi konteks aktif
```

Kalau elo salah memahami tiga ini, semua desain memory jadi kacau.

Contoh:

```
Workspace:
"aplikasi/customer/environment mana?"

Peer:
"siapa/apa entitas yang sama dari waktu ke waktu?"

Session:
"interaksi ini episode apa?"
```

Jadi sebelum mikir retrieval, embedding, atau LLM, pertanyaan desain pertama adalah:

```
Apa boundary-nya?
Apa identity-nya?
Apa episode-nya?
```

## 3. Workspace design: kapan harus dipisah?

Workspace adalah **hard isolation boundary**.

Page bilang:

> “A workspace is a hard isolation boundary.”

Artinya kalau dua hal harus benar-benar tidak saling melihat memory, pisahkan workspace.

Pattern default-nya:

```
Satu workspace per application.
```

Pisah workspace hanya kalau ada boundary nyata:

- beda produk
- beda customer/tenant
- beda environment: dev/staging/prod
- beda compliance/privacy boundary
- beda agent yang memang tidak boleh saling memengaruhi memory

Contoh bagus:

```
workspace_prod_customer_A
workspace_prod_customer_B
```

atau:

```
workspace_my_ai_coding_app_prod
workspace_my_ai_coding_app_dev
```

Kesalahan umum: terlalu cepat memisahkan workspace.

Misalnya elo punya coding agent, writing agent, dan research agent yang semuanya membantu user yang sama dalam project yang sama. Kalau mereka dipisah workspace, mereka tidak bisa berbagi konteks.

Page bilang:

> “Agents that collaborate over the same product, user, or game state belong in the same workspace so each can retrieve what the others produced.”

Atomic idea-nya:

```
Pisahkan workspace untuk isolasi.
Satukan workspace untuk kolaborasi.
```

Jangan kebalik.

## 4. Workspace dalam multi-agent

Kalau beberapa agent bekerja pada hal yang sama, mereka sebaiknya satu workspace.

Contoh:

```
Workspace: project_alpha

Peers:
- user_raka
- planner_agent
- coder_agent
- reviewer_agent
```

Kenapa satu workspace?

Karena planner agent bisa membuat keputusan, coder agent mengeksekusi, reviewer agent mengecek. Mereka butuh shared memory.

Kalau dipisah workspace:

```
planner_agent tidak tahu keputusan coder_agent
reviewer_agent tidak tahu konteks planner_agent
user harus mengulang semua konteks
```

Tapi kalau agent tidak boleh saling memengaruhi, pisahkan.

Contoh:

```
workspace_customer_A_support
workspace_customer_B_support
```

Customer A tidak boleh melihat atau dipengaruhi memory Customer B.

Jadi rule-nya:

```
Shared state → same workspace
Hard isolation → separate workspace
```

## 5. Peer design: siapa yang harus jadi peer?

Page bilang:

> “Any persistent participant whose messages should be attributed or reasoned about.”

Jadi peer adalah entitas yang:

- punya identitas berkelanjutan
- muncul di banyak interaksi
- message-nya perlu diatribusikan
- perilaku/preferensinya perlu dipahami

Contoh peer:

```
users
agents
assistants
NPCs
students
customers
```

Bisa juga entitas non-manusia kalau memang persisten:

```
project_alpha
repository_backend
game_world_state
support_customer_123
```

Tapi hati-hati: jangan semua hal dijadikan peer. Kalau entitas tidak perlu dimodelkan, cukup simpan sebagai metadata atau message content.

Atomic distinction:

```
Peer = entitas yang ingin dipahami lintas waktu.
Metadata = atribut pendukung.
Message = event/data yang terjadi.
```

Contoh salah:

```
Peer:
- button_click
- page_view
- notification_01
```

Itu lebih cocok jadi message/event, bukan peer.

Contoh benar:

```
Peer:
- user_123
- support_agent
- customer_account_456
```

## 6. Peer ID: satu entitas, satu ID stabil

Ini salah satu poin paling praktis.

Page bilang:

> “Give each real-world entity one stable peer ID and reuse it everywhere.”

Kenapa? Karena peer ID adalah jangkar representation.

Kalau satu orang dibuat dengan banyak ID:

```
alice
alice-discord
alice-slack
alice-web
```

Honcho akan membangun tiga atau empat representation berbeda.

Akibatnya:

```
memory Alice di Discord tidak nyambung ke Alice di web
agent melihat Alice sebagai beberapa orang berbeda
cross-session continuity rusak
```

Page menyebut ini sebagai common mistake:

> “Splitting one identity across peer IDs.”

Pattern yang sehat:

```
Peer ID utama:
user_12345
```

Lalu channel source disimpan sebagai metadata atau alias:

```
{
  "aliases": ["alice", "alice_discord", "alice_slack"],
  "discord_id": "491827364",
  "slack_id": "U123"
}
```

Kalau app multi-channel, page menyarankan prefix ID by source, misalnya:

```
discord_491827364
```

Tapi ini perlu dibaca hati-hati. Prefix by source bagus kalau identitas memang hanya pasti di level source. Kalau elo sudah tahu Discord user dan Slack user itu orang yang sama, lebih baik satukan ke satu stable canonical ID, lalu simpan source ID sebagai alias.

Atomic rule:

```
Kalau mau unified memory, satu entitas harus punya satu canonical peer ID.
```

## 7. Peer card dan alias

Page menyebut kalau peer punya banyak nama, simpan alias di peer card dengan `set_card()` / `setCard()`.

Ini penting karena nama manusia tidak stabil:

```
Raka
raka.dev
@raka_ai
raka@gmail.com
```

Kalau semua jadi peer ID terpisah, memory pecah.

Lebih baik:

```
peer_id: user_raka_001

peer_card:
name: Raka
aliases:
- raka.dev
- @raka_ai
- raka@gmail.com
```

Dengan begitu representation tetap satu, tapi Honcho tetap tahu variasi identitasnya.

## 8. Session design: session harus diskop berdasarkan apa?

Session adalah temporal boundary. Page bilang session memengaruhi:

```
- bagaimana summaries dibuat
- bagaimana context diambil
- kapan reasoning fires
```

Jadi session bukan sekadar “chat id”. Session adalah keputusan desain: konteks lokal ini harus terus nyambung atau reset?

Page memberi beberapa pattern umum.

### Pattern 1: Per-conversation

Session = setiap chat thread baru.

Contoh:

```
ChatGPT-style UI
Claude Code thread
satu percakapan = satu session
```

Cocok kalau setiap thread punya konteks berbeda dan wajar direset.

### Pattern 2: Per-channel

Session = channel/room persistent.

Contoh:

```
Discord channel
Slack thread
group room
```

Cocok kalau konteks channel memang terus akumulatif.

Misalnya channel `#project-alpha` berisi diskusi ongoing. Jangan bikin session baru tiap pesan, karena konteksnya harus mengalir.

### Pattern 3: Per-interaction

Session = satu task atau encounter yang bounded.

Contoh:

```
support ticket
game encounter
appointment
sales call
```

Cocok kalau ada awal dan akhir yang jelas.

### Pattern 4: Per-project

Session = work area persisten.

Contoh:

```
coding agent memory untuk satu repository
```

Cocok untuk agent coding. Satu repo bisa punya memory berkelanjutan: keputusan arsitektur, bug, test, convention, setup.

### Pattern 5: Per-import

Session = batch external data.

Contoh:

```
import email
import dokumen
import meeting transcripts
```

Cocok kalau elo mau mengaitkan data eksternal ke peer tertentu tanpa menjadikannya chat normal.

## 9. Kapan bikin session baru vs reuse session?

Page memberi rule:

> “Create a new session when context resets ... reuse one when context should keep accumulating.”

Terjemahan praktis:

Bikin session baru kalau:

```
- percakapan baru
- topik baru
- hari baru, kalau konteks harian penting
- support ticket baru
- task run baru
- konteks lama tidak perlu dibawa secara lokal
```

Reuse session kalau:

```
- channel ongoing
- persistent thread
- project/repo yang sama
- konteks lokal harus terus bertambah
- low-volume input yang kalau dipecah terlalu kecil
```

Ini bukan sekadar rapi. Ini memengaruhi reasoning.

## 10. Jangan bikin session terlalu tipis

Page memberi warning penting:

> “Don’t scope sessions too thin.”

Alasannya: Honcho baru melakukan reasoning atas peer setelah akumulasi kira-kira **~1.000 token dalam satu session**.

Kalau elo bikin banyak session kecil:

```
session_1: 80 token
session_2: 120 token
session_3: 50 token
session_4: 90 token
```

Reasoning bisa tertunda karena masing-masing tidak melewati threshold.

Page bilang:

> “Many tiny sessions each stall below that threshold.”

Artinya data tidak hilang, tapi reasoning menunggu. Efeknya: representation lambat update.

Atomic idea:

```
Session terlalu kecil = konteks lokal pecah + reasoning bisa stall.
Session terlalu besar = konteks bisa terlalu campur.
```

Jadi pilih boundary yang natural.

Untuk trickle inputs, misalnya user action log kecil-kecil, lebih baik append ke ongoing session daripada bikin session baru tiap event.

## 11. Cross-session reasoning: session memory vs peer memory

Ini bagian yang sering bikin salah paham.

Page menjelaskan:

```
Session memory = lokal ke satu interaction.
Peer memory / representation = akumulasi lintas semua session yang melibatkan peer.
```

Jadi ada dua level memory:

```
Session-level:
"apa yang terjadi di episode ini?"

Peer-level:
"apa yang kita pahami tentang entitas ini dari semua episode?"
```

Contoh:

```
Session A:
User bahas sandboxing.

Session B:
User bahas Honcho memory.

Session C:
User bahas ekonomi Indonesia.
```

Session memory masing-masing tetap lokal. Tapi peer representation bisa menangkap pola lintas semuanya:

```
User likes deep structured analysis, compares systems via trade-offs, and cares about reliability.
```

## 12. `session.context()` dan `peer_target`

Page menyebut common mistake:

> “Forgetting peer_target on session context.”

Ini krusial.

`session.context()` secara default mengembalikan konteks session aktif:

```
summary session ini
recent messages session ini
```

Tapi kalau elo ingin cross-session memory, perlu menambahkan `peer_target`.

Page bilang:

> “It becomes cross-session only through adding a peer_target which includes the peer representation.”

Jadi:

```
Tanpa peer_target:
ambil konteks lokal session ini saja.

Dengan peer_target:
ambil konteks session ini + representation lintas sesi dari peer target.
```

Contoh:

```
User: "lanjut yang kemarin"
```

Kalau agent hanya pakai session context lokal, bisa bingung.

Kalau agent pakai `peer_target=user_raka`, Honcho bisa memasukkan long-term representation user itu.

Atomic rule:

```
Mau memory lintas sesi? Jangan cuma panggil session.context().
Tambahkan peer_target.
```

## 13. `observe_me`: kapan dimatikan?

Page bilang:

> “Should I set observe_me: false? Yes, for deterministic peers Honcho does not need to model, like bots or tool agents.”

Default-nya `observe_me` aktif. Artinya Honcho membangun representation tentang peer itu.

Tapi untuk peer deterministic, sering tidak perlu.

Contoh peer yang bisa `observe_me: false`:

```
calculator_tool
weather_bot
retrieval_bot
static_assistant
scripted_agent
```

Kenapa dimatikan?

Karena Honcho tidak perlu membangun model tentang sesuatu yang perilakunya sudah dikontrol dan tidak berevolusi.

Kalau dibiarkan aktif:

```
- reasoning compute terbuang
- representation noise bertambah
- biaya naik
```

Tapi message dari peer itu tetap bisa disimpan agar peer lain punya session context.

Ini nuance penting:

```
observe_me false ≠ jangan simpan message.
observe_me false = jangan reason about peer itu sebagai entitas.
```

## 14. Kapan `observe_me` tetap aktif?

Untuk peer yang berubah atau perlu dipahami.

Contoh:

```
user
student
customer
evolving agent
creative assistant
NPC dengan karakter berkembang
```

Kalau user adalah peer utama, biasanya `observe_me` harus aktif.

Karena tujuan Honcho adalah membangun representation tentang user dari waktu ke waktu.

## 15. `observe_others`: kapan dipakai?

Page bilang:

> “Do I need observe_others? Only when a peer needs its own perspective on another participant.”

Ini tidak perlu dinyalakan semua tempat.

Gunakan `observe_others` kalau butuh perspektif relatif.

Contoh:

```
games
multi-agent systems
parent/subagent workflows
group chat simulation
```

Misalnya:

```
Bob hanya tahu Alice dari session 1 dan 2.
Charlie hanya tahu Alice dari session 3.
```

Maka Bob’s representation of Alice dan Charlie’s representation of Alice harus beda.

Ini penting untuk simulation realism dan trust.

Kalau semua peer tahu semua hal, agent jadi omniscient.

## 16. Jangan nyalakan `observe_others` sembarangan

Common mistake dari page:

> “Turning on observe_others everywhere.”

Kenapa salah?

Karena directional representations kuat, tapi kompleks.

Kalau setiap peer mengamati setiap peer lain, jumlah representation bisa meledak.

Contoh session dengan 10 peer:

```
Setiap peer bisa punya representation tentang 9 peer lain.
```

Itu menambah:

```
- compute
- storage
- retrieval complexity
- risiko perspective leakage
- maintenance cost
```

Jadi gunakan hanya kalau memang perlu “siapa tahu apa tentang siapa”.

Untuk banyak aplikasi biasa, cukup model user sebagai peer, tidak perlu setiap agent membangun representation tentang agent lain.

## 17. Common mistakes: bedah satu-satu

### Mistake 1: Splitting one identity across peer IDs

Ini bikin memory pecah.

Salah:

```
alice
alice-discord
alice-cursor
alice-web
```

Benar:

```
user_alice_001
aliases: alice, alice-discord, alice-cursor, alice-web
```

Kalau memang ingin unified memory, satu entitas harus satu peer.

### Mistake 2: Too many tiny sessions

Ini bikin local context fragmented dan reasoning bisa stall di bawah ~1.000 token.

Salah:

```
session per message
session per small event
session per tiny import row
```

Benar:

```
session per ongoing channel
session per support ticket
session per project
session per import batch
```

### Mistake 3: Separating agents that should collaborate

Kalau agent perlu shared product/customer/team context, taruh di workspace sama.

Salah:

```
planner_workspace
coder_workspace
reviewer_workspace
```

padahal ketiganya kerja di project sama.

Benar:

```
workspace_project_alpha
peers: planner, coder, reviewer
```

### Mistake 4: Leaving observe_me on for assistants

Kalau assistant deterministic dan elo tidak perlu modelnya, matikan.

Salah:

```
observe_me aktif untuk calculator_bot
```

Benar:

```
observe_me false untuk deterministic tool agent
```

### Mistake 5: Turning on observe_others everywhere

Gunakan hanya kalau butuh perspective-taking.

Salah:

```
semua peer mengamati semua peer lain
```

Benar:

```
hanya peer yang butuh perspektif stateful terhadap peer lain
```

### Mistake 6: Forgetting peer_target

Kalau mau cross-session context tapi tidak pakai `peer_target`, agent cuma dapat session-local context.

Salah:

```
session.context()
```

Benar:

```
session.context(peer_target=user_id)
```
```
Konsepnya, bukan syntax presisi.

### Mistake 7: Blocking on processing

Page bilang messages diproses async.

Jangan polling atau menunggu reasoning selesai sebelum app lanjut.

Salah:

```
save message
wait until reasoning done
then respond
```

Benar:

```
save message
continue app flow
let reasoning update in background
use available context opportunistically
```

Trade-off-nya: context terbaru mungkin belum langsung tersedia. Tapi app tetap responsif.

## 18. Pattern untuk use case nyata

### Use case: personal AI across tools

Misalnya elo pakai Claude Code, Cursor, OpenCode, dan app sendiri.

Pattern:

```
Workspace:
shared_personal_workspace

Peer:
same user peer ID everywhere

Sessions:
per repo / per conversation / per task
```

Tujuannya: unified memory.

Kalau tiap plugin pakai workspace dan peer ID berbeda, memory pecah.

### Use case: coding agent per repository

Pattern:

```
Workspace:
coding_assistant

Peers:
user
coding_agent
repo_project_alpha

Sessions:
per-project atau per-repo
```

Kalau repo butuh memory panjang, pakai session per-project/repo. Kalau tiap task dibuat session kecil, keputusan arsitektur bisa terfragmentasi.

### Use case: customer support SaaS

Pattern:

```
Workspace:
per tenant/customer org jika butuh isolasi keras

Peers:
customer_user
support_agent
billing_agent

Sessions:
per support ticket
```

Kenapa per-ticket? Karena ticket punya boundary natural.

Peer representation customer tetap lintas ticket.

### Use case: Discord bot komunitas

Pattern:

```
Workspace:
community_server

Peers:
discord_user_id untuk tiap member
bot_agent

Sessions:
per-channel atau per-thread
```

Kalau channel ongoing, reuse session. Kalau thread topic-specific, session per-thread.

### Use case: game / NPC

Pattern:

```
Workspace:
game_world

Peers:
player
NPC_A
NPC_B

Sessions:
per encounter / per location / per scene

observe_others:
aktif untuk NPC yang perlu punya perspektif berbeda terhadap player
```

Ini salah satu kasus di mana `observe_others` masuk akal.

NPC A boleh tahu sejarah dengan player. NPC B tidak boleh tahu kalau belum pernah bertemu.

## 19. Linking: bagaimana design pattern nyambung ke architecture, reasoning, representation

Kita sambungkan semua:

Architecture memberi bentuk:

```
Workspace → Peer → Session → Message
```

Reasoning memproses message:

```
Message → reasoning → conclusions/summaries/peer cards
```

Representation menyimpan hasil belajar:

```
Conclusions + summaries + peer cards → peer representation
```

Design patterns memastikan input ke sistem ini tidak rusak.

Kalau workspace salah, isolation salah.

Kalau peer ID salah, representation pecah.

Kalau session salah, summary dan batching salah.

Kalau observation salah, perspective salah.

Kalau lupa peer_target, context retrieval salah.

Jadi design pattern adalah lapisan “information architecture” untuk memory.

```
Bad design pattern → bad memory
Bad memory → bad context
Bad context → bad agent behavior
```

## 20. Insight penutup

★ Insight ─────────────────────────
Kesalahan umum orang waktu pakai memory system adalah langsung mikir “cara retrieve-nya gimana?”

Di Honcho, pertanyaan pertama harusnya:
“Gue mau memisahkan dunia apa?” → workspace
“Gue mau memodelkan siapa?” → peer
“Episode interaksinya apa?” → session
“Siapa boleh tahu apa tentang siapa?” → observation
“Context lokal atau lintas sesi?” → peer_target

Kalau lima keputusan ini benar, reasoning punya bahan yang bersih. Kalau salah, model sebagus apa pun cuma akan mengolah kekacauan.
───────────────────────────────────

## 21. Korelasi dengan konsep lain

Konsep pertama: **domain-driven design**.

Di DDD, lo harus menentukan bounded context dan identity. Honcho mirip:

```
Workspace = bounded context / isolation boundary
Peer = entity dengan identity
Session = interaction aggregate / episode
Message = event
Representation = projection/state hasil reasoning
```

Bedanya: DDD biasanya deterministic business logic. Honcho memakai reasoning model untuk membangun state interpretatif.

Konsep kedua: **database schema design**.

Kalau schema salah, query jadi buruk. Di Honcho, kalau workspace/peer/session salah, memory retrieval juga buruk.

Bedanya: schema database biasanya tentang tabel dan relasi. Design pattern Honcho tentang identitas, konteks, dan perspektif.

Konsep ketiga: **Zettelkasten**.

Zettelkasten menuntut atomic notes dan linking yang benar. Honcho menuntut atomic identity dan context boundary yang benar.

Bedanya: Zettelkasten idea-centric. Honcho peer-centric.

Kesimpulan pendeknya: **Design Patterns Honcho adalah panduan supaya memory agent tidak bocor, tidak pecah, tidak terlalu kecil, dan tidak terlalu omniscient. Prinsipnya: workspace untuk isolasi, peer untuk identitas jangka panjang, session untuk konteks aktif, observation untuk perspektif, dan peer_target untuk memory lintas sesi.**

## Related documents

- [[notes.agentic-engineering.honcho.architecture]]
- [[notes.agentic-engineering.honcho.peer-representations]]
- [[notes.agentic-engineering.honcho.reasoning]]
- [[notes.agentic-engineering.honcho.stateful-memory]]
