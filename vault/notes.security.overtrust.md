---
id: notes.security.overtrust
title: "Overtrust: lokal workstation scanner untuk trust boundary, bukan bug scanner"
desc: "Deep dive Overtrust, arsitektur, deteksi risiko agentic coding di workstation, use case, dan batasannya."
updated: 1777991439615
created: 1777991439615
tags:
  - notes
  - security
  - overtrust
  - agentic-coding
---

## Overview
Gue lihat `cheese-cakee/overtrust` sebagai lawan dari Deepsec. Deepsec nyari bug di codebase. Overtrust ngecek apakah workstation developer terlalu percaya pada tool, extension, process, dan config yang punya akses ke secret.

## 1. Masalah fundamental Overtrust
- workstation developer sekarang juga attack surface.
- bukan cuma secret yang ke-commit. secret bisa bocor gara-gara tool lokal punya akses file, process, atau shell.
- Overtrust nanya: "apa yang bisa nyentuh secret gue?", bukan sekadar "apa secret ada di repo?"
- ini penting buat era agentic coding.

## 2. Cara kerja tanpa AI
- Overtrust sengaja deterministik, offline, lokal.
- source code utamanya di `src/scanner/`:
  - `walker.cpp` buat file walk dan ignore path,
  - `classifier.cpp` buat deteksi jenis file,
  - `manifest.cpp` buat parse manifest VS Code / npm / Dockerfile,
  - `secrets.cpp` buat keyword → regex → entropy → FP guard,
  - `procscanner_linux.cpp` / `procscanner_win.cpp` buat scan process.
- semua logika ditulis di C++. nggak ada cloud, nggak ada LLM, jadi nggak nambah trust problem.
- untuk versi yang lebih detail tentang alur kerja lokal dan trust boundary, lihat [[notes.security.overtrust.workflow-detail]].

## 3. Kategori risiko yang dideteksi
- IDE extension: terminal access, auth provider, debug adapter, always-on activation.
- npm package: preinstall/postinstall, `curl | bash`.
- Dockerfile: root container, `curl | bash` pada RUN.
- Secrets: AWS, GitHub, OpenAI, Anthropic, Stripe, PEM.
- credential file: `~/.aws/credentials`, `.env`, SSH private key.
- Kubernetes: `~/.kube/config`.
- shell history: `.bash_history`, `.zsh_history`.
- process Linux: `CAP_SYS_PTRACE`, `CAP_SYS_ADMIN`, sensitive FD.
- process Windows: `SeDebugPrivilege`, `SeTcbPrivilege`, elevated token.
- AI tool: Cursor, Copilot, Codeium, dll.

## 4. Bedanya dengan secret scanner biasa
- secret scanner biasa cuma nyari secret di file.
- Overtrust juga ngecek siapa yang bisa akses secret itu sekarang.
- contoh: `.env` bisa ke-flag sama secret scanner. Overtrust juga bakal lihat extension auth provider, npm script, atau process privileged.
- menurut gue, Overtrust lebih mirip "workstation exposure scanner".

## 5. Implementasi nyata
- local inspection: jalankan `./build/overtrust` buat audit workstation.
- demo/tests: ada folder `demo/` buat ngecek fixture bahaya.
- CI: `--no-tui --report out.json --exit-code` buat pipeline.
- integrasi tim: ideal buat preflight sebelum agentic tool jalan atau sebelum scan Deepsec.
- praktik terbaik: jangan pakai `--exit-code` fail-all tanpa threshold, pakai report JSON buat triage.

## 6. Limitasi dan false positive
- Overtrust cuma risk indicator, bukan bukti breach.
- beberapa false positif mungkin muncul:
  - extension auth provider nggak otomatis jahat,
  - Dockerfile root nggak otomatis exploit,
  - `curl | bash` bisa juga buat installer sah,
  - shell history bisa berisi command biasa.
- score sederhana bikin orientasi gampang, tapi bisa oversimplify.
- Overtrust cuma bisa baca yang usernya bisa akses. area protected nggak ke-scan.
- rules hardcoded perlu maintenance seiring ekosistem berubah.
- nggak ada threat intel cloud, jadi nggak deteksi reputasi package terbaru.

## 7. Korelasi dengan agentic coding dan Deepsec
- thread cheesecake nanya: "apa yang bisa dibaca agentic coding tool?"
- Overtrust jawab: "workstation lo sendiri juga rentan." 
- Deepsec jawab: "apakah codebase lo punya vuln?"
- menurut gue, mereka saling melengkapi.
- jalankan Overtrust dulu buat ngecek boundary sebelum kasih agent akses.
- setelah lingkungan lebih bersih, baru pake Deepsec buat audit kode.

## 8. Insight penting
- Overtrust bukan cuma anti-secret leak. Dia ngecek trust boundary workstation.
- di era agentic tooling, developer sering kasih AI akses lokal tanpa sadar.
- pertanyaan yang lebih penting: "apa izin process ini?" bukan sekadar "apakah provider aman?"
- risiko agentic coding termasuk privilege lokal dan trust pada extension.

## Referensi
- `https://github.com/cheese-cakee/overtrust`
- `.references/overtrust` (local clone dari repo Overtrust)
- `README.md`
- `src/scanner/walker.cpp`
- `src/scanner/classifier.cpp`
- `src/scanner/manifest.cpp`
- `src/scanner/secrets.cpp`
- `src/scanner/procscanner_linux.cpp`
- `src/scanner/procscanner_win.cpp`
- `src/graph/graph.cpp`
- `src/report.cpp`
- `demo/`

## Practical position
- Overtrust cocok buat developer yang pengen tahu apakah workstation mereka terlalu terbuka.
- lebih cocok sebagai audit/preflight daripada blocking gate setiap commit.
- jangan anggap ini pengganti secret scanner atau pentest.
- idealnya dipakai bareng secret scanner, SCA, dan Deepsec.

## Related Zettels
- [[zettel.20260505179968]]
- [[zettel.20260505179971]]
- [[zettel.20260505179972]]
- [[zettel.20260505179979]]
- [[zettel.20260505179980]]
- [[zettel.20260505179983]]
