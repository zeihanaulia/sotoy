---
id: notes.paper.2604.05000v1.closed-loop-workflow
title: "Paper arXiv 2604.05000v1: Closed-loop backlog workflow"
description: "Ringkasan paper tentang alur kerja closed-loop dari dokumen sumber ke backlog, fix queue, verification, publish, dan reconciliation."
tags:
  - paper
  - workflow
  - backlog
  - ai
status: published
source: https://arxiv.org/html/2604.05000v1
created: 1778555015045
updated: 1778604764488
---

## Konteks

Dari gue, paper ini penting karena menjelaskan bagaimana workflow closed-loop seharusnya bekerja untuk perbaikan kode dan backlog. Ini bukan sekadar chatbot yang bilang "generate fix". Arti workflow di sini adalah alur kerja sistem dari backlog mentah sampai ticket selesai/diverifikasi, di mana AI hanyalah salah satu operator di dalam pabrik kecil itu.

Intinya:

`source docs / Jira / scan finding → canonical backlog → grooming → fix queue → isolated code fix → verification → publish ke Jira → reconcile balik ke backlog → audit trail`

## 5 Pertanyaan Kunci

1. Dari mana kerjaan masuk?
2. Bagaimana sistem memutuskan ticket mana yang aman dikerjakan?
3. Kapan AI boleh mengubah kode?
4. Siapa yang mengecek hasilnya?
5. Bagaimana hasilnya balik ke Jira dan backlog?

## 1. Intake: dari mana kerjaan masuk?

Input datang dari banyak sumber, bukan cuma Jira. Paper ini menyebut setidaknya 13 dokumen terstruktur sebagai sumber:

- planning document
- design spec
- architecture review
- security assessment
- deployment manifest
- runbook
- existing Jira tickets
- codebase scan findings

Workflow Lane 1 adalah `Backlog Sync & Intake`.

Tugasnya:

- membaca semua sumber,
- membuat item backlog yang eksplisit,
- menambahkan field minimal: identifier, title, description, source reference, tags, priority, owner.

**Atomic idea**: kerjaan harus dibuat eksplisit dulu sebelum bisa diotomasi. Kalau requirement masih cuma "ada di dokumen", agent belum boleh asal memperbaiki.

## 2. Canonical backlog: sumber kebenaran lokal

Paper ini tidak menjadikan Jira sebagai source of truth utama. Jira hanya public status surface. Source of truth yang otoritatif adalah **canonical backlog lokal** yang versioned.

Analogi:

- `canonical backlog = buku besar akuntansi`
- `Jira = papan pengumuman publik`

Workflow-nya:

```
Raw input
  ↓
Canonical backlog lokal
  ↓
Jira disinkronkan sebagai representasi publik
```

Ini penting, karena kalau Jira langsung dianggap kebenaran utama, agent bisa terjebak oleh status yang salah, duplicate ticket, atau komentar tidak lengkap.

## 3. Canonicalization dan confidence tiers

Setelah item masuk backlog, sistem melakukan dedup dan matching.

Strateginya meliputi:

- exact tag matching,
- key matching,
- summary similarity,
- fuzzy text matching.

Paper memakai score similarity `s` dengan tier:

```
s >= 0.83       → autonomous action
0.50 <= s < 0.83 → human review
s < 0.50        → halt / re-ingest
```

**Atomic idea**: autonomy bukan boolean; autonomy adalah confidence tier.

Sistem menanyakan:

> seberapa yakin item ini cocok dengan task/fix plan yang sudah dikenal?

Kalau sangat yakin, boleh lanjut. Kalau setengah yakin, manusia harus review. Kalau rendah, jangan diteruskan.

## 4. Grooming: menyiapkan strategi fix

Lane 3 adalah `Backlog Groomer`.
Dia tidak langsung memperbaiki kode. Dia menyiapkan `fix_queue`.

Isi `fix_queue` kira-kira:

- ticket_id
- priority_score
- priority_type
- relevant_paths
- area
- confidence
- fix_strategy

Lane 3 berperan seperti tech lead kecil: menyortir ticket, menentukan mana yang actionable, memilih area kode relevan, dan mengirim ke Lane 4.

**Atomic idea**: agent fixer tidak boleh memilih sendiri sesukanya. Dia cuma mengerjakan queue yang sudah digrooming.

## 5. Claim ticket: ownership harus terlihat

Sebelum Lane 4 membaca kode, agent harus mengunci ticket di Jira dengan transisi:

```
To Do → In Progress
```

Fungsinya sebagai distributed lock.
Kalau gagal, berarti ticket sudah diklaim agent lain atau manusia, maka worker harus abandon dan ambil ticket lain.

**Atomic idea**: sebelum agent mengubah kode, ownership harus terlihat secara eksternal.

## 6. Execution: isolated worktree

Lane 4 adalah AI Code Fixer.
Dia bekerja di isolated worktree, bukan on main working directory.

Workflow:

- ticket diklaim,
- buat isolated worktree,
- AI/code fixer apply perubahan,
- generate diff,
- simpan evidence.

Ada time budget:

- standard hourly run: 45 menit,
- nightly deep sweep: 120 menit,
- checkpoint 10 menit,
- kalau stuck → hard stop.

Kalau gagal, worktree dibuang dan ticket kembali ke queue.

**Atomic idea**: agent boleh eksperimen, tapi eksperimennya terjadi di ruang isolasi.

## 7. Verification: executor tidak boleh jadi auditor

Ini prinsip paling penting.
Setelah Lane 4 membuat perubahan, Lane 6 menjalankan quality gate.

Verifikator meliputi:

- product verifier: compile, unit test, integration constraint,
- security verifier: npm audit, eslint/static analysis, security ticket verifier,
- mutation/state check.

Workflow:

```
Diff dari Lane 4
  ↓
Lane 6: Quality Gate
  ↓
Pass atau fail
```

Kalau pass:

```
In Progress → Done
```

Kalau fail:

```
In Progress → To Do
```

Fail kembali ke `To Do` supaya harus melewati pipeline lagi dengan review baru.

**Atomic idea**: failure harus balik ke sistem keputusan, bukan dipaksa lanjut oleh agent yang sama.

## 8. Publication: post ke Jira dengan deduplication

Setelah verification selesai, hasil dipublish ke Jira.

Ada tiga lapis dedup:

- local receipt log,
- Jira comment history,
- per-run cache.

Output yang dipost harus mencakup:

- run ID,
- timestamp,
- transition ID,
- permalink ke evidence log.

Tujuannya agar manusia bisa menelusuri:

- ticket ini berubah karena run mana,
- apa input-nya,
- apa diff-nya,
- verifier apa yang jalan,
- hasilnya apa.

## 9. Reconciliation: sinkronisasi balik ke canonical backlog

Setelah Jira diperbarui, sistem reconcile ke canonical backlog.

Workflow:

```
Jira result
  ↓
Reconciliation
  ↓
Update canonical backlog
  ↓
Commit/versioning dengan run ID + timestamp
```

Ini yang membuat loop-nya closed. Bukan sekadar `agent fix ticket → selesai`, tapi `agent fix ticket → verify → publish → reconcile → state sistem berubah.`

## 10. Ops intelligence dan recovery

Lane 5 adalah `Ops Intelligence`.

Dia memantau:

- lane health,
- Jira connectivity,
- stale lock,
- stale `In Progress` ticket,
- aging `On Hold` ticket,
- queue drain,
- degraded mode.

Kalau Jira down, sistem masuk degraded mode dan menyimpan intent lokal:

- jira_write_outbox.json,
- mcp_replay_needed.json,
- jira_fallback_queue.md.

Begitu Jira hidup lagi, Lane 5 replay queued writes.

**Atomic idea**: automation yang bergantung pada Jira tidak boleh langsung corrupt saat Jira bermasalah.

## 11. Lane ringkas

Ringkasnya ada tujuh lane:

- Lane 1 = intake + backlog sync
- Lane 2 = codebase auditor read-only
- Lane 3 = grooming, dedup, scoring, fix queue
- Lane 4 = AI fixer apply perubahan
- Lane 5 = ops watchdog dan recovery
- Lane 6 = quality gate dan verifier
- Lane 7 = spec completeness auditor

## 12. Insight

Workflow paper ini bukan "AI baca ticket lalu langsung ngoding".

Dia lebih mirip pabrik kecil:

- intake,
- sortir,
- eksekusi,
- quality control,
- publikasi,
- audit.

AI hanya satu operator di pabrik itu, bukan bos bebas.

Kalau mau meniru, jangan mulai dari "bikin 7 agent". Mulai dari loop minimal:

1. canonical backlog,
2. claim/lock mechanism,
3. executor,
4. verifier terpisah,
5. evidence log,
6. failure kembali ke backlog.

Kalau enam hal itu belum ada, nambah agent cuma bikin automation kelihatan canggih tapi state-nya rapuh.
