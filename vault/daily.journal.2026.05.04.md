---
id: daily.journal.2026.05.04
title: '2026-05-04'
desc: ''
tags:
  - daily
  - browser-automation
  - stealth
  - agent
  - knowledge-graph
  - code-review
  - research
created: 1777865970903
updated: 1777866319315
traitIds:
  - journalNote
---

- [Obscura oleh h4ckf0r0day](https://github.com/h4ckf0r0day/obscura)
  - Post LinkedIn Eric Vyacheslav ngasih framing Obscura sebagai headless browser engine open-source buat web scraping dan AI automation.
  - Klaim utamanya: binary kecil (~70MB), startup cepat, load page 85ms, RAM ~30MB, serta mode stealth buat mengurangi deteksi bot.
  - Inti pesan yang gue tangkap: ini bukan cuma tools baru, tapi pitch “lebih ringan, lebih cepat, dan lebih susah dideteksi” dibanding stack browser automation biasa.

- 4 pertanyaan kunci buat ngecek hype ini:
  - Sebenarnya post ini lagi ngomongin apa?
    - Obscura diposisikan sebagai alternatif [Puppeteer](https://github.com/puppeteer/puppeteer)/[Playwright](https://github.com/microsoft/playwright) dengan footprint kecil dan kemampuan stealth yang diperkuat.
  - Kenapa Obscura dianggap menarik?
    - Karena menargetkan dua bottleneck sekaligus: biaya resource dan deteksi anti-bot.
    - Kalau benar ringan, cepat, dan kompatibel, ini bisa beda buat scraping skala besar dan agent automation.
  - Klaim mana yang kuat, dan mana yang kebanyakan hype?
    - Masuk akal: binary kecil, boot cepat, footprint rendah, Rust + V8 + CDP, upaya masking fingerprint.
    - Perlu ditahan: claim "no detector can catch it" dan "drop-in replacement" tanpa bukti kompatibilitas penuh.
  - Implikasi praktis dan risikonya apa?
    - Praktis: cocok untuk scraping terkontrol, AI agent ringan, internal automation, dan testing tertentu.
    - Risiko: berada di wilayah dual-use, bisa dipakai untuk abuse, dan deteksi bot sebenarnya lebih dari sekadar browser fingerprint.

- Why the stealth claim feels sensitif:
  - Deteksi bot modern nggak cuma lihat `navigator.webdriver` atau user agent.
  - Mereka lihat timing, interaksi, network, reputasi IP, session flow, dan pola perilaku.
  - Jadi browser stealth bisa membantu, tapi bukan solusi tunggal.

- Insight personal:
  - Yang menarik bukan klaim "chrome kalah", tapi bahwa Obscura bisa jadi contoh specialized runtime yang efisien untuk subset use case.
  - Ini mirip trade-off antara full browser dan specialized runtime: kompatibilitas luas vs efisiensi fokus.
  - Hype seringnya terjadi ketika "lebih cepat" dicampur dengan "lebih stealth" tanpa memasukkan realitas operasional dan hukum.

- Kesimpulan ringkas:
  - Obscura menarik sebagai eksperimen dan proof-of-concept untuk runtime web automation yang lebih ringan.
  - Narasi stealth besar-besaran harus dilihat skeptis.
  - Nilai riilnya mungkin ada di scope sempit: scraping/automation tertentu, bukan sebagai pengganti Chrome di semua kasus.

- Follow-up jika mau lanjut:
  - Bedah konsep headless browser, CDP, Puppeteer, Playwright, dan di mana Obscura coba masuk.
  - Tinjau komentar teknis di post untuk melihat area mana yang valid dan mana yang overclaim.
  - Kembangkan insight ini jadi zettel kecil tentang batasan stealth dalam browser automation. (Sudah dibuat: [[zettel.1777866407372]])
  - Buat zettel tambahan untuk:
    - runtime web automation khusus yang menukar kompatibilitas luas dengan efisiensi fokus ([[zettel.1777866581063]]).
    - persistent knowledge graph + blast radius untuk mengurangi context waste di code review agen ([[zettel.1777866581064]]).
    - bottleneck agen coding yang sering ada pada pemilihan konteks, bukan kapasitas model ([[zettel.1777866581065]]).
  - Explore lebih lanjut Obscura dengan use case:
    - scraping artikel yang pakai heavy JS, untuk lihat apakah runtime-nya benar-benar eksekusi halaman modern.
    - automation internal yang butuh banyak sesi singkat, untuk lihat dampak startup/memory.
    - skenario stealth minim, seperti fetch data dari halaman yang sudah pakai anti-bot dasar.
  - Process yang bisa dicoba:
    - clone repo, build/binary check, jalankan sample script, cek apakah page JS heavy berjalan.
    - bandingkan hasil render/response dengan Puppeteer/Playwright pada target halaman yang sama.
    - tes deteksi sederhana dengan script yang mengecek `navigator.webdriver`, canvas fingerprint, dan network request.

- [code-review-graph oleh tirth8205](https://github.com/tirth8205/code-review-graph)
  - Repo ini muncul di post LinkedIn Youssef Hosni sebagai contoh persistent knowledge graph untuk codebase, supaya coding agent gak harus baca semua file.
  - Inti masalah yang diserang: **context waste**. Agent sering dikasih task kecil tetapi malah membaca terlalu banyak file yang tidak relevan, jadi token terbuang dan reasoning model jadi noisy.

- Mekanisme yang kemungkinan dipakai:
  - Repo diparse dengan [Tree-sitter](https://github.com/tree-sitter/tree-sitter) untuk ekstraksi struktur: function, class, import, dependency, dan relasi antar file.
  - Hasil parsing itu disimpan di [SQLite](https://github.com/sqlite/sqlite) sebagai graph persisten, bukan dibangun ulang tiap kali.
  - Saat file berubah, sistem update incremental hanya bagian yang berubah.
  - Blast radius dihitung: caller, callee, dependent, related test, dan file yang terdampak.
  - Agent baru dikasih subset file relevan, bukan seluruh repo.

- Kenapa pendekatan knowledge graph + blast radius menarik:
  - Dia memisahkan pekerjaan finding context dari pekerjaan reasoning.
  - Model LLM tidak lagi dibebani untuk jadi parser, navigator repo, dan impact analyzer sekaligus.
  - Ini mirip prinsip: komponen murah precompute struktur, komponen mahal fokus berpikir.
  - Hasilnya bisa jadi lebih fokus dan lebih murah, terutama di repo besar.

- Kapan ini berguna dan kapan overkill:
  - Berguna untuk repo besar, PR kecil dengan dampak tersebar, code review, change impact analysis, test suggestion, dan monorepo/polyglot.
  - Overkill untuk repo kecil, task greenfield/desain API baru, atau codebase yang terlalu dinamis dan runtime-heavy.
  - Juga perlu hati-hati kalau dukungan [Tree-sitter](https://github.com/tree-sitter/tree-sitter) untuk bahasa tertentu belum cukup mendalam.

- Klaim yang kuat versus yang perlu hati-hati:
  - Kuat: context waste adalah problem nyata; persistent graph + incremental update logis; blast radius buat review masuk akal.
  - Hati-hati: angka 6.8x / 49x mungkin cuma valid di benchmark tertentu; "support 23 languages" tidak selalu berarti analisis semantik lengkap untuk semua bahasa; istilah "knowledge graph" bisa kedengaran lebih fancy daripada implementasi praktisnya.
  - Explore lebih lanjut code-review-graph dengan use case:
    - evaluasi repo besar yang sering PR kecil, untuk lihat apakah blast radius bisa memangkas file relevan.
    - proyek yang banyak dependency antar modul, untuk lihat apakah graph membantu hitung impact lebih cepat.
    - integrasi agent review, untuk lihat apakah token context berkurang dan hasil review lebih fokus.
  - Process yang bisa dicoba:
    - clone repo, jalankan indexing pada satu repo besar, lalu inspeksi SQLite graph yang dihasilkan.
    - ubah satu fungsi kecil di repo target, lihat file mana yang dihitung terdampak dan apakah daftar itu relevan.
    - bandingkan alur “agent baca semua file” dengan “agent baca subset dari blast radius” di satu PR nyata.

- Insight tambahan:
  - Ini bukan hanya tool buat Claude Code. Ini lebih ke gagasan bahwa bottleneck coding agent sering ada di pemilihan konteks, bukan di modelnya.
  - Kalau agen adalah analis pintar, project ini bikin "petugas arsip" yang nyaring dokumen relevan sebelum model diminta berpikir.
  - Jadi nilai utamanya adalah **fokus**, bukan sekadar hemat token.
  - Tujuan utama bukan menyembunyikan bot secara absolut, tapi mereduksi jejak fingerprint dan sinyal yang sering dipakai situs untuk mendeteksi automation.
  - Post itu menyebut:
    - randomisasi fingerprint per session untuk GPU, canvas, audio, battery
    - masking `navigator.webdriver`
    - patch native functions
    - blocking ribuan tracker domains

- Lapisan teknis stealth yang kemungkinan dimainkan:
  - Property masking: override getter di `navigator`, `screen`, `plugins`, `languages`, WebGL, battery, device memory, dsb.
  - Per-session randomization: sesi bot dibuat tidak identik, tapi harus tetap konsisten sebagai fingerprint perangkat nyata.
  - Native function patching: bukan hanya output yang harus normal, tapi juga tampilan fungsi saat diinspeksi.
  - Tracker/anti-bot suppression: mengurangi observasi pihak ketiga, tapi bisa juga jadi sinyal jika pola request jadi terlalu bersih.

- Kenapa fitur ini bisa efektif, tapi tidak pernah jaminan?
  - Browser-level stealth itu cuma satu lapisan deteksi. Situs modern mengevaluasi banyak sinyal lain seperti IP reputation, timing request, pola klik/scroll, durasi sesi, cookie reuse, dan kontinuitas navigasi.
  - Jadi `navigator.webdriver` lolos saja belum cukup.
  - Di use case AI agent internal, stealth bisa kurang penting; di scraping situs pihak ketiga yang serius, stealth hanya titik awal.

- Batasan / failure mode:
  - Inconsistency: patch satu API tapi lupa API lain, jadi terjadi kontradiksi antar sinyal.
  - Unrealistic randomness: fingerprint terlalu acak sampai jadi nggak masuk akal.
  - Behavioral detection: fingerprint lolos, tapi klik/scroll masih mekanis.
  - Network layer kalah: IP/proxy jelek atau TLS fingerprint tidak wajar.
  - Compatibility gap: stealth oke, tapi rendering/runtime tidak cocok untuk halaman web modern.

- Ringkasannya:
  - Stealth mode Obscura paling tepat dilihat sebagai risk reduction pada permukaan browser fingerprint.
  - Bukan jubah gaib; lebih mirip make-up forensics yang bantu browser bot lolos pintu depan.
  - Efektif di satu permukaan, tapi tidak menghapus semua bukti.
