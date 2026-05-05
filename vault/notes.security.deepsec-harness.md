---
id: notes.security.deepsec-harness
title: "Deepsec: security harness untuk codebase besar"
desc: "Analisis deepsec sebagai agentic security review orchestration dan cara pakainya di workflow nyata."
updated: 1777990955339
created: 1777990955339
tags:
  - notes
  - security
  - ai-security
  - deepsec
---

## Overview
Gue sekarang nangkep Deepsec bukan sebagai scanner biasa. Menurut gue dia lebih kayak "security harness" yang ngatur agent, bukan cuma ngasih AI buat ngecek kode.

## Masalah fundamental yang diselesaikan Deepsec
- repo modern terlalu besar buat direview manual.
- bug keamanan sering muncul dari relasi antar file, bukan pattern tunggal.
- scanner tradisional jago rule, tapi lemah kalau konteksnya kompleks.
- problem nyata biasanya ada di flow: auth, permission, webhook, server action, dan boundary data.
- Deepsec berusaha menemukan area sensitif dulu, kemudian ngerjain investigasi yang lebih dalam.

## Apa itu "security harness"?
- buat gue, harness itu sistem yang ngatur proses, bukan cuma model.
- dia merangkum: menentukan scope, ngejalain agent, validasi, ngasih severity, dan nempelkan owner.
- ini bedanya Deepsec sama scanner yang output-nya cuma "ada issue" tanpa bukti.
- kalau cuma scanner, outputnya mentah. kalau harness, outputnya mesti bisa ditindaklanjuti.

## Workflow Deepsec
### 1. Scan
- Deepsec mulai dari regex-only scan ke seluruh file.
- menurut gue ini langkah bagus: LLM mahal, jadi pakai dulu cara murah untuk cari hotspot.
- ini mirip cara kerja security engineer: jangan baca semua file, cari yang berisiko dulu.

### 2. Investigate
- setelah kandidat ketemu, baru agent masuk.
- agent ini nggak cuma cari pattern. dia nonton flow, cek mitigasi, lihat reachable path, dan nilai impact.
- intinya: bukan sekadar "ada input user". yang penting adalah "apakah kontrolnya cukup?"

### 3. Revalidate
- ini yang penting buat gue.
- Deepsec nggak berhenti di satu pass. ada run kedua buat ngecek hasil pertama.
- revalidate berfungsi buat nurunin false positive dan ngoreksi severity.
- kalau agent cuma sekali, hasilnya sering overclaim.

### 4. Enrich
- Deepsec nggak cuma kasih issue, tapi coba nempelkan metadata dan owner.
- ini penting karena kalau issue nggak punya pemilik, dia bakal mati di dashboard.
- temuan security harus bisa ditangani engineering, bukan cuma dicatat.

### 5. Export
- hasilnya bisa diekspor jadi instruksi, ticket, atau prompt agent lain.
- menurut gue ini poin kritis: output harus bisa langsung dipakai, bukan cuma "ada masalah".

## Use case realistis
### Audit repo besar sebelum release
- Deepsec paling masuk akal buat app yang kompleks: multi-tenant, admin API, billing, webhook.
- nggak semua commit perlu diskip. lebih cocok sebelum major release atau audit domain berisiko.

### Scheduled audit area berisiko
- menurut gue, lebih sehat jalankan berkala di repo penting.
- hasilnya masuk backlog security, lalu ditriage sebelum sprint.

### Fokus area sensitif
- yang worth: auth/session, RBAC/ABAC, tenant isolation, payment, webhook, upload, fetch, secret management.
- ini bikin Deepsec nggak jadi "satpam semua file".

### Custom matcher
- temuan awal nggak cukup. yang paling berguna adalah jika temuan itu jadi matcher baru.
- contoh: kalau satu endpoint admin ilang permission check, bikin matcher buat cari pola serupa.

### Maintainer OSS
- Deepsec juga bisa bantu OSS maintainer yang butuh laporan actionable.
- tapi disclosure harus hati-hati.

## Batasan dan risiko
- false positive masih ada.
- Deepsec bukan oracle. output tetap perlu triage manusia.
- kualitas sangat bergantung model, prompt, dan budget.
- biaya bisa besar kalau scan full repo tanpa prioritas.
- kalau codebase dieksekusi lewat cloud, kontrol source code masih penting.
- finding yang nggak actionable malah jadi beban.

## Implementasi sehat buat dunia nyata
- jangan langsung scan semua repo.
- mulai dari satu repo penting dan satu domain risiko.
- bikin rubric triage: validitas, reachable, impact, auth/public, confidence.
- ekspor langsung ke ticket dengan owner dan bukti.
- buat custom matcher dari temuan valid.
- scan manual dulu sebelum release besar, baru scale.
- CI gate cuma di area tertentu jika SNR-nya sudah bagus.

## Korelasi konsep lain
- SAST: Deepsec pakai rule awal, tapi nambah reasoning kontekstual.
- fuzzing: keduanya eksploratif. fuzzing punya oracle crash; Deepsec butuh verifikasi semantik.
- pentest: Deepsec agak mirip pola pikir pentester, tapi manusia masih lebih kuat di konteks bisnis dan exploit kompleks.
- Secure SDLC: Deepsec bisa jadi lapisan baru di antara SAST dan pentest manusia.

## Insight penting
- Deepsec bukan cuma agent. dia sistem kerja.
- tanpa scan awal, agent keborosan.
- tanpa investigation, scan cuma pattern matcher.
- tanpa revalidate, output rentan noisy.
- tanpa enrich, temuan bisa hilang.
- tanpa export, hasil nggak masuk workflow.
- yang penting bukan "pakai model apa", tapi "bagaimana temuan diverifikasi dan dikonversi jadi patch".

## Referensi terkait
- [[zettel.20260505179908]]

## Related Zettels
- [[zettel.20260505179969]]
- [[zettel.20260505179970]]
- [[zettel.20260505179973]]
- [[zettel.20260505179975]]
- [[zettel.20260505179977]]
- [[zettel.20260505179979]]
- [[zettel.20260505179980]]
- [[zettel.20260505179981]]
- [[zettel.20260505179982]]
- [[zettel.20260505179983]]
- [[daily.journal.2026.05.05]]
