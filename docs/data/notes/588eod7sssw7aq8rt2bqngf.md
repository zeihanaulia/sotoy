
Teori dasar dari Lean Manufacturing dan The Three Ways, prinsip-prinsip dari mana semua perilaku DevOps dapat diperoleh. Fokus utama di sini adalah pada teori dan prinsip-prinsip tersebut, yang menggambarkan banyak pengalaman yang dipelajari selama beberapa dekade dari manufaktur, organisasi dengan keandalan tinggi, model manajemen dengan kepercayaan tinggi, dan lain-lain, dari mana praktik DevOps telah diperoleh. Prinsip-prinsip dan pola-pola konkret yang dihasilkan, serta aplikasi praktisnya untuk aliran nilai teknologi, disajikan dalam bab-bab yang tersisa dari buku ini.

## Ringkasan

Ringkasan dari section "PART I - Agile, Continuous Delivery, and the Three Ways" adalah memperkenalkan konsep-konsep yang terkait dengan pengiriman nilai melalui teknologi value stream, termasuk pengukuran waktu pemrosesan dan pengiriman, serta prinsip-prinsip dasar DevOps yang dikenal sebagai Three Ways. Three Ways ini mencakup prinsip-prinsip Flow, Feedback, dan Experimentation yang menjadi dasar DevOps dan digunakan untuk menghasilkan pengiriman produk dan layanan secara cepat, berkualitas, dan terus menerus. Selain itu, disebutkan juga tentang praktik-praktik yang memungkinkan aliran kerja yang cepat, mengamplifikasi umpan balik untuk mencegah masalah yang sama terjadi lagi, dan menciptakan budaya yang mendukung pengambilan risiko dan percobaan yang inovatif.

## Action Items

Beberapa action item yang dapat diambil dari section "PART I - Agile, Continuous Delivery, and the Three Ways" adalah:

- Identifikasi dan visualisasikan value stream organisasi Anda untuk memahami bagaimana pekerjaan dilakukan, siapa yang melakukannya, dan bagaimana nilai diciptakan.
- Ukur lead time dan process time dalam value stream Anda untuk mengetahui bagaimana proses bekerja dan mengidentifikasi area yang dapat dioptimalkan.
- Gunakan %C/A sebagai metrik untuk mengukur kualitas output dalam setiap tahap value stream dan mengidentifikasi area yang perlu ditingkatkan.
- Terapkan prinsip-prinsip Three Ways untuk meningkatkan efektivitas dan efisiensi value stream organisasi Anda.
- Fokus pada prinsip Flow untuk menciptakan aliran kerja yang cepat dan efektif dalam value stream Anda.
- Implementasikan praktik-praktik seperti continuous build, integration, test, dan deployment processes, menciptakan lingkungan on-demand, dan membatasi work in process (WIP).
- Fokus pada prinsip Feedback Loop untuk menciptakan sistem kerja yang lebih aman dan berkelanjutan, dan memaksimalkan kesempatan untuk belajar dan berkembang.
- Membangun budaya organisasi yang mendukung eksperimen dan pengambilan risiko yang didasarkan pada pendekatan ilmiah dan disiplin, sehingga organisasi dapat belajar dan berkembang lebih cepat dari pesaing di pasar.


## THE MANUFACTURING VALUE STREAM

Pada bagian ini, diperkenalkan konsep dasar dari Lean Manufacturing yaitu value stream. Konsep ini dijelaskan terlebih dahulu dalam konteks manufaktur dan kemudian diterapkan pada DevOps dan teknologi value stream. 

Karen Martin dan Mike Osterling mendefinisikan value stream dalam bukunya Value Stream Mapping: How to Visualize Work and Align Leadership for Organizational Transformation sebagai "urutan aktivitas yang dilakukan oleh sebuah organisasi untuk memenuhi permintaan pelanggan," atau "urutan aktivitas yang diperlukan untuk merancang, memproduksi, dan mengirimkan barang atau layanan kepada pelanggan, termasuk aliran ganda informasi dan bahan." 

Pada operasi manufaktur, value stream seringkali mudah dilihat dan diamati: dimulai ketika pesanan pelanggan diterima dan bahan baku dirilis ke lantai pabrik. Untuk memungkinkan waktu pemrosesan yang cepat dan dapat diprediksi pada setiap value stream, biasanya terdapat fokus yang tak kenal lelah dalam menciptakan aliran kerja yang lancar dan merata, dengan menggunakan teknik seperti ukuran batch kecil, mengurangi work in process (WIP), mencegah rework untuk memastikan bahwa tidak ada cacat yang diteruskan ke work center downstream, dan terus mengoptimalkan sistem kita menuju tujuan global kita.

## THE TECHNOLOGY VALUE STREAM

Selanjutnya buku ini membahas mengenai value stream di dalam teknologi, di mana prinsip-prinsip yang sama yang memungkinkan aliran kerja yang cepat dalam proses fisik juga sama-sama berlaku untuk pekerjaan teknologi (dan, pada kenyataannya, untuk semua pekerjaan pengetahuan). Dalam DevOps, teknologi value stream didefinisikan sebagai proses yang diperlukan untuk mengubah hipotesis bisnis menjadi layanan yang diaktifkan oleh teknologi yang memberikan nilai kepada pelanggan.

Input dari proses ini adalah formulasi tujuan bisnis, konsep, ide, atau hipotesis, dan dimulai ketika pekerjaan diterima di Pengembangan, ditambahkan ke backlog pekerjaan yang sudah dikommit. Dari sana, tim Pengembangan yang mengikuti proses Agile atau iteratif yang khas kemungkinan akan mentransformasikan ide itu menjadi cerita pengguna dan beberapa jenis spesifikasi fitur, yang kemudian diimplementasikan dalam kode ke aplikasi atau layanan yang sedang dibangun. Kode kemudian diperiksa di dalam repositori kontrol versi, di mana setiap perubahan diintegrasikan dan diuji dengan bagian lain dari sistem perangkat lunak.

Karena nilai diciptakan hanya ketika layanan kami berjalan di production, kami harus memastikan bahwa kami tidak hanya memberikan aliran yang cepat, tetapi juga bahwa deployment kami dapat dilakukan tanpa menyebabkan kekacauan dan gangguan seperti outage layanan, impairments layanan, atau kegagalan keamanan atau kepatuhan.

## FOCUS ON DEPLOYMENT LEAD TIME

Selanjutnya buku ini fokus pada waktu deployment (deployment lead time), suatu subset dari nilai aliran yang telah dijelaskan sebelumnya. Nilai aliran ini dimulai ketika setiap insinyur dalam nilai aliran kita (yang mencakup Development, QA, IT Operations, dan Infosec) memeriksa perubahan ke dalam kontrol versi dan berakhir ketika perubahan itu berhasil berjalan di produksi, memberikan nilai kepada pelanggan dan menghasilkan umpan balik dan telemetri yang berguna.

Fase pertama dari pekerjaan yang mencakup Desain dan Pengembangan mirip dengan Lean Product Development dan sangat bervariasi dan sangat tidak pasti, seringkali memerlukan tingkat kreativitas yang tinggi dan pekerjaan yang mungkin tidak pernah dilakukan lagi, menghasilkan waktu proses yang sangat bervariasi. Sebaliknya, fase kedua dari pekerjaan, yang mencakup Pengujian dan Operasi, mirip dengan Lean Manufacturing. Ini membutuhkan kreativitas dan keahlian, dan berusaha untuk dapat diprediksi dan mekanistik, dengan tujuan mencapai hasil kerja dengan minimalkan variabilitas (misalnya, waktu deployment yang pendek dan dapat diprediksi, hampir tanpa cacat).

Alih-alih memproses batch kerja besar secara berurutan melalui nilai aliran desain/pengembangan dan kemudian melalui nilai aliran pengujian/operasi (seperti ketika kita memiliki proses air terjun batch besar atau cabang fitur yang hidup lama), tujuan kita adalah untuk memiliki pengujian dan operasi berjalan secara simultan dengan desain/pengembangan, memungkinkan aliran yang cepat dan berkualitas tinggi. Metode ini berhasil ketika kita bekerja dalam batch kecil dan membangun kualitas ke setiap bagian dari nilai aliran kita.†††

### Defining Lead Time vs. Processing Time

Di komunitas Lean, lead time adalah salah satu dari dua ukuran yang umum digunakan untuk mengukur kinerja dalam value stream, dengan yang lain adalah processing time (kadang-kadang dikenal sebagai touch time atau task time).

Sementara jam lead time dimulai saat permintaan dibuat dan berakhir ketika permintaan terpenuhi, jam process time dimulai hanya ketika kami mulai bekerja pada permintaan pelanggan—secara khusus, menghilangkan waktu ketika pekerjaan berada di antrian, menunggu untuk diproses.

![Lead time vs. process time of a deployment operation](assets/20230421130113.png)

Karena lead time adalah yang dialami pelanggan, kami biasanya memfokuskan perhatian perbaikan proses kami di sana daripada pada process time. Namun, proporsi process time terhadap lead time menjadi ukuran efisiensi yang penting—mencapai aliran cepat dan lead time yang pendek hampir selalu memerlukan pengurangan waktu pekerjaan kami menunggu di antrian.

### Skenario Umum: Waktu Pemakaian Yang Memerlukan Berbulan-Bulan

Dalam bisnis biasa, seringkali kita menemukan diri kita berada dalam situasi di mana waktu penyebaran kami memerlukan berbulan-bulan. Ini terutama umum terjadi dalam organisasi besar dan kompleks yang bekerja dengan aplikasi monolitik yang sangat terkait, seringkali dengan lingkungan uji integrasi yang langka, waktu pemimpin lingkungan uji dan produksi yang lama, ketergantungan tinggi pada pengujian manual, dan beberapa proses persetujuan yang diperlukan. Ketika ini terjadi, maka value stream kita mungkin terlihat seperti pada gambar:

![A technology value stream with a deployment lead time of three months (Source: Damon Edwards, “DevOps Kaizen,” 2015.)](assets/20230421130420.png)

Ketika kita memiliki waktu penyebaran yang lama, heroisme diperlukan di hampir setiap tahap value stream. Kita mungkin menemukan bahwa tidak ada yang berfungsi pada akhir proyek ketika kita menggabungkan semua perubahan tim pengembangan, yang menghasilkan kode yang tidak lagi dibangun dengan benar atau lulus semua tes kami. Memperbaiki setiap masalah memerlukan hari atau minggu investigasi untuk menentukan siapa yang merusak kode dan bagaimana itu dapat diperbaiki, dan masih menghasilkan hasil pelanggan yang buruk.


### Visi DevOps Kami: Deployment Lead Time dalam Hitungan Menit

Pada kondisi ideal DevOps, para developer menerima umpan balik cepat dan terus-menerus terhadap pekerjaan mereka, yang memungkinkan mereka untuk dengan cepat dan mandiri mengimplementasikan, mengintegrasikan, dan memvalidasi kode mereka, serta melakukan deployment kode tersebut ke dalam lingkungan produksi (baik dengan melakukan deployment sendiri atau oleh orang lain).

Kami mencapainya dengan terus memeriksa perubahan kode kecil ke dalam repositori kontrol versi kami, melakukan pengujian otomatis dan eksploratori terhadapnya, dan mendeploynya ke dalam produksi. Ini memungkinkan kami memiliki tingkat keyakinan yang tinggi bahwa perubahan kami akan berfungsi seperti yang direncanakan di produksi dan bahwa setiap masalah dapat dideteksi dan diperbaiki dengan cepat.

Hal ini paling mudah dicapai ketika kita memiliki arsitektur yang modular, terenkapsulasi dengan baik, dan longgar-terkait sehingga tim kecil mampu bekerja dengan tingkat otonomi yang tinggi, dengan kegagalan yang kecil dan terkandung, dan tanpa menyebabkan gangguan global.

Pada skenario ini, waktu deployment lead time kita diukur dalam hitungan menit, atau, dalam kasus terburuk, jam. Peta alir nilai hasil kami harus terlihat seperti gambar:

![A technology value stream with a lead time of minutes](assets/20230421130853.png)

### OBSERVING “%C/A” AS A MEASURE OF REWORK

Metric ketiga dalam technology value stream, yaitu persentase selesai dan akurat (%C/A) yang mencerminkan kualitas output dari setiap langkah dalam value stream. %C/A dapat diukur dengan cara menanyakan kepada pelanggan downstream berapa persentase waktu mereka menerima pekerjaan yang "dapat digunakan apa adanya" yang berarti mereka dapat melakukan pekerjaan mereka tanpa harus memperbaiki informasi yang diberikan, menambahkan informasi yang hilang yang seharusnya disediakan, atau menjelaskan informasi yang seharusnya dan bisa lebih jelas. 

Hal ini menjadi penting karena kualitas yang buruk akan menghasilkan pekerjaan yang tidak efektif dan efisien dalam penggunaan sumber daya.

Misalnya, dalam sebuah perusahaan software, jika 80% dari kode yang dikerjakan oleh tim pengembang dalam sprint pertama dapat diserahkan ke tim testing tanpa perlu dilakukan perbaikan tambahan, maka %C/A untuk sprint tersebut adalah 80%. Artinya, dari semua pekerjaan yang diselesaikan dalam sprint pertama, 80% dari pekerjaan tersebut dapat digunakan tanpa perlu dikerjakan ulang atau memperbaiki lagi.

Jika persentase %C/A ini rendah, misalnya hanya 30%, artinya hanya 30% pekerjaan yang dapat diserahkan ke downstream tanpa perlu dilakukan perbaikan tambahan, sedangkan 70% sisanya memerlukan rework atau perbaikan lagi, yang berarti adanya masalah dalam proses pengembangan yang harus diperbaiki. Dalam hal ini, peningkatan %C/A menjadi tujuan yang harus dicapai untuk meningkatkan kualitas hasil kerja dan mengurangi rework.

## THE THREE WAYS: THE PRINCIPLES UNDERPINNING DEVOPS

Konsep ini terdiri dari tiga prinsip yang menjadi dasar bagi semua perilaku dan pola DevOps yang diamati. Prinsip pertama disebut The First Way, yang bertujuan untuk memungkinkan aliran kerja yang cepat dari Development ke Operations hingga ke pelanggan. 

Untuk memaksimalkan aliran kerja ini, perlu membuat pekerjaan terlihat, mengurangi ukuran batch dan interval pekerjaan, membangun kualitas dengan mencegah cacat agar tidak diteruskan ke pusat kerja hilir, dan terus mengoptimalkan tujuan global. Prinsip-prinsip lain dari The Three Ways akan dibahas pada bagian selanjutnya.

![The Three Ways (Source: Gene Kim, “The Three Ways: The Principles Underpinning DevOps,” IT Revolution Press blog, accessed August 9, 2016, http://itrevolution.com/the-three-ways-principles-underpinning-devops/.)](assets/20230421131336.png)

Dengan mempercepat aliran melalui value stream teknologi, kita dapat mengurangi waktu yang diperlukan untuk memenuhi permintaan internal atau pelanggan, terutama waktu yang dibutuhkan untuk mendeploy kode ke lingkungan produksi. Dengan melakukan hal ini, kita meningkatkan kualitas pekerjaan dan throughput, serta meningkatkan kemampuan kita untuk melampaui kompetisi.

Praktik yang dihasilkan meliputi proses continuous build, integration, test, dan deployment; menciptakan lingkungan sesuai permintaan; membatasi work in process (WIP); dan membangun sistem dan organisasi yang aman untuk diubah.

Prinsip kedua (The Second Way) adalah memungkinkan aliran feedback yang cepat dan konstan dari kanan ke kiri di semua tahap value stream kita. Dalam prinsip ini, kita perlu memperkuat feedback untuk mencegah masalah terjadi lagi atau memungkinkan deteksi dan pemulihan yang lebih cepat. Dengan melakukan ini, kita menciptakan kualitas di sumbernya dan menghasilkan atau menyematkan pengetahuan di tempat yang dibutuhkan.

Dengan melihat masalah saat terjadi dan menanganinya hingga tindakan perbaikan yang efektif diterapkan, kita terus memperpendek dan memperkuat feedback loop, prinsip inti dari hampir semua metodologi perbaikan proses modern. Hal ini memaksimalkan peluang organisasi kita untuk belajar dan meningkatkan.

Prinsip ketiga (The Third Way) adalah memungkinkan terciptanya budaya generatif yang tinggi kepercayaannya dan mendukung pendekatan yang dinamis, disiplin, dan ilmiah terhadap eksperimen dan pengambilan risiko. Prinsip ini memfasilitasi terciptanya pembelajaran organisasi dari keberhasilan dan kegagalan. Dengan memperpendek dan memperkuat terus-menerus feedback loop, kita menciptakan sistem kerja yang semakin aman dan mampu mengambil risiko serta melakukan eksperimen yang membantu kita belajar lebih cepat dari kompetitor dan menang di pasar.

Sebagai bagian dari The Third Way, kita juga merancang sistem kerja kita sehingga kita dapat memperbanyak efek pengetahuan baru, mengubah penemuan lokal menjadi perbaikan global. Terlepas dari di mana seseorang melakukan pekerjaan, mereka melakukannya dengan pengalaman kumulatif dan kolektif dari semua orang di organisasi.