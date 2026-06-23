
## Kenapa ini penting di era LLM

Kalau elo cuma lihat output AI coding dari sisi "cepatnya bikin kode", lo ketinggalan satu dimensi lebih penting.

Code bukan cuma instruksi mesin. Code juga adalah bahasa bersama untuk tim, domain expert, dan LLM. Kalau vocabulary codebase tidak jelas, AI bisa menghasilkan kode yang compile tapi membuat tim bingung.

Artikel Unmesh Joshi di Martin Fowler menjelaskan ini dengan bagus: https://martinfowler.com/articles/what-is-code.html.

## Fokus utama handbook ini

1. pastikan codebase punya vocabulary domain yang stabil,
2. tetapkan bounded context dengan jelas,
3. gunakan programming language sebagai alat discovery,
4. kurangi cognitive debt, bukan cuma technical debt,
5. jadikan codebase sendiri sebagai context dan harness untuk LLM.

## 1. Bangun vocabulary domain sebelum permintaan kode besar

Sebelum minta LLM membuat feature, tanyakan dulu:

- apa istilah utama domain ini?
- apa bedanya `Order` vs `Cart` vs `Shipment`?
- apa yang dimaksud `Payment` di sini: authorized, captured, settled?
- apakah `Customer` berarti individu, account, atau entitas legal?

Kalau vocabulary belum jelas, jangan langsung minta LLM coding. Mulai dari definisi domain, bukan dari endpoint.

### Praktik yang masuk akal

- buat glossary singkat `<domain>/vocabulary.md`
- definisikan noun penting dan batas konteksnya
- jangan biarkan istilah serupa dipakai bergantian tanpa alasan
- gunakan nama yang membawa konsekuensi desain

## 2. Tetapkan bounded context secara eksplisit

Satu kata bisa punya banyak arti di organisasi besar. Itulah odd word disease.

- di e-commerce, `Customer` bisa berarti pembeli.
- di CRM, `Customer` bisa berarti account bisnis.
- di support, `Customer` bisa berarti user yang kontak helpdesk.
- di billing, `Customer` bisa berarti entitas yang ditagih.

Sebelum menambahkan abstraction baru, tanyakan: apakah vocabulary ini valid di bounded context ini?

### Teknik praktis

- dokumentasikan context contract untuk modul besar,
- catat di mana model `Customer` itu berlaku,
- pisahkan model jika artinya berbeda,
- gunakan boundary names seperti `orders`, `billing`, `support`, `catalog`.

## 3. Gunakan code sebagai alat discovery, bukan cuma hasil prompt

Programming language membantu kita menemukan desain.

- Go memaksa kita pikir tentang concurrency.
- Java memaksa kita pikir tentang objek dan interface.
- Rust memaksa kita pikir tentang ownership.
- FP memaksa kita pikir tentang transformasi data.

Jadi jangan pasif. Bahkan jika LLM generate code, manusia harus aktif memilih language constructs dan memakainya sebagai medium berpikir.

### Aman dipakai

- gunakan pola bahasa untuk menegaskan batas: type, enum, interface, module,
- gunakan types dan invariants untuk membuat vocabulary konkret,
- jangan biarkan LLM menumpuk abstraction tanpa alasan nyata.

## 4. Kurangi cognitive debt dengan shared understanding

Cognitive debt terjadi ketika codebase punya vocabulary namun tim tidak paham maknanya.

LLM bisa mempercepat vocabulary masuk ke codebase. Itu berbahaya kalau vocabulary itu tidak disepakati.

### Checklist untuk menghindari cognitive debt

- pastikan setiap abstraction punya alasan domain yang jelas,
- jangan pakai pattern enterprise hanya karena terdengar profesional,
- tulis tests yang bukan cuma validate behavior, tapi juga dokumentasikan intent,
- review code bukan hanya untuk bug, tapi juga untuk model konseptual,
- tanyakan: apakah nama-nama ini sesuai dengan domain lokal?

## 5. Jadikan codebase sendiri context untuk LLM

Codebase yang baik adalah context permanen.

Kalau LLM bekerja di repo yang punya:

- nama-nama konsisten,
- abstraction yang jelas,
- tests yang mewakili behavior,
- types yang mengekspresikan kontrak,
- boundary yang bersih,

maka output LLM akan lebih mudah diprediksi.

Ini penting: prompt bagus saja tidak cukup jika repo itu sendiri tidak punya bahasa yang jelas.

### Praktik harness

- jaga agar module naming dan domain naming selaras,
- pertahankan file struktur yang mencerminkan bounded context,
- levelkan antarmuka publik dari internal detail,
- buat test suite yang memverifikasi intent, bukan hanya implementation,
- gunakan commit message dan PR description untuk menjelaskan vocabulary yang baru.

## 6. Workflow rekomendasi untuk AI-assisted coding

1. desain vocabulary dan bounded context.
2. tulis spec singkat yang mencakup domain language.
3. buat plan kecil-kecil yang tetap memegang vocabulary.
4. suruh LLM generate kode di langkah-langkah terbatas.
5. tes dan review tidak sekadar correctness, tapi juga vocabulary.
6. iterasi sampai codebase makin jelas, bukan makin kompleks.

## 7. Hubungan ke artikel lain

- [[notes.prompt-engineering.interrogatory-llm]] — konteks digali dari manusia.
- [[notes.prompt-engineering.harper-llm-codegen-workflow]] — konteks itu dijadikan spec, plan, execution.
- [[notes.agentic-coding.what-is-code]] — code harus menjaga vocabulary supaya LLM tidak menambah cognitive debt.

## Ringkasannya

LLM mungkin membuat instruksi mesin jadi murah. Nilai engineer tetap ada di:

- memilih vocabulary yang tepat,
- menegaskan bounded context,
- membangun shared understanding,
- menjaga codebase tetap jadi context yang bisa digunakan lagi.

Jangan hanya tanya "bikin kode ini". Tanya juga "bahasa apa yang kita pakai di sini?" dan "siapa yang akan paham model ini nanti?".
