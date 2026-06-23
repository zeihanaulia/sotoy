
## Overview
Gue baca thread `cheese_cakee_9/status/2050938657545310628` dan yang keliatan jelas adalah kalau agentic coding sekarang bukan cuma soal prompt. Ini soal izin lokal: file yang bisa dibaca, command yang bisa dijalanin, dan data apa yang bisa keluar.

## 1. Risiko utama dari agentic coding tools
- agentic coding bukan cuma "AI yang nulis kode".
- tool bisa baca file, cari file, jalankan command, dan akses environment.
- risiko utamanya adalah transformasi dari autocomplete jadi process yang punya permission.
- pertanyaan penting: dia bisa baca apa? dia bisa jalanin apa? dia bisa kirim apa?

## 2. Kenapa filesystem access sensitif
- workstation dev menyimpan lebih dari source code.
- file sensitif umum:
  - `.env`,
  - `~/.ssh`,
  - `~/.aws/credentials`,
  - `~/.kube/config`,
  - shell history,
  - `~/.docker/config.json`,
  - npm/pnpm/yarn credential,
  - VS Code extension/session state.
- kalau agent punya akses folder, bahaya nyata kalau dia bisa naik ke parent atau home directory.

## 3. Data apa saja yang bisa kebaca atau ikut terkirim?
- langsung: source code, config, secret file.
- tersembunyi: terminal output, git history, environment variables, prompt history, file README/jadi source injection.
- kalau agent punya network egress, data ini gampang beroled keluar.
- penting: data nggak harus dilatih oleh model. Cukup muncul di request, log, atau artifact.

## 4. Korelasi dengan Deepsec
- Deepsec butuh akses kode buat nemuin vuln.
- thread cheesecake nunjukin bahwa akses itu sendiri bisa jadi risk.
- menurut gue, security harness yang bagus harus ngatur agent dan batas akses agent.
- tanpa boundary, agen pencari bug bisa jadi agen baca secret.

## 5. Mitigasi realistis
- pisahkan environment agent dari environment utama: sandbox, devcontainer, VM, atau folder bersih.
- jangan jalankan agent dari `$HOME` yang penuh credential.
- hindari secret production di laptop.
- audit file sensitif: `.env`, `.npmrc`, `.pypirc`, `.docker/config.json`, `~/.aws/credentials`, `~/.kube/config`, `~/.ssh`, shell history.
- batasi network egress untuk agent kalau bisa.
- jangan biarkan agent langsung jalanin perintah dari repo asing.
- treat repo eksternal sebagai data, bukan instruksi otomatis.
- pakai allowlist/denylist jika tool mendukung.

## Practical takeaway
Thread cheesecake jadi counterpoint yang sehat buat hype agentic coding.
- kalau developer nganggep tool ini cuma autocomplete, itu berbahaya.
- agentic coding nggak aman secara default.
- ini harus diperlakukan seperti process lokal dengan potensi exfiltration.

## Related Zettels
- [[zettel.20260505179967]]
- [[zettel.20260505179968]]
- [[zettel.20260505179972]]
- [[zettel.20260505179979]]
- [[zettel.20260505179983]]
- [[zettel.20260505179980]]
- [[daily.journal.2026.05.05]]
