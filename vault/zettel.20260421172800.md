---
id: zettel.20260421172800
title: "BMAD project context adalah konstitusi implementasi untuk AI agents, bukan dokumentasi biasa"
desc: "Mengurai halaman BMAD Project Context: fungsi, struktur, cara dibuat, dan peranannya dalam menjaga konsistensi agent."
tags:
  - bmad
  - project-context
  - ai-native
  - context-engineering
---

## Pertanyaan yang dibuka

1. Apa fungsi utama `project-context.md` dalam BMAD?
2. Bagaimana file ini dimuat dan dipakai oleh workflows BMAD?
3. Apa perbedaan antara project context dan dokumentasi biasa?

## Klaim utama

BMAD project context bukan sekadar dokumentasi proyek. Ia adalah konstitusi implementasi untuk AI agents yang memastikan semua workflow membuat keputusan yang konsisten dan sesuai dengan pola tim.

> Jika artefak lain menjelaskan "apa" dan "kenapa", project context menjelaskan "bagaimana" untuk agent.

`project-context.md` berfungsi sebagai memori operasional proyek: aturan lokal yang membuat agent bisa bertindak seolah mereka sudah cukup lama bekerja di repositori.

## Apa fungsi utama `project-context.md`?

Halaman Project Context menegaskan bahwa AI agents membuat keputusan implementasi secara terus menerus. Tanpa context ini, mereka akan:

* memakai pola generic yang tidak cocok,
* mengambil keputusan yang inkonsisten antar story,
* melewatkan constraint spesifik proyek,
* berjalan sendiri tanpa alignment.
* mengisi kekosongan dengan best practice umum yang tidak relevan.

Tanpa `project-context.md`, agent bisa mengalami tiga failure mode utama:

* Genericity failure: solusi teknis valid secara umum tapi tidak sesuai pola proyek.
* Cross-story inconsistency: perubahan antar story drift karena tidak ada shared rules.
* Constraint blindness: aturan lokal wajib tidak terlihat dari kode atau best practice umum.

`project-context.md` hadir sebagai file LLM-optimized yang memberi tahu agent apa yang perlu mereka ketahui sebelum bekerja.

## Bagaimana `project-context.md` bekerja?

Setiap workflow implementasi BMAD otomatis memuat file ini jika ada. Ini bukan hanya untuk dev story; arsitek juga memakainya.

Project context beroperasi sebagai lapisan context cross-cutting: bukan hanya untuk menulis kode, tetapi juga untuk architecture, story creation, review, planning, dan penyesuaian arah.

Workflows yang memuat context ini termasuk:

* `bmad-create-architecture`
* `bmad-create-story`
* `bmad-dev-story`
* `bmad-code-review`
* `bmad-quick-dev`
* `bmad-sprint-planning`
* `bmad-retrospective`
* `bmad-correct-course`

Implikasinya: project context bukan sekadar helper untuk developer. Ia adalah sumber kebenaran yang dipakai sepanjang lifecycle.

## Project Context dalam established project

Halaman Established Projects FAQ menegaskan realitas brownfield: kode lama punya sejarah, kompromi, dokumentasi bolong, dan pola yang tidak selalu ideal.

Untuk repo existing, `document-project` sangat direkomendasikan karena ia membantu agent membangun peta mental sistem yang tersebar. Ini bukan ritual wajib; tujuannya adalah context discovery yang cukup baik. Jika dokumentasi lain sudah komprehensif dan up to date, tujuan operasionalnya sama-sama tercapai.

Tanpa field survey seperti itu, agent cenderung melakukan dua kesalahan:

* terlalu percaya pada inferensi lokal dan pola yang tampak,
* atau menerapkan best practice umum yang tidak cocok dengan kebiasaan proyek.

## Quick Flow di existing project

Quick Flow tetap bisa dipakai untuk repo lama, khususnya untuk bug fix dan fitur kecil. Bedanya, workflow harus:

* auto-detect stack dan tooling yang ada,
* analisis pattern kode existing,
* deteksi conventions dan minta konfirmasi manusia,
* hasilkan spec yang menghormati konteks repo, bukan hanya ide ideal.

Itu membuat Quick Flow lebih seperti workflow adaptif daripada generator greenfield.

## Ketika codebase tidak mengikuti best practice

BMAD mengakui bahwa established project bisa hidup dengan pola yang bukan best practice universal. Dalam kasus itu, agent sebaiknya meminta konfirmasi:

* apakah kita mengikuti conventions existing untuk menjaga konsistensi?
* atau kita membangun standar baru yang lalu didokumentasikan secara jelas?

Ini menjadikan modernisasi sebuah keputusan sadar, bukan efek samping otomatis dari perbaikan kecil.

## Apa yang masuk ke dalamnya?

BMAD membagi file ini menjadi dua bagian utama:

### Technology Stack & Versions

Ini adalah daftar spesifik stack dan versi yang berlaku. Contohnya:

* Node.js 20.x, TypeScript 5.3, React 18.2
* Zustand, Vitest, Playwright, MSW
* Tailwind CSS dengan design tokens custom

Penting bahwa ini bukan jawaban umum. Ia harus spesifik untuk proyek.

### Critical Implementation Rules

Bagian ini berisi pola dan aturan yang agent mungkin tidak infer dari kode saja:

* aturan TypeScript (`strict`, `use interface for public APIs`)
* organisasi kode (`/src/components/`, `/src/lib/`)
* API dan networking (`apiClient` singleton, no direct fetch)
* testing pattern (`unit tests` untuk logika bisnis, `MSW` untuk integrasi)
* framework-specific rules (`handleError` wrapper, feature flag helper, file-based routing)

Halaman Project Context menegaskan: fokus pada hal yang tidak jelas dari kode. Jangan tulis standar universal. Tulis hanya yang akan membuat agent berbeda dari generic.

## Apa yang tidak boleh dimasukkan?

* Standar umum yang berlaku di semua proyek.
* Filosofi besar yang tidak memengaruhi keputusan implementasi lokal.
* Penjelasan teoretis tanpa aturan operasional.

Tulisan seharusnya hanya berisi aturan, pola, dan preferensi yang membuat tindakan agent menjadi berbeda dari inferensi kode generik.

## Kenapa ini penting

Project context bukan hanya dokumentasi tambahan. Ia adalah memori operasional yang menjaga agar semua agent BMAD mengikuti aturan lokal yang sama, bahkan ketika workflow mereka berbeda.

Tanpa file ini, detail seperti helper khusus, error wrapper, atau pola test dapat hilang dalam inferensi generik, yang menghasilkan perubahan yang secara teknis valid tapi tidak konsisten.

## Kapan membuat file ini?

BMAD memberikan tiga kesempatan:

* New project, before architecture: buat manual jika Anda sudah tahu preferensi teknis.
* New project, after architecture: generate setelah architecture untuk menangkap keputusan.
* Existing project: generate dari kode untuk menemukan pola yang ada.

Untuk Quick Flow, file ini jadi pengganti gap planning/architecture.

## Cara membuat dan memperbarui

Ada tiga opsi:

* manual creation di `_bmad-output/project-context.md`
* generate after architecture dengan `bmad-generate-project-context`
* generate for existing projects dengan `bmad-generate-project-context`

File ini hidup. Update ketika:

* keputusan arsitektur berubah,
* konvensi baru disetujui,
* implementasi mengungkap pola baru,
* agent menunjukkan perilaku yang salah.

## Mengapa ini penting untuk AI-native engineering?

Project context adalah bentuk nyata context engineering. Ia mengubah dokumentasi dari catatan pasif menjadi input operasional bagi agent.

Tanpa context:

* agent menggunakan generic patterns
* pola implementasi jadi inkonsisten
* agent tidak tahu constraint proyek
* semua agent membuat keputusan sendiri-sendiri

Dengan context:

* semua agent align dengan aturan proyek
* hasil implementasi konsisten antar story
* arsitektur dihormati selama pengembangan
* Quick Flow tetap terjebak di pola yang sesuai

## Insight penting

BMAD project context adalah konstitusi implementasi, bukan dokumentasi biasa. Ia memberi agent jawaban atas pertanyaan:

* gaya apa yang harus dipakai?
* pola apa yang harus diikuti?
* aturan khusus apa yang wajib dijaga?

Tanpa itu, BMAD hanya jadi rangka kerja AI dengan agen. Dengan itu, BMAD jadi rangka kerja AI dengan satu sumber kebenaran operasional.

## Lihat juga

* [[zettel.20260421172430]] — BMAD named agents membangun AI coworker model, bukan sekadar persona lucu
* [[zettel.20260421172636]] — BMAD activation flow dan customization: menyusun agent dari template, konteks, dan kebiasaan tim
* [[zettel.20260421171457]] — BMAD analysis phase menghentikan ketidakjelasan sebelum berubah jadi PRD dan architecture
* [[zettel.moc.software-architecture]]
