
## Outcomes Devops

This enables organizations to create a safe system of work, where small teams are able to quickly and independently develop, test, and deploy code and value quickly, safely, securely, and reliably to customers. This allows organizations to maximize developer productivity, enable organizational learning, create high employee satisfaction, and win in the marketplace.

## Awal cerita

Awal revolusi devops dimulai pada tahun 1980an dengan adanya Manufacturing Revolution. By adopting Lean principles and practices, manufacturing organizations dramatically improved plant productivity, customer lead times, product quality, and customer satisfaction, enabling them to win in the marketplace.

Sebelum revolusi, waktu pesanan rata-rata pabrik manufaktur adalah enam minggu, dengan kurang dari 70% pesanan yang dikirim tepat waktu. Namun, setelah diterapkannya praktik Lean secara luas, waktu pesanan rata-rata berkurang menjadi kurang dari tiga minggu, dan lebih dari 95% pesanan dikirim tepat waktu. 

Organisasi yang tidak menerapkan praktik Lean kehilangan pangsa pasar, dan banyak yang bangkrut. Hal ini menunjukkan betapa pentingnya penerapan praktik Lean dalam meningkatkan efisiensi dan daya saing industri manufaktur.

![(Source: Adrian Cockcroft, “Velocity and Volume (or Speed Wins),” presentation at FlowCon, San Francisco, CA, November 2013.)](assets/20230421100423.png)

Jadi problem apa yang coba diselesaikan oleh devops?

## THE PROBLEM: SOMETHING IN YOUR ORGANIZATION MUST NEED IMPROVEMENT

Organisasi yang tidak dapat melakukan perubahan production dengan cepat dan tidak dapat melakukan rilis ratusan atau ribuan perubahan ke production per hari akan menghadapi ketidakmampuan bersaing dalam pasar yang memerlukan waktu development yang cepat, tingkat layanan yang tinggi, dan eksperimen yang tak henti-hentinya, yang disebabkan oleh konflik utama dalam organisasi teknologi mereka.

### THE CORE, CHRONIC CONFLICT

Konflik utama dalam organisasi teknologi adalah antara tim dev (development) yang ingin membuat perubahan dengan cepat dan sering, dan tim operasi (operations) yang ingin menjaga stabilitas dan keandalan sistem. 

Konflik ini terjadi karena tim dev harus membuat perubahan untuk memenuhi kebutuhan bisnis yang terus berubah, sedangkan tim operasi harus memastikan bahwa perubahan tersebut tidak mengganggu operasi yang sedang berjalan dan tetap menjaga stabilitas sistem.

Untuk menyelesaikan konflik ini, organisasi harus menerapkan prinsip-prinsip DevOps yang memungkinkan kolaborasi antara kedua tim dan mengotomatiskan proses delivery software agar lebih cepat dan aman.

Dr. Eliyahu M. Goldratt, salah satu pendiri gerakan manajemen manufaktur, menyebut konfigurasi semacam ini sebagai "konflik utama yang kronis" - di mana pengukuran dan insentif organisasi di berbagai silo menghalangi pencapaian tujuan global organisasi. 

Konflik ini menciptakan spiral penurunan yang begitu kuat sehingga mencegah pencapaian hasil bisnis yang diinginkan, baik di dalam maupun di luar organisasi TI.

Konflik kronis ini seringkali menempatkan pekerja teknologi dalam situasi yang mengarah pada kualitas software dan layanan yang buruk, serta hasil pelanggan yang buruk, serta kebutuhan harian untuk solusi sementara, pemadam kebakaran, dan heroisme, baik di Manajemen Produk, Development, QA, Operasi TI, atau Keamanan Informasi.

### DOWNWARD SPIRAL IN THREE ACTS

Downward spiral adalah suatu kondisi atau situasi di mana suatu masalah atau konflik semakin memburuk seiring waktu, dan akhirnya mengakibatkan dampak negatif yang semakin parah dan sulit untuk diperbaiki. 

IT Operations yang memiliki tujuan untuk menjaga aplikasi dan infrastruktur agar tetap berjalan sehingga organisasi dapat memberikan nilai kepada pelanggan. Namun, banyak masalah yang dihadapi karena aplikasi dan infrastruktur yang kompleks, buruk dalam dokumentasi, dan sangat rapuh. 

Ini disebut "technical debt" yang sering diatasi dengan workaround, namun sulit untuk diperbaiki karena kekurangan waktu. Hal ini sangat mengkhawatirkan karena sistem yang paling rentan terhadap kegagalan adalah sistem yang paling penting dalam menghasilkan pendapatan atau proyek kritis. 

Ketika perubahan-perubahan terjadi pada sistem-sistem ini dan gagal, maka hal ini dapat membahayakan janji-janji organisasi yang paling penting, seperti ketersediaan bagi pelanggan, tujuan pendapatan, keamanan data pelanggan, pelaporan keuangan yang akurat, dan lain sebagainya.

Dalam downward spiral act kedua, seseorang harus menggantikan "broken promise" - bisa saja seorang manajer produk yang berjanji untuk menambahkan fitur yang lebih besar, atau seorang eksekutif bisnis yang menetapkan target pendapatan yang lebih tinggi.

Kemudian, tanpa memperhatikan kemampuan teknologi atau apa yang menyebabkan kegagalan komitmen sebelumnya, mereka menugaskan organisasi teknologi untuk memenuhi janji baru ini.

Sebagai hasilnya, Development diberi tugas dengan proyek mendesak lain yang tak terelakkan membutuhkan pemecahan tantangan teknis baru dan memotong sudut untuk memenuhi tanggal rilis yang dijanjikan, yang semakin menambah hutang teknis kita.

Act ketiga dimulai saat segala hal menjadi sedikit lebih sulit, bit by bit. Semua orang semakin sibuk, pekerjaan semakin memakan waktu, komunikasi menjadi lebih lambat, dan antrean pekerjaan semakin panjang. 

Semua orang semakin sibuk, pekerjaan semakin memakan waktu, komunikasi menjadi lebih lambat, dan antrean pekerjaan semakin panjang. Pekerjaan kita semakin terikat, tindakan kecil menyebabkan kegagalan yang lebih besar, dan kita menjadi lebih takut dan kurang toleran terhadap perubahan. 

Pekerjaan kita semakin terikat, tindakan kecil menyebabkan kegagalan yang lebih besar, dan kita menjadi lebih takut dan kurang toleran terhadap perubahan. 

Pekerjaan membutuhkan lebih banyak komunikasi, koordinasi, dan persetujuan; tim harus menunggu sedikit lebih lama untuk pekerjaan yang bergantung pada mereka selesai; dan kualitas pekerjaan semakin buruk. Roda mulai berputar lebih lambat dan membutuhkan lebih banyak usaha untuk tetap bergerak.

Dan hasilnya. Akan makin menjadi lebih lama. Seperti yang disebutkan oleh Steven J. Spear dalam bukunya, The High-Velocity Edge, dampaknya dapat sangat merusak dan berbahaya, sama seperti penyakit yang merusak tubuh atau kecelakaan yang menghancurkan. Oleh karena itu, penting bagi organisasi untuk memprioritaskan investasi dalam sistem IT yang kuat dan efektif untuk mencegah kerusakan pada kinerja organisasi secara keseluruhan.

## WHY DOES THIS DOWNWARD SPIRAL HAPPEN EVERYWHERE?

Intinya adalah bahwa setiap perusahaan sebenarnya adalah perusahaan teknologi dan hampir setiap keputusan bisnis memerlukan setidaknya satu perubahan IT. Proyek-proyek sangat penting dalam konteks bisnis dan keuangan karena mereka merupakan mekanisme utama untuk perubahan di dalam organisasi. Proyek biasanya didanai melalui pengeluaran modal, dan pemimpin bisnis jauh lebih bergantung pada pengelolaan IT yang efektif untuk mencapai tujuan mereka daripada yang mereka pikirkan. Prinsip DevOps diperlukan untuk mengatasi spiral kehancuran yang terjadi pada organisasi IT.

## Bagaimana memecahkan Spiral Down dengan Devops

DevOps dapat membantu memecahkan masalah dan konsekuensi negatif yang muncul akibat keadaan yang ada saat ini dalam dunia teknologi. Dengan menerapkan DevOps, tim developers dapat bekerja secara mandiri untuk mengimplementasikan fitur-fitur baru, menguji validitasnya di lingkungan yang mirip dengan production, dan melakukan deployment secara cepat, aman, dan terjamin. Hal ini memungkinkan deployment dilakukan pada saat yang rutin dan dapat diprediksi, bukan pada malam hari di akhir pekan, sehingga tidak mengganggu pengguna. 

Dalam penggunaan DevOps, feedback loop dilakukan secara cepat pada setiap tahap proses sehingga setiap orang dapat melihat efek dari tindakan yang mereka lakukan. Penggunaan automated testing juga memungkinkan developer untuk menemukan kesalahan dengan cepat sehingga memungkinkan perbaikan yang lebih cepat dan juga pembelajaran yang lebih baik. Dengan menggunakan DevOps, masalah dapat diperbaiki secepat mungkin, dan tujuan global menjadi lebih penting daripada tujuan lokal.

Dalam pengimplementasiannya, DevOps dapat membuat tim developers bekerja secara mandiri dan aman dalam memasang fitur-fitur yang telah mereka buat ke dalam lingkungan production. Hal ini dapat mempercepat pengiriman fitur baru dan perbaikan kesalahan pada software yang dibuat.

Dengan adanya tes otomatis yang cepat dan dilakukan secara terus menerus di lingkungan production, para developers dapat mendeteksi kesalahan mereka dengan cepat, memperbaikinya secara lebih cepat, dan belajar dari kesalahan tersebut. Pada akhirnya, keseluruhan organisasi akan terbebas dari hutang teknis, masalah akan diperbaiki segera setelah ditemukan, dan semua pihak di dalam organisasi akan merasa produktif.

Dalam pengaplikasiannya, DevOps juga memanfaatkan teknologi telemetry untuk memonitor kesalahan yang terjadi pada software. Teknologi ini memungkinkan deteksi dan perbaikan kesalahan dengan cepat sehingga semua sistem dan lingkungan production bekerja sesuai dengan rencana dan memberikan nilai tambah bagi pengguna. Selain itu, DevOps juga menggunakan teknik dark launch dalam merilis produk baru dan fitur-fitur penting. Hal ini memungkinkan tim developers untuk menguji dan mengevaluasi fitur secara berkala dan memastikan bahwa fitur tersebut sesuai dengan tujuan bisnis sebelum dirilis ke publik.

DevOps dapat membantu menghindari masalah yang sering terjadi pada saat peluncuran produk baru dan meningkatkan produktivitas tim. Dengan adopsi DevOps, tim dapat bekerja secara mandiri dengan proses pengujian otomatis yang cepat dan terus menerus. Pemantauan terus menerus terhadap lingkungan production dan kode memastikan bahwa masalah dapat terdeteksi dan diperbaiki dengan cepat sehingga peluncuran produk baru menjadi terkontrol, dapat diprediksi, reversibel, dan rendah stres. 

Dalam penggunaan DevOps, tim juga dapat terus belajar dan memperbaiki proses mereka, sehingga dapat mencegah masalah terulang di masa depan. Dalam penggunaan DevOps, setiap proses development produk diperlakukan seperti eksperimen dan menggunakan metode ilmiah untuk memastikan keberhasilannya.

DevOps membantu dalam menciptakan lingkungan kerja yang produktif, efektif, dan efisien. Dengan melakukan pengujian secara otomatis di lingkungan yang mirip dengan produksi, tim developers dapat menemukan kesalahan dengan cepat dan memperbaikinya secepat mungkin, sehingga tidak ada masalah teknis yang menumpuk. Teknologi seperti pengumpulan data produksi juga memastikan bahwa setiap masalah dideteksi dan diperbaiki dengan cepat, sehingga dapat meminimalkan kerugian yang disebabkan oleh masalah tersebut.

Selain itu, DevOps juga membantu menciptakan lingkungan kerja yang kooperatif dan berbasis kepercayaan. Tim yang bertanggung jawab untuk mencapai tujuan jangka panjang akan terus dipertahankan dan bekerja sama, dan mereka terus mempelajari dan memperbaiki diri. Kultur risiko yang diterapkan juga memotivasi setiap orang untuk berbicara terbuka tentang masalah dan memberikan solusi untuk meningkatkan kinerja tim secara keseluruhan.

semua orang di organisasi memiliki tanggung jawab penuh terhadap kualitas pekerjaan mereka. Mereka membangun pengujian otomatis ke dalam pekerjaan sehari-hari dan menggunakan ulasan rekan untuk memastikan bahwa masalah ditangani sebelum mereka dapat memengaruhi pelanggan. Proses ini mengurangi risiko dan memungkinkan pengiriman nilai dengan cepat, dapat diandalkan, dan aman, bahkan membuktikan kepada auditor skeptis bahwa organisasi memiliki sistem pengendalian internal yang efektif.

Ketika terjadi kesalahan, organisasi melakukan post-mortem yang bebas dari salahkan bukan untuk menghukum siapa pun, tetapi untuk memahami penyebab kecelakaan dan bagaimana mencegahnya di masa depan. Ritual ini memperkuat budaya belajar organisasi. Organisasi juga mengadakan konferensi teknologi internal untuk meningkatkan keterampilan dan memastikan bahwa semua orang selalu mengajar dan belajar.

Karena organisasi peduli pada kualitas, mereka bahkan menyuntikkan kesalahan ke dalam lingkungan produksi mereka sehingga mereka dapat belajar bagaimana sistem mereka gagal secara terencana. Organisasi melakukan latihan terencana untuk melatih kegagalan dalam skala besar, secara acak mematikan proses dan server komputasi di produksi, dan menyuntikkan keterlambatan jaringan dan tindakan jahat lainnya untuk memastikan organisasi semakin tangguh. Dengan melakukan ini, organisasi memungkinkan keandalan yang lebih baik, serta pembelajaran dan perbaikan organisasi.

Dalam dunia ini, setiap orang memiliki kepemilikan dalam pekerjaannya, terlepas dari perannya dalam organisasi teknologi. Mereka memiliki keyakinan bahwa pekerjaan mereka penting dan berkontribusi secara berarti terhadap tujuan organisasi, terbukti dengan lingkungan kerja yang rendah tekanan dan keberhasilan organisasi di pasar. Bukti mereka adalah bahwa organisasi memang menang di pasar.

### Beberapa action item

1. Menerapkan pengukuran (telemetry) secara luas dalam kode dan lingkungan produksi untuk mendeteksi masalah secepat mungkin dan memastikan semuanya berjalan sesuai yang diinginkan, sehingga pelanggan memperoleh nilai dari software yang diciptakan.

2. Menggunakan teknik dark launch untuk menguji dan mengembangkan fitur baru sebelum diluncurkan, sehingga peluncuran produk dan fitur dapat menjadi rutin dan lebih terkontrol.

3. Menggunakan fitur toggle atau pengaturan konfigurasi untuk membuat fitur baru terlihat oleh segmen pelanggan yang semakin besar secara otomatis, sehingga perilisan produk menjadi terkendali, terprediksi, dapat dikembalikan, dan rendah stres.

4. Menciptakan tim yang bertanggung jawab untuk mencapai tujuan jangka panjang, serta membentuk budaya eksperimen dan pembelajaran.

5. Membangun tes otomatis dalam pekerjaan sehari-hari dan melakukan ulasan rekan untuk memastikan kualitas kerja, serta melaksanakan post-mortem tanpa menyalahkan untuk meningkatkan pemahaman atas penyebab kegagalan dan cara mencegahnya.

6. Memiliki budaya kolaborasi dan kepercayaan yang tinggi, serta memotivasi orang untuk berbicara tentang masalah dan mengambil risiko dalam menyelesaikan masalah.

7. Menerapkan praktik resiliensi dengan memasukkan kesalahan yang direncanakan ke dalam lingkungan produksi untuk memahami cara sistem gagal secara terencana, melakukan latihan kegagalan berskala besar, serta memasukkan latensi jaringan dan tindakan lain untuk meningkatkan ketahanan organisasi dan pembelajaran.

Inti dari semua paragraf adalah untuk menciptakan lingkungan kerja yang produktif, kolaboratif, dan terorganisir dengan baik, di mana setiap orang merasa memiliki tanggung jawab atas kualitas pekerjaannya dan dapat belajar dari kesalahan. Hal ini dapat dilakukan dengan menerapkan praktik-praktik yang efektif dalam development produk dan manajemen risiko secara keseluruhan.

## Bisnis value dari devops

DevOps memberikan nilai bisnis yang signifikan. Dalam kurun waktu 2013 hingga 2016, sebagai bagian dari State Of DevOps Report dari Puppet Labs, yang ditulis oleh Jez Humble dan Gene Kim, kami mengumpulkan data dari lebih dari dua puluh lima ribu profesional teknologi, dengan tujuan untuk lebih memahami kesehatan dan kebiasaan organisasi pada semua tahap adopsi DevOps.

Hasil dari pengumpulan data mengejutkan, dimana terungkap bahwa organisasi yang melakukan praktik DevOps dengan kinerja tinggi jauh lebih unggul dari pesaing yang tidak melakukan praktik DevOps dalam beberapa area berikut:

- Metrik throughput
- Penyebaran kode dan perubahan (tiga puluh kali lebih sering)
- Waktu pengiriman kode dan perubahan (dua ratus kali lebih cepat)
- Metrik keandalan
- Penyebaran produksi (tingkat kesuksesan perubahan enam puluh kali lebih tinggi)
- Waktu rata-rata untuk memulihkan layanan (168 kali lebih cepat)
- Metrik kinerja organisasi
- Produktivitas, pangsa pasar, dan tujuan keuntungan (dua kali lebih mungkin untuk melampaui)
- Pertumbuhan kapitalisasi pasar (lebih tinggi 50% dalam tiga tahun)

Hasil penelitian dari Puppet Labs' State of DevOps Report dari tahun 2013 hingga 2016. Penelitian ini dilakukan untuk memahami kesehatan dan kebiasaan organisasi pada semua tahap adopsi DevOps. Hasil penelitian menunjukkan bahwa organisasi dengan kinerja tinggi yang menggunakan praktik DevOps jauh lebih unggul dibandingkan dengan pesaing mereka yang tidak memiliki kinerja tinggi dalam beberapa area, seperti throughput metrics, reliability metrics, dan organizational performance metrics.

Organisasi dengan kinerja tinggi lebih lincah dan andal, memberikan bukti empiris bahwa DevOps memungkinkan kita untuk memecahkan konflik inti yang kronis. Mereka mampu melakukan deployment code 30 kali lebih sering, dan waktu yang dibutuhkan untuk berhasil menjalankan produksi adalah 200 kali lebih cepat. Organisasi kinerja tinggi juga lebih mungkin untuk melampaui tujuan keuntungan, pangsa pasar, dan produktivitas dua kali lipat. 

Selain itu, organisasi kinerja tinggi memiliki pertumbuhan kapitalisasi pasar 50% lebih tinggi selama tiga tahun dan tingkat kepuasan kerja yang lebih tinggi serta tingkat burnout yang lebih rendah. Mereka juga 2,2 kali lebih mungkin merekomendasikan organisasi mereka sebagai tempat kerja yang bagus. Selain itu, organisasi kinerja tinggi juga memiliki hasil keamanan informasi yang lebih baik, dengan mengintegrasikan tujuan keamanan ke dalam semua tahap proses development dan operasi. Mereka menghabiskan 50% lebih sedikit waktu untuk memperbaiki masalah keamanan.

Inti dari section "THE BUSINESS VALUE OF DEVOPS" adalah bahwa DevOps dapat memberikan nilai bisnis yang signifikan melalui peningkatan produktivitas, keandalan, dan kecepatan pengiriman, serta pencapaian tujuan keuntungan, pangsa pasar, dan produktivitas yang lebih tinggi. Hasil survei menunjukkan bahwa organisasi yang mengadopsi praktik DevOps secara lebih terampil cenderung mengungguli pesaing mereka dan mencapai keberhasilan yang lebih besar. Dalam hal ini, DevOps juga membantu memecahkan konflik antara agilitas dan keandalan dalam development dan operasi teknologi.

## DEVOPS HELPS SCALE DEVELOPER PRODUCTIVITY

DevOps membantu meningkatkan produktivitas developers dalam skala besar. Saat jumlah developers meningkat, produktivitas individu developers seringkali menurun karena masalah komunikasi, integrasi, dan pengujian yang berlebihan. Namun, DevOps menunjukkan bahwa dengan arsitektur yang tepat, praktik teknis yang tepat, dan norma budaya yang tepat, tim developers kecil dapat dengan cepat, aman, dan independen mengembangkan, mengintegrasikan, menguji, dan mendeploy perubahan ke dalam produksi.

DevOps dapat membantu organisasi besar dengan ribuan developers menjadi produktif seperti startup, dan tidak seperti metode development tradisional yang menambahkan developers saat proyek terlambat yang justru menurunkan produktivitas individu dan keseluruhan.

Dalam laporan State of DevOps 2015, tidak hanya mengukur "jumlah deploy per hari", tetapi juga "jumlah deploy per hari per developers". Laporan ini berasumsi bahwa organisasi high performer mampu meningkatkan jumlah deployment dengan tim yang semakin besar.

![Deployments/day vs. number of developers (Source: Puppet Labs, 2015 State Of DevOps Report.)](assets/20230421104421.png)

Pada dasarnya, DevOps membantu meningkatkan produktivitas developers. Ketika jumlah developers meningkat, produktivitas individu seringkali menurun karena adanya overhead komunikasi, integrasi, dan pengujian. DevOps menunjukkan bahwa ketika kita memiliki arsitektur yang tepat, praktik teknis yang tepat, dan norma budaya yang tepat, tim kecil developers dapat dengan cepat, aman, dan mandiri mengembangkan, mengintegrasikan, menguji, dan melakukan perubahan ke produksi. 

Sebuah laporan State of DevOps pada tahun 2015 meneliti "deploys per day" dan juga "deploys per day per developer." Mereka menghipotesiskan bahwa **high performers akan dapat meningkatkan jumlah deployment saat jumlah tim developers bertambah**. Dan kenyataannya memang seperti itu. Pada low performers, deploys per day per developer menurun seiring dengan bertambahnya ukuran tim, tetap konstan untuk medium performers, dan meningkat secara linear untuk high performers. Artinya, organisasi yang mengadopsi DevOps dapat meningkatkan jumlah deploys per day secara linear saat mereka meningkatkan jumlah developers, sama seperti yang dilakukan oleh Google, Amazon, dan Netflix.

## Bagian dari buku the devops handbook

Dalam Bagian I, kami menyajikan sejarah singkat tentang DevOps dan memperkenalkan teori dasarnya serta tema-tema kunci dari pengetahuan yang relevan yang mencakup beberapa dekade. Kami kemudian menyajikan prinsip-prinsip tingkat tinggi dari Tiga Cara: Aliran, Umpan Balik, dan Pembelajaran dan Eksperimen Terus Menerus.

Bagian II menjelaskan bagaimana dan di mana memulai, dan memperkenalkan konsep-konsep seperti aliran nilai, prinsip dan pola desain organisasi, pola adopsi organisasi, dan studi kasus.

Bagian III menjelaskan bagaimana mempercepat Aliran dengan membangun dasar dari pipeline deployment kita: memungkinkan pengujian otomatis yang cepat dan efektif, integrasi terus menerus, pengiriman terus menerus, dan perancangan untuk rilis yang rendah risiko.

Bagian IV membahas bagaimana mempercepat dan memperkuat Umpan Balik dengan menciptakan telemetri produksi yang efektif untuk melihat dan menyelesaikan masalah, lebih baik memperkirakan masalah dan mencapai tujuan, memungkinkan umpan balik sehingga Dev dan Ops dapat dengan aman melakukan perubahan, mengintegrasikan pengujian A/B ke dalam pekerjaan sehari-hari kita, dan menciptakan proses tinjauan dan koordinasi untuk meningkatkan kualitas kerja kita.

Bagian V menjelaskan bagaimana mempercepat Pembelajaran Terus Menerus dengan membentuk budaya yang adil, mengubah penemuan lokal menjadi perbaikan global, dan menentukan waktu yang tepat untuk menciptakan pembelajaran dan perbaikan organisasi.

Terakhir, di Bagian VI, kami menjelaskan bagaimana mengintegrasikan keamanan dan kepatuhan dengan tepat ke dalam pekerjaan sehari-hari kita, dengan mengintegrasikan kontrol keamanan pencegahan ke dalam repositori dan layanan kode sumber bersama, mengintegrasikan keamanan ke dalam pipeline deployment kita, meningkatkan telemetri untuk lebih memungkinkan deteksi dan pemulihan, melindungi pipeline deployment, dan mencapai tujuan manajemen perubahan.

Dengan mengkodekan praktik-praktik ini, kami berharap dapat mempercepat adopsi praktik DevOps, meningkatkan keberhasilan inisiatif DevOps, dan menurunkan energi aktivasi yang diperlukan untuk transformasi DevOps.
