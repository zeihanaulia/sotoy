---
id: daily.journal.2026.05.14
title: '2026-05-14'
desc: "Refleksi pembacaan buku Rust pattern dan mental model design Rust dibanding OOP."
updated: 1778775198969
created: 1778769784651
tags:
  - daily
  - rust
  - design-patterns
---

## Baca buku Rust tentang design pattern

Hari ini gue baca daftar isi dan struktur buku *Design Patterns and Best Practices in Rust*. Yang paling nyantol adalah penekanannya: ini bukan buku yang ngajarin pattern klasik satu per satu, tapi buku yang ngajarin cara mikir ulang desain agar selaras dengan Rust.

Gue mulai melihat tiga layer yang berbeda:

- mental model Rust dulu,
- lalu terjemahan pattern lama ke idiom Rust,
- baru akhirnya pattern yang benar-benar native Rust.

### Insight yang gue tangkap

- Kalau lo pindah dari Java/C#, kebiasaan membuat class hierarchy dan object-oriented design biasanya jadi jebakan.
- `Clone` dan `Rc` sering dipakai sebagai pelarian ketika borrow checker menolak, padahal itu bisa jadi tanda desain ownership yang kabur.
- Borrow checker bukan musuh; dia feedback sistem desain. Kalau dia nggak terima, berarti lo harus jawab siapa pemilik data, siapa boleh baca, siapa boleh ubah.
- Di Rust, pattern penting bukan karena namanya, tapi karena problem yang dia selesaikan dan apakah dia bisa di-encode di level type system.

## Baca thread ClaudeDevs tentang perubahan programmatic usage

Gue baca thread terbaru ClaudeDevs: https://x.com/ClaudeDevs/status/2054610152817619388. Inti thread ini bukan cuma angka credit, tapi mental contract antara pengguna dan subscription.

Yang bikin banyak orang kesal adalah framing-nya: Anthropic bilang paid plan bisa klaim "dedicated monthly credit" untuk penggunaan programmatic. Mereka juga bilang batasan subscription nggak berubah karena tetap dikhususkan buat interactive use. Tapi dari sudut developer heavy user, itu terasa seperti akses programmatic yang dulu masuk dalam subscription sekarang dipisah ke kuota baru yang lebih kecil.

Dua realitas ini bisa berdiri bareng:

- Kalau lo pake Anthropic dari perspektif mereka, ini adalah upaya agar programmatic usage nggak makan limit chat/Claude Code interaktif.
- Kalau lo pake Claude buat agentic workflow dan SDK, ini adalah perubahan ekonomi: akses yang terasa subscription-like sekarang jadi usage-metered.

Gue nangkep tiga alasan terbesar kemarahan ini:

1. Ini tentang trust platform. Banyak orang udah bangun tooling di atas Claude Agent SDK, lalu rules billing-nya berubah setelah mereka invest waktu.
2. Framing sebagai "free credit" bikin salah fokus. Seharusnya yang dibahas adalah apakah ini bonus, atau justru plafon baru untuk usage yang sebelumnya dianggap termasuk plan.
3. Perubahan ini tidak cuma billing; dia memukul workflow developer, khususnya GitHub Actions, agent runner, IDE wrapper, dan third-party tools seperti Conductor / OpenClaw.

Dari situ, gue ngebayangin konflik antara dua kategori penggunaan:

- interactive user = chat / Claude Code langsung,
- agentic/programmatic user = SDK, script, automation, third-party app.

Kalau Claude memisahkan dua beban ini, secara teknis masuk akal karena programmatic bisa boros. Tapi buat developer yang beli Claude karena agentic coding, ini terasa seperti nilai utama mereka dikurangin.

### Insight penting yang gue tahan

- Perdebatan sebenarnya bukan soal kredibilitas angka credit, tapi soal reframe value lama jadi kuota baru.
- "Subscription limit tidak berubah" dalam bahasa Anthropic bisa tetap berarti "pengalaman gede lo berkurang" untuk developer yang pakai SDK.
- Saat platform mengubah aturan setelah adopsi terbentuk, istilah "rug pull" sering muncul karena ini bukan sekadar harga; ini soal landasan ekonomi tempat tooling dibangun.

### Kenapa ini relevan buat gue

- Gue jadi lebih waspada kalau bangun workflow di atas API/SDK platform: jangan cuma hitung harga saat ini, tapi juga model governancenya.
- Perubahan seperti ini biasanya lebih berbahaya untuk agentic workflow daripada API biasa, karena automation bisa mengaburkan batas antara interactive dan programmatic usage.
- Kalau lo kerja di produk open ecosystem, perubahan batas kuota SDK bisa jadi sinyal untuk sediakan fallback atau opsi alternatif bagi pengguna heavy.

## Baca Martin Fowler: Interrogatory LLM

Gue baca artikel Martin Fowler tentang "Interrogatory LLM": LLM yang dipakai sebagai pewawancara konteks, bukan sekadar mesin jawaban. Inti artikel ini adalah memindahkan pekerjaan menulis konteks dari kepala manusia ke proses elicitation yang bisa dilakukan bertahap.

Link: https://martinfowler.com/bliki/InterrogatoryLLM.html

Yang nempel adalah lima pertanyaan penting:

1. Apa itu Interrogatory LLM?
2. Kenapa LLM perlu mewawancarai manusia?
3. Kenapa pertanyaan harus satu per satu?
4. Apa bedanya membuat dokumen vs mereview dokumen?
5. Apa konsekuensinya untuk knowledge work?

Dari situ gue tangkap bahwa ini bukan sekadar prompt engineering. Ini soal mengubah konteks menjadi artefak yang layak dipakai oleh model lain. Kalau prompt biasa sering terasa sekali tembak dan rapuh, pola ini memandang prompt final sebagai produk dari percakapan yang benar.

### Insight yang gue ambil

- Interrogatory LLM menempatkan LLM sebagai extractor, bukan eksekutor.
- Satu pertanyaan atomik membantu jawaban lebih fokus dan membuat konteks lebih lengkap.
- LLM bisa dipakai untuk review dokumen yang sudah ada, bukan hanya membuat dokumen baru.
- Ini sangat relevan di organisasi di mana banyak expert nggak suka nulis, tapi mereka bisa jawab pertanyaan jika diarahkan.
- Intinya: prompt final yang bagus sering kali bukan ditulis langsung; dia dihasilkan dari proses wawancara konteks.

## Baca Harper Reed: LLM codegen workflow

Gue baca artikel Harper Reed tentang workflow LLM codegen: bukan sekadar prompt langsung ke model, tapi rangkaian artefak eksplisit—brainstorming, spec, planning, execution, test/iterate.

Link: https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm/

Inti artikelnya kurang lebih 6 pertanyaan penting:

1. Apa workflow utama Harper untuk LLM coding?
2. Kenapa dia mulai dari brainstorming/spec, bukan langsung coding?
3. Kenapa planning dipisah dari execution?
4. Apa bedanya workflow greenfield dan brownfield?
5. Apa bahaya "over my skis" dalam AI coding?
6. Apa insight sosial dari workflow ini: solo vs team?

Yang paling nempel adalah ini:

- spec adalah artefak pusat, bukan dokumen administratif.
- planning membuat perubahan kecil yang bisa diuji, bukan lompatan besar.
- greenfield butuh plan-heavy workflow; brownfield butuh context extraction dari repo sebelum mengubah apa pun.
- "over my skis" adalah ketika velocity AI terlalu cepat sementara pemahaman manusia tertinggal.
- dalam tim, AI coding harus punya collaboration protocol, bukan cuma kerja single-player.

Kalimat yang paling pas buat artikel ini: "AI coding yang bagus bukan soal model aja. Ini soal membuat LLM bergerak di rel kecil yang elo desain." 

## Baca Unmesh Joshi: What Is Code?

Gue baca artikel Unmesh Joshi di Martin Fowler tentang "What Is Code?": https://martinfowler.com/articles/what-is-code.html.

Yang paling nyantol buat gue adalah bahwa code bukan hanya instruksi untuk mesin, tapi juga vocabulary konseptual untuk manusia, tim, dan LLM. Nama kelas, nama modul, dan istilah domain bukan kosmetik; mereka membawa asumsi, boundary, dan cara berpikir.

Unmesh bikin dua poin utama:

- code sebagai instruksi mesin, yang LLM sudah mulai commoditize,
- code sebagai model domain, yang justru jadi nilai utama ketika AI bisa generate syntax.

Dari situ gue jadi lebih waspada terhadap cognitive debt: nama-nama keren dan pattern enterprise bisa muncul cepat, tapi tim belum tentu paham model konseptualnya.

## Baca thread Kun tentang hardened npm supply chain

Gue baca thread Kunchenguid tentang hardening supply chain npm: intinya bukan soal scan semua package, tapi soal membuat cooldown policy supaya project nggak otomatis mengambil versi baru yang baru rilis.

Link: https://x.com/kunchenguid/status/2054600854553206992

Yang paling nempel adalah konsepnya: trust attachment harus ke versi package, bukan sekadar nama package. `chalk`, `eslint`, atau package terkenal bisa dipercaya dari versi lama, tapi versi baru yang muncul pagi ini tetap berisiko kalau akun maintainer disusupi.

Guardrail utama yang dia pakai adalah:

- `minimumReleaseAge: 10080`
- `minimumReleaseAgeStrict: true`

Artinya tiap dependency baru harus setidaknya 7 hari di registry sebelum pnpm boleh resolve dan install. Ini bukan ganti private registry; ini pake pnpm sebagai gatekeeper di depan npm registry.

Gue lihat tiga lapisan praktis di desainnya:

1. policy cooldown di level resolving versi baru,
2. CI harus pakai `pnpm install --frozen-lockfile`,
3. build script hanya boleh jalan untuk dependency yang eksplisit di-allowlist.

Yang menarik: ini bukan security tool magis, tapi proses. Kalau dependency baru dipakai harus sadar ada buffer observasi. Kalau package internal butuh langsung, pakai `minimumReleaseAgeExclude` sebagai escape hatch — tapi jangan besar-besaran.

Kalau mau adopsi, modelnya lebih ke "delay gate" ketimbang "freeze forever". Cooldown ini mesti sustainable, bukan bikin dependency management jadi ngeri.

## Baca thread Gergely Orosz tentang Anders Hejlsberg

Gue baca thread Gergely Orosz soal interview/podcast Anders Hejlsberg: https://x.com/GergelyOrosz/status/2054652158231167482. Thread ini bukan cuma nostalgia Turbo Pascal, Delphi, C#, dan TypeScript. Ini soal pola besar: bahasa yang menang biasanya bukan yang paling murni teori, tapi yang paling mampu menyelesaikan friksi developer di waktu yang tepat.

Yang gue tangkep ada lima poin penting:

1. Anders dianggap living legend bukan karena satu bahasa, tapi karena kontribusinya di beberapa fase: Turbo Pascal, Delphi, C#, dan TypeScript.
2. Turbo Pascal penting karena murah, cepat, dan interaktif—kombinasi yang menurunkan friksi ekonomi dan teknis.
3. C# lahir dari tekanan ekosistem, bukan sekadar ide teknis: konflik dengan Java membuat Microsoft butuh bahasa sendiri.
4. TypeScript menang karena tidak jadi "C# to JavaScript". Ia memperbaiki JavaScript dari dalam, bukan memaksa web keluar dari JavaScript.
5. Desain bahasa adalah permainan 10 tahun. Versi pertama perlu waktu, versi kedua memperbaiki, versi ketiga baru terasa matang.

Reply thread juga menarik:

- Nostalgia Turbo Pascal mengingatkan bahwa tool yang benar-benar sukses seringkali membuat developer lebih cepat mengubah ide jadi program, bukan sekadar memberi kontrol paling dekat ke mesin.
- Seorang reply di thread menegaskan bahwa skill besar saat ini bukan sekadar syntax JS/TS, tapi memahami type system dan modeling.
- Ada juga counterpoint yang bilang Anders terlalu dipuja, tapi itu justru menguatkan poin: inovasi sering ada di integrasi dan timing, bukan cuma di fitur abstrak.
- Ada komentar tentang tooling TypeScript di monorepo besar, yang menunjukkan tantangan selanjutnya: kinerja dan skalabilitas compiler/tooling.
- Ada juga klaim AI-assisted programming membuat TS lebih kuat karena typed codebase memberi sinyal yang lebih jelas untuk AI.

Intinya, thread ini menggarisbawahi satu lesson yang gede buat gue:

Bahasa yang besar menang karena kompromi yang tepat antara kompatibilitas, produktivitas, tooling, dan timing. Turbo Pascal nggak menang karena paling canggih, C# nggak lahir dari idenya saja, TypeScript nggak menang karena sekadar nambah type. Mereka menang karena membaca friksi ekosistem dengan tepat.
