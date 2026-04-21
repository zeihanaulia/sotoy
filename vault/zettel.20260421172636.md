---
id: zettel.20260421172636
title: "BMAD activation flow dan customization: menyusun agent dari template, konteks, dan kebiasaan tim"
desc: "Analisis BMAD tentang cara named agent diaktifkan dan bagaimana customization diperlakukan sebagai bagian struktural dari agent behavior." 
tags:
  - bmad
  - named-agents
  - customization
  - activation-flow
  - ai-native
---

## Pertanyaan yang dibuka

1. Bagaimana BMAD membentuk satu named agent saat dipanggil?
2. Mengapa activation flow penting untuk konsistensi dan adaptasi tim?
3. Apa peran customization dalam membuat agent layak dipakai di dunia nyata?

## Klaim utama

BMAD activation flow menunjukkan bahwa named agent bukan identitas statis. Ia adalah agent yang dirakit setiap kali dipanggil: template umum + konteks tim + override personal.

> Dalam BMAD, agent bukan hanya "Mary exists". Dia adalah "Mary in this team, dengan kebiasaan ini, pada sesi ini."

## Activation flow: apa yang terjadi saat agent dinyalakan

Halaman Named Agents menyebutkan delapan langkah aktivasi. Secara konseptual, urutannya menunjukkan bahwa agent dibentuk lebih dalam daripada sekadar memanggil sebuah persona.

### 1. Resolve agent block

Ini berarti BMAD mulai dengan definisi agent yang sudah ada: skill, voice, role, default behavior.

### 2. Merge config

Di sini BMAD menggabungkan konfigurasi global agent dengan override tim. Artinya perilaku agent tidak hanya berdasarkan template default.

### 3. Prepend steps

Langkah-langkah tambahan yang dijalankan sebelum persona aktif. Contohnya, persiapan konteks awal atau checklist yang harus dipasang.

### 4. Adopt persona

Agent mengambil karakter dan mode kerja tertentu: analyst, architect, dev, dsb. Ini bukan hanya nama, tetapi flow mental.

### 5. Load persistent facts

Informasi yang tidak boleh hilang demi menjaga konsistensi: aturan tim, preferensi tool, knowledge organisasi.

### 6. Load config language/name/output

Agent disesuaikan dengan setting bahasa, nama, dan format keluaran yang relevan.

### 7. Greeting personal

Memberi kesan bahwa agent ini terhubung ke sesi, bukan hanya template kosong.

### 8. Append steps

Langkah tambahan yang dijalankan setelah persona aktif: misalnya tugas pengingat, atau hooking ke workflow selanjutnya.

## Kenapa urutan ini penting?

Karena urutan ini memisahkan tiga hal berbeda. Pertama, identitas umum agent. Kedua, konteks tim. Ketiga, kebiasaan lokal dan preferensi.

Jika semua digabung sekaligus tanpa struktur, agent akan menjadi lumpuh dan tidak bisa dikustomisasi dengan aman. Dengan alur ini, BMAD menunjukkan bahwa agent dapat tetap memiliki bentuk umum yang konsisten, sambil berevolusi sesuai tim.

## Customization sebagai bagian struktural

BMAD tidak memposisikan customization sebagai fitur tambahan. Ia adalah kaki ketiga dari sistem named agent.

Tanpa customization, seluruh agent akan terasa generik. Tanpa named agent, customization tidak punya tempat untuk menetap. Bersama-sama, mereka membuat model agent BMAD:

* skill = apa yang bisa dilakukan,
* named agent = siapa yang melakukannya,
* customization = bagaimana dia melakukannya dalam konteks tim.

## Jenis kustomisasi BMAD

Halaman ini menjelaskan dua jenis utama:

* team overrides — konfigurasi yang di-commit agar seluruh tim punya perilaku yang konsisten.
* personal overrides — preferensi individu yang tidak di-commit, untuk kebiasaan pribadi.

Perbedaan ini penting. Team overrides menanamkan standar dan guardrail. Personal overrides memberi fleksibilitas tanpa mengacaukan standar.

## Contoh relevansi dunia nyata

Bayangkan Amelia dipanggil untuk `bmad-dev-story` di dua tim berbeda.

* Di tim A, ia pakai pola `feature branch + PR + unit test first`.
* Di tim B, ia pakai `trunk-based + CI gated commit + contract test`.

Nama Amelia tetap sama, tetapi perilaku detailnya berbeda karena customization tim. Ini memungkinkan user tetap menggunakan anchor mental "Amelia untuk implementasi", tanpa harus memikirkan detail toolchain setiap kali.

## Mengapa customization bukan sekadar prompt template?

Banyak platform lain memberi kemungkinan "custom instructions" atau "preferred style." BMAD menempatkannya lebih dalam: pada activation flow agent.

Artinya customization BMAD bukan hanya mengubah cara menjawab. Ia mengubah layer yang aktif sebelum jawaban dibuat:

* mesin mana yang dipakai,
* konteks apa yang dimuat,
* batasan mana yang diterapkan,
* pekerjaan mana yang diprioritaskan.

## Implikasi untuk AI-native engineering

Activation flow + customization membuat BMAD lebih mirip sistem staff engineer otomatis daripada assistant generik.

### Konsistensi

User tahu apa yang diharapkan dari Mary, John, Winston, Amelia karena activation flow memberi mereka konteks yang seragam.

### Adaptasi

Tim bisa melokalkan agent tanpa merusak identitas dasar. Ini penting untuk adopsi di organisasi nyata.

### Reduksi friksi

User tidak perlu mengingat apakah "feature branch" harus disebutkan setiap kali. Mereka cukup memanggil nama agent, dan kebiasaan tim sudah terpasang.

## Insight penting

BMAD activation flow memperlihatkan bahwa named agents bukan hanya persona sosial.

Ia adalah mekanisme untuk merakit identitas agent yang:

* stabil secara ekspektasi,
* adaptif secara perilaku,
* dan terikat ke konteks tim.

Ini membuat interaksi AI lebih dapat diandalkan daripada antarmuka agen yang langsung dan generik.

## Lihat juga

* [[zettel.20260421172430]] — BMAD named agents membangun AI coworker model, bukan sekadar persona lucu
* [[zettel.20260421170812]] — BMAD Getting Started mengajarkan workflow awal AI-native engineering, bukan sekadar installasi
* [[zettel.20260421171457]] — BMAD analysis phase menghentikan ketidakjelasan sebelum berubah jadi PRD dan architecture
* [[zettel.moc.software-architecture]]
