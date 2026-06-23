
## Overview
Gue baca thread Mitchell Hashimoto di https://x.com/mitchellh/status/2052397933522506079 sebagai defensif terhadap satu ide: kode AI kasar tidak selalu buruk, asal jelas fungsinya sebagai eksperimen disposable, bukan fondasi yang dipaksakan ke user.

Di thread ini gue baca istilah "yapping" sebagai "lagi ngomong panjang soal poin besarnya" — bukan sekadar nge-omel tanpa isi. Itu penting karena konteksnya bukan kritik general terhadap AI, tapi diskusi spesifik tentang kapan output AI boleh dianggap temporary.

Istilah yang gue pakai di note ini:
- "ngeslop" = bikin output AI kasar/mentah untuk eksplorasi.
- "ngevibing code" = vibe coding: AI-assisted fast iterative drafting, bukan langsung jadi permanen.

## Apa yang dia maksud dengan “AI slop”?
Mitchell pakai "slop" untuk kode atau produk yang fungsinya bukan final. Ini kasar, mungkin jelek, tapi cukup untuk ngetes apakah desain, alur, atau ekosistem yang kita incar bisa jalan. Slop di sini adalah eksperimen cepat, bukan kualitas akhir yang akan dishare ke customer tanpa review.

### Ngeslop vs vibe coding
Ngeslop adalah output kasar untuk eksplorasi. Vibe coding adalah workflow cepat dengan AI yang mengandalkan iterasi, bukan desain semua detail dari awal. Keduanya bisa sah, selama outputnya tidak langsung dianggap final.

### Good enough to learn
Slop yang valid tidak perlu sempurna. Dia cukup baik untuk menghasilkan insight — bukan cukup baik untuk langsung di-ship. Itu yang komentar sebut sebagai "good enough to learn."

## Kenapa slop bisa bagus?
Karena slop menurunkan biaya eksperimen. Dulu mau bikin 50 plugin atau 100 provider itu mahal dan lambat. Sekarang agent AI bisa generate banyak variasi cepat, jadi kita bisa menguji apakah model ecosystem masuk akal sebelum invest lebih jauh.

Sederhananya:
- AI slop membuat eksperimen paralel murah.
- eksperimen paralel membuat validasi desain sistem jauh lebih cepat.
- validasi cepat membantu kita tahu apakah arsitektur besar layak dilanjutkan.

## Batas aman slop itu di mana?
Batasnya bukan soal apakah kode enak dibaca, tapi soal area risiko.

Boleh slop kalau itu:
- alpha atau internal,
- disposable dan mudah diganti,
- hanya untuk ngetes flow, UX, atau integrasi kasar.

Harus bersih kalau itu:
- contract boundary,
- data schema,
- persistence,
- security,
- idempotency,
- migration,
- API shape.

Prinsip praktisnya: frontend atau demo flow boleh lebih kasar di awal; core workflow seperti auth, billing, permission model, state machine, dan data contract tidak boleh divibe-kan sembarangan.

### Standar release customer-facing
Sebelum output AI masuk ke customer-facing release, minimal harus melalui:
- behavior yang sesuai kebutuhan user,
- error case yang terkelola,
- data integrity dan rollback,
- security boundary yang aman,
- observability cukup,
- tim yang paham bagian pentingnya.

Kalau cuma "dicoba dan keliatan jalan," itu masih terlalu lemah.

Mitchell menekankan: bagian paling penting bukan "slop is good." Poinnya adalah etiket dan skill untuk tahu di mana slop ada, seberapa banyak harus dibersihkan, dan bagaimana proses cleanup-nya.

## Kapan slop berubah jadi bahaya?
Slop jadi bahaya ketika:
- dilepas ke customer tanpa review,
- dipasang ke project lain tanpa transparansi,
- dianggap final padahal sebenarnya eksperimen,
- menyentuh state/data/security kritikal,
- masuk ke arsitektur sebagai fondasi tanpa cleanup.

Bahaya muncul saat tim kehilangan batas antara "coba cepat" dan "bertahan lama." Itu bukan lagi soal kode jelek; itu soal kepercayaan, data integrity, dan arsitektur.

## Hubungan dengan agentic coding dan software engineering sekarang
Skill baru di era AI bukan cuma generate kode cepat. Skill-nya adalah boundary discipline:
- jaga core internals tetap berkualitas,
- biarkan pinggiran eksperimen kasar,
- cetak kontrak bersih di boundary,
- review hasil slop dengan transparansi,
- cleanup setelah insight didapat.

## Vibe coding sebagai draft, bukan kebenaran
Vibe coding boleh dipakai untuk nge-draft dengan cepat, tapi tidak boleh membuat developer menyerahkan semua kebenaran ke AI. Mode ini berdasar pada speed dan flow, bukan pada asumsi bahwa output sudah tepat.

Kalau developer bilang "jalan di laptop gue, berarti selesai," itu tanda vibe coding yang tidak sehat. Versi sehatnya adalah: AI mempercepat gerak, tapi judgement tetap di manusia dan quality gate tetap ada.

Mitchell pakai contoh Terraform 0.1: dulu mereka cuma bisa ship sekitar 3 provider karena bikin provider lambat dan mahal. Kalau hari ini, dia bilang mungkin bisa generate 100 provider untuk membuktikan desain ekosistem lebih cepat — bukan sebagai kualitas final, tapi sebagai eksperimen.

## Insight utama
AI slop bukan normalisasi kualitas buruk. Dia normalisasi disposable experimentation.

Indikator pahamnya adalah: bukan lagi bertanya "boleh atau nggak?", tapi "mana bagian sistem yang boleh rusak, diganti, atau diregenerate ulang tanpa merusak trust, data, atau arsitektur?"

## Social boundary dan distribusi beban
Beberapa komentar penting di thread memperjelas bahwa slop bukan cuma properti teknis dari kode. Slop juga punya distribusi biaya sosial.

Kalau lo generate rough code untuk diri sendiri, biaya rusaknya lo tanggung sendiri. Kalau lo PR generated mess ke tim lain, reviewer harus nebak intent, cek edge case, dan mastiin kode itu bukan cuma "jalan di demo." Devin Stein menyebut bahwa slop adalah alat pribadi yang sering jadi beban orang lain ketika ia dipindah tanpa konteks.

Ini membuat boundary Mitchell lebih kaya: bukan hanya boundary teknis antara core dan pinggiran, tapi juga boundary sosial antara siapa yang eksperimen dan siapa yang harus membersihkan sisaannya.

## Slop sebagai riset murah
Komentar Manoj menggeser definisi slop dari "produk gagal" menjadi "instrumen riset murah." Generate 20 integrasi, 18 sampah, 2 valid — nilai sejatinya ada di sinyal bahwa dua arah itu layak dikembangkan.

Itu beda dengan sekadar menghasilkan kode yang jalan. Slop di sini adalah eksplorasi paralel: kita mengorbankan kualitas awal untuk menemukan arah yang benar lebih cepat. Tapi itu hanya valid jika ada fase seleksi dan cleanup setelahnya.

## Slop debt dan time boundary
Clément Miao membahas slop sebagai bentuk debt. Ini membuat slop lebih mudah dibaca lewat lensa ekonomi engineering: debt sehat harus dicatat, dibatasi, dan dibayar.

Perbedaan penting terhadap technical debt biasa adalah bahwa slop debt kadang muncul tanpa kesadaran tim. Tim bisa melihat AI generate banyak file dan mengira itu progress, padahal mereka mungkin cuma menumpuk potensi utang.

Hanzi menambahkan: yang paling bahaya bukan ketika slop terlihat jelek, tapi ketika slop mulai berguna. Friday prototype yang bertahan enam bulan bisa berubah dari eksperimen menjadi arsitektur tanpa disadari.

## Modularity sebagai containment strategy
Banyak komentar menekankan modularitas. Misael bilang modularity akan tetap penting di era AI. Felipe menegaskan bahwa slop liar di monolith 500 ribu baris sangat berbahaya.

Modularitas membuat slop lebih aman karena kerusakannya bisa dikurung di satu plugin, satu provider, satu adapter, satu UI screen. Kalau salah, bagian itu bisa dihapus, diregenerate, atau diganti tanpa ngerusak keseluruhan sistem.

Kalau slop masuk ke codebase monolitik non-modular, efeknya berbeda. Ia bisa nambah coupling, bikin review susah, dan mengacaukan mental model tim.

## Counter argument yang kuat
Ada juga counter argument yang valid: "There’s never time to do it right, but somehow there’s always time to do it over." Ini mengingatkan bahwa budaya ship cepat dulu sering jadi jebakan loop pengulangan dan rework.

Posisi paling adil adalah: Mitchell benar untuk eksplorasi, counter ini benar untuk komitmen. Masalah muncul ketika tim menyamaratakan kondisi itu — pura-pura masih eksperimen padahal sistemnya sudah dipakai sebagai production path.

## Ringkasan boundary yang lebih matang
Dari thread dan komentar yang terbaca, pagar yang diperlukan adalah:
- personal boundary: siapa yang eksperimen dan siapa yang menanggung biaya,
- modular boundary: apakah slop dikurung di komponen yang mudah diganti,
- production boundary: apakah kode itu masih alpha/internal atau sudah disalurkan ke user,
- time boundary: apakah ada rencana bayar utang dan cleanup sebelum eksperimen jadi struktur.

Kalau empat pagar itu jelas, slop bisa jadi research. Kalau pager itu kabur, slop jadi debt dan externalized cost.

## Related
- [[notes.agentic-engineering.how-i-use-ai-to-code]]
- [[notes.agentic-engineering.senior-judgement-to-harness]]
- [[zettel.20260507100900]]
- [[zettel.20260508142459]]
- [[zettel.20260508150000]]
