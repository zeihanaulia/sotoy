---
id: daily.journal.2026.05.11
title: '2026-05-11'
desc: "Refleksi public tentang service-centric SaaS dan perbandingan product vs service di konteks HRIS, CRM, dan SDLC Studio."
updated: 1778453509273
created: 1778453509273
tags:
  - daily
  - saas
  - service
  - product
  - x
  - twitter
---

## Baca dan catat hari ini
Hari ini gue bikin note baru yang menjelaskan perbedaan product vs service di SaaS B2B dengan contoh HRIS, CRM, dan SDLC Studio.

Intinya: product adalah capability inti, service adalah experience berkelanjutan yang bikin tenant betah.

## Apa yang dibuat
- [[notes.saas.product-vs-service]] — contoh public untuk HRIS, CRM, dan SDLC Studio.
- [[book-summaries.building-multi-tenant-saas-architectures.chapter-1]] — summary Chapter 1 tentang mindset SaaS.
- [[book-summaries.building-multi-tenant-saas-architectures.chapter-1.close-reading]] — close reading Chapter 1 dengan paragraf, quotes, dan sketch.
- [[notes.prompt-engineering.lee-robinson-hiring-signals]] — catatan thread Lee Robinson tentang paket aplikasi engineering signal-first.
- [[notes.software-architechture.bun-rust-porting]] — catatan thread Jarred Sumner tentang port Bun ke Rust, layering, crates, dan tagged pointers.
- [[notes.software-architechture.bun-rewrite-oracle]] — catatan thread Rhys Sullivan tentang validasi rewrite Bun Zig→Rust dan oracle testing.
- [[notes.prompt-engineering.hunk-terminal-diff-reviewer]] — catatan tool Hunk untuk review-first terminal diff dan workflow Jujutsu (`jj`) integration.

## Insight penting
- Dalam SaaS B2B, customer masuk karena capability, tapi churn karena service experience.
- Service experience meliputi onboarding, operability, support, reliability, trust, dan continuity of value.
- Product-only mindset bisa menghasilkan fitur bagus, tetapi service buruk yang membuat tenant capek.

## Thread X & notes baru
Hari ini gue lihat kemungkinan kuat bahwa thread Markdown vs HTML untuk LLM ini berkaitan langsung dengan artikel Thariq.

- Thariq mengoptimalkan artifact yang harus dibaca manusia dalam workflow agent.
- Antirez mengoptimalisasi representasi yang harus dibaca model, dengan fokus pada token economy dan semantic density.
- Reply terbaik tidak mematahkan keduanya secara frontal; mereka menggeser diskusi ke hybrid pipeline:
  - **Markdown untuk source / agent-facing context**
  - **HTML untuk rendered / human-facing surface**
  - **Generate HTML dari markdown / reasoning output, bukan pakai HTML sebagai source utama**
- Jadi arah diskusi yang mulai muncul bukan "Markdown menang" atau "HTML menang" — tapi **keduanya punya tempat berbeda**.

Buat referensi sendiri: [[notes.prompt-engineering.markdown-vs-html-llm]]

## Rencana lanjut
Lanjut ke Chapter 2: *Multi-Tenant Architecture Fundamentals* untuk mulai mengurai bagaimana mindset ini bertransformasi ke pilihan arsitektur.

## Thread X: Markdown vs HTML untuk kerja bareng LLM
Link: https://x.com/antirez/status/2053113951123054963

Yang gue pilih dulu: diskusinya di thread itu tentang debat format untuk kerja sama dengan LLM, bukan debat web-dev rendering umum.

Inti yang gue tangkap:

1. Pertanyaannya bukan hanya format untuk manusia, tapi format untuk LLM.
2. Antirez bilang pindah dari Markdown ke HTML itu "rugi" karena HTML biasanya lebih verbose dan bikin makna tersebar ke banyak token.
3. HTML bisa lebih nyaman untuk struktur kompleks, tapi itu belum tentu optimal untuk model yang lebih baik baca teks dan pattern manusia.
4. Perbedaan "semantically dense" vs "semantically sparse" itu soal berapa banyak makna yang dibawa tiap token, bukan semata jumlah tag.
5. Kesimpulan praktis: Markdown lebih cocok untuk reasoning, notes, dan prompt artifact yang perlu padat. HTML masih relevan untuk presentasi, UI spec, atau transformasi ke sistem lain.

Insight penting:

* Ini bukan soal mana yang lebih bagus secara absolut. Ini soal representation cost untuk penerima utamanya.
* HTML bisa berguna untuk browser/parser tradisional, tapi untuk LLM kadang wrapper tambahan justru menambah noise.
* Kalau kita pakai satu format untuk dua tujuan sekaligus — reasoning dan rendering — kita mungkin salah kaprah.

Gue sensenya: thread ini paling sehat kalau dilihat sebagai panggilan untuk memisahkan "working representation" dan "presentation representation". Format yang optimal buat LLM belum tentu sama dengan yang optimal buat browser atau UI.

## Thread X: DP mindset di sistem nyata
Link: https://x.com/DevanshuXi/status/2053327490106466691

Yang gue pilih dari thread ini: ini bukan thread tentang LeetCode atau definisi DP dari buku. Ini tentang kenapa pola pikir DP muncul di sistem nyata — compiler, database, scheduler, distributed systems — dan kenapa itu penting.

1. DP itu apa menurut thread?
   - DP adalah cara mereduksi ruang pencarian eksponensial jadi state kecil yang bisa dihitung ulang.
   - Fokusnya bukan cuma recurrence atau tabel 2D, tapi: ada banyak kemungkinan, ada overlap, dan kita bisa pakai kembali hasil subproblem.

2. Kenapa infrastruktur "diam-diam bergantung" pada ide ini?
   - Banyak sistem nyata sedang menjawab: "untuk state X, keputusan terbaik apa?"
   - Kalau jawaban itu disimpan dan dibangun dari bagian kecil, aroma DP muncul.
   - Ini bukan berarti semua sistem implementasi DP literal. Banyak yang sebenarnya pakai pola pikir serupa: state, cost, reuse, decomposition.

3. Contoh optimizer database itu apa maksudnya?
   - Query optimizer klasik (Selinger-style) memang menyimpan plan termurah untuk setiap subset join.
   - Itu benar-benar DP: state = subset tabel, value = cost terbaik, transition = gabung subplan.
   - Jadi contoh ini bukan sekadar retorika; dia punya DNA DP yang nyata.

4. Semua contoh yang disebut apakah benar-benar DP?
   - Beberapa jelas: Viterbi, edit distance, sequence alignment, value iteration, query optimization subset-style.
   - Beberapa lain sering mengandung DP tapi tidak otomatis: compiler optimization, register allocation, scheduling, GPU tiling, cache policy.
   - Sisanya lebih ke bau DP: TCP congestion, distributed systems thinking, heuristik cost-based.
   - Jadi koreksinya: thread kuat sebagai framing mindset, tetapi sedikit overreach kalau semua contoh dibaca sebagai DP literal.

5. Insight penting yang gue ambil:
   - Yang paling berharga bukan daftar contoh, tapi cara nanya:
     * apa state minimum yang penting?
     * apa informasi yang cukup untuk memutuskan masa depan?
     * dimana overlap komputasi terjadi?
     * apakah local optimality bisa compose jadi global optimality?
     * apa dimensi search space yang harus dimodelkan?
   - Itu adalah mental model DP yang bisa dipakai jauh di luar soal algorithmic DP.

Catatan penting:
- DP bukan cuma memoization. Memoization tanpa recurrence dan optimal substructure belum tentu DP.
- DP juga bukan greedy atau heuristic. Tapi pola pikir serumpun kadang membantu pilih antara DP literal dan heuristic engineer.
- Dalam engineering sehari-hari, yang sering kepake adalah pola pikir: cari state yang relevan, simpan hasil intermediate, dan bangun solusi besar dari bagian kecil.

Kalau mau lanjut, next gue bisa bedah: "beda DP literal, memoization biasa, greedy, dan heuristic optimizer."