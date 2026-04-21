---
id: zettel.20260421172430
title: "BMAD named agents membangun AI coworker model, bukan sekadar persona lucu"
desc: "Analisis BMAD Named Agents: skill, named agent, customization sebagai struktur interaksi AI coworker dalam workflow engineering." 
tags:
  - bmad
  - named-agents
  - ai-native
  - workflow
  - agent-model
---

## Pertanyaan yang dibuka

1. Kenapa BMAD memakai named agents seperti Mary, John, Winston, dan Amelia?
2. Apa perbedaan antara skill, named agent, dan customization?
3. Bagaimana struktur ini mengubah cara pengguna berinteraksi dengan AI?

## Klaim utama

BMAD named agents bukan gimmick kosmetik. Mereka adalah cara menurunkan beban kognitif user sekaligus menjaga kontinuitas perilaku AI dalam alur kerja nyata.

> BMAD tidak sedang menjual maskot. Dia sedang membangun model interaksi AI coworker yang punya identitas, batas kemampuan, dan kebiasaan tim.

## Skill, named agent, dan customization

Halaman Named Agents memperkenalkan tiga primitive yang membentuk pengalaman agent BMAD.

### Skill

Skill adalah kemampuan diskret: brainstorming, bikin PRD, membuat arsitektur, menulis story, review kode. Ini adalah jawaban atas pertanyaan "apa yang bisa dilakukan?"

Skill adalah unit kerja. Jika Anda menghapus semua nama, inilah yang tersisa: katalog kapabilitas yang bisa dipanggil saat relevan.

### Named agent

Named agent adalah pembungkus identitas di atas kumpulan skill.

Misalnya:

* Mary = Business Analyst / analyst mode
* John = Product Manager / planning mode
* Winston = Architect / solutioning mode
* Amelia = Senior Engineer / implementation mode

Ini menjawab pertanyaan "siapa yang sedang melakukan pekerjaan ini?" Nama memberi anchor mental dan ekspektasi mode kerja.

### Customization

Customization membuat perilaku named agent bisa disesuaikan dengan tim dan organisasi.

Tanpa customization, semua tim dipaksa memakai perilaku default tunggal. Tanpa named agent, identitasnya jadi kurang stabil. Dengan customization, BMAD memberikan struktur bersama sekaligus ruang adaptasi lokal.

Customization memetakan aturan coding tim, preferensi artefak, toolchain, dan kebiasaan delivery ke dalam perilaku agent.

## Mengapa named agents penting?

Pilihan BMAD untuk memberi nama pada agent adalah tentang pengalaman pengguna, bukan hanya estetika.

### Menu vs named agents

Jika semua yang tersedia hanyalah menu atau daftar kemampuan, beban navigasi jatuh ke user. Mereka harus ingat skill apa yang dipakai untuk fase mana. Ini membuat antarmuka terasa kaku dan mengundang kesalahan.

### Blank prompt vs named agents

Blank prompt kelihatan natural, tetapi sebenarnya memindahkan beban ke pengguna untuk menebak frasa yang tepat dan mode kerja yang benar. Ini membuat user menjadi prompt engineer setiap kali.

Named agents mencoba memotong kedua beban itu. Mereka membuat interaksi terasa seperti bicara dengan teammate: cukup panggil nama, dan sistem mengarahkan ke mode kerja yang relevan.

## Apa yang sedang dibangun BMAD di sini?

BMAD membangun bukan sekadar AI tool, tetapi **AI coworker model**.

This model memiliki tiga lapisan:

* skill = tangan
* named agent = karakter / peran
* customization = kebiasaan lokal tim

Dengan lapisan ini, AI bisa diberikan batas peran, tidak terlalu cair, dan tetap bisa beradaptasi.

## Activation flow dan maknanya

Halaman ini juga menyoroti delapan langkah aktivasi agent:

1. resolve agent block
2. merge config
3. prepend steps
4. adopt persona
5. load persistent facts
6. load config bahasa/nama/output
7. greeting personal
8. append steps

Arti pentingnya bukan urutan teknis. Arti pentingnya adalah bahwa agent dibentuk secara bertahap: dari template umum, lalu ditambah konteks tim, lalu diberi identitas sosial, lalu diarahkan ke workflow.

Ini menunjukkan bahwa agent bukan entitas statis. Ia adalah sosok yang dirakit ketika dipanggil, dengan identitas yang tetap tetapi perilaku yang bisa dikustomisasi.

## Kenapa nama manusia berguna?

Nama manusia seperti Mary, John, Winston, dan Amelia menciptakan **social handle** yang lebih mudah diingat daripada `analysis-agent` atau `architect-agent`.

Fungsi ini bukan sekadar friendly interface. Nama membantu user membangun model mental: jika saya panggil Winston, saya mengharapkan mode engineer arsitektur. Ini menurunkan friction karena user tidak perlu memikirkan detail implementasi skill.

## Customization sebagai struktur, bukan bonus

BMAD menempatkan customization sebagai kaki ketiga dari sistem. Ini penting karena banyak tool AI punya customization, tetapi biasanya sifatnya tempelan. BMAD ingin customization menjadi bagian struktural.

Dengan customization, tim bisa menyimpan:

* standar coding,
* template artefak,
* fallback toolchain,
* aturan review,
* preferensi komunikasi.

Ini membuat agent terasa lebih "bagian dari tim" daripada hanya agent generik.

## Implikasi untuk AI-native engineering

BMAD named agents menyambungkan fase dan persona.

* Mary untuk Analysis,
* John untuk Planning,
* Winston untuk Solutioning,
* Amelia untuk Implementation.

Ini bukan kebetulan. Ini pemetaan dari fase ke mode kognitif. Analisis phase tidak hanya membutuhkan skill brainstorming; ia membutuhkan identitas analyst. Implementation bukan hanya membutuhkan skill dev-story; ia membutuhkan identitas engineer.

Dengan cara ini, BMAD menciptakan continuity expectation. Ketika Anda memanggil Mary, Anda tahu apa yang akan dilakukan dan bagaimana dia akan bekerja.

## Insight penting

Named agents dalam BMAD adalah cara mengemas workflow engineering menjadi antarmuka yang lebih murah secara mental.

Bukan:

* sekadar roleplay,
* bukan sekadar peran.

Tapi: **lapisan koordinasi antara skill, identity, dan local process.**

Itulah yang membuat halaman Named Agents relevan bagi AI-native engineering: ini adalah argumen bahwa pengalaman AI harus dibangun sebagai sistem coworker, bukan sebagai katalog fitur atau prompt.

## Lihat juga

* [[zettel.20260421170516]] — BMAD adalah framework workflow AI-native engineering yang mengganti prompt chaos dengan peran dan fase terstruktur
* [[zettel.20260421170812]] — BMAD Getting Started mengajarkan workflow awal AI-native engineering, bukan sekadar installasi
* [[zettel.20260421171457]] — BMAD analysis phase menghentikan ketidakjelasan sebelum berubah jadi PRD dan architecture
* [[zettel.20260421172636]] — BMAD activation flow dan customization: menyusun agent dari template, konteks, dan kebiasaan tim
* [[zettel.moc.software-architecture]]
