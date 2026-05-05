---
id: notes.agentic-engineering.before-after-judgement-harness
title: "Before-After: Senior Judgement ke Harness"
desc: "Perbandingan workflow tim sebelum dan sesudah judgement senior dipindahkan ke harness, dengan skenario N+1 query."
updated: 1777998461480
created: 1777998461480
tags:
  - notes
  - agentic-engineering
  - harness
  - workflow
  - nplusone
---

## Overview

Ini catatan gue tentang satu pola yang selalu gue temui: judgement senior sering berhenti di komentar PR, lalu hilang.

Bukan cuma soal AI agent. Ini soal workflow engineering: review, test, rule, skill file, CI, dan feedback loop.

Gue ambil satu skenario utama karena ini paling gampang nge-lock: agent sering bikin N+1 query / query database di dalam loop.

## Why this matters

Buat gue, ini bukan tentang "sebelum AI vs sesudah AI".

Yang keganjilan adalah: banyak judgement senior selama ini cuma numpang lewat di komentar review.

Kalimat kecil seperti "ini rawan N+1", "authz-nya kurang", "jangan campur refactor dengan perubahan behavior" itu tampaknya sepele. Padahal itu pengalaman panjang.

Masalahnya, kalau insight itu cuma berhenti di review, tim bakal mengulang kesalahan yang sama. Senior berubah jadi filter manual. Itu kerja yang nggak scalable.

Jadi yang gue cari: judgement senior dipindahkan ke guardrail. Bukan supaya senior nggak berpikir. Justru supaya dia mikir di level sistem.

Before: senior jadi filter manual.
After: senior jadi desainer guardrail.

Itu persis yang gue tulis di [[notes.agentic-engineering.self-hosted-agent-runner]] dan [[til.ai.semgrep.guardrails]]: jangan biarkan review comment kelar dengan kata-kata saja, jadikan itu rule/verify guardrail yang hidup di `.ai/commands/verify.sh`.

## Skenario: User Activity Dashboard

Product minta fitur baru:

"Admin bisa melihat daftar user beserta jumlah order, last login, dan status subscription."

Stack:
- Backend: Node.js / TypeScript
- Database: PostgreSQL
- ORM/repository layer
- CI sudah ada, tapi belum punya performance/query-count test
- Tim mulai pakai agent coding CLI/cloud agent

---

# BEFORE: Senior sebagai reviewer manual

### 1. Task diberikan ke agent

Developer kasih prompt ke agent:

```text
Build admin user activity dashboard API.

Return:
- user id
- email
- total orders
- last login
- subscription status
```

Agent baca codebase, lalu membuat endpoint baru.

### 2. Agent menghasilkan kode

Kodenya kira-kira seperti ini:

```ts
async function getUserActivityDashboard() {
  const users = await userRepository.findAllActiveUsers()

  const result = []

  for (const user of users) {
    const orders = await orderRepository.findByUserId(user.id)
    const lastLogin = await loginRepository.findLastByUserId(user.id)
    const subscription = await subscriptionRepository.findByUserId(user.id)

    result.push({
      id: user.id,
      email: user.email,
      totalOrders: orders.length,
      lastLoginAt: lastLogin?.createdAt ?? null,
      subscriptionStatus: subscription?.status ?? "none",
    })
  }

  return result
}
```

Di data dev cuma ada 10 user. Endpoint kelihatan jalan. Test basic pass.

### 3. Pull request dibuka

PR summary dari agent:

```text
Added admin user activity dashboard endpoint.
Includes unit tests for response shape.
All tests pass.
```

Developer merasa aman karena test hijau.

### 4. Senior review

Senior lihat kode dan langsung sadar:

"Ini N+1 parah."

Kalau ada 10.000 user, query-nya bisa:
- 1 query ambil users
- 10.000 query ambil orders
- 10.000 query ambil last login
- 10.000 query ambil subscription

Total: 30.001 query.

Senior komentar:

```text
This introduces N+1 queries. Please bulk load orders, logins, and subscriptions instead of querying inside the loop.
```

Agent memperbaiki.

### 5. Agent memperbaiki kode

Agent ubah jadi:

```ts
async function getUserActivityDashboard() {
  const users = await userRepository.findAllActiveUsers()
  const userIds = users.map((user) => user.id)

  const orderCounts = await orderRepository.countByUserIds(userIds)
  const lastLogins = await loginRepository.findLastByUserIds(userIds)
  const subscriptions = await subscriptionRepository.findByUserIds(userIds)

  return users.map((user) => ({
    id: user.id,
    email: user.email,
    totalOrders: orderCounts.get(user.id) ?? 0,
    lastLoginAt: lastLogins.get(user.id)?.createdAt ?? null,
    subscriptionStatus: subscriptions.get(user.id)?.status ?? "none",
  }))
}
```

Senior approve.

### 6. Masalahnya: pengetahuan tidak berpindah

PR ini selesai, tapi pelajaran cuma ada di percakapan review.

Besok agent bikin endpoint lain: "Export customer billing report."
Agent lagi-lagi bikin query di loop.
Senior komentar lagi: "Same issue: avoid DB calls inside loops."

Minggu depan junior bikin serializer baru. Masalah sama muncul lagi.

Senior jadi bottleneck.
Agent tidak benar-benar belajar.
Junior tidak menyerap pattern secara sistemik.
Review penuh komentar repetitif.
Tim merasa AI mempercepat coding, tapi memperlambat review.

### Before dalam satu kalimat

**Kesalahan ditemukan setelah terjadi, oleh manusia, satu PR demi satu PR.**

---

# AFTER: Senior memindahkan judgement ke harness

Sekarang tim memutuskan: komentar "jangan query DB di loop" tidak boleh cuma jadi komentar review. Ini harus masuk harness.

### 1. Senior mengubah review insight menjadi rule

Di `AGENTS.md`, senior menambahkan rule pendek:

```markdown
## Database performance

- Do not perform database/repository calls inside loops over collections.
- Prefer bulk queries, joins, batching, eager loading, or precomputed lookup maps.
- If a looped query is unavoidable, explain why in the PR and add a regression test.
```

Rule ini dibaca agent di awal sesi.

### 2. Senior membuat skill file

Karena rule pendek belum cukup, senior bikin:

```text
.ai/skills/database-performance.md
```

Isinya:

```markdown
# Database Performance Skill

Use this skill when changing:
- repositories
- ORM queries
- list endpoints
- serializers
- dashboard/reporting APIs
- GraphQL resolvers
- code that processes collections of entities

## Main risk

Avoid N+1 queries. A code path handling N items should not execute O(N) database queries.

## Bad pattern

Do not call repository/database methods inside:
- for loops
- while loops
- map/forEach callbacks
- serializers
- template rendering loops

## Better patterns

Prefer:
- WHERE IN bulk fetch
- joins
- eager loading
- batching
- DataLoader pattern
- aggregation queries
- lookup maps in memory

## Before completion

1. Search changed files for DB calls inside loops.
2. Estimate query count for the main path.
3. Add or update a query-count/performance test when possible.
4. Report the verification result.
```

Ini bukan cuma "larangan". Ini mengajarkan pattern berpikir.

### 3. Senior menambahkan static sensor

Tim bikin Semgrep rule sederhana:

```yaml
rules:
  - id: db-call-inside-loop
    message: "Avoid database/repository calls inside loops. Use bulk fetch, batching, join, or eager loading."
    severity: WARNING
    languages:
      - typescript
    patterns:
      - pattern-inside: |
          for (...) {
            ...
          }
      - pattern-either:
          - pattern: await $REPO.$METHOD(...)
          - pattern: await $DB.$METHOD(...)
```

Rule ini tidak sempurna, tapi cukup jadi alarm.

### 4. Senior menambahkan test query count

Untuk endpoint dashboard, tim membuat test:

```ts
it("does not use N+1 queries for user activity dashboard", async () => {
  await seedUsersWithActivity(100)

  const queryCounter = startQueryCounter()

  await getUserActivityDashboard()

  expect(queryCounter.count()).toBeLessThanOrEqual(5)
})
```

Sekarang behavior penting dilindungi.

### 5. Senior menambahkan verification command

Di repo:

```bash
./.ai/commands/verify.sh
```

Isinya:

```bash
set -euo pipefail

pnpm lint
pnpm typecheck
pnpm test
semgrep --config .semgrep/database.yml src/
```

Di `AGENTS.md`:

```markdown
Before declaring work complete, run:

./.ai/commands/verify.sh

If it fails, fix the root cause or explain why the failure is unrelated.
```

### 6. Task baru diberikan ke agent

Sekarang product minta fitur baru: "Export customer billing report."

Developer kasih prompt:

```text
Build customer billing report export.

Use existing reporting patterns.
Make sure it works for large customer lists.
Run verification before finishing.
```

Agent membaca `AGENTS.md`. Karena task menyentuh report/list/database, agent juga menarik skill `database-performance.md`.

### 7. Agent membuat plan lebih baik

Sebelum coding, agent menulis plan:

```text
Plan:
1. Find existing reporting API patterns.
2. Identify billing/customer repositories.
3. Avoid per-customer DB calls.
4. Bulk fetch invoices, payments, and subscriptions by customer IDs.
5. Build lookup maps in memory.
6. Add test for report output.
7. Add query-count test for 100 customers.
8. Run ./.ai/commands/verify.sh
```

Perhatikan bedanya: judgement senior sudah muncul di plan agent, sebelum kesalahan terjadi.

### 8. Agent menghasilkan kode yang lebih aman

Agent langsung menulis bulk pattern:

```ts
async function exportCustomerBillingReport(customerIds: string[]) {
  const customers = await customerRepository.findByIds(customerIds)

  const invoices = await invoiceRepository.findByCustomerIds(customerIds)
  const payments = await paymentRepository.findByCustomerIds(customerIds)
  const subscriptions = await subscriptionRepository.findByUserIds(customerIds)

  const invoicesByCustomerId = groupBy(invoices, "customerId")
  const paymentsByCustomerId = groupBy(payments, "customerId")
  const subscriptionByCustomerId = indexBy(subscriptions, "customerId")

  return customers.map((customer) => ({
    customerId: customer.id,
    email: customer.email,
    invoiceCount: invoicesByCustomerId.get(customer.id)?.length ?? 0,
    totalPaid: sumPayments(paymentsByCustomerId.get(customer.id) ?? []),
    subscriptionStatus:
      subscriptionByCustomerId.get(customer.id)?.status ?? "none",
  }))
}
```

### 9. Agent menjalankan verification

Agent menjalankan:

```bash
./.ai/commands/verify.sh
```

Hasil:

```text
lint: pass
typecheck: pass
test: pass
semgrep database rules: pass
```

Agent menulis PR summary:

```text
Implemented customer billing report export.

Database performance:
- Avoided per-customer queries.
- Bulk loaded invoices, payments, and subscriptions.
- Built lookup maps in memory.
- Added query-count regression test for 100 customers.
- Verification passed: lint, typecheck, test, Semgrep database rules.
```

### 10. Senior review jadi lebih ringan

Senior tidak lagi perlu komentar "jangan query di loop".
Dia hanya cek hal yang lebih tinggi:
- Apakah aggregation logic benar?
- Apakah report sesuai kebutuhan finance?
- Apakah memory usage aman untuk jumlah customer besar?
- Apakah export perlu streaming?
- Apakah akses admin sudah benar?

Jadi senior naik level: dari menangkap bug repetitif ke judgement arsitektural/domain.

### After dalam satu kalimat

**Kesalahan dicegah sebelum terjadi, oleh harness, lalu manusia fokus ke judgement yang lebih tinggi.**

---

## Before vs After secara tajam

Before:
- Agent menghasilkan kode.
- Kesalahan masuk PR.
- Senior menemukan kesalahan.
- Senior memberi komentar.
- Agent memperbaiki.
- Pelajaran hilang di thread review.
- Kesalahan muncul lagi di PR berikutnya.

After:
- Senior menemukan pola kesalahan.
- Pola diubah jadi:
  - rule pendek
  - skill file detail
  - contoh good/bad
  - test/linter/sensor
  - CI gate jika critical
- Agent membaca sebelum kerja.
- Sensor menangkap saat salah.
- Review manusia fokus ke judgement lebih tinggi.
- Pelajaran menetap di harness.

★ Insight:
Before adalah sistem berbasis "hero reviewer".
After adalah sistem berbasis "institutionalized judgement".

Di before, kualitas bergantung pada apakah senior sempat melihat PR.
Di after, kualitas mulai melekat pada sistem kerja.

---

## Skenario kedua: security bug authorization

Biar kelihatan bukan cuma database performance.

### BEFORE

Product minta:

"Tambahkan endpoint update project setting."

Agent menulis:

```ts
router.patch("/projects/:id/settings", requireAuth, async (req, res) => {
  const project = await projectRepository.findById(req.params.id)

  await projectRepository.updateSettings(project.id, req.body)

  res.json({ success: true })
})
```

Test pass karena user login bisa update project.

Senior review:

```text
This checks authentication but not authorization. A logged-in user could update another team's project.
```

Agent memperbaiki:

```ts
router.patch("/projects/:id/settings", requireAuth, async (req, res) => {
  const project = await projectRepository.findById(req.params.id)

  await requireProjectAdmin(req.user.id, project.id)

  await projectRepository.updateSettings(project.id, req.body)

  res.json({ success: true })
})
```

Selesai. Tapi pelajaran tetap cuma di PR.

### AFTER

Senior menambahkan ke `AGENTS.md`:

```markdown
## Authorization

- Authentication is not authorization.
- Every write endpoint must verify the caller is allowed to modify the target resource.
- For resource-scoped actions, check ownership, role, or explicit permission.
- Add negative tests for unauthorized users.
```

Skill file:

```text
.ai/skills/authorization-review.md
```

Isi ringkas:

```markdown
# Authorization Review Skill

Use this skill when adding or changing:
- API endpoints
- mutations
- write operations
- admin actions
- resource ownership logic

## Required checks

For every write operation:
1. Identify the actor.
2. Identify the target resource.
3. Identify the permission required.
4. Add a negative test where an authenticated but unauthorized user is denied.

## Common mistake

requireAuth only proves the user is logged in.
It does not prove the user can modify the resource.
```

Test template:

```ts
it("rejects authenticated users without project admin permission", async () => {
  const project = await seedProjectOwnedBy("team-a")
  const user = await seedUserInTeam("team-b")

  const response = await request(app)
    .patch(`/projects/${project.id}/settings`)
    .set("Authorization", authTokenFor(user))
    .send({ name: "Hacked" })

  expect(response.status).toBe(403)
})
```

CI gate:

```bash
pnpm test -- authorization
```

Next time agent bikin endpoint write, plan-nya berubah:

```text
This is a write endpoint.
I need:
- requireAuth
- project-level authorization
- negative test for unauthorized authenticated user
```

Senior tidak perlu mengulang komentar "authn bukan authz".

---

## Skenario ketiga: migration berbahaya

### BEFORE

Agent diminta:

"Rename column `status` to `subscription_status`."

Agent membuat migration:

```sql
ALTER TABLE subscriptions RENAME COLUMN status TO subscription_status;
```

Di dev aman.

Senior review:

```text
This is not safe. Existing app version still reads status. Use expand-contract migration.
```

Agent memperbaiki. Tapi lagi-lagi, lesson hilang.

### AFTER

Rule di `AGENTS.md`:

```markdown
## Database migration safety

- Do not perform breaking schema changes in one step.
- Use expand-contract for production tables.
- Backward-compatible migration first, code rollout second, cleanup later.
- Destructive changes require human approval.
```

Skill file:

```text
# Safe Migration Skill

Use this skill for schema changes.

## Expand-contract pattern

1. Add new nullable column.
2. Write to both old and new columns.
3. Backfill in batches.
4. Switch reads to the new column after verification.
5. Remove old column in a later deploy.

## Never do without approval

- Drop column
- Rename column directly
- Change type on large table
- Add non-concurrent index on large table
- Add non-null column without default/backfill plan
```

Agent berikutnya akan membuat plan:

```text
This rename should use expand-contract:
1. Add subscription_status.
2. Dual-write status and subscription_status.
3. Backfill existing rows.
4. Switch reads.
5. Later cleanup migration.
```

Senior review pindah dari "jangan rename langsung" ke "apakah rollout plan ini cocok dengan release cadence kita?"

---

## Pola before-after yang bisa dipakai sebagai template

Setiap kali ada review comment berulang, pakai format ini:

### Before

```text
Agent/junior membuat kesalahan.
Senior melihat.
Senior komentar.
Kesalahan diperbaiki.
Pelajaran hilang.
Kesalahan muncul lagi.
```

### After

```text
Senior melihat pola.
Pola diubah jadi:
- rule pendek
- skill file detail
- contoh good/bad
- test/linter/sensor
- CI gate jika critical
Agent membaca sebelum kerja.
Sensor menangkap saat salah.
Review manusia fokus ke judgement lebih tinggi.
```

### Pertanyaan konversinya

Untuk setiap komentar review, tanya:
- Apakah ini sering muncul?
- Kalau iya, bisa jadi rule tidak?
- Butuh contoh panjang? Kalau iya, jadikan skill.
- Bisa dicek otomatis? Kalau iya, buat linter/static analysis.
- Bisa dibuktikan behavior-nya? Kalau iya, buat test.
- Risikonya tinggi? Kalau iya, jadikan CI gate atau human approval rule.
- Butuh konteks keputusan? Kalau iya, buat ADR/concept note.

## Kesimpulan

Kalau gue ringkas jadi lebih tegas:

- Before: senior adalah **manual quality gate**.
- After: senior adalah **harness designer**.

Before, AI membuat output lebih banyak dan review burden makin berat.
After, AI tetap bikin output banyak, tapi sistem juga mulai menjaga output itu.

Yang gue suka dari model after adalah: kesalahan yang sama jadi lebih sulit muncul lagi, bukan hanya dikomentari ulang.

**Before: “Agent salah, senior koreksi.”**
**After: “Agent salah sekali, senior ubah sistem agar kesalahan itu makin sulit terulang.”**

## Related

- [[notes.agentic-engineering.self-hosted-agent-runner]]
- [[til.ai.semgrep.guardrails]]
- [[notes.security.sast.semgrep]]
- [[notes.agentic-engineering.cloud-agent.handson.reference.martin-fowler-harness-engineering]]
- [[notes.agentic-engineering.senior-judgement-to-harness]]
- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[zettel.moc.agentic-engineering]]
