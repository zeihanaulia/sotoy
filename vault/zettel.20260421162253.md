---
id: zettel.20260421162253
title: "Classic, Modern, dan AI-native Software Engineering adalah tiga mode kerja, bukan disiplin formal"
desc: "Membedakan tiga mode engineering berdasarkan pusat gravitasi kerja, bukan pada istilah baku universal."
tags:
  - software-engineering
  - ai-native
  - modern-software-engineering
---

## Pertanyaan yang dibuka

1. Apa beda inti cara berpikir dari Classic, Modern, dan AI-native Software Engineering?
2. Dalam workflow nyata, siapa yang melakukan apa di tiap mode?
3. Kalau dikasih tugas yang sama, hasilnya akan berbeda di mana?
4. Trade-off dan failure mode masing-masing apa?

## Klaim utama

Classic, Modern, dan AI-native Software Engineering bukan tiga disiplin formal yang punya definisi universal. Mereka adalah tiga mode kerja engineering yang dibedakan oleh di mana letak tenaga utama engineering dikeluarkan.

## Definisi atomik

### Classic Software Engineering

* Pelaku utama: manusia.
* Coding, testing, dokumentasi, debugging, deployment banyak dilakukan manual atau semi-manual.
* Proses cenderung linear: requirement → design → code → test → release.
* Knowledge sering tersimpan di senior engineer dan dokumen formal.

Model mental: **software dibangun oleh manusia, dengan tool sebagai alat bantu pasif.**

### Modern Software Engineering

* Pelaku utama tetap manusia, tetapi delivery sangat diotomasi.
* CI/CD, cloud, observability, test automation, trunk-based development, infra-as-code, dan platform engineering menjadi norma.
* Feedback loop lebih cepat.

Model mental: **software dibangun oleh manusia, dibantu sistem automasi yang menjaga kualitas dan kecepatan.**

### AI-native Software Engineering

* Manusia tidak lagi menulis semua perubahan langsung.
* AI agent/model menjadi aktor aktif dalam analisis, implementasi, test generation, dokumentasi, refactor, dan eksplorasi codebase.
* Tugas engineer bergeser ke orkestrasi intent, context, constraint, workflow, dan verifikasi output AI.

Model mental: **software dibangun oleh manusia + AI sebagai co-worker operasional, di bawah constraint dan review yang didefinisikan manusia.**

## Perbedaan inti cara berpikir

* Classic = engineer sebagai pembuat langsung.
* Modern = engineer sebagai perancang dan pemelihara delivery system.
* AI-native = engineer sebagai orchestrator AI dan penyusun konteks.

## Siapa melakukan apa

### Classic

* Engineer menulis kode dan tes.
* QA melakukan verifikasi manual.
* Release engineer atau ops menjalankan deployment.
* Tool hanya membantu editing, version control, dan eksekusi manual.

### Modern

* Engineer menulis kode dan tes.
* Sistem otomatis menjalankan CI, build, test, security scan, deploy.
* Platform engineer menjaga pipeline dan observability.
* Manual review fokus pada desain dan kualitas.

### AI-native

* Engineer menulis spec, acceptance criteria, context, dan guardrail.
* AI agent menganalisis codebase, mengenerate kode, membuat tes, dan menyiapkan PR.
* Sistem otomatis masih melakukan validasi dan deployment.
* Engineer review hasil AI dan memutuskan aksi final.

## Skenario yang sama: fitur reset password

### Classic

* Requirement turun lewat tiket.
* Engineer implement manual endpoint, token, email, UI, validasi.
* QA mengetes manual/staging.
* Deploy prosedural.

Beban utama: ingatan engineer, navigasi codebase, komunikasi manusia, checklist manual.

### Modern

* Engineer masih menulis mayoritas kode.
* Namun kode diuji, dibuild, dan dideploy oleh pipeline otomatis.
* Observability dan rollback tersedia.

Beban utama: desain sistem, kualitas delivery, pipeline sehat.

### AI-native

* Engineer mendefinisikan spec, context, constraint, dan workflow.
* AI agent scan codebase, generate perubahan, dan jalankan tes.
* Engineer fokus pada review kualitas dan domain.

Beban utama: orkestrasi intent, context, guardrail, dan verifikasi AI.

## Trade-off dan failure mode

### Classic

* Kelebihan: kontrol manusia tinggi, reasoning eksplisit.
* Kekurangan: lambat, costly, knowledge bottleneck, mudah lupa.
* Failure mode: proses manual berat, release kaku, human error.

### Modern

* Kelebihan: lebih cepat, stabil, feedback loop pendek.
* Kekurangan: masih bergantung pada jam manusia untuk implementasi besar.
* Failure mode: tooling kompleks tanpa tujuan, pipeline rapuh, developer experience buruk.

### AI-native

* Kelebihan: perubahan multi-file cepat, eksplorasi murah, dokumentasi/test paralel.
* Kekurangan: spesifikasi jelek cepat jadi masalah, context miskin, overtrust AI.
* Failure mode: solusi terlihat rapi tapi salah domain/security/architecture; false confidence.

## Catatan penting

* AI-native bukan sekadar modern SE plus Copilot.
* Jika engineer masih menulis sebagian besar kode sendiri dan AI hanya autocomplete, itu lebih tepat disebut **modern engineering with AI assistance**.
* AI-native sehat dibangun di atas fondasi modern: repo rapi, test ada, observability hidup, boundary jelas.

## Lihat juga

* [[zettel.20260421161001]] — AI-native adalah jargon strategi yang menandai asumsi desain AI sebagai fondasi, bukan sekadar fitur tambahan
* [[zettel.moc.software-architecture]]
