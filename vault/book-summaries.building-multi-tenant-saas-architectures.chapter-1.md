---
id: book-summaries.building-multi-tenant-saas-architectures.chapter-1
title: "Chapter 1 — The SaaS Mindset"
desc: "Ringkasan Chapter 1 yang menegaskan SaaS sebagai model bisnis, operasi, dan layanan, bukan sekadar teknologi."
updated: 1778453922420
created: 1778452709476
published: true
tags:
  - saas
  - mindset
  - multi-tenancy
  - architecture
---

Chapter 1 ini terasa seperti pergeseran cara pikir. Setelah Preface bilang kenapa buku ini perlu ada, di chapter ini Golding bikin kita sepakat dulu bahwa SaaS bukan sekadar teknologi atau deployment model.

Yang paling gue ingat adalah dua kalimat ini:

> “It’s essential for SaaS architects to understand that SaaS is not a technology-first mindset.”

> “With SaaS, we shift from creating a product to creating a service.”

Itu bukan jargon. Itu mengubah pusat perhatian dari "apa yang dibangun" jadi "bagaimana value itu terus dialami." Kalau kamu masih nganggap SaaS cuma berarti cloud, Kubernetes, atau multi-tenant DB, kamu bakal gagal nangkap ruh chapter ini.

## 1) Product mindset fokus ke apa yang dibangun

Kalau kamu building product, yang biasanya kamu tanyakan adalah:

- fitur apa yang dibutuhkan?
- capability apa yang harus tersedia?
- gap mana yang bisa ditutup?
- ini bisa dijual nggak?

Golding bilang model product-centric biasanya masih cukup untuk software yang diinstall per-customer. Di situ, fokusnya adalah barangnya ada, lalu customer membeli.

## 2) Service mindset fokus ke bagaimana value dialami

Begitu masuk SaaS, pertanyaannya berubah jadi:

- onboarding semudah apa?
- time to value cepat atau lama?
- seberapa sering downtime terjadi?
- feedback user masuk seberapa cepat?
- update terasa sebagai improvement berkelanjutan atau gangguan?

Analogi restorannya pas: makanan itu product. Salam di pintu, air minum, kecepatan waiter, itu service.

Di SaaS, aplikasi bisa fiturnya lengkap, tapi kalau pengalaman onboarding, reliability, dan support jelek, tenant akan tetap sakit hati.

## 3) Product bisa statis, service harus terus hidup

Product mentality mudah jatuh pada pola "kita bikin, lalu customer gunakan." Service mentality nggak bisa kayak gitu. Service itu selalu berjalan.

Dalam model SaaS, tenant hanya melihat permukaan service. Mereka nggak peduli patch, konfigurasi infra, atau deployment pipeline. Mereka peduli apakah mereka terus dapat value.

Jadi operation bukan urusan belakang layar saja. Uptime, deployment, dan onboarding adalah bagian dari experience yang dirasakan tenant.

## 4) Service mindset berbeda dari product mindset secara konseptual

Model software lama sering sales-driven. Itu bisa membuat organisasi kejar one-off request demi menutup deal.

Tapi Golding bilang:

> “the needs of the many should always outweigh the needs of the few.”

Ini penting. Service mindset bilang:

- jangan korbankan kualitas sistem untuk satu customer besar,
- jangan biarkan satu fitur khusus merusak agility dan operability untuk semua tenant.

Keputusan SaaS harus dilihat secara sistemik, bukan per deal.

## 5) Success metric berubah

Di product mindset, metrik sukses biasanya:

- feature completeness,
- roadmap delivery,
- win rate,
- customer acquisition.

Di service mindset, metriknya melebar jadi:

- onboarding completion time,
- time to value,
- availability / reliability,
- release frequency,
- support responsiveness,
- feedback loop,
- retention / churn,
- tenant satisfaction.

Bukan sekadar "fitur selesai", tapi "apakah service experience membaik?"

## 6) Organisasi harus berubah juga

Ini bukan cuma urusan PM atau arsitek. Semua peran terpengaruh.

- Product owner harus mikir onboarding dan operational attributes.
- Engineer harus mikir apakah solusi mempercepat perubahan, meningkatkan reliabilitas, dan memudahkan operasi.
- QA harus menjaga kualitas experience, bukan sekadar memvalidasi fitur.

Kalau kamu masih building product, organisasi cenderung build lalu handoff. Kalau kamu building service, semua orang harus rapat karena semua orang ikut bentuk pengalaman tenant.

## 7) Ini penting karena SaaS menurut Golding adalah service-centric

Definisi SaaS yang dia hadirkan adalah:

> “a low-friction, service-centric model that maximizes value for customers and providers.”

Fokusnya: low-friction dan service-centric. Jadi SaaS bukan cuma software yang bisa diakses lewat internet. SaaS adalah software yang dibungkus sebagai experience berkelanjutan dengan friction rendah.

Kalau kamu masih tertarik pada product-only, kamu akan lupa friction seperti:

- daftar yang susah,
- setup lama,
- billing yang nggak jelas,
- support lambat,
- rollout yang mengganggu.

Semua itu bukan "fitur", tapi mereka masih membunuh value.

## Synthesizing: product vs service dalam SaaS

Kalau gue ringkas:

**Building product** = optimalisasi pada apa yang dibuat.
**Building service** = optimalisasi pada bagaimana value terus dialami.

Di SaaS, Golding jelas memihak yang kedua. Karena tenant nggak beli sekadar fitur. Mereka membeli pengalaman yang terus hidup.

## Bagaimana chapter ini mendukung keseluruhan buku

Chapter 1 tidak hanya mengajarkan istilah baru. Dia memindahkan pusat cara mikir:

- dari "apa yang saya bangun" ke "bagaimana tenant merasakan value"
- dari "shared infra vs dedicated" ke "apakah service yang dirasakan tetap terpusat dan rapi"
- dari "kejar one-off deal" ke "jaga service kolektif"

Itu membuat bab selanjutnya bukan langsung soal teknis. Mereka jadi soal bagaimana pola teknis itu membantu tujuan layanan dan bisnis.

Kalau lo mau, next kita bisa bikin **10 takeaways paling penting dari Chapter 1** atau langsung ke **Chapter 2: Multi-Tenant Architecture Fundamentals**.
