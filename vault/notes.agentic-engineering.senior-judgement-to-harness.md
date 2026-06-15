---
id: notes.agentic-engineering.senior-judgement-to-harness
title: "Senior Judgement yang Dipindahkan ke Harness"
desc: "Cara mengubah review comment senior menjadi aturan, skill, linter, test, dan gate yang bisa dipakai agent dan tim berulang."
updated: 1778003052300
created: 1777998431344
tags:
  - notes
  - agentic-engineering
  - harness
  - senior-engineer
---

## Overview

Gue pakai "judgement" di sini sebagai keputusan teknis berbasis pengalaman: kapan query dianggap berbahaya, kapan desain dianggap rapuh, kapan perubahan butuh test, kapan perlu eskalasi manusia.

Senior engineer yang bagus bukan cuma komentar "ini salah, benerin." Dia tanya: kenapa agent bisa mengulang kesalahan ini, dan bagian mana dari sistem yang harus diubah agar kesalahan ini tidak muncul lagi?

## Apa itu judgement senior?

Judgement senior biasanya muncul dalam komentar review singkat seperti:

- "Ini bakal N+1 query."
- "Jangan taruh business logic di controller."
- "Migration ini riskan, rollback-nya mana?"
- "Ini harus idempotent."
- "Authz check-nya hilang."
- "Jangan catch error lalu diam."
- "Ini perlu test regresi."
- "Ini akan lambat kalau datanya 1 juta row."
- "Nama function ini nyembunyiin intent."
- "Ini coupling-nya bikin susah diubah."

Komentar itu singkat, tapi isinya judgement yang lahir dari pengalaman incident, latency spike, data corruption, security bug, atau maintainability buruk.

Kalau judgement itu tetap tinggal di review comment, agent dan junior akan mengulang. Reviewer jadi bottleneck. Maka kita perlu turunkan judgement ini menjadi sistem.

## Review comment yang berulang = sinyal harness belum lengkap

Atomic idea: review comment yang berulang adalah sinyal bahwa ada rule/harness yang belum dibuat.

Transformasi dasarnya:

Review comment → prinsip → rule → contoh → check → feedback loop.

Contoh singkat:

Review comment:
- "Jangan query database di dalam loop."

Prinsip:
- query di loop bisa menyebabkan N+1, latency linear, dan beban database.

Rule:
- jika memproses koleksi entity, jangan panggil repository/database per item. Gunakan bulk query, join, eager loading, batching, atau prefetch.

Contoh:
- bad: `for each user: query orders`
- good: `query orders dengan WHERE IN(...) lalu group di memory`

Check:
- test jumlah query.
- static analysis cari repository call di dalam loop.
- agent review scan pola N+1.
- CI gagal jika query count > threshold.

Feedback loop:
- kalau agent masih salah, update skill file dengan kasus nyata baru.

## Kapan pakai rule, skill, linter, test, gate?

Ini penting biar harness tidak berantakan.

- `AGENTS.md`
  - cocok untuk aturan pendek, universal, selalu relevan.
  - contoh: "Do not introduce database calls inside loops. Prefer bulk fetch, batching, eager loading, or query joins."

- skill file
  - cocok untuk aturan yang butuh penjelasan, contoh, dan prosedur.
  - contoh: `skills/database-performance.md` berisi apa itu N+1, kapan muncul, contoh baik/buruk, cara deteksi, checklist PR.

- linter / static analysis
  - cocok untuk pola mekanis yang bisa dikenali oleh mesin.
  - contoh: repository call dalam `for`, `map`, `forEach`; raw SQL interpolation; endpoint tanpa auth middleware.

- test
  - cocok untuk behavior yang perlu dibuktikan.
  - contoh: query count maksimal 2 untuk endpoint list, API tetap cepat untuk 1.000 record, migration rollback, authz failure.

- CI gate
  - cocok untuk aturan yang tidak boleh dilanggar sebelum merge.
  - contoh: typecheck, lint, security scan, critical vulnerability, migration validation.

Atomic idea: rule jelaskan niat; skill ajarkan cara; linter tangkap pola; test buktikan behavior; CI paksa disiplin.

## Contoh konkret: query database di loop

Agent sering bikin kode seperti ini:

```ts
async function getUsersWithOrders(userIds: string[]) {
  const result = []

  for (const userId of userIds) {
    const user = await userRepository.findById(userId)
    const orders = await orderRepository.findByUserId(userId)

    result.push({
      user,
      orders,
    })
  }

  return result
}
```

Kalau ada 500 user, ini bisa jadi 1.000 query. Di dev kecil aman, di produksi bisa jadi lambat parah.

## Related

- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.before-after-judgement-harness]]
- [[notes.agentic-engineering.cloud-agent.handson.gitlab-mr-comment-formatting]]
- [[zettel.moc.agentic-engineering]]

### Ubah jadi harness

`AGENTS.md`

```markdown
## Database performance rules

- Never perform database or repository calls inside loops over collections.
- Prefer bulk queries, joins, eager loading, batching, or prefetching.
- If a looped query is unavoidable, explain why and add a regression test for query count or performance.
```

Skill file: `skills/database-performance.md`

```markdown
# Database Performance Skill

Use this skill when changing repository, ORM, query, serializer, list endpoint, or data-loading code.

## Core rule

Avoid N+1 queries. A code path that handles N items should not execute O(N) database queries unless explicitly justified.

## Bad pattern

Calling repository/database methods inside:
- for / while loops
- map / forEach callbacks
- serializers
- template rendering loops
- GraphQL field resolvers without batching

## Better patterns

Prefer:
- bulk fetch with WHERE IN
- joins
- eager loading
- dataloader/batching
- precomputed lookup maps
- pagination
- query-level aggregation

## Before completing the task

1. Search changed files for database calls inside loops.
2. Check list endpoints and serializers.
3. Add or update a test that protects query count when possible.
4. Report expected number of queries for the main path.
```

Perbaikan kode:

```ts
async function getUsersWithOrders(userIds: string[]) {
  const users = await userRepository.findByIds(userIds)
  const orders = await orderRepository.findByUserIds(userIds)

  const ordersByUserId = new Map<string, Order[]>()

  for (const order of orders) {
    const existing = ordersByUserId.get(order.userId) ?? []
    existing.push(order)
    ordersByUserId.set(order.userId, existing)
  }

  return users.map((user) => ({
    user,
    orders: ordersByUserId.get(user.id) ?? [],
  }))
}
```

Test pseudo:

```ts
it("loads users with orders without N+1 queries", async () => {
  await seedUsersWithOrders(50)

  const queryCounter = startQueryCounter()

  await getUsersWithOrders(await getSeededUserIds())

  expect(queryCounter.count()).toBeLessThanOrEqual(3)
})
```

Static check sensor:

- Semgrep rule untuk repository call dalam loop
- query count regression test
- CI yang menjalankan scan + test

PR template:

```markdown
## Database impact

- [ ] This change does not introduce database calls inside loops
- [ ] Query count is bounded for list/bulk paths
- [ ] Bulk loading, batching, or eager loading is used where needed
- [ ] If an exception exists, it is explained below
```

## Contoh lain: authz, migration, dependency

### Authz

Review comment:
- "Endpoint ini cuma cek authentication, belum cek authorization."

Harness:

`AGENTS.md`:

```markdown
All write endpoints must check both authentication and authorization. Authentication alone is not sufficient.
```

Skill: `skills/authz-review.md`.

Test:
- user A tidak boleh update resource milik user B.

CI:
- authz tests wajib jalan untuk semua write endpoint.

### Migration

Review comment:
- "Migration ini tidak aman untuk table besar."

Harness:

`AGENTS.md`:

```markdown
Database migrations on large tables must be backward-compatible, non-blocking, and have rollback strategy.
```

Skill: `skills/safe-migration.md`.

Check:
- migration dry-run
- rollback test
- no table lock check
- human approval for destructive migration

### Dependency

Review comment:
- "Kenapa nambah library baru untuk fungsi kecil?"

Harness:

`AGENTS.md`:

```markdown
Do not add new runtime dependencies without justification. Prefer existing utilities or standard library for small tasks.
```

Skill: `skills/dependency-review.md`.

CI:
- OSV scanner
- license checker
- bundle size check

## Batasannya

Tidak semua judgement bisa diautomasi.

Yang tetap manusia:

- trade-off performa vs complexity untuk bisnis ini
- apakah perubahan domain model sesuai strategi produk
- apakah breaking change bisa diterima pelanggan
- apakah data retention policy cocok dengan regulasi
- apakah desain ini terlalu kompleks untuk ukuran tim
- apakah risiko security ini acceptable atau harus stop release

Harness membantu menyiapkan evidence, tetapi keputusan akhir tetap manusia.

## Workflow senior yang berubah

Dulu:
- senior review PR
- senior komentar sama berkali-kali
- senior jadi bottleneck
- knowledge tetap di kepala senior

Sekarang:
- senior lihat pola kesalahan
- senior putuskan rule skill test gate mana yang dibutuhkan
- senior perbaiki harness
- agent/junior belajar dari harness
- review berikutnya lebih ringan
- knowledge jadi reusable

## Insight

- harness bukan cuma dokumentasi.
- harness adalah aturan yang diarahkan, dibatasi, diuji, dan diberi feedback.
- review comment berulang harus dilihat sebagai peluang memperbaiki sistem, bukan bukti agen atau junior bodoh.
- judgement senior dipromosikan menjadi artefak operasional, bukan ditempel di PR saja.

## Related Zettels

- [[zettel.20260419190800]]
