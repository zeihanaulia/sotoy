---
id: notes.ai-agents.evolution-of-loops
title: "The Evolution of Agentic Loops: From ReAct to Orchestration"
desc: "Pemetaan evolusi pola kerja AI agent dari interaksi sederhana hingga sistem koordinasi multi-agent."
updated: 1781148619057
created: 1781148619027
tags:
  - notes
  - ai-agents
  - agentic-workflow
  - evolution
---

## Paradigma Evolusi Agent

Evolusi AI agent bukan sekadar peningkatan parameter model, melainkan pergeseran pada **kontrol siklus kerja**. Fokus utamanya adalah bagaimana memindahkan kendali dari interaksi manual manusia ke sistem otomatis yang terukur.

### Peta Evolusi Siklus Kerja

| Tahap | Nama Pola | Karakteristik Utama | Failure Mode yang Diatasi | Masalah Baru yang Muncul |
| :--- | :--- | :--- | :--- | :--- |
| 0 | **Chat** | Tanya $\rightarrow$ Jawab | - | Halusinasi, tidak ada aksi |
| 1 | **ReAct** | Thought $\rightarrow$ Action $\rightarrow$ Obs | Halusinasi tanpa observasi | Human-watched, single session |
| 2 | **AutoGPT** | Goal $\rightarrow$ Subtasks $\rightarrow$ Loop | Human micromanagement | Chaos autonomy, token burn |
| 3 | **Ralph Loop** | Fixed Prompt $\rightarrow$ Repo State | Context drift, chaos autonomy | Stopping condition rapuh |
| 4 | **`/goal`** | Iteration $\rightarrow$ Validator $\rightarrow$ Exit | Loop yang tidak tahu kapan berhenti | Validator bias/terlalu longgar |
| 5 | **Orchestration** | Orchestrator $\rightarrow$ Worker $\rightarrow$ Verifier | Keterbatasan satu agent/task | Cost, security, review bottleneck |

---

## Bedah Detail Tiap Tahap

### 1. ReAct (Reasoning + Acting)
Pola yang menggabungkan *reasoning trace* dan *action*. Model tidak hanya menghasilkan teks, tetapi berinteraksi dengan environment (misal: Wikipedia API, Shell).
- **Atomic Idea**: Model jangan hanya berpikir di internal; ia harus mengobservasi dunia luar untuk memperbarui pemahamannya.

### 2. AutoGPT (Autonomous Goal-Seeking)
Upaya untuk memindahkan agent dari *task-level* ke *goal-level*. Agent mencoba memecah goal besar menjadi subtask secara mandiri.
- **Atomic Idea**: Transisi dari assistant yang menggunakan tool menjadi pencari tujuan otonom.
- **Kritik**: Autonomy tanpa disiplin menghasilkan agent yang "terlihat sibuk" namun tidak produktif.

### 3. Ralph Loop (Disciplined Iteration)
Pola yang menekankan pada *context reset* dan penggunaan filesystem sebagai memory utama, bukan chat history.
- **Atomic Idea**: Gunakan repo sebagai memory; jangan biarkan chat history menjadi otak utama.
- **Karakteristik**: Menggunakan anchor file (misal: `LOOP.md`) untuk menjaga konsistensi antar iterasi.

### 4. `/goal` (Verified Stopping)
Versi produk dari loop yang memiliki *stopping condition* eksplisit. Loop berjalan hingga validator (deterministic atau model-based) mengonfirmasi penyelesaian.
- **Atomic Idea**: Loop harus memiliki definisi "selesai" yang bisa diverifikasi secara eksternal.

### 5. Multi-agent Orchestration (Systemic Coordination)
Layer tertinggi di mana sebuah *orchestrator* mengelola banyak worker loop dengan peran spesifik (Implementer, Reviewer, Security Checker).
- **Atomic Idea**: Agent bukan sekadar worker; ada manager loop yang mengatur distribusi kerja dan quality gate.

## Kesimpulan: Tiap Solusi adalah Respons terhadap Failure Mode

Evolusi ini menunjukkan bahwa tidak ada tahap "final". Setiap kemajuan dalam otonomi menciptakan masalah baru di layer yang lebih tinggi (misal: dari masalah halusinasi $\rightarrow$ masalah koordinasi $\rightarrow$ masalah biaya & security). 

Kunci dari implementasi yang sukses bukan pada pemilihan model tercanggih, melainkan pada desain **stopping condition, feedback loop, state management, dan human-in-the-loop verification**.

Referensi: Artikel Matt Van Horn & Diskusi Loop Engineering.
