
- Apa yang terlibat dalam implementasi pipeline
- Dampak organisasi jika pipeline baru atau diperbarui diimplementasikan dan digunakan
- Berbagai jenis model operasional mengenai infrastruktur integrasi dan tanggung jawab tim dan organisasi
- Bagaimana implementasi aplikasi dapat mendapatkan manfaat dari penggunaan fitur tambahan seperti runbook, catatan rilis, dan promosi artefak

Ketika aplikasi diterapkan ke produksi untuk pertama kalinya, banyak hal yang harus diatur. Sertifikat harus diminta dan diinstal. Kredensial dan rahasia lainnya harus diatur dan disimpan dengan aman. Pemantauan aplikasi harus diatur, dan sebagainya. Dalam asumsi bahwa tidak semua kegiatan dalam rantai pasokan perangkat lunak dapat diotomatisasi, beberapa tugas manual terlibat. Selain itu, proses pengelolaan dan penggunaan aplikasi harus teratur. Tim harus tahu apa yang harus dilakukan jika aplikasi gagal atau berperilaku buruk. Prosedur untuk perubahan, insiden, masalah, dan manajemen ketersediaan harus ada.

Hal yang sama berlaku untuk pipeline. Lingkungan di mana pipeline berjalan harus dipersiapkan dan ditingkatkan. Platform tempat pipeline berjalan mungkin memiliki koneksi eksternal yang perlu diamankan, dan infrastruktur platform integrasi serta pipeline itu sendiri perlu dipantau. Jika pipeline gagal atau tidak berfungsi sebagaimana mestinya, tim harus bereaksi dengan tepat. Hanya setelah persiapan ini selesai, pipeline siap digunakan. Implementasi pipeline melibatkan lebih banyak pekerjaan daripada yang terlihat.

## Implementasi Pipeline

Implementasi pipeline itu sendiri agak aneh. Jika implementasi pipeline dibandingkan dengan implementasi aplikasi, pipeline perlu dikonfigurasi untuk dan diterapkan ke lingkungan target. Namun, apa yang menjadi lingkungan target dalam kasus pipeline, dan apakah kita dapat berbicara tentang implementasi pipeline? Dalam diskusi pipeline dari pipeline, kesimpulannya adalah bahwa menerapkan pipeline ke produksi tidak lebih dari sekadar mendorong kode pipeline ke repositori jarak jauh dan menggabungkannya dengan jalur utama. Gambar 7-1 menggambarkan perilaku ini.

![Gambar 7-1 Implementasi Pipeline](assets/2023-07-07-14-15-08.png)

Pada Gambar 7-1, kode pipeline baru atau diperbarui berada di cabang lain dalam repositori yang sama dengan aplikasi, atau berada di repositori lain yang dikloning dari repositori asli. Hal ini tergantung pada metode pengembangan pipeline. Kode pipeline diuji di lingkungan uji pipeline, yang membangun dan menerapkan aplikasi ke lingkungan uji, yang disebut Uji Jalankan-1. Menggabungkan kode pipeline dengan jalur utama berarti bahwa pipeline sejak saat itu diimplementasikan dan dapat digunakan untuk diterapkan ke semua lingkungan target (Uji Jalankan-1, Uji Jalankan-2, dan Produksi Jalankan).

## Dampak Organisasi

Sebuah pipeline dikembangkan sesuai dengan persyaratan dan pedoman, dan diuji dengan baik sebelum dapat digunakan. Ini berarti perilaku fungsional sesuai dengan spesifikasi, kinerja pipeline diuji dan memenuhi kriteria, langkah-langkah keamanan diterapkan, dan pipeline memenuhi spesifikasi kepatuhan organisasi. Karena pipeline digunakan oleh tim DevOps, semua anggota tim harus yakin bahwa pipeline tersebut dapat digunakan. Jika perlu, instruksi dokumentasi mengenai penggunaan pipeline, pengaturan teknis, dan pemeliharaan ditulis. Ini tidak wajib, tetapi dapat membantu mempersiapkan seluruh tim. Tim memutuskan apakah dokumentasi diperlukan. Mereka harus menyetujui kesiapan pipeline.

Setiap kali versi baru pipeline digunakan, batasannya harus diakui, dan masalah yang diketahui harus dicatat. Daftarkan persyaratan yang tidak terwujud. Daftarkan tindakan mitigasi, seperti pemeriksaan manual, jika ada persyaratan yang tidak diimplementasikan tetapi dapat menimbulkan risiko.

Baik tim maupun bisnis mengevaluasi kesenjangan yang mungkin terjadi dan perbaikan lain yang dapat dilakukan. Setiap kesenjangan dimasukkan dalam backlog dan diprioritaskan. Keterlibatan bisnis terutama berkaitan dengan strategi rilis dan penggunaan kebijakan organisasi. Apakah perlu untuk menerapkan setiap fitur yang diwujudkan ke produksi dalam waktu 15 menit, atau masih cukup untuk menggabungkan fitur-fitur menjadi peningkatan kecil dan merilisnya dengan frekuensi satu minggu? Jika ada perubahan dalam aspek-aspek ini, alur kerja tim dan mungkin desain pipeline akan terpengaruh. Struktur pengawasan harus ada untuk melakukan evaluasi ini. Sisihkan waktu sebagai tim untuk mengevaluasi atau, yang lebih baik, tetapkan proses perbaikan berkelanjutan, tidak hanya untuk pengembangan aplikasi tetapi juga untuk pengembangan pipeline.

Jika belum dikonfigurasi sebelumnya, tentukan seperti apa struktur pemberitahuan seharusnya. Selama pengembangan pipeline, seluruh tim mungkin menerima email yang sama dengan status jalannya pipeline dan permintaan untuk menyetujui penerapan. Tepat sebelum menerapkan pipeline, penerima harus dikonfigurasi, dan pemberitahuan ditetapkan, sehingga setiap anggota tim hanya menerima informasi spesifik yang menarik bagi mereka. Cegah informasi yang berlebihan dan manfaatkan dashboard untuk memvisualisasikan informasi penting.

### Disiplin Tim

Meskipun tim antusias tentang otomatisasi dan bekerja dengan pipeline, tetap saja ada hal-hal tertentu yang sedikit terabaikan. Implementasi pipeline juga berarti tim harus disiplin dalam beberapa area. Beberapa masalah yang persisten adalah sebagai berikut:

- Breaking builds: Salah satu prinsip integrasi berkelanjutan adalah bahwa build yang rusak harus diperbaiki segera. Developers diharapkan meninggalkan apa pun yang sedang mereka kerjakan dan memperbaiki pipeline yang rusak. Ini sedikit keinginan semata. Developers sering tidak bereaksi langsung terhadap peristiwa ini. Ini tidak masalah, jika tidak menyebabkan masalah dalam merilis artefak terlambat. Namun, meninggalkan pipeline yang rusak selama satu atau dua hari juga bukan praktik yang disarankan. Salah satu alasan yang jelas mengapa pipeline dapat rusak adalah kode yang di-commit tidak benar dan tidak dapat dibangun. Alasan lain adalah dunia di sekitar pipeline sedang berubah. Sistem eksternal bisa turun, diperbarui, atau tidak lagi dapat diakses; pemeriksaan kerentanan diperketat; kredensial atau sertifikat kedaluwarsa; atau platform ALM/integrasi itu sendiri mengalami masalah teknis. Tim harus memperbaiki pipeline-pipeline yang rusak ini. Jika tidak, usaha untuk memperbaikinya akan meningkat seiring berjalannya waktu.

- Disabled quality gates: Praktik baik adalah jika analisis kode mendeteksi kerentanan yang serius atau berperingkat tinggi dalam kode, pipeline akan "rusak" karena quality gates diaktifkan. Beberapa pipeline tidak memiliki quality gates yang diaktifkan, baik karena kecelakaan atau dengan sengaja. Yang terakhir kemungkinan karena masalah berikut.

- Tindak lanjut terhadap cacat analisis kode: Beberapa tim menjaga kebersihan analisis kode dengan baik. Mereka menyelesaikan semua kerentanan penting, sehingga quality gates dilewati. Tim lain mengabaikan hasil analisis kode, menonaktifkan quality gates, dan menumpuk hutang teknis.

- Cakupan uji unit: Hal yang sama berlaku untuk cakupan uji unit. Beberapa tim menjadikan menjaga cakupan tinggi sebagai tantangan. Tim lain tidak melakukannya. Cakupan uji unit yang rendah—cakupan di bawah ambang batas yang ditentukan—harus memecahkan pipeline.

- Otomatisasi pengujian tertinggal: Sering terjadi backlog dalam mengotomatisasi pengujian. Terkadang, jumlah orang yang terlibat dalam mengotomatisasi pengujian terbatas, sehingga menyebabkan backlog yang besar dalam pengujian otomatis. Ini bisa terjadi jika pengujian otomatis dilakukan hanya oleh tim QA (kecil). Bantuan akan datang ketika kegiatan pengujian otomatis disebar ke seluruh tim dan pengembang juga terlibat dalam pengembangan pengujian otomatis.

Tergantung pada tim dan kematangan mereka, ada lebih banyak masalah yang persisten. Beberapa tim masih berhasil menghindari pipeline dan menerapkan ke produksi dengan cara lain, atau mereka melakukan integrasi berkelanjutan dari cabang pengembangan di pipeline, sementara mereka masih membuat artefak rilis dari cabang utama pada mesin pengembangan lokal mereka. Jika ada tekanan, pull request disetujui tanpamelihat kode. Semua ini adalah bagian dari proses belajar, tetapi masalah-masalah ini harus diatasi.

### Platform Integrasi

Tergantung pada jenis platform integrasi yang digunakan, tanggung jawab dalam menyiapkan dan mengelola infrastruktur berbeda-beda. Dalam konteks ini, infrastruktur integrasi melibatkan platform integrasi (middleware) seperti Jenkins dan perangkat tambahan yang digunakan oleh pipeline seperti SonarQube, alat-alat penerapan, dll. Infrastruktur integrasi juga mencakup infrastruktur tempat semuanya berjalan. Ini menghasilkan beberapa model operasional.

- Model SaaS: Solusi SaaS lengkap menawarkan platform integrasi lengkap, mengurangi kekhawatiran bagi tim DevOps. Karena tanggung jawab bersama, tim DevOps dapat fokus sepenuhnya pada implementasi pipeline, sementara penyedia SaaS bertanggung jawab atas manajemen seluruh tumpukan platform integrasi, termasuk pengamanan dan peningkatan kapasitas server serta pembaruan perangkat lunak secara teratur. Platform seperti Azure DevOps atau CircleCI Cloud termasuk dalam kategori ini.

- Model IaaS: Juga memungkinkan penggunaan infrastruktur sebagai layanan (IaaS) di mana penyedia infrastruktur mengelola lanskap server, sementara tumpukan platform integrasi dikelola oleh tim IT4IT terpisah atau tim DevOps itu sendiri. Dalam konteks ini, tim IT4IT atau DevOps mendapatkan lebih banyak tanggung jawab, mulai dari mengelola klaster Kubernetes hingga secara teratur mengupgrade kontainer, memperbarui perangkat lunak, dan menginstal plugin. Tim juga harus menentukan apakah platform sudah cukup skala. Mungkin infrastruktur sudah disiapkan sekali, tetapi tes kinerja pipeline menunjukkan bahwa kapasitasnya tidak lagi mencukupi dengan diperkenalkannya pipeline-pipeline baru. Diperlukan penyesuaian skala infrastruktur agar kriteria kinerja terpenuhi kembali. Selain itu, pemindahan beban kerja ke server/kontainer terpisah harus dipertimbangkan. Jika build, analisis kode, pengujian, dan penerapan semuanya dilakukan pada server yang sama, memindahkan tahap-tahap tertentu ke server/nodes/agen lain membantu dalam penyebaran beban. Model operasional semacam ini umumnya dapat dicapai dengan menginstal Jenkins pada server biasa seperti AWS EC2 dan Azure VM, atau Jenkins dalam wadah Docker yang berjalan di Azure Kubernetes Service (AKS) atau bahkan AWS ECS Fargate.

- Model self-hosting: Sebuah organisasi juga dapat memutuskan untuk meng-hosting infrastruktur platform integrasi lengkap. Ini berarti perlu persiapan lebih lanjut. Berikut adalah tanggung jawab tambahan:
  
  - Provisi infrastruktur tempat platform integrasi berjalan.
  - Penyetelan logging, pemantauan, dan pemberitahuan infrastruktur harus diatur dan dikonfigurasi. Tentukan metrik sistem mana yang perlu divalidasi; misalnya, pemberitahuan akan dipicu jika server menggunakan lebih dari 90 persen kapasitas CPU atau pemberitahuan akan dipicu jika ruang disk lebih besar dari 80 persen.
  - Infrastruktur akhir harus disetujui. Gunakan kerangka acuan seperti ISO 25010 (lihat [25]) sebagai panduan untuk menentukan apakah semua persyaratan (nonfungsional) terpenuhi, dan pastikan infrastruktur cukup aman. Dalam hal terakhir, dapat digunakan kerangka acuan seperti NIST Framework for Improving Critical Infrastructure Cybersecurity (lihat [26]).

Selain persiapan infrastruktur yang telah disebutkan dalam berbagai model operasional, tindakan keamanan harus diterapkan pada infrastruktur tersebut. Berikut beberapa contohnya:
Apakah infrastruktur sudah cukup aman? Pastikan semua server telah diperkuat dan manajemen kerentanan dilakukan. Secara teratur melakukan pembaruan perangkat lunak pada server.

- Apakah semua koneksi aman? Platform ALM/platform integrasi mungkin berkomunikasi dengan sistem SCM, sistem manajemen item kerja, server yang melakukan analisis kode, dll. Koneksi harus diamankan menggunakan HTTPS, misalnya (dan lebih baik menggunakan mTLS daripada TLS satu arah).

- Hal ini juga berlaku untuk koneksi dengan lingkungan target—baik uji coba maupun produksi—tempat aplikasi dijalankan.

- Perbaiki akses dengan mengatur izin untuk pengguna atau grup. Pengguna yang memulai penerapan secara manual tidak diizinkan untuk menyetujui penerapan tersebut sendiri.

- Konfigurasikan kebijakan cabang jika belum dilakukan. Jika tim menggunakan cabang dan pipeline yang terkait dengan cabang mengalami kegagalan, seharusnya tidak mungkin menggabungkan cabang tersebut ke dalam jalur utama.

- Konfigurasikan vault yang digunakan untuk menyimpan token, kunci, kredensial, dan rahasia lainnya.

- Konfigurasikan infrastruktur sedemikian rupa sehingga kode aplikasi, pipeline (yang berjalan), pengujian, item kerja, pull request, dll., yang terlibat dalam pembuatan artefak rilis yang diterapkan ke produksi, tidak dapat dihapus.

- Pasang pemindai kepatuhan pipeline. Pemindai ini memvalidasi apakah pipeline-pipeline memenuhi kebijakan perusahaan.

### Persiapan Lingkungan Target

Jika tim telah mengadopsi pengembangan pipeline yang diperluas (atau canggih), sebagian besar pengembangan dan pengujian pipeline dilakukan menggunakan lingkungan pengembangan/ujian pipeline. Jika pipeline siap untuk diimplementasikan dan digunakan, pipeline tersebut dipromosikan sehingga dapat membangun dan menerapkan aplikasi ke berbagai lingkungan target. Ini mungkin meliputi lingkungan uji tambahan dan lingkungan produksi. Konfigurasikan lingkungan target ini agar dapat diakses oleh pipeline dan lakukan penerapan melalui koneksi yang aman.

Aplikasi yang diimplementasikan kemungkinan juga memerlukan kredensial (basis data), sertifikat, atau data statis. Hal ini harus diminta atau dihasilkan dan diterapkan ke lingkungan target sehingga aplikasi dapat menggunakannya. Lebih baik jika ini adalah proses otomatis; gunakan pipeline operasional untuk mengatur hal ini. Bab berikutnyaakan membahas pipeline operasional dengan lebih detail.

Dalam kasus lingkungan uji aplikasi, perlu diatur data uji. Entah menghasilkan data sintetis atau menggunakan salinan dari produksi, tetapi pastikan data tersebut dianonimkan.

#### Playbook

Apa dampak bisnis jika terjadi insiden atau masalah dengan pipeline? Kegagalan pipeline dapat menyebabkan kerusakan. Misalnya, perbaikan mendesak pada aplikasi harus dibuat dan perlu diterapkan. Namun, pipeline tidak berfungsi karena kegagalan infrastruktur dari platform integrasi. Ini dapat merusak kelangsungan proses bisnis jika pipeline tidak tersedia dalam waktu yang lama. Proses ITIL juga berlaku untuk pipeline. Playbook dapat berperan penting dalam proses manajemen insiden dan masalah.

Playbook berisi metode investigasi yang didokumentasikan untuk mendeteksi dan menyelesaikan masalah. Playbook ini berguna untuk menyelidiki insiden atau kegagalan. Playbook juga dapat digunakan untuk pipeline. Penyusunan playbook pipeline dapat dimulai selama pengujian pipeline. Kegagalan pipeline umum dan solusinya ditambahkan ke playbook. Tentu saja, playbook tidak pernah lengkap, dan setelah implementasi dan penggunaan pipeline, akan muncul lebih banyak kasus. Kasus-kasus ini juga ditambahkan ke playbook.

### Implementasi Aplikasi

Sulit untuk membicarakan implementasi pipeline tanpa menyebutkan implementasi aplikasi. Implementasi aplikasi, pada dasarnya, adalah tujuan penggunaan pipeline. Menambahkan fitur-fitur tertentu ke dalam pipeline dapat berkontribusi pada pengalaman implementasi aplikasi yang solid. Pertimbangkan untuk menggunakan atau mengimplementasikan fitur-fitur berikut.

#### Runbook

"Sebuah runbook adalah sekumpulan proses dan prosedur yang Anda eksekusi secara berulang untuk mendukung berbagai tugas perusahaan."

Referensi [33]

Mengapa Anda membutuhkan runbook jika Anda menggunakan pipeline otomatis? Itu pertanyaan yang bagus. Sebuah pipeline sudah mengatur pelaksanaan aplikasi, bukan? Tetapi tim masih menggunakan runbook meskipun mereka juga menggunakan pipeline. Ada beberapa alasan mengapa penggunaan runbook masih valid.
Masih ada tugas atau aktivitas satu kali yang tidak termasuk dalam CI/CD. Awal CI adalah saat melakukan commit ke repositori. Akhir CD adalah saat penerapan artefak ke lingkungan produksi. Banyak tugas termasuk dalam proses sebelum dan sesudah CI/CD. Pikirkan tentang meminta langganan Azure, mengonfigurasi peran IAM, dan mengalokasikan anggota tim. Selain itu, pemeliharaan atau migrasi rutin melibatkan aktivitas yang juga tidak termasuk dalam pipeline CI/CD. Terkadang aktivitas-aktivitas ini kompleks dan memerlukan runbook yang detail.

Alasan lain menggunakan runbook adalah implementasi pertama dari sistem lengkap. Anda tidak memiliki CI/CD yang disiapkan sejak hari pertama. Implementasi sistem baru dalam produksi mungkin memerlukan eksekusi beberapa pipeline dalam urutan tertentu; bahkan dalam arsitektur mikro layanan, beberapa pipeline harus berjalan dalam urutan tertentu. Pikirkan tentang menyiapkan komponen infrastruktur dasar yang digunakan oleh semua mikro layanan.

Segala sesuatu dapat diotomatiskan, termasuk runbook. Jika sebuah spreadsheet sederhana tidak cukup, gunakan salah satu dari beberapa alat runbook otomatis. Dan karena Anda sudah mengembangkan pipeline, mengatur pipeline orkestrasi untuk mengimplementasikan runbook juga menjadi pilihan. Namun, pertanyaannya adalah apakah manfaatnya sebanding dengan usaha dan biaya yang dikeluarkan. Itu adalah pertanyaan yang hanya dapat dijawab oleh tim.

### Release Note

Sebuah release note adalah catatan perubahan, yang menggambarkan pembaruan perangkat lunak. Ini juga dapat mencakup bukti bahwa semua fitur baru telah diuji dan diterima. Jadi, release note terkait dengan artefak dan berisi informasi tentang fitur-fitur yang disampaikan dan (opsional) laporan pengujian. Karena buku ini membahas desain CI/CD, pembuatan release note seharusnya tidak dilakukan secara manual tetapi dibuat secara otomatis. Namun, ada satu hal yang perlu dipertimbangkan. Antara dua rilis produksi, kemungkinan ada beberapa kandidat rilis, termasuk fitur-fitur dan perubahan baru. Kandidat rilis terakhir ditandai sebagai "rilis" dan diterapkan ke produksi. Potensial, beberapa catatan rilis dibuat di antara mereka, masing-masing terkait dengan kandidat rilis. Hanya artefak terakhir yang diterapkan ke produksi yang berisi semua fitur baru sejak rilis produksi sebelumnya. Kemungkinan besar catatan rilis terakhir sangat ringkas, hanya menggambarkan perbaikan bug. Hal ini sedikit disayangkan. Catatan rilis dari artefak produksi seharusnya idealnya terdiri dari semua perubahan antara rilis produksi sebelumnya dan rilis produksi saat ini. Selain itu, catatan rilis juga harus berisi semua hasil pengujian yang dilakukan pada rilis yang diterapkan ke produksi.

Untuk memecahkan masalah ini, sistem harus melacak semua perubahan antara rilis produksi terbaru dan rilis produksi berikutnya dan mengumpulkan semua metadata perantara untuk membentuk catatan rilis yang teragregasi. Setelah setiap penerapan produksi, status metadata direset, dan proses pengumpulan dimulai kembali. Lihat Gambar 7-2.

![Gambar 7-2 Pengumpulan data catatan rilis](assets/2023-07-07-14-46-39.png)

Karena catatan rilis berpotensi berisi semua fitur artefak dan hasil pengujian yang terkait, pembuatannya biasanya dilakukan setelah semua pengujian selesai. Metadata yang terdiri dari semua fitur dihasilkan pada tahap Publish artefak, di mana semua data perubahan dan fitur artefak dikumpulkan. Tahap Perform test menghasilkan semua hasil pengujian. Sepertinya masuk akal bahwa pembuatan catatan rilis dilakukan sebagai bagian dari tahap Notify actors.

Pertimbangkan kasus berikut:

> Tim ingin mengotomatisasi pembuatan catatan rilis. Mereka menggunakan sistem pelacak masalah terpisah untuk mendaftar item kerja. Kode disimpan di Git, dan artefak disimpan di repositori artefak.

> Tim diberi informasi tentang setiap penerapan produksi menggunakan email (baik penerapan yang berhasil maupun yang gagal).

> Catatan rilis dipublikasikan di halaman wiki. Tim ingin memiliki catatan rilis teragregasi, yang berisi semua fitur sejak rilis terakhir diterapkan ke produksi, termasuk hasil pengujian dari rilis terakhir.

Model BPMN khas dapat terlihat seperti pada Gambar 7-3.

![Gambar 7-3 BPMN, membuat catatan rilis](assets/2023-07-07-14-47-16.png)

Ketika tahap Publish artefak dieksekusi, artefak disimpan di repositori artefak, setelah itu tugas khusus mengumpulkan semua data yang terkait dengan artefak. Ini berarti pesan komit kode diambil dan item kerja yang terkait dengan artefak rilis diambil (tidak ditampilkan dalam diagram untuk alasan kejelasan). Informasi ini disimpan di database sehingga dapat digunakan nanti.

Pada akhir tahap Perform test, hasil penguji akan terbaca. Data hasil pengujian dikumpulkan dan juga disimpan dalam database yang sama.

Pada suatu waktu dalam proses CI/CD, artefak tersebut (berhasil) diimplementasikan ke lingkungan produksi. Hasil dari penerapan tersebut diteruskan ke tahap Notify actors, dan tugas Publish release note mengambil metadata dari database, mengumpulkan data tersebut, memformatnya menjadi catatan rilis, dan mempublikasikannya ke halaman wiki. Setelah ini selesai, metadata dalam database direset ke situasi awal yang baru.

#### Promosi Artefak

Hasil dari tahap build, package, dan publish adalah sebuah artefak yang disimpan dalam repositori biner. Artefak ini adalah kandidat rilis, artinya secara potensial dapat diimplementasikan ke produksi. Namun, pertama-tama artefak harus melalui berbagai siklus pengujian, sehingga segalanya dapat terjadi sepanjang perjalanan. Selama proses pengujian, artefak bergerak mendekati produksi, tetapi hanya artefak yang telah diuji dengan sukses yang diizinkan untuk diimplementasikan ke produksi. Kandidat rilis yang terhenti di tengah proses pengujian harus diberi tanda karena ada potensi risiko bahwa rilis yang salah diimplementasikan ke produksi. Masalahnya adalah semua kandidat rilis, baik yang gagal dalam pengujian maupun yang berhasil, disimpan dalam repositori biner yang sama. Harus ada cara untuk membedakan kandidat rilis yang gagal dengan rilis yang berhasil. Untuk memastikan bahwa kandidat rilis yang gagal selama pengujian dicegah dari diimplementasikan ke produksi, dapat ditambahkan quality gate; ini adalah pemeriksaan tambahan untuk menentukan bahwa artefak valid. Pemeriksaan ini dapat diimplementasikan dalam tahap Validate exit criteria.

Tapi berdasarkan informasi apa quality gate ini bekerja? Ada beberapa opsi untuk mencegah rilis yang salah diimplementasikan.

- Artefak dipromosikan dari tahap ke tahap. Salah satu jenis implementasi adalah artefak berpindah antara repositori biner yang berbeda. Jadi setelah pengujian integrasi, pengujian penerimaan, dan pengujian kinerja, artefak dipindahkan dari satu repositori ke repositori berikutnya. Repositori terakhir berisi rilis yang siap untuk produksi, jadi itu adalah repositori yang digunakan dalam tahap Deploy artefak ke produksi. Kondisi/quality gate tambahan bahkan tidak diperlukan karena repositori yang tepat sudah digunakan. Kelemahan besar dari solusi ini adalah bahwa multiple repositori diperlukan dan artefak dipindahkan beberapa kali.

- Opsi lainnya adalah mempromosikan artefak secara manual. Fitur ini ditawarkan oleh beberapa platform ALM. Masalah dengan opsi ini adalah bahwa itu adalah tindakan manual. Pengguna harus secara aktif mengubah status artefak dari pra-rilis menjadi rilis, misalnya. Tahap kontrol ganda sudah merupakan tindakan manual, jadi apa gunanya menambah lebih banyak tindakan manual? Jujur saja, promosi artefak manual adalah sesuatu yang harus dihindari.

- Alih-alih menarik artefak yang sama ke repositori biner yang berbeda, ada juga opsi untuk menyimpan semua artefak dalam repositori yang sama dan menyediakan metadata. Setelah tahap-tahap dan tugas-tugas tertentu selesai dan pengujian berhasil, metadata artefak diperbarui (menggunakan curl atau Maven, misalnya). Berdasarkan metadata-nya, status artefak menjadi jelas.

Gambar 7-4 menggambarkan artefak kerangka pengujian unit dengan metadata tambahan dalam format file XML. File metadata (unittest-1.0-metadata.xml) berisi informasi tambahan tentang status tugas pengujian.

![Gambar 7-4 Menyimpan metadata tambahan](assets/2023-07-07-14-50-03.png)

Sebelum artefak diunduh dari repositori biner dan diimplementasikan ke produksi, metadata-nya dibaca dan diinterpretasikan (menggunakan tugas quality gate dalam tahap Validate exit criteria). Karena pengujian penerimaan dalam metadata di sebelah kiri Gambar 7-5 menunjukkan bahwa pengujian penerimaan gagal, pipeline berakhir di sini, dan implementasi ke produksi tidak dilakukan. Pada contoh kedua, di sebelah kanan, metadata menunjukkan bahwa semua pengujian berhasil. Quality gate terlewati, dan implementasi dapat dimulai.

![Gambar 7-5 Menyimpan metadata dengan hasil pengujian](assets/2023-07-07-14-50-34.png)

Catatan: Ini menjadi masalah yang lebih kecil jika bagian CI dan CD diimplementasikan sebagai satu pipeline fisik. Pipeline tersebut sudah gagal sebelum tahap Validate exit criteria dicapai. Namun, ini menjadi risiko jika implementasinya terdiri dari pipeline-pipeline terpisah. Salah satu contoh di mana ini menjadi masalah adalah dalam kasus strategi pembangunan multiteam, di mana ada satu pipeline CD terpisah, memproses artefak dari beberapa pipeline CI.
