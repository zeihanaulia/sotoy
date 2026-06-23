
## Inti Pemikiran

Masalah utama dalam workflow AI coding adalah developer sering menjadi "kurir" (messenger) yang memindahkan error dari terminal kembali ke AI. Rody (@0x_rody) mengusulkan perubahan paradigma: **"Done" berarti "Verified", bukan "Written".**

Tujuannya adalah mengubah workflow dari garis lurus (Write $\rightarrow$ Stop $\rightarrow$ Manual Check) menjadi loop (Write $\rightarrow$ Run Checks $\rightarrow$ Fix $\rightarrow$ Repeat $\rightarrow$ Stop when Verified).

## Setup 3 File untuk Loop Enforcement

Untuk memaksa AI mengikuti loop ini, diperlukan kombinasi antara kebijakan (policy), penegakan (enforcement), dan jalur eskalasi (escalation).

### 1. `CLAUDE.md` (The Protocol)
Berfungsi sebagai konstitusi kerja agent di root project.
- **Protokol**: Write $\rightarrow$ Run Checks (tests, linter, typecheck) $\rightarrow$ Fix root cause $\rightarrow$ Repeat (max 5x).
- **Strict Rules**:
    - Dilarang melaporkan "done" tanpa output check dari session saat ini.
    - **Dilarang melemahkan test** (menghapus assertion/skip test) agar terlihat pass. Perbaiki kodenya, bukan test-nya.

### 2. `.claude/settings.json` (The Enforcement)
Mengubah instruksi menjadi mekanisme fisik melalui hooks.
- **PostToolUse Hook**: Menjalankan typecheck (misal: `tsc --noEmit`) setiap kali agent melakukan `Write` atau `Edit`. Feedback masuk instan ke session.
- **Stop Hook**: Menjalankan test suite saat agent mencoba mengakhiri tugas. Jika gagal, output kegagalan memaksa agent kembali ke loop perbaikan.

### 3. `.claude/agents/fixer.md` (The Escalation)
Sub-agent khusus yang dipanggil ketika loop utama stuck (misal: error yang sama muncul 2x).
- **Tugas**: Diagnosis mendalam $\rightarrow$ Cari root cause $\rightarrow$ Fix hanya root cause tersebut $\rightarrow$ Verifikasi.
- **Guardrails**: Dilarang melakukan drive-by refactor, menghapus test, atau menyembunyikan error dengan try/catch.

## Analisis Loop yang Sehat

Loop yang efektif bukan loop yang berjalan selamanya, melainkan loop yang memiliki **Stop Condition** yang jelas:
1. **Success**: Semua check pass $\rightarrow$ Done.
2. **Limit**: Mencapai max attempts (misal: 5x) $\rightarrow$ Stop & report progress.
3. **Stagnation**: Error yang sama muncul berulang kali $\rightarrow$ Eskalasi ke `@fixer` atau manusia.

## Sintesis dengan Paradigma Lain

| Konsep | Hubungan dengan Setup Rody |
|---|---|
| **Loop Engineering (Addy/Matt)** | Implementasi mikro dari sistem orkestrasi (Protocol $\rightarrow$ Feedback $\rightarrow$ Retry $\rightarrow$ Escalation). |
| **Engineering Discipline (Allen)** | Penegakan aturan "jangan ubah test" untuk menjaga integritas guardrail. |
| **LDD (Nuno)** | Menggunakan test/linter sebagai oracle sederhana untuk memandu loop. |

## Referensi
- Thread X: https://x.com/0x_rody/status/2064728139314389073
