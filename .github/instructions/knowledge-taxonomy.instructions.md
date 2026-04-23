---
applyTo: "vault/**/*.md"
description: "Taksonomi category knowledge untuk Book Summaries, Daily, Handbook, Notes, Today I Learned, dan proyeksinya ke Zettelkasten."
---

## Tujuan

Instruction ini mendefinisikan fungsi tiap category knowledge di vault supaya agent dan workflow lain tidak mencampuradukkan:
- **Book Summaries**
- **Daily**
- **Handbook**
- **Notes**
- **Today I Learned**
- **Zettelkasten**

Tujuannya bukan sekadar menentukan folder, tapi menjaga agar setiap output punya **fungsi epistemik** yang jelas.

## Prinsip Umum

Jangan perlakukan semua category sebagai tempat simpan yang setara.

Masing-masing punya peran berbeda:
- **Book Summaries** = storytelling dan interpretasi hasil baca buku
- **Daily** = jurnal pengetahuan harian berbasis waktu
- **Handbook** = panduan reusable dan best practice
- **Notes** = tulisan eksploratif atau standalone technical single
- **Today I Learned** = atomic learning nugget
- **Zettelkasten** = distilasi atomic idea dari semua kategori lain

**Zettelkasten bukan primary intake folder.**  
Ia adalah projection layer dari kategori lain jika ada ide yang cukup atomic dan bernilai.

## Definisi Category

### Book Summaries
Gunakan category ini untuk:
- menceritakan ulang buku, bab, atau bagian buku dengan voice user,
- menangkap interpretasi user terhadap isi buku,
- menulis summary yang naratif, bukan textbook summary.

Aturan:
- bedakan isi sumber, interpretasi user, dan insight pribadi user,
- jika ada sumber atau kutipan, verifikasi bahwa pemahaman user tidak melenceng,
- prioritaskan storytelling dan kejernihan,
- jangan menulisnya seperti handbook atau literature review akademik.

### Daily
Gunakan category ini untuk:
- apa yang dibaca, dipikirkan, atau diperdebatkan user pada hari tertentu,
- opini dan refleksi harian,
- beberapa artikel atau beberapa sumber dalam satu hari.

Aturan:
- group by date,
- boleh ada beberapa section per hari,
- boleh ada beberapa artikel atau tema dalam satu file,
- pertahankan opini user,
- jika berasal dari artikel, rapikan isi dari kepala user dan verifikasi pemahamannya.

Daily bersifat **time-bound**, bukan evergreen.

### Handbook
Gunakan category ini untuk:
- best practice,
- tutorial,
- panduan kerja,
- how-to yang reusable,
- baseline teknikal,
- penjelasan trade-off dan opsi alternatif.

Aturan:
- harus jelas, structured, dan bisa dipakai lagi,
- jelaskan reasoning di balik rekomendasi,
- kalau ada beberapa pendekatan, jelaskan kapan masing-masing cocok,
- jika memungkinkan, beri follow-up references sebagai baseline.

Handbook harus terasa seperti dokumen rujukan, bukan catatan eksplorasi.

### Notes
Gunakan category ini untuk:
- tulisan teknikal atau konseptual yang berdiri sendiri,
- catatan eksploratif,
- tutorial kecil,
- hasil eksperimen,
- perjalanan pemikiran,
- topik yang belum cukup besar atau matang untuk jadi handbook.

Analogi:
- **Notes = singles**
- **Handbook = albums**

Notes boleh lebih bebas dan lebih personal dibanding Handbook, tapi tetap harus coherent.

### Today I Learned
Gunakan category ini untuk:
- satu hal baru yang baru dipelajari user,
- insight kecil yang atomic,
- learning nugget yang jelas dan singkat.

Aturan:
- fokus ke satu hal,
- jelaskan kenapa itu penting,
- kalau mulai terlalu panjang atau berkembang jadi tutorial, pindahkan ke Notes atau Handbook,
- TIL boleh menjadi feeder ke Zettelkasten.

### Zettelkasten
Gunakan category ini untuk:
- klaim,
- insight,
- prinsip,
- pertanyaan permanen,
- relasi bermakna,
- atomic idea yang cukup mandiri untuk hidup sendiri.

Zettel bisa lahir dari:
- Book Summaries
- Daily
- Handbook
- Notes
- Today I Learned

Namun jangan memaksa semua hal menjadi zettel.

## Aturan Routing

Saat satu input datang, tentukan:
1. **output utama** paling tepat masuk ke category mana,
2. apakah perlu **output turunan** ke category lain,
3. apakah ada **1–5 atomic idea** yang layak diproyeksikan ke Zettelkasten.

Contoh:
- hasil baca buku → output utama di **Book Summaries**, turunan ke **Zettelkasten**
- opini atas beberapa artikel hari ini → output utama di **Daily**, insight tertentu bisa jadi **TIL** atau **Zettelkasten**
- tutorial kecil hasil eksperimen → output utama di **Notes**, jika makin matang bisa dipromosikan ke **Handbook**
- satu hal baru yang baru disadari → output utama di **Today I Learned**, lalu evaluasi apakah layak jadi zettel
- best practice matang → output utama di **Handbook**, prinsip intinya bisa diproyeksikan ke **Zettelkasten**

## Aturan Promosi antar Category

Promosi boleh dilakukan jika kematangan knowledge naik.

### TIL → Notes
Lakukan jika:
- insight sudah butuh penjelasan lebih panjang,
- ada contoh, reasoning, atau konsekuensi yang perlu dijabarkan,
- satu ide berkembang menjadi tulisan.

### Notes → Handbook
Lakukan jika:
- isi sudah cukup matang,
- reusable lintas konteks,
- punya struktur tutorial / best practice yang jelas,
- layak dijadikan rujukan jangka panjang.

### Daily → Notes / Handbook
Lakukan jika:
- refleksi harian menghasilkan ide yang tidak lagi bergantung pada tanggal,
- ada topik yang berkembang jadi pembahasan mandiri,
- ada prinsip kerja yang layak diabadikan.

### Kategori apa pun → Zettelkasten
Lakukan jika:
- ada ide atomik yang mandiri,
- ada klaim atau relasi yang bernilai jangka panjang,
- ada pertanyaan permanen yang layak dipelihara.

## Aturan Verifikasi

Jika output berasal dari sumber eksternal:
- bedakan isi sumber dan interpretasi user,
- jangan copy-paste sumber mentah sebagai isi utama,
- verifikasi bahwa pemahaman user tidak menyimpang,
- kalau ada koreksi, lakukan dengan menjaga voice user.

## Aturan Gaya per Category

### Book Summaries
- naratif,
- storytelling,
- voice user dominan,
- grounded pada isi buku.

### Daily
- reflektif,
- time-bound,
- bisa multi-item,
- tetap rapi dan terkelompok.

### Handbook
- instructional,
- preskriptif,
- ada reasoning,
- ada alternatif dan trade-off.

### Notes
- bebas tapi coherent,
- lebih eksploratif,
- bisa seperti technical single atau essay pendek.

### Today I Learned
- singkat,
- atomic,
- jelas,
- tidak melebar.

### Zettelkasten
- tajam,
- atomic,
- linked,
- bernilai jangka panjang.

## Constraints

- JANGAN mencampur Daily dan Handbook seolah sama.
- JANGAN menjadikan Notes sebagai dump yang tak berbentuk.
- JANGAN menjadikan TIL sebagai esai panjang.
- JANGAN menulis Book Summaries seperti handbook.
- JANGAN menjadikan Zettelkasten sebagai folder intake utama.
- JANGAN menggandakan isi mentah ke semua category tanpa fungsi yang berbeda.

- SELALU pilih satu output utama.
- SELALU tentukan apakah ada output turunan yang benar-benar berguna.
- SELALU evaluasi kandidat atomic idea untuk Zettelkasten.
- SELALU jaga fungsi epistemik tiap category.

## Tes Cepat Klasifikasi

Gunakan pertanyaan ini saat bingung:

- Apakah ini terutama hasil baca buku yang ingin diceritakan ulang? → **Book Summaries**
- Apakah ini terutama apa yang dibaca / dipikirkan hari ini? → **Daily**
- Apakah ini sudah reusable sebagai panduan? → **Handbook**
- Apakah ini tulisan eksploratif yang masih standalone? → **Notes**
- Apakah ini cuma satu hal baru yang baru dipelajari? → **Today I Learned**
- Apakah dari semuanya ada ide atomik yang layak hidup sendiri? → **Zettelkasten**
