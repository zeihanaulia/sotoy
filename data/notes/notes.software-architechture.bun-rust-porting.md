
## Konteks

Jared Sumner membahas port Bun yang awalnya tumbuh enak di Zig, tapi lalu ketemu batasan baru saat dibawa ke Rust.
Bukan diskusi "Rust vs Zig" tribal, tapi tentang bagaimana model modular Rust mengubah arsitektur runtime yang saling terhubung dalam Bun.

- Post: https://x.com/jarredsumner/status/2053368908372128055

## Problem utama Jared

Yang dia ceritakan bukan cuma compile time atau sintaks.
Ini adalah problem dari transisi arsitektur:

- Bun sudah mulai tumbuh organik di Zig,
- Rust port memecahnya jadi banyak crate,
- crate bagus untuk compile time dan reuse,
- tapi Rust memaksa dependency graph jadi DAG,
- sementara banyak bagian Bun di Zig saling terhubung erat,
- tagged pointers di Zig dulu memudahkan interface heterogen.

Atomic problemnya:
**struktur runtime yang nyaman dan interconnected di Zig tidak langsung punya padanan ergonomis di Rust crate-based modularity.**

## Kenapa layering jadi masalah besar di Rust port

Layering di Rust bukan sekadar stylistic.
Ini memaksa keputusan desain baru:

- siapa boleh depend ke siapa,
- di crate mana interface didefinisikan,
- di crate mana type shared ditempatkan,
- di crate mana implementasi behavior tinggal.

Trade-offnya jelas:

- lebih sedikit crates = graph lebih longgar, tapi compile time dan reuse lebih buruk;
- lebih banyak crates = compile time incremental lebih bagus, tapi cycle dan boundary jadi tajam.

Untuk Bun, banyak area seperti event loop, process callback, nonblocking I/O, task scheduler itu secara alami saling bersilang.
Rust memperlakukan itu sebagai masalah arsitektur, bukan sekadar masalah implementasi.

## Crates, compile time, dan cyclic deps

Relasi yang Jared tunjukkan adalah:

- banyak crates → compile unit lebih kecil → compile incremental lebih cepat
- tapi banyak crates → dependency graph harus DAG-ish
- dan DAG-ish → cyclic dependency langsung jadi error desain

Beberapa reply teknis menanggapi dengan pola arsitektur:

- `bun-core` atau `*_types` crate sebagai dasar,
- `*_impl` crate untuk implementasi,
- pisahkan data schema dari behavior,
- dispatch logic ditempatkan di layer yang lebih tinggi.

Itu semua pada dasarnya adalah strategi memutus cycle di Rust.
Tapi strategi ini juga mengubah bentuk sistem: dari jaringan organik ke builder-style modular architecture.

## Kenapa tagged pointers Zig jadi titik friksi?

Tagged pointers memberikan fleksibilitas low-level yang sulit ditiru secara ergonomis di Rust.
Mereka memberi Zig:

- heterogeneity ringan,
- object layout kontrol manual,
- dispatch dan payload dalam satu representasi,
- performa tanpa overhead box/dyn.

Di Rust, pilihan padanannya biasanya:

- `Box<dyn Trait>`: ergonomis, tapi punya runtime dispatch / vtable / alloc cost,
- `T: Trait` generic: zero-cost, tapi tidak cocok untuk koleksi heterogen dinamis,
- `enum` of structs: static, no vtable, tapi harus dipusatkan dan bisa jadi besar.

Jadi friksi utama adalah: Zig bisa pakai tagged pointer sebagai building block runtime, sedangkan Rust mengharuskan kamu memilih antara runtime heterogeneity atau static modularity.

## Arah diskusi reply-reply

Diskusinya tidak tampak ingin balik ke Zig sebagai jawaban utama.
Arah utama yang muncul adalah:

1. **traits/types split** — taruh kontrak di core crate, implementasi di crate lain.
2. **core trait crate / bun-core** — shared trait dan types jadi titik temu.
3. **enum/`*_types` + `*_impl` split** — cara klasik memutus cycle.
4. **static generic vs dynamic trait** — pilih biaya runtime vs compile-time.
5. Ada juga suara yang bilang: jika arsitektur Bun memang serupa Zig, mungkin Zig lebih cocok ketimbang paksa Rust.

Jadi arah thread ini lebih ke negosiasi ulang arsitektur daripada adu fitur Rust/Zig.

## Cabang kualitas rewrite: measurable better dan stability

Thread lanjutan Jared menggeser diskusi dari "bagaimana cara port" ke "kapan port ini pantas di-merge".

Intinya, dia menegaskan bahwa Rust port tidak akan diterima kecuali hasil akhirnya bisa dibuktikan secara terukur lebih baik dari Zig di aspek:

- performance,
- memory usage,
- stability.

Di cabang ini, reply-reply berfokus pada kekhawatiran berikut:

- **stability sulit divalidasi** — test suite besar bisa memukul known failures, tapi unknown bug class baru masih mungkin muncul di dunia nyata.
- **rewrite harus measurable** — bukan cukup "works" atau "tests pass"; harus ada benchmark dan evidence.
- **benchmark/hot path evidence** — publik mulai menunggu angka nyata, bukan sekadar arsitektur teori.

Jadi, orang di cabang ini tidak menolak Rust port secara ide. Mereka menaikkan standar pembuktian. Rewrite dianggap hanya sah jika dia menang dalam metrik nyata, bukan sekadar menawarkan design-level safety.

Definisi stability dalam cabang ini muncul dua level:

1. **Design-level stability** — Rust mempersulit kelas crash tertentu seperti segfault dan memory safety bugs.
2. **Field-level stability** — apakah sistem tetap kokoh di paparan penggunaan nyata dan edge case dunia nyata.

Diskusi kini beralih ke arah yang lebih dewasa:

- menolak argumen "Rust lebih aman" tanpa bukti,
- menerima motivasi Rust untuk mengurangi kelas crash tertentu,
- menuntut benchmark dan test evidence,
- menyadari bahwa stabilitas penuh baru bisa didekati lewat exposure lapangan.

## Cabang sejarah dan metodologi port besar

Tweet Jared selanjutnya menyambung ke kisah asal Bun: port besar pertama kali dibuat dari Go ke Zig, pre-LLM, dan butuh pendekatan mental yang brutal.

Yang dia jelaskan bukan lagi arsitektur target, tapi **cara berpikir saat melakukan hand-port besar**.

Dia memberi dua heuristik penting:

- **breadth-first**, bukan depth-first,
- **tulis semua kode dulu**, jangan incremental-fix satu per satu.

Kalimatnya sederhana, tapi ini penting:
port bootstrap line-for-line bukan soal kesempurnaan. Ini soal membentuk kerangka sistem terlebih dahulu.

Beberapa insight dari cabang ini:

- port besar kadang lebih mirip pekerjaan mekanis daripada desain elegan.
- LOC ported bisa jadi proxy progress awal ketika fitur belum sempurna.
- menjaga source lama dekat dengan source baru membantu beban kognitif.
- fase awal port adalah bootstrap; fase berikutnya adalah fix; fase terakhir adalah redesign/optimization.

Reply yang paling berharga di cabang ini menegaskan:

- Glauber: port manual sering efektif kalau source lama tetap terlihat di samping source baru.
- Jason: port besar bisa berjalan bersamaan dengan re-architecture, tapi tidak selalu baik kalau langsung dicampur.
- Somi: “sort of work” berarti port awal bisa lulus, tetapi belum benar-benar matang.

Arah diskusi cabang ini adalah ke model kerja port:

- bootstrap dulu,
- baru kemudian hadapi mismatch arsitektur,
- lalu buktikan hasilnya.

Itu menambah konteks penting pada keseluruhan thread: Jarred ngomong tidak dari teori, tapi dari pengalaman port besar yang sebenarnya dia pernah jalani.

## Insight besar buat desain software

Dari thread ini gue ambil insight ini:

- port bahasa sistem bukan sekadar translasi fitur;
- itu soal memetakan ulang **abstraction model** dan **dependency model**;
- model yang nyaman di satu bahasa bisa jadi beban di bahasa lain;
- modularity dengan banyak unit kompilasi adalah trade-off; bukan free lunch.

Untuk sistem performa-sensitif dan interconnected, desain yang cocok di Zig bisa jadi:

- lebih organik,
- representasi heterogen dekat ke runtime,
- boundary implicit.

Sementara desain yang cocok di Rust cenderung:

- lebih eksplisit,
- boundary lebih tegas,
- shared contract di crate khusus,
- heterogeneity dipaksa lewat trait object atau enum.

Itu bukan soal salah satu lebih hebat.
Ini soal: **apa model yang paling sesuai dengan sifat sistem yang kamu bawa?**

## Yang masih menggantung

Bun thread Jared juga menunjukkan bahwa beberapa masalah belum beres:

- seberapa jauh `dyn` trait bisa dipakai tanpa bikin runtime overhead tidak terkendali?
- kapan `enum` jadi terlalu besar dan sulit dikembangkan?
- apakah `types`/`impl` split membuat sistem terlalu verbose?
- apakah batas crate yang diusulkan lebih banyak membuat kode jadi lebih keras dipahami?

Ini berarti thread ini berguna sebagai kasus arsitektur nyata, bukan sekadar diskusi bahasa.

## Takeaway

Kalau lo punya sistem performa-sensitif, heavily interconnected, dan tumbuh organik, porting ke Rust berarti lo mungkin harus:

- pilih ulang batas modularitas,
- taruh shared contract di crate dasar,
- tentukan mana runtime heterogeneity yang layak bayar dengan `dyn`,
- dan siap menerima kode lebih verbose sebagai biaya desain.

Itu lebih menarik daripada sekadar: "Rust harus punya fitur Zig."