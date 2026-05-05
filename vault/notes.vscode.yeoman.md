---
id: notes.vscode.yeoman
title: "Yeoman: scaffolding engine untuk frontend modern"
desc: "Ringkasan peran Yeoman di era 2012–2015, masalah yang diselesaikannya, dan warisan idenya ke CLI modern."
tags:
  - notes
  - vscode
  - yeoman
  - tooling
  - history
---

## Yeoman itu apa?

Yeoman adalah scaffolding engine untuk project web, bukan runtime framework.
Dia muncul sebagai tool untuk membuat kerangka kerja awal: struktur folder, config build, dependency, testing setup, dan template file.
Inti ide Yeoman adalah: jangan mulai project web dari file kosong.

Catatan: artikel ini dirancang supaya bisa dibaca sendiri. Semua penjelasan di sini lengkap tanpa harus buka note lain.

Yeoman bekerja lewat ecosystem generator. Setiap generator adalah plugin yang bisa dipakai untuk kickstart project baru atau menambah bagian tertentu ke project yang sudah ada.

- `yo` = command-line engine.
- `generator-*` = template dan opini untuk jenis project tertentu.
- `prompt` = interaksi konfigurasi saat scaffold berjalan.

Jadi: **Yeoman = scaffolding engine**.

## Kenapa Yeoman terasa penting banget di era 2012–2015?

Karena waktu itu frontend sudah terlalu kompleks untuk lagi-lagi mulai dari nol.
Sebelum Yeoman, startup project sering berarti:

- cari library lewat GitHub atau StackOverflow,
- pilih antara Bower / npm / RequireJS / Browserify,
- tulis konfigurasi Grunt/Gulp manual,
- siapkan testing dengan Karma/Jasmine/Mocha,
- bungkus asset Sass/Less/Autoprefixer sendiri,
- atur live reload dan production build sendiri.

Yeoman hadir saat frontend sudah masuk fase industrialisasi.
Dia memberi satu cara untuk menjahit semua bagian itu jadi wizard awal, sehingga tim nggak lagi fokus ke setup tetapi ke domain aplikasi.

**Era 2012–2015 cocok buat Yeoman** karena:

- belum ada pemenang tooling universal,
- banyak framework masih baru dan toolingnya tersebar,
- tim frontend butuh standar onboarding,
- developer mulai merasa setup project lebih berbahaya daripada kode fitur.

## Masalah apa yang Yeoman coba selesaikan?

Masalah inti Yeoman bukan sekadar "generator file".
Yeoman mencoba menyelesaikan tiga masalah sekaligus:

1. **fragmentasi tooling**
   - npm, Bower, Grunt, Gulp, RequireJS, Browserify, Karma, Jasmine, Sass, Less.
   - Semua punya API dan cara set up berbeda.
2. **boilerplate manual**
   - struktur folder, config, dan skrip build sering di-copy dari repo lama.
   - copy-paste bikin project baru rawan salah.
3. **onboarding inconsistent**
   - developer baru harus tahu banyak tooling sekaligus.
   - generator jadi satu titik input untuk menyesuaikan opsi project.

Jadi Yeoman bukan hanya membuat file, tapi memformalkan workflow: generate + install dependency + siap kerja.

## Kenapa sekarang namanya jarang terdengar?

Karena idenya menang, produknya harus mundur.

Yeoman membuka kategori baru: scaffolding CLI untuk web app.
Setelah kategori itu terbukti penting, banyak framework dan platform mulai membawa generator sendiri.

- Angular punya `ng new`
- React punya `create-react-app`
- Vue punya Vue CLI / Vite starter
- Next.js punya `create-next-app`
- NestJS punya `nest new`
- Rails, Laravel, Spring Initializr punya generator masing-masing

Yeoman terlalu generik ketika ekosistem mulai memilih tooling yang terikat langsung ke framework.
Hasilnya, Yeoman tetap relevan sebagai konsep, tapi namanya tidak lagi jadi brand utama.

## Warisan idenya ke tooling modern

Yeoman memberi dua warisan utama:

1. **Pembiasaan scaffolding**
   - mulai project lewat command khusus.
   - pilih opsi awal lewat prompt.
   - otomatis pasang dependency dan setup file.

2. **Generator sebagai extensible template**
   - generator bisa dibuat untuk banyak jenis project.
   - ini adalah cikal bakal pendekatan CLI yang bisa di-extend oleh komunitas.

Tooling modern mewarisi pola ini, tetapi dengan fokus yang lebih sempit:

- `npm create vite@latest` = starter modern untuk dev server + bundler,
- `create-react-app` = generator khusus React,
- `ng new` = generator yang dikemas dalam framework Angular,
- `nx generate` / `turbo` = generator yang berorientasi monorepo.

Yeoman bisa dipahami sebagai jembatan antara:

Manual setup → boilerplate repo → Yeoman generator → framework CLI → meta-framework starter.

## Kenapa Yeoman bukan framework?

Ini penting.
Yeoman hanya bantu bikin struktur awal.
Dia tidak menentukan runtime aplikasi.

Kalau lo pakai generator AngularJS 2014, Yeoman hanya bikin folder, file, dan config yang dibutuhkan. Setelah itu, aplikasi tetap jalan di AngularJS.
Kalau generatornya untuk Chrome extension, hasilnya tetap extension yang runtime-nya bukan Yeoman.

Jadi salah kaprah terbesar adalah mengira Yeoman sebagai "tool yang mengikat project". Padahal Yeoman cuma "mandor proyek" yang bantu siapkan pondasi.

## Insight

Yeoman adalah tanda bahwa frontend bukan lagi sekadar halaman HTML statis.
Dia menandai peralihan mental model: web app sekarang adalah project dengan lifecycle `create -> build -> test -> lint -> deploy`.

Kalau memahami Yeoman dengan benar, lo bukan cuma tahu command `yo`.
Lo tahu kenapa generator jadi penting, kenapa framework CLI berkembang, dan kenapa sekarang startup project modern biasanya dimulai dengan `npm create` atau `create-...`.

### Catatan singkat

- Yeoman penting karena era 2012–2015 tooling frontend sudah broken, tetapi belum ada satu standar.
- Yeoman menyelesaikan fragmentation dan onboarding.
- Kini idenya hidup lagi di CLI framework modern, meski nama Yeoman jarang muncul.
- `yo code` adalah gambaran yang tepat: generator yang memotong boilerplate, bukan mengganti logika.
