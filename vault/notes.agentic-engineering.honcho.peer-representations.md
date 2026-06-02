---
id: notes.agentic-engineering.honcho.peer-representations
title: Peer Representations
desc: >-
  Catatan tentang peer representation di Honcho sebagai kumpulan hasil reasoning
  dinamis tentang entitas.
updated: 1780425734283
created: 1780425734283
tags:
  - notes
  - agentic-engineering
  - memory
---

Link: https://honcho.dev/docs/v3/documentation/core-concepts/representation

**“peer representations” di Honcho = kumpulan hasil reasoning Honcho tentang satu peer dari waktu ke waktu**. Bukan “representation” dalam arti embedding vektor doang, dan bukan juga “profile user” sederhana.

Di sini “peer” berarti entitas yang dimodelkan Honcho: bisa user, agent, customer, student, NPC, project, atau entitas lain. “Representation” berarti state pemahaman Honcho tentang peer itu: siapa dia, apa pola perilakunya, apa yang dia pedulikan, apa konteks historisnya, dan bagaimana pemahaman itu berubah ketika message baru masuk.

## 1. Pertanyaan kunci

Ada 7 pertanyaan penting:

1. Apa itu peer representation secara inti?
2. Isi representation itu apa saja?
3. Kenapa representation bukan sekadar memory/fact list?
4. Apa bedanya conclusion, summary, dan peer card?
5. Apa itu observation dan perspective-taking?
6. Kenapa representasi bisa berbeda tergantung siapa yang mengamati?
7. Risiko atau failure mode-nya apa?

★ Insight ─────────────────────────
Peer representation adalah “model mental” Honcho tentang satu entitas.

Kalau message adalah catatan mentah, representation adalah hasil pemahaman yang dibangun dari catatan itu. Mirip manusia: elo tidak mengingat semua kalimat teman elo secara literal, tapi elo punya model tentang “dia orangnya gimana, biasanya peduli apa, punya pola apa, dan history gue sama dia apa.”

Bedanya: Honcho mencoba membuat model itu secara eksplisit lewat reasoning, bukan cuma lewat ingatan kabur.
───────────────────────────────────

## 2. Definisi inti: apa itu peer representation?

Page-nya mendefinisikan:

> “A representation is the collection of reasoning Honcho has done about a peer over time.”

Ini kalimat kunci. Representation bukan raw chat log. Representation adalah **koleksi hasil reasoning**.

Lalu page lanjut:

> “It’s the continual learning about a peer over every message that’s been written to it.”

Artinya setiap message baru bisa memperbarui representation. Jadi representation itu dinamis, bukan profil statis.

Formula sederhananya:

```
messages about / from peer
→ reasoning
→ premises
→ conclusions
→ summaries
→ peer card
→ peer representation
```

Kalau peer-nya adalah user, representation bisa berisi:

```
- user sering minta penjelasan tajam
- user tidak suka jawaban netral yang mengaburkan posisi
- user tertarik AI agent, memory system, sandboxing
- user suka struktur ide kecil yang saling dihubungkan
```

Kalau peer-nya agent, representation bisa berisi:

```
- agent ini sering bertindak sebagai coding assistant
- agent ini berinteraksi dengan user dalam konteks debugging
- agent ini punya pola menjawab teknis dan prosedural
```

Kalau peer-nya project, representation bisa berisi:

```
- project ini terkait sandbox security
- concern utama: file access, environment secrets, repo-level config
- keputusan sebelumnya: perlu env sanitization
```

Atomic idea-nya:

**Peer representation = state yang dipelajari tentang entitas.**

## 3. Representation bukan “database fakta”

Ini penting. Banyak memory system menyimpan fakta seperti:

```
User uses macOS.
User likes Python.
User works on project X.
```

Itu berguna, tapi dangkal.

Honcho representation lebih kaya karena berisi hasil reasoning seperti:

```
User is likely concerned with practical security boundaries when using coding agents.
```

Itu bukan fakta mentah. Itu kesimpulan dari beberapa interaksi.

Page bilang:

> “Think of it as Honcho’s understanding of who that peer is, what they care about, and how they behave, built through formal logic rather than simple storage.”

Bagian pentingnya: **built through formal logic rather than simple storage**.

Jadi representation bukan cuma daftar memory. Ia adalah struktur pemahaman yang dibangun dari:

```
apa yang eksplisit dikatakan
apa yang bisa disimpulkan
pola apa yang muncul
kontradiksi apa yang perlu direkonsiliasi
ringkasan sesi apa yang relevan
data biografis dasar apa yang harus tetap stabil
```

Dengan kata lain:

```
Memory biasa:
"apa yang pernah disimpan?"

Peer representation:
"apa yang sekarang Honcho pahami tentang peer ini?"
```

## 4. Isi peer representation: tiga artifact utama

Page menyebut representation terdiri dari beberapa artifact:

1. Conclusions
2. Summaries
3. Peer cards

Kita pecah.

## 4.1 Conclusions: insight hasil reasoning

Conclusions adalah insight yang diturunkan lewat formal logic.

Page membagi conclusion ke beberapa tipe:

```
Deductive conclusions
Inductive conclusions
Abductive conclusions
```

### Deductive conclusion

Deductive conclusion adalah kesimpulan yang relatif pasti berdasarkan premis.

Contoh:

Premis:

```
User said they use macOS.
sandbox-exec is a macOS sandboxing tool.
```

Deductive conclusion:

```
sandbox-exec advice is relevant to this user’s environment.
```

Deduksi idealnya ketat: kalau premis benar, kesimpulan harus mengikuti.

Dalam representation, deduksi membantu agent tidak perlu mengulang inference sederhana setiap kali.

### Inductive conclusion

Inductive conclusion membaca pola dari banyak message.

Contoh message lintas sesi:

```
User often asks:
- failure mode-nya apa?
- trade-off-nya apa?
- logical fallacy-nya apa?
- jangan main tengah
```

Inductive conclusion:

```
User evaluates topics by testing assumptions, trade-offs, and failure modes.
```

Ini bukan dari satu pesan, tapi dari pola.

Page memberi contoh sejenis:

> “if a user frequently mentions work deadlines and rarely mentions hobbies, Honcho might inductively conclude they’re time-constrained or career-focused.”

Ini contoh bahwa Honcho mencoba mengambil pola perilaku dari banyak sinyal.

### Abductive conclusion

Abductive conclusion mencari penjelasan paling sederhana untuk perilaku yang diamati.

Contoh:

Observasi:

```
User sering curiga dokumen tanpa sitasi.
User sering minta cek sumber.
User sering membedakan fakta, opini, dan framing.
```

Abductive conclusion:

```
User is concerned with epistemic reliability and source quality.
```

Abduction ini kuat, tapi paling rawan salah. Karena dia menjelaskan “kemungkinan sebab”, bukan kebenaran pasti.

Jadi di representation, abductive conclusion harus dipahami sebagai **hipotesis berguna**, bukan fakta keras.

## 4.2 Summaries: kompresi session

Summaries menangkap esensi session.

Page menyebut:

> “Short summaries are generated every 20 messages by default, and long summaries every 60 messages.”

Ini menarik karena Honcho tidak hanya menyimpan conclusion tentang peer, tapi juga ringkasan percakapan.

Kenapa summary penting?

Karena raw chat history bisa panjang dan mahal dimasukkan ke prompt. Summary mengompresnya menjadi konteks padat.

Contoh session:

```
User and agent discussed macOS sandbox-exec. Main concern: sandbox blocks filesystem access but does not automatically sanitize environment variables. Suggested mitigation: launch agent with clean env and restrict secrets at shell/session level.
```

Itu lebih berguna daripada memasukkan 100 message mentah.

Atomic idea:

```
Conclusion = insight tentang peer
Summary = kompresi episode/session
```

Keduanya beda.

Conclusion lebih seperti “apa yang dipelajari tentang entitas”.

Summary lebih seperti “apa yang terjadi dalam sesi ini”.

## 4.3 Peer cards: grounding dasar peer

Peer card berisi informasi biografis atau identitas dasar tentang peer.

Page bilang:

> “Peer cards contain key biographical information.”

Lalu:

> “They essentially cache the most basic information about a peer (name, occupation, interests) to ensure the model never loses its grounding.”

Peer card itu seperti kartu identitas ringkas.

Contoh peer card untuk user:

```
Name: Raka
Interests: AI agents, economics, software architecture, Indonesian politics
Communication preference: Indonesian casual style, structured explanation
```

Contoh peer card untuk agent:

```
Name: coding_agent
Role: helps debug software projects and explain architecture
Context: often works with user on CLI tools and sandboxing
```

Peer card penting karena agent bisa kehilangan grounding kalau konteks terlalu panjang atau session sudah lama. Peer card memastikan hal-hal dasar tetap ada.

Tapi hati-hati: peer card yang salah bisa sangat merusak, karena ia menjadi “identitas dasar” yang sering dipakai.

## 5. Continuous improvement: representation terus berubah

Page bilang:

> “Each new message refines conclusions, updates summaries, and keeps peer cards current.”

Jadi peer representation bukan snapshot sekali jadi. Ia seperti model yang terus diperbarui.

Contoh perubahan:

Awal:

```
User prefers concise answers.
```
Setelah beberapa sesi:

```
User prefers concise answers for simple topics, but asks for deep structured dives on technical systems.
```
Setelah lebih banyak data:

```
User prefers atomic, linked explanations; depth is acceptable when the topic is architectural or conceptual.
```

Ini contoh representation yang makin nuanced.

Atomic idea:

```
representation yang baik bukan makin panjang,
tapi makin akurat dan kontekstual.
```

Kalau cuma menumpuk memory, hasilnya bising. Kalau reasoning-nya bagus, representation harus menggabungkan, memperbaiki, dan membatasi kesimpulan.

## 6. Observation: siapa yang diamati?

Bagian ini penting dan agak unik.

Honcho punya konsep observation dan perspective-taking.

Ada dua mode utama:

```
observe_me
observe_others
```

### 6.1 observe_me

Page menjelaskan:

> “Honcho observing peers (observe_me): When enabled (default), Honcho forms a representation of the peer based on all messages they’ve sent across all sessions.”

Artinya kalau `observe_me` aktif, Honcho membangun representation tentang peer berdasarkan semua message yang peer itu kirim.

Contoh:

Alice sebagai peer mengirim message di banyak session.

Honcho mengamati semua message Alice.

Lalu Honcho membangun representation tentang Alice.

Kalau `observe_me: false`, Honcho tidak melakukan reasoning tentang peer itu.

Ini berguna kalau ada entitas yang tidak ingin dimodelkan karena privacy, compliance, atau noise.

### 6.2 observe_others

Page menjelaskan:

> “Peers observing others (observe_others): When enabled at the session level, a peer will form representations of other peers in that session based only on messages they’ve observed.”

Ini lebih menarik.

Artinya satu peer bisa punya representation tentang peer lain, tapi hanya berdasarkan interaksi yang dia saksikan.

Contoh:

```
Session 1 dan 2:
Alice ngobrol dengan Bob.

Session 3:
Alice ngobrol dengan Charlie.
```

Kalau Bob punya `observe_others: true`, Bob membangun representation tentang Alice berdasarkan session 1 dan 2 saja.

Kalau Charlie punya `observe_others: true`, Charlie membangun representation tentang Alice berdasarkan session 3 saja.

Maka:

```
Bob's representation of Alice ≠ Charlie's representation of Alice
```

Kenapa? Karena pengalaman mereka terhadap Alice berbeda.

Ini disebut perspective-taking.

## 7. Perspective-taking: kenapa penting?

Page bilang:

> “Why would you want peers observing others? So you can simulate stateful perspectives.”

Ini inti konsepnya.

Tanpa perspective-taking, semua agent bisa jadi omniscient. Semua agent tahu semua hal tentang semua orang. Itu tidak realistis dan bisa merusak trust.

Contoh:

Bob pernah debat panjang dengan Alice di session 1 dan 2.

Charlie baru bertemu Alice di session 3.

Kalau Charlie tiba-tiba tahu inside joke atau konflik lama Alice-Bob, simulasi jadi rusak. Charlie seperti punya pengetahuan yang tidak pernah ia alami.

Honcho mencoba mencegah itu dengan representasi berbasis perspektif.

Atomic distinction:

```
Global representation:
Honcho’s overall understanding of Alice.

Perspective representation:
Bob’s understanding of Alice, based only on what Bob observed.
```

Ini kuat untuk:

```
multi-agent simulation
group chat
role-playing game
customer support dengan banyak agent
education platform
team collaboration
social agents
```

## 8. Contoh konkret: Alice, Bob, Charlie

Misalnya ada peer:

```
Alice = user
Bob = AI tutor
Charlie = AI career coach
```

Session:

```
Session 1:
Alice belajar matematika dengan Bob.

Session 2:
Alice curhat ke Bob bahwa dia takut ujian.

Session 3:
Alice ngobrol dengan Charlie soal kerja.
```

Representation global Alice oleh Honcho:

```
Alice is a student who is anxious about exams and is also exploring career planning.
```

Bob’s representation of Alice:

```
Alice struggles with exam anxiety and benefits from patient explanations.
```

Charlie’s representation of Alice:

```
Alice is considering career options and wants practical guidance.
```

Ketiganya benar, tapi berbeda scope.

Ini seperti manusia. Teman kuliah, bos kerja, dan terapis bisa punya model berbeda tentang orang yang sama.

Honcho membuat perbedaan ini eksplisit.

## 9. Kenapa representations “work” menurut Honcho?

Page bilang:

> “Statefulness is simulated through reconstruction of the past.”

Ini klaim filosofis yang penting.

Agent tidak benar-benar “punya masa lalu” seperti manusia. Agent mensimulasikan statefulness dengan cara merekonstruksi masa lalu yang relevan.

RAG biasa merekonstruksi masa lalu dengan:

```
search facts
retrieve similar chunks
hope LLM connects the dots
```

Honcho ingin merekonstruksi masa lalu dengan:

```
reason over past data
store conclusions
handle contradictions
surface implicit insights
assemble relevant context
```

Page bilang:

> “Honcho reconstructs through reasoning about the past exhaustively, leaving much less to chance.”

Artinya: jangan serahkan semua koneksi makna ke LLM saat inference. Sebagian koneksi sudah dibuat sebelumnya lewat reasoning background.

Ini logis. Kalau agent baru “berpikir dari nol” setiap kali user bertanya, agent mudah lupa atau inconsistent. Kalau reasoning sudah dikompresi menjadi representation, agent punya state yang lebih stabil.

## 10. Contoh implicit insight dalam representation

Page memberi contoh:

> “If a user mentions they’re saving for a house in one session and complains about subscription costs in another, Honcho can conclude they’re budget-conscious without anyone saying it.”

Ini contoh bagus.

Raw data:

```
Session A:
User is saving for a house.

Session B:
User complains about subscription costs.
```

Representation:

```
User is likely budget-conscious.
```

Ini tidak eksplisit. Tapi berguna.

Kalau agent nanti menyarankan tool SaaS, ia bisa mempertimbangkan harga.

Misalnya:

```
Instead of recommending expensive enterprise software, suggest low-cost or open-source options first.
```

Inilah nilai representation: mengubah potongan masa lalu menjadi konteks tindakan.

## 11. Contradiction handling

Page juga bilang reasoning bisa menangani kontradiksi:

> “when new information conflicts with old conclusions, it reconciles them instead of just accumulating more data.”

Ini penting karena memory yang hanya menumpuk fakta bisa kacau.

Contoh:

Memory lama:

```
User prefers JavaScript.
```

Memory baru:

```
User now prefers TypeScript for production code.
```

Sistem buruk akan menyimpan keduanya tanpa konteks.

Representation yang baik harus merekonsiliasi:

```
User previously used JavaScript, but currently prefers TypeScript for production projects.
```

Atau:

```
Preference depends on context: JavaScript for quick scripts, TypeScript for production.
```

Ini jauh lebih berguna daripada daftar fakta yang saling tabrakan.

## 12. Prediction under uncertainty

Page menyebut reasoning memungkinkan:

> “prediction under uncertainty”

Maksudnya representation bisa membantu agent menebak hal yang mungkin relevan meski data tidak lengkap.

Contoh:

Representation:

```
User is budget-conscious.
User prefers open-source tools.
User dislikes vendor lock-in.
```

Ketika user bertanya:

```
"Tool memory agent enaknya pakai apa?"
```

Agent bisa memprioritaskan:

```
local-first / open-source / self-hosted options
```

Tapi ini harus hati-hati. Prediction under uncertainty bukan izin untuk sok tahu. Seharusnya dipakai sebagai soft bias, bukan asumsi keras.

Kalimat sehatnya:

```
Given your prior preference for local-first setups, ByteRover or Holographic may fit better.
```

Bukan:

```
You definitely only want local tools.
```

## 13. Representation vs raw memory vs summary vs profile

Biar bersih, bedakan empat hal ini.

```
Raw memory:
Message mentah yang pernah terjadi.

Summary:
Ringkasan session atau percakapan.

Profile / peer card:
Data dasar tentang peer.

Representation:
Gabungan conclusions, summaries, peer cards, dan reasoning artifacts tentang peer.
```

Contoh:

Raw memory:

```
User said: "Jangan main tengah lah soal ginian."
```
Summary:

```
The user criticized vague neutrality and asked for a clearer judgment.
```
Peer card:

```
User prefers direct, clear analysis.
```
Representation:

```
User tends to value decisive reasoning, especially in political/economic analysis, and dislikes evasive neutrality when evidence supports a clear judgment.
```

Representation lebih kaya karena menghubungkan banyak artifact.

## 14. Kenapa ini penting untuk AI agent?

Agent yang tidak punya peer representation akan sering seperti ini:

```
User: Lanjut yang kemarin.
Agent: Bisa jelaskan maksudnya?
```

Agent dengan representation bisa lebih seperti:

```
User: Lanjut yang kemarin.
Agent: Kemarin kita bahas sandbox-exec, boundary file access, dan risiko env secret leakage. Bagian yang belum selesai adalah setup Codex per repo vs global.
```

Perbedaannya bukan sekadar ingat keyword. Agent punya model konteks.

Untuk agent jangka panjang, representation membantu:

```
- mempertahankan preferensi user
- mengingat keputusan project
- memahami relasi antar peer
- menjaga continuity antar session
- menghindari pengulangan
- memberi saran lebih sesuai konteks
```

## 15. Failure mode peer representation

Sistem seperti ini kuat, tapi rawan beberapa masalah.

### Failure 1: Salah menyimpulkan identitas peer

Contoh:

User sering baca artikel ekonomi.

Kesimpulan salah:

```
User is an economist.
```

Yang lebih aman:

```
User often analyzes economic and policy topics.
```

Representation harus membedakan “interest” dan “identity”.

### Failure 2: Overfitting ke momen sementara

User bilang:

```
"Jawab pendek, gue lagi buru-buru."
```

Representation salah:

```
User always prefers short answers.
```

Representation sehat:

```
User may prefer short answers in time-constrained situations.
```

### Failure 3: Perspective leakage

Charlie tidak pernah ikut session lama Alice-Bob, tapi tiba-tiba tahu konflik mereka.

Ini melanggar perspective-taking.

Dalam multi-agent, leakage semacam ini bikin user merasa sistem “aneh” atau terlalu tahu.

### Failure 4: Memory inertia

Representation lama tidak cepat berubah.

Contoh:

Dulu user beginner.

Sekarang user advanced.

Kalau representation masih menganggap user beginner, agent akan terus menjelaskan terlalu dasar.

### Failure 5: Bad peer identity management

Kalau user yang sama dibuat jadi banyak peer ID:

```
raka
raka_1
user_raka
raka@gmail.com
```

Representation terpecah. Agent jadi tidak punya continuity penuh.

Sebaliknya, kalau dua user berbeda memakai peer ID yang sama, representation tercampur. Ini lebih berbahaya.

## 16. Linking: hubungan dengan architecture dan reasoning

Sekarang kita hubungkan ke konsep sebelumnya.

Di arsitektur Honcho:

```
Workspace → Peers → Sessions → Messages
```

Reasoning memproses messages.

Peer representation adalah hasil yang tersimpan.

Flow-nya:

```
Peer mengirim message dalam session
→ message disimpan
→ reasoning berjalan
→ conclusions / summaries / peer cards dibuat
→ representation peer diperbarui
→ agent mengambil context dari representation
→ agent menjawab lebih stateful
```

Jadi:

```
Architecture = bentuk sistem
Reasoning = mesin pengolah
Representation = hasil belajar
Context endpoint = cara hasil itu dipakai agent
```

Kalau diibaratkan tubuh:

```
Messages = pengalaman
Reasoning = proses berpikir/refleksi
Representation = ingatan terstruktur
Context = apa yang diingat saat perlu bertindak
```

## 17. Insight penutup

★ Insight ─────────────────────────
Kesalahan umum memahami peer representation adalah mengira ini cuma “profil user otomatis”.

Lebih tepat: peer representation adalah **state interpretatif** tentang entitas, dibangun dari semua message yang relevan, lalu terus diperbarui melalui reasoning.

Elo sudah paham kalau bisa membedakan:

1. Peer = siapa/apa yang dimodelkan
2. Message = bukti mentah
3. Reasoning = proses menarik makna
4. Conclusion = insight
5. Summary = kompresi session
6. Peer card = grounding dasar
7. Representation = gabungan state yang dipakai agent
───────────────────────────────────

## 18. Korelasi dengan konsep lain

Konsep pertama: **mental model**.

Manusia punya mental model tentang orang lain. Elo tahu teman elo biasanya suka apa, sensitif soal apa, gaya komunikasinya bagaimana. Peer representation mencoba membuat mental model itu eksplisit untuk agent.

Bedanya: mental model manusia sering kabur dan emosional. Honcho ingin membuatnya lebih terstruktur lewat reasoning artifacts.

Konsep kedua: **CRM customer profile**.

CRM menyimpan riwayat customer, preferensi, ticket, status, dan catatan. Peer representation mirip CRM untuk AI agent.

Bedanya: CRM biasanya fact-based dan human-readable. Peer representation lebih aktif: ia bisa menyimpan conclusions, pola, dan perspektif antar peer.

Konsep ketiga: **event-sourced projection**.

Dalam event sourcing:

```
events → projection/state
```

Di Honcho:

```
messages → reasoning → peer representation
```

Bedanya: event sourcing biasanya deterministik. Honcho interpretatif karena memakai reasoning model.

Konsep keempat: **Zettelkasten**.

Zettelkasten membangun pemahaman dari banyak catatan kecil yang saling terhubung. Peer representation juga begitu: message kecil menjadi premise, conclusion, summary, lalu membentuk state.

Bedanya: Zettelkasten biasanya idea-centric. Peer representation entity-centric. Fokusnya bukan cuma “ide ini berhubungan dengan ide apa”, tapi “entitas ini sekarang dipahami sebagai apa berdasarkan sejarah interaksinya.”

Kesimpulan pendeknya: **peer representation adalah pusat memory Honcho: bukan tempat menyimpan semua chat, tapi model yang terus diperbarui tentang peer, berisi conclusion, summary, dan peer card, termasuk perspektif berbeda tergantung siapa yang mengamati.**

## Related documents

- [[notes.agentic-engineering.honcho.reasoning]]
- [[notes.agentic-engineering.honcho.architecture]]
- [[notes.agentic-engineering.honcho.design-patterns]]
