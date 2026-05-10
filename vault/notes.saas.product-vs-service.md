---
id: notes.saas.product-vs-service
title: "Product vs Service dalam SaaS"
desc: "Perbandingan contoh HRIS, CRM, dan SDLC Studio untuk membedakan lapisan product dan service di SaaS B2B."
updated: 1778453382539
created: 1778453382539
tags:
  - saas
  - service
  - product
  - b2b
---

Gue pakai tiga contoh untuk bikin perbedaan product vs service lebih nyata.

## Prinsip utama

Di SaaS B2B ada dua lapisan yang harus dipisah:

- **Core capability** — hal utama yang software lakukan. Ini bagian product.
- **Delivery and experience system** — cara capability itu sampai, dipakai, dipelihara, dan terus memberi value. Ini bagian service.

Customer biasanya beli karena lapisan product. Mereka bertahan karena lapisan service.

## HRIS

### Product

Fokusnya pada fitur HR inti:

- employee data
- payroll
- leave management
- attendance
- performance review
- org chart
- approval workflow

Pertanyaan product:

- apakah fitur payroll ada?
- apakah cuti otomatis bisa?
- apakah approval berlapis tersedia?

### Service

Fokusnya pada pengalaman menjalankan HR lewat sistem itu:

- onboarding perusahaan baru secepat apa?
- import data karyawan dari Excel atau sistem lama mulus gak?
- setup role HR/manager/employee gampang atau membingungkan?
- apakah payroll rule bisa dipahami tanpa bantuan support panjang?
- sistem stabil saat tanggal gajian ramai?
- support dan incident handling cepat?

### Failure mode

HRIS bisa kaya fitur, tapi kalau onboarding lama, mapping payroll sering salah, dan role permission membingungkan, maka customer akan bilang:

> produknya bagus, tapi capek dipakainya.

Itu artinya product-nya oke, service-nya buruk.

## CRM

### Product

Fokusnya pada fitur sales & pipeline:

- lead management
- pipeline sales
- contact database
- email integration
- sales activity log
- forecast dashboard
- automation workflow

Pertanyaan product:

- apakah pipeline tracking lengkap?
- apakah auto follow-up bisa dijalankan?
- apakah dashboard forecast tersedia?

### Service

Fokusnya pada pengalaman tim sales pakai CRM:

- tim sales baru bisa aktif dalam 1 hari atau harus training 2 minggu?
- import kontak dari spreadsheet/CRM lama gampang gak?
- setting pipeline bisa self-service gak?
- mobile experience nyaman buat sales lapangan?
- sync email/calendar stabil?
- dashboard cepat saat meeting penting?
- adaptasi struktur tim atau region mudah?

### Failure mode

CRM dengan feature mendalam bisa kalah dari layanan yang fiturnya lebih tipis tapi onboardingnya cepat, penggunaan ringan, dan supportnya responsif.

Itu yang sering terjadi di SaaS: service experience yang simpel dan andal bisa mengalahkan product depth yang rumit.

## SDLC Studio (private note di vault2)

Contoh ini dijadikan private note di vault2 karena konteks project internal.

### Product

Capability utama:

- generate PRD/FSD/TSD
- breakdown ke task
- connect ke Jira/GitLab/Confluence
- coding agent bantu implementasi
- traceability antar artifact

Pertanyaan product:

- bisa generate dokumen apa saja?
- bisa kirim ke Jira/GitLab?
- bisa baca repo dan bantu coding?

### Service

Pertanyaan service yang lebih luas:

- tenant baru bisa setup workspace secepat apa?
- integrasi ke alat lain semudah apa?
- permission per tenant aman?
- user awal langsung paham flow atau bingung?
- artifact generation konsisten nggak?
- traceability jelas atau berantakan?
- kalau provider LLM down, service tetap graceful?
- cost visibility per tenant ada?
- feedback dari PO/engineer cepat masuk loop?
- team kedua/ketiga bisa onboard tanpa manual besar?

### Insight penting

Di SDLC Studio, AI generation itu cuma satu bagian dari product.
Service value-nya lebih banyak ditentukan oleh:

- tenant onboarding,
- permission model,
- traceability,
- integration reliability,
- observability,
- fallback behavior,
- feedback loop.

Kalau semua ini nggak beres, fitur AI yang canggih pun nggak cukup.

## Synthesis

Di ketiga contoh ini pola yang sama muncul:

- **Product** = apa yang sistem bisa lakukan.
- **Service** = bagaimana customer terus menerima manfaat dari itu secara konsisten.

Di SaaS B2B, capability menarik customer masuk. Experience yang bagus membuat mereka bertahan.

Jadi, buat desain SaaS, jangan terlalu cepat berhenti di fitur. Lihat juga bagaimana fitur itu disampaikan, dioperasikan, dan terus dijaga sebagai bagian dari layanan.
