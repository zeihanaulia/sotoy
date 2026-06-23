
Preface ini bikin gue langsung ngeh bahwa buku ini nggak ditulis untuk orang yang mau cepat-cepat nyari recipe. Dari awal, gue merasa Tod Golding lagi bilang: "Dunia SaaS sekarang penuh kabut, bukan peta." Itu penting. Ini bukan sekadar pembuka; ini adalah alasan kenapa buku ini harus ada.

Yang gue ambil dari kalimat itu adalah: masalah SaaS bukan kekurangan tool. Masalahnya adalah istilahnya kabur, asumsi orang beda-beda, dan semua pake label yang sama. Kalau definisi dasar nggak jelas, semua keputusan berikutnya bisa jadi ngawur.

## SaaS bukan label stabil

Di Preface, gue jadi sadar bahwa banyak orang pakai kata "SaaS" untuk banyak hal. Buat sebagian, itu cukup berarti aplikasi web yang di-host. Buat yang lain, cukup berarti subscription. Itu bikin banyak tim bilang mereka SaaS padahal model isolation, data, dan operasi mereka beda jauh.

Yang gue suka dari sini adalah Golding nggak mau definisi SaaS cuma keren di slide deck. Dia pengin definisi yang bisa diterjemahkan jadi keputusan nyata: tenant isolation gimana, onboarding gimana, routing gimana, data partitioning gimana, dan operasi gimana.

## Ini buku tentang taxonomy, bukan dogma

Poin ini bikin gue ngerasa adem. Dia bilang buku ini bukan "bible" SaaS. Jadi dia jelas ngebangun kerangka dan bahasa, bukan nyuruh kita ikut satu formula mutlak.

Buat gue, itu berarti pendekatannya lebih fleksibel. Dia pengin merapikan bahasa dan boundary dulu, bukan nyuruh orang langsung tulis kode atau desain infrastruktur.

## SaaS itu business-shaped architecture

Ini yang paling nancep buat gue: arsitektur SaaS bukan cuma masalah service atau database. Dia lahir dari target bisnis dan operating model.

Jadi kalau bisnis lo butuh efisiensi buat banyak tenant kecil, mungkin lo condong ke shared infrastructure. Kalau lo target enterprise yang butuh compliance dan blast radius kecil, lo mungkin pilih isolation lebih dedicated.

Buat gue, kalimat ini ngejelasin: SaaS nggak cuma soal teknis. SaaS itu soal mana yang bisa ditolerir dari sisi cost, agility, support, dan risk.

## Cloud bukan SaaS

Punya cloud itu bagus, tapi nggak otomatis bikin lo SaaS. Preface ini ngejelasin bahwa cloud itu cuma lingkungan, sedangkan SaaS adalah model operasional dan arsitektur.

Itu penting karena banyak org keblinger: deploy ke AWS terus merasa sudah SaaS. Menurut gue, di sini Golding lagi ngingetin kita untuk jangan terjebak dengan tool. Cari dulu prinsipnya.

## Bacanya jangan lompat

Preface ini juga bilang dengan cukup jelas: kalau kamu skip bab awal, kamu bakal rugi.

Buku ini disusun dengan dependency antar konsep. Bab awal bukan filler; dia yang bikin kamu ngerti kenapa pola di bab selanjutnya dipilih.

Kalau gue baca tanpa Preface, gue mungkin cuma bakal anggap ini buku tentang multi-tenant pattern. Tapi Preface nge-trek gue bahwa ini buku tentang cara kita ngobrol soal SaaS dulu.

## Scope-nya

Satu lagi yang gue tangkap: buku ini nggak ngaku bahas semua SaaS. Ini lebih ke konteks B2B / multi-tenant enterprise. Itu bikin saran-sarannya terasa lebih nyata dan nggak terlalu broad.

Jadi buat gue, Preface ini semacam peta awal yang nentuin: kita bakal baca SaaS sebagai sistem arsitektur yang dibentuk oleh bisnis, bukan sekadar katalog teknologi.

Kalau lo paham Preface ini, lo baca bab berikutnya dengan frame yang lebih tajam. Kalau lo belum paham, bab-bab selanjutnya bisa terasa kayak kumpulan fitur tanpa alasan yang jelas.
