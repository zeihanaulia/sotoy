
**Ringkasan**

Context-anchoring: praktik memindahkan konteks keputusan yang sifatnya ephemeral (mis. chat dengan AI) ke dokumen hidup level fitur supaya "the why" nggak hilang saat sesi terputus. Tujuannya: make restarts cheap — siapa pun bisa warm-start tanpa tanya ulang alasan desain.

**Dokumen Terkait**

- Literature note: [vault/zettel.literature.context-anchoring.md](vault/zettel.literature.context-anchoring.md)
- contoh permanent note: [vault/zettel.20260420131310.md](vault/zettel.20260420131310.md)
- Daftar zettel turunan: lihat bagian "Zettels yang Dibuat" di literature note.

**Kapan dipakai**

- Fitur lintas-sesi atau akan direvisit dalam >1 hari.
- Pekerjaan yang melibatkan >1 orang (handoff / review). 
- Keputusan yang punya dampak arsitektural atau mempengaruhi banyak komponen.

**Format Minimal Dokumen Fitur (recommended)**

- Judul: singkat, fitur/area
- Sections: Decisions, Reasons, Rejected alternatives, Open questions, State
- Metadata: date, owner, refs (issue/PR/file)

**Workflow Praktis (low-friction)**

1. Saat sesi chat/ideasi berakhir, si pemilik sesi minta ringkasan 2–3 baris (decision + why + refs).
2. Tempel ringkasan itu ke feature doc: buat file baru di repo/`vault/` atau update issue/PR.
3. Link feature doc ke issue/PR/PR description agar mudah ditemukan.
4. Reviewer/owner finalize saat PR merge: mark sebagai `status: settled` atau convert ke ADR jika berdampak besar.
5. Kalau perlu, tambahkan field `last-updated` dan siapa yang mengubah.

**Template YAML minimal (copy-paste)**

```yaml
title: "Feature X — quick context"
date: 2026-04-20
owner: @nama
decision: "Gunakan paginasi server-side"
reason: "Kurangi latency & memori di client"
refs:
  - issue: 123
  - files: src/feed/*
open_questions:
  - "Perlu mekanisme backfill untuk clients lama?"
status: draft
```

**Contoh VSCode snippet (paste ke `snippets/*.code-snippets`)**

```json
"Feature Context (quick)": {
  "prefix": "featctx",
  "body": [
    "title: \"${1:Feature X — quick context}\"",
    "date: ${TM_YEAR}-${TM_MONTH}-${TM_DAY}",
    "owner: ${2:@nama}",
    "decision: \"${3:Keputusan singkat}\"",
    "reason: \"${4:Alasan singkat}\"",
    "refs:",
    "  - issue: ${5:123}",
    "open_questions:",
    "  - \"${6:Pertanyaan terbuka}\"",
    "status: draft"
  ],
  "description": "Quick feature context template"
}
```

**Skrip shell kecil: buat feature doc dari template**

```bash
# buat-feature-doc.sh
set -e
slug="$1"
dir="vault/feature-docs"
mkdir -p "$dir"
file="$dir/${slug}.md"
cat > "$file" <<EOF
---
title: "${2:-Feature: $slug}"
date: $(date +%F)
owner: ${3:-unknown}
status: draft
---

## Decisions

## Reasons

## Rejected alternatives

## Open questions

## Refs

EOF
echo "Created $file"
```

Gunakan: `./buat-feature-doc.sh feature-x @nama` → membuat `vault/feature-docs/feature-x.md`.

**Praktik Integrasi ke Alur Kerja**

- Tambahkan checklist singkat di PR template: "Does this PR update the feature doc / add context?".
- Integrasi ke CI: optional check that feature-doc exists for PR touching feature folders (advanced).
- Education: ajarkan tim kebiasaan 30 detik: setiap sesi berakhir, tulis 1–2 kalimat.

**Risiko & Batasan**

- Overhead: jangan paksakan untuk quick-fixes; anchoring punya biaya dan harus di-kalibrasi.
- Kualitas ringkasan: ringkasan buruk lebih berbahaya daripada tidak ada ringkasan — fokus pada alasan singkat.

**Links & Next Steps**

- Buat snippet VSCode di repo/shared snippets.
- Implementasikan `vault/feature-docs/` sebagai tempat pendahuluan kalau tim mau simpannya di repo.
- Pertimbangkan automasi ringan (bot yang menempatkan TL;DR ke issue body saat ditag).

---

Jika mau, gue bisa: (a) commit file snippet VSCode, (b) tambah `buat-feature-doc.sh` ke repo, atau (c) buat checklist PR template contoh. Mana yang mau elu mulai dulu? 
