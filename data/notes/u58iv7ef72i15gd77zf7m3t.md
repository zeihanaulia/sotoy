
## Apa itu Monitoring?

Saat di sekolah menengah, salah satu guru Brian mengatakan kepadanya bahwa jika Anda menanyakan 10 ahli ekonomi apa arti dari ekonomi, Anda akan mendapatkan 11 jawaban yang berbeda. Monitoring juga memiliki kekurangan konsensus yang sama tentang apa artinya secara tepat. Ketika Brian menceritakan kepada orang lain tentang pekerjaannya, orang-orang mengira bahwa pekerjaannya meliputi segalanya mulai dari menjaga suhu di pabrik, hingga memantau karyawan di mana dia yang menemukan siapa yang mengakses Facebook selama jam kerja, bahkan mendeteksi intruder di jaringan.

Prometheus tidak dibangun untuk melakukan hal-hal seperti itu. Prometheus dibangun untuk membantu pengembang perangkat lunak dan administrator dalam mengoperasikan sistem komputer produksi, seperti aplikasi, alat, database, dan jaringan yang mendukung situs web populer.

Jadi apa itu monitoring dalam konteks tersebut? Mari kita mempersempit jenis monitoring operasional sistem komputer menjadi empat hal:

1. Alerting

    Mengetahui kapan sesuatu sedang berjalan salah biasanya adalah hal yang paling penting yang Anda inginkan dari monitoring. Anda ingin sistem monitoring memanggil manusia untuk melihat-lihat.

2. Debugging

    Sekarang setelah Anda memanggil manusia, mereka perlu menyelidiki untuk menentukan akar penyebab dan akhirnya memecahkan masalah apa pun.

3. Trending

    Alerting dan debugging biasanya terjadi dalam rentang waktu dari beberapa menit hingga beberapa jam. Meskipun kurang mendesak, kemampuan untuk melihat bagaimana sistem Anda digunakan dan berubah dari waktu ke waktu juga berguna. Trending dapat memberikan masukan ke dalam keputusan desain dan proses seperti perencanaan kapasitas.

4. Plumbing

    Ketika yang Anda miliki hanyalah palu, semua mulai terlihat seperti paku. Pada akhirnya, semua sistem monitoring adalah pipa pemrosesan data. Terkadang lebih nyaman untuk memanfaatkan sebagian dari sistem monitoring Anda untuk tujuan lain, daripada membangun solusi khusus. Ini bukan benar-benar monitoring, tetapi umumnya diterapkan dalam praktik sehingga kami suka menyertakannya.

Tergantung pada siapa yang Anda ajak bicara dan latar belakang mereka, mereka mungkin hanya mempertimbangkan beberapa hal ini sebagai monitoring. Hal ini menyebabkan banyak diskusi tentang monitoring yang berputar-putar, meninggalkan semua orang frustrasi. Untuk membantu Anda memahami perspektif orang lain, kami akan melihat sejarah kecil tentang monitoring.

## Sejarah Monitoring secara singkat dan tidak lengkap

Monitoring telah mengalami pergeseran menuju alat seperti Prometheus dalam beberapa tahun terakhir. Selama waktu yang lama, solusi dominan adalah kombinasi Nagios dan Graphite atau varian mereka.

Ketika kita menyebut Nagios, kita termasuk dalam keluarga perangkat lunak yang sama, seperti Icinga, Zmon, dan Sensu. Mereka bekerja terutama dengan secara teratur menjalankan skrip yang disebut cek. Jika cek gagal dengan mengembalikan kode keluar nonzero, sebuah alert dibuat. Nagios awalnya dimulai oleh Ethan Galstad pada tahun 1996 sebagai aplikasi MS-DOS yang digunakan untuk melakukan ping. Itu pertama kali dirilis sebagai NetSaint pada tahun 1999, dan diubah namanya menjadi Nagios pada tahun 2002.

Untuk membahas sejarah Graphite, kita perlu kembali ke tahun 1994. Tobias Oetiker membuat skrip Perl yang menjadi Multi Router Traffic Grapher, atau MRTG 1.0, pada tahun 1995. Seperti namanya, itu digunakan terutama untuk monitoring jaringan melalui Simple Network Management Protocol (SNMP). Ini juga dapat memperoleh metrik dengan menjalankan skrip. Tahun 1997 membawa perubahan besar dengan memindahkan beberapa kode ke C, dan penciptaan Round Robin Database (RRD), yang digunakan untuk menyimpan data metrik. Ini membawa perbaikan kinerja yang signifikan, dan RRD adalah dasar untuk alat lain, termasuk Smokeping dan Graphite.

Dimulai pada tahun 2006, Graphite menggunakan Whisper untuk penyimpanan metrik, yang memiliki desain yang mirip dengan RRD. Graphite tidak mengumpulkan data itu sendiri, melainkan dikirim oleh alat pengumpulan seperti collectd dan StatsD, yang dibuat pada tahun 2005 dan 2010, masing-masing.

Pengambilan kunci di sini adalah bahwa grafik dan pengingatan pada suatu waktu benar-benar menjadi perhatian terpisah yang dilakukan oleh alat yang berbeda. Anda bisa menulis skrip cek untuk mengevaluasi kueri di Graphite dan menghasilkan peringatan berdasarkan itu, tetapi kebanyakan cek cenderung pada keadaan yang tidak terduga seperti proses tidak berjalan.

Salah satu peninggalan dari era ini adalah pendekatan yang relatif manual dalam mengelola layanan komputer. Layanan diterapkan pada mesin-mesin individual dan dijaga dengan penuh kasih sayang oleh administrator sistem. Peringatan yang mungkin menunjukkan adanya masalah segera ditindaklanjuti oleh insinyur yang setia. Namun, dengan munculnya teknologi cloud dan cloud native seperti EC2, Docker, dan Kubernetes, memperlakukan mesin-mesin dan layanan-layanan individual seperti hewan peliharaan dengan memberikan perhatian individual tidak memungkinkan untuk diterapkan secara berskala. Sebaliknya, mesin-mesin dan layanan-layanan tersebut cenderung dilihat sebagai hewan ternak dan dikelola serta dipantau sebagai sebuah kelompok. Sama halnya dengan cara industri yang bergerak dari pengelolaan manual, ke alat-alat seperti Chef dan Ansible, hingga saat ini mulai menggunakan teknologi seperti Kubernetes, monitoring juga perlu melakukan transisi yang sama. Ini berarti bergerak dari memeriksa proses individual pada mesin-mesin individual ke monitoring berdasarkan kesehatan layanan secara keseluruhan.

Beralih ke waktu yang lebih baru, OpenTelemetry lahir dari dua proyek open source lainnya, OpenCensus dan OpenTracing. OTel5 adalah spesifikasi dan kumpulan komponen yang bertujuan untuk menawarkan telemetri yang terintegrasi untuk proyek-proyek. Komponen metriknya kompatibel dengan Prometheus dengan tambahan OpenTelemetry collector, yang bertanggung jawab untuk mengumpulkan dan memberikan metrik ke server Prometheus Anda.

Anda mungkin telah memperhatikan bahwa kami tidak menyebutkan logging, tracing, dan profiling. Secara historis, log telah digunakan sebagai sesuatu yang Anda gunakan dengan menggunakan tail, grep, dan awk secara manual. Anda mungkin memiliki alat analisis seperti AWStats untuk menghasilkan laporan setiap jam atau harian. Dalam beberapa tahun terakhir, log juga telah digunakan sebagai bagian penting dari monitoring, seperti dengan tumpukan Elasticsearch, Logstash, dan Kibana (ELK) dan OpenSearch. Tracing dan profiling umumnya dilakukan dengan stack perangkat lunak mereka sendiri: Zipkin dan Jaeger dibuat untuk tracing, sementara Parca dan Pyroscope menangani profiling kontinu.

Sekarang setelah kita telah sedikit melihat grafik dan peringatan, mari kita lihat bagaimana metrik dan log masuk ke dalam lanskap tersebut. Apakah ada kategori monitoring selain dua itu?

### Narrative

Halo teman-teman, hari ini saya ingin bercerita tentang topik yang menarik: monitoring sistem komputer. Tapi jangan khawatir, meskipun terdengar teknis dan serius, saya akan mencoba menghadirkannya dengan cara yang menyenangkan dan santai.

Jadi, kalian pasti tahu kan bahwa zaman dulu, para sistem administrator merawat layanan komputer satu per satu dengan penuh kasih sayang? Mereka seperti merawat peliharaan.  Jika ada peringatan atau tanda-tanda masalah, maka para sistem administrator akan langsung menanganinya dengan sepenuh hati. Pada waktu itu, alat monitor yang biasa digunakan masih sederhana, seperti tail, grep, dan awk, serta analisis tool seperti AWStats.

Namun, seiring berkembangnya teknologi cloud dan cloud native seperti EC2, Docker, dan Kubernetes, cara ini sudah tidak scalable lagi. Kini, layanan dan mesin dianggap seperti ternak yang diurus dan dimonitor secara kelompok.

Dan kamu tahu tidak, sekarang sudah ada teknologi yang memungkinkan kita untuk memonitor layanan secara otomatis? Namanya adalah OpenTelemetry, yang merupakan gabungan dari dua proyek open source lainnya, yaitu OpenCensus dan OpenTracing. OpenTelemetry memberikan kemudahan bagi pengembang untuk memasukkan metrik dalam proyek mereka.

Nah, mungkin kamu bertanya-tanya, bagaimana dengan logging, tracing, dan profiling? Nah, dulu memang sering dilakukan dengan tools seperti tail, grep, dan awk secara manual. Namun sekarang, kita bisa menggunakan berbagai teknologi seperti ELK stack atau Zipkin dan Jaeger untuk melakukan tracing dan profiling.

Intinya, dengan monitoring sistem komputer yang tepat, kita bisa memastikan bahwa layanan kita selalu berjalan dengan baik dan memberikan pengalaman terbaik bagi pengguna. Jadi, teman-teman, itulah sedikit cerita tentang monitoring sistem komputer. Terima kasih sudah mendengarkan!

## Kategori Monitoring

Pada akhirnya, sebagian besar monitoring berhubungan dengan hal yang sama: peristiwa. Peristiwa dapat menjadi hampir apa saja, termasuk:

- Receiving an HTTP request
- Sending an HTTP 400 response
- Entering a function
- Reaching the else of an if statement
- Leaving a function
- A user logging in
- Writing data to disk
- Reading data from the network
- Requesting more memory from the kernel

Semua peristiwa juga memiliki konteks. Permintaan HTTP akan memiliki alamat IP dari mana permintaan tersebut berasal dan kemana permintaan tersebut ditujukan, URL yang diminta, kuki yang disetel, dan pengguna yang melakukan permintaan. Tanggapan HTTP akan memiliki berapa lama tanggapan itu dibutuhkan, kode status HTTP, dan panjang dari isi tanggapan. Peristiwa yang melibatkan fungsi memiliki tumpukan panggilan fungsi di atasnya, dan apa pun yang memicu bagian dari tumpukan ini, seperti permintaan HTTP.

Memiliki semua konteks untuk semua peristiwa akan sangat membantu dalam debugging dan memahami kinerja sistem Anda dari segi teknis dan bisnis, namun jumlah data tersebut tidak praktis untuk diproses dan disimpan. Oleh karena itu, kami melihat sekitar empat cara untuk mengurangi volume data tersebut menjadi sesuatu yang dapat diolah, yaitu profiling, tracing, logging, dan metrik.

### Profiling

Profiling mengambil pendekatan bahwa Anda tidak dapat memiliki semua konteks untuk semua peristiwa sepanjang waktu, tetapi Anda dapat memiliki sebagian dari konteks untuk periode waktu yang terbatas.

Tcpdump adalah contoh alat profil yang memungkinkan Anda merekam lalu lintas jaringan berdasarkan filter yang ditentukan. Ini adalah alat debugging penting, tetapi Anda tidak dapat benar-benar mengaktifkannya sepanjang waktu karena akan kehabisan ruang disk.

Build debug dari biner yang melacak data profil juga merupakan contoh lain. Mereka memberikan banyak informasi yang berguna, tetapi dampak kinerja pengumpulan semua informasi tersebut, seperti waktu panggilan setiap fungsi, berarti bahwa umumnya tidak praktis untuk menjalankannya secara berkelanjutan di produksi.

Di kernel Linux, Enhanced Berkeley Packet Filters (eBPF) memungkinkan profil yang detail dari peristiwa kernel mulai dari operasi sistem file hingga anomali jaringan. Ini memberikan akses ke tingkat wawasan yang sebelumnya tidak umum tersedia. eBPF dilengkapi dengan keuntungan lain, seperti portabilitas dan keamanan. Kami akan merekomendasikan membaca tulisan [Brendan Gregg tentang subjek ini](https://www.brendangregg.com/ebpf.html).

Profil sebagian besar untuk debugging taktis. Jika digunakan dalam jangka waktu yang lebih lama, maka volume data harus dikurangi agar sesuai dengan salah satu kategori monitoring lainnya, atau Anda perlu beralih ke continuous profiling, yang memungkinkan pengumpulan selama periode waktu yang lebih lama.

Yang baru dengan continuous profiling adalah untuk memangkas volume data dan menjaga overhead yang relatif rendah, maka frekuensi profil dikurangi. Salah satu alat continuous profiling yang muncul, yaitu Parca Agent yang berbasis eBPF, menggunakan frekuensi 19Hz. Sebagai konsekuensinya, ia mencoba mendapatkan data yang signifikan secara statistik selama beberapa menit daripada detik, sambil tetap menyediakan data yang diperlukan untuk memahami bagaimana waktu CPU dihabiskan dalam infrastruktur, dan membantu meningkatkan efisiensi aplikasi di mana dibutuhkan.

### Tracing

Tracing biasanya tidak melihat semua kejadian, melainkan mengambil beberapa proporsi kejadian seperti satu dari seratus yang melewati beberapa fungsi yang menarik. Tracing akan mencatat fungsi-fungsi pada stack trace pada titik-titik yang menarik, dan seringkali juga berapa lama setiap fungsi tersebut diperlukan untuk dieksekusi. Dari sini, Anda bisa mendapatkan gambaran di mana program Anda menghabiskan waktu dan jalur kode mana yang paling memberikan kontribusi terhadap laten.

Alih-alih melakukan snapshot dari stack trace pada titik-titik yang menarik, beberapa sistem tracing melacak dan merekam waktu setiap panggilan fungsi di bawah fungsi yang menarik. Sebagai contoh, satu dari seratus permintaan HTTP pengguna dapat diambil sampelnya, dan untuk permintaan-permintaan tersebut, Anda dapat melihat berapa banyak waktu yang dihabiskan berbicara dengan backend seperti database dan cache. Ini memungkinkan Anda untuk melihat bagaimana waktu yang dihabiskan berbeda berdasarkan faktor seperti cache hits versus cache misses.

Tracing terdistribusi melangkah lebih jauh. Ini membuat tracing bekerja melintasi proses dengan melekatkan ID unik pada permintaan yang dilewatkan dari satu proses ke proses lainnya dalam pemanggilan prosedur jarak jauh (RPC), selain dari apakah permintaan ini adalah yang harus dilacak. Tracing dari proses dan mesin yang berbeda dapat dijahit kembali bersama berdasarkan ID permintaan. Ini adalah alat penting untuk debugging arsitektur mikro layanan yang didistribusikan. Teknologi di ruang ini termasuk OpenZipkin dan Jaeger.

Untuk tracing, pengambilan sampel adalah yang menjaga volume data dan dampak kinerja instrumentasi dalam batas wajar.

### Logging

Logging (pencatatan) melihat sejumlah terbatas peristiwa dan mencatat sebagian dari konteks untuk setiap peristiwa tersebut. Misalnya, mungkin melihat semua permintaan HTTP yang masuk atau semua panggilan database yang keluar. Untuk menghindari menggunakan terlalu banyak sumber daya, sebagai aturan praktis, Anda dibatasi sekitar seratus bidang per entri log. Di atas itu, lebar pita dan ruang penyimpanan cenderung menjadi perhatian.

Misalnya, untuk server yang menangani 1.000 permintaan per detik, entri log dengan 100 bidang masing-masing mengambil 10 byte akan menjadi 1 megabita per detik. Itu merupakan proporsi yang cukup besar dari kartu jaringan 100 Mbit, dan 84 GB penyimpanan per hari hanya untuk pencatatan.

Manfaat besar dari pencatatan adalah (biasanya) tidak ada sampling peristiwa, sehingga meskipun ada batasan pada jumlah bidang, adalah praktis untuk menentukan bagaimana permintaan yang lambat mempengaruhi satu pengguna tertentu yang berbicara dengan satu titik akhir API tertentu.

Sama seperti pemantauan yang memiliki makna yang berbeda bagi orang yang berbeda, logging juga memiliki makna yang berbeda tergantung pada siapa yang ditanya, yang dapat menyebabkan kebingungan. Jenis logging yang berbeda memiliki penggunaan, durabilitas, dan persyaratan retensi yang berbeda. Seperti yang kita lihat, ada empat kategori umum dan sedikit tumpang tindih:

1. Log transaksi

    Ini adalah catatan bisnis penting yang harus Anda jaga dengan aman dengan biaya apa pun, mungkin selamanya. Segala hal yang berkaitan dengan uang atau digunakan untuk fitur pengguna yang kritis cenderung berada dalam kategori ini.

2. Log permintaan

    Jika Anda melacak setiap permintaan HTTP, atau setiap panggilan basis data, itu adalah log permintaan. Mereka mungkin diproses untuk mengimplementasikan fitur yang dihadapi pengguna, atau hanya untuk optimasi internal. Anda umumnya tidak ingin kehilangan mereka, tetapi tidak apa-apa jika beberapa dari mereka hilang.

3. Log aplikasi

    Tidak semua log adalah tentang permintaan; beberapa tentang proses itu sendiri. Pesan startup, tugas pemeliharaan latar belakang, dan baris log level proses lainnya yang khas. Log ini sering dibaca langsung oleh manusia, sehingga Anda harus mencoba untuk menghindari memiliki lebih dari beberapa per menit dalam operasi normal.

4. Log debug

    Log debug cenderung sangat rinci dan mahal untuk dibuat dan disimpan. Mereka sering hanya digunakan dalam situasi debugging yang sangat sempit, dan sedang trending ke arah profiling karena volume datanya. Persyaratan keandalan dan retensi cenderung rendah, dan log debug bahkan mungkin tidak meninggalkan mesin tempat mereka dibuat.

Memperlakukan jenis log yang berbeda semua dengan cara yang sama dapat menempatkan Anda pada dunia yang paling buruk, di mana Anda memiliki volume data dari log debug yang digabungkan dengan persyaratan keandalan yang sangat tinggi dari log transaksi. Oleh karena itu, saat sistem Anda berkembang, Anda harus berencana untuk memisahkan log debug sehingga mereka dapat ditangani secara terpisah.

Contoh sistem logging termasuk tumpukan ELK, OpenSearch, Grafana Loki, dan Graylog.

### Metrics

Metrics pada umumnya mengabaikan konteks dan lebih fokus pada agregasi dari berbagai jenis event dalam periode waktu tertentu. Untuk menjaga penggunaan sumber daya agar wajar, jumlah angka yang dilacak perlu dibatasi: 10.000 per proses merupakan batas atas yang wajar untuk diingat.

Contoh metrics yang dapat Anda miliki adalah jumlah permintaan HTTP yang diterima, berapa banyak waktu yang dihabiskan untuk menangani permintaan, dan berapa banyak permintaan yang sedang berlangsung. Dengan mengabaikan informasi tentang konteks, volume data dan pemrosesan yang dibutuhkan menjadi masuk akal.

Namun demikian, konteks tidak selalu diabaikan. Untuk permintaan HTTP, Anda dapat memutuskan untuk memiliki sebuah metrik untuk setiap jalur URL. Namun panduan 10.000 metrik harus diingat, karena setiap jalur yang berbeda sekarang dihitung sebagai metrik. Menggunakan konteks seperti alamat email pengguna akan tidak bijaksana, karena memiliki kardinalitas yang tidak terbatas.

Anda dapat menggunakan metrics untuk melacak latensi dan volume data yang ditangani oleh setiap subsistem dalam aplikasi Anda, sehingga lebih mudah untuk menentukan penyebab lambatnya sistem. Log tidak dapat mencatat banyak bidang, tetapi setelah Anda mengetahui subsistem mana yang menjadi penyebabnya, log dapat membantu Anda mencari tahu permintaan pengguna mana yang tepat yang terlibat.

Inilah tempat di mana trade-off antara log dan metrics menjadi paling jelas. Metrics memungkinkan Anda mengumpulkan informasi tentang event dari seluruh proses Anda, tetapi biasanya hanya dengan satu atau dua bidang konteks yang memiliki kardinalitas yang terbatas. Log memungkinkan Anda mengumpulkan informasi tentang semua jenis event, tetapi hanya dapat melacak seratus bidang konteks dengan kardinalitas yang tidak terbatas. Kardinalitas dan batasan yang diberikannya pada metrics penting untuk dipahami, dan kami akan menjelajahkannya dalam bab-bab selanjutnya.

Sebagai sistem pemantauan berbasis metrics, Prometheus dirancang untuk melacak kesehatan, perilaku, dan kinerja sistem secara keseluruhan daripada event individu. Dengan kata lain, Prometheus memperhatikan bahwa ada 15 permintaan dalam satu menit terakhir yang membutuhkan waktu 4 detik untuk ditangani, menghasilkan 40 panggilan basis data, 17 hit cache, dan 2 pembelian oleh pelanggan. Biaya dan jalur kode dari panggilan individu akan menjadi perhatian profil atau log.

Sekarang bahwa Anda memahami di mana Prometheus cocok dalam ruang pemantauan secara keseluruhan, mari kita lihat berbagai komponen Prometheus.

## Arsitektur Prometheus

Gambar 1-1 menunjukkan arsitektur keseluruhan dari Prometheus. Prometheus menemukan target yang akan diambil dari layanan yang ditemukan. Ini dapat berupa aplikasi yang sudah diinstrumen atau aplikasi pihak ketiga yang dapat diambil melalui pengekspor. Data yang diambil akan disimpan dan dapat digunakan pada dashboard dengan menggunakan PromQL atau dikirimkan sebagai notifikasi peringatan ke Alertmanager, yang akan mengonversi notifikasi tersebut menjadi halaman, email, dan notifikasi lainnya.

![Arsitektur Prometheus](assets/2023-05-10-16-15-25.png)

### Client Library

Biasanya, metrik tidak langsung muncul dari aplikasi, seseorang harus menambahkan instrumen yang menghasilkan metrik tersebut. Di sinilah perpustakaan klien berperan. Dengan hanya dua atau tiga baris kode, kamu dapat menentukan metrik dan menambahkan instrumen yang diinginkan langsung dalam kode yang bisa kamu kendalikan. Ini disebut sebagai instrumen langsung.

Perpustakaan klien tersedia untuk semua bahasa dan runtime utama. Proyek Prometheus menyediakan perpustakaan klien resmi dalam Go, Python, Java/JVM, Ruby, dan Rust. Selain itu, ada juga berbagai perpustakaan klien pihak ketiga, seperti untuk C#/.Net, Node.js, Haskell, dan Erlang.

> RESMI VERSUS TIDAK RESMI
>
> Jangan terhalang oleh integrasi seperti perpustakaan klien yang tidak resmi atau pihak ketiga. Dengan ratusan aplikasi dan sistem yang mungkin ingin kamu integrasikan, tidak mungkin bagi tim proyek Prometheus untuk memiliki waktu dan keahlian untuk membuat dan memelihara semuanya. Oleh karena itu, sebagian besar integrasi dalam ekosistem adalah pihak ketiga. Untuk menjaga konsistensi dan agar semua berjalan dengan semestinya, pedoman tersedia tentang cara menulis integrasi.

Perpustakaan klien menangani semua detail yang rumit seperti keselamatan thread, pencatatan, dan menghasilkan format ekspor teks Prometheus dan/atau OpenMetrics sebagai respons terhadap permintaan HTTP. Karena pemantauan berbasis metrik tidak melacak peristiwa individu, penggunaan memori perpustakaan klien tidak meningkat dengan semakin banyaknya peristiwa yang terjadi. Sebaliknya, memori terkait dengan jumlah metrik yang kamu miliki.

Jika salah satu dependensi perpustakaan dari aplikasi kamu memiliki instrumen Prometheus, instrumen tersebut akan otomatis terdeteksi. Dengan demikian, dengan memberikan instrumen pada perpustakaan kunci seperti RPC client kamu, kamu bisa mendapatkan instrumen untuk itu di semua aplikasi kamu.

Beberapa metrik, seperti penggunaan CPU dan statistik garbage collection, biasanya disediakan langsung oleh perpustakaan klien, tergantung pada perpustakaan dan lingkungan runtime.

Perpustakaan klien tidak terbatas pada output metrik dalam format teks Prometheus dan OpenMetrics. Prometheus adalah ekosistem terbuka, dan API yang sama yang digunakan untuk menghasilkan format teks bisa digunakan untuk menghasilkan metrik dalam format lain atau untuk menghasilkan instrumen pada sistem lain. Demikian juga, kamu bisa mengambil metrik dari sistem instrumen lain dan menghubungkannya ke perpustakaan klien Prometheus, jika kamu belum sepenuhnya beralih ke instrumen Prometheus.

### Exporter

Tidak semua kode yang kamu jalankan adalah kode yang bisa kamu kontrol atau bahkan kamu punya akses ke dalamnya, sehingga menambahkan instrumentasi langsung tidak menjadi pilihan yang tepat. Sebagai contoh, tidak mungkin kernel sistem operasi akan mulai menghasilkan metrik dalam format Prometheus melalui HTTP dalam waktu dekat.

Perangkat lunak tersebut sering memiliki antarmuka melalui mana kamu bisa mengakses metriknya. Ini mungkin merupakan format ad hoc yang memerlukan parsing dan penanganan kustom, seperti yang diperlukan untuk banyak metrik Linux, atau standar yang sudah mapan seperti SNMP.

Exporter adalah perangkat lunak yang kamu pasang tepat di samping aplikasi yang ingin kamu peroleh metriknya. Ia menerima permintaan dari Prometheus, mengumpulkan data yang dibutuhkan dari aplikasi, mentransformasikannya ke dalam format yang benar, dan akhirnya mengembalikannya dalam respons kepada Prometheus. Kamu bisa memikirkan exporter sebagai proxy satu-satu kecil, yang mengonversi data antara antarmuka metrik sebuah aplikasi dan format eksposisi Prometheus.

Tidak seperti instrumentasi langsung yang kamu gunakan untuk kode yang kamu kontrol, exporter menggunakan gaya instrumentasi yang berbeda yang dikenal sebagai custom collectors atau ConstMetrics.

Berita baiknya adalah dengan ukuran komunitas Prometheus yang besar, exporter yang kamu butuhkan kemungkinan sudah ada dan dapat digunakan dengan sedikit usaha dari kamu. Jika exporter tidak memiliki metrik yang kamu minati, kamu selalu dapat mengirimkan permintaan pull untuk memperbaikinya, menjadikannya lebih baik untuk orang berikutnya yang menggunakannya.

### Service Discovery

Setelah Anda memiliki semua aplikasi yang diinstrumentasi dan exporter berjalan, Prometheus perlu mengetahui di mana mereka berada. Hal ini agar Prometheus tahu apa yang harus dimonitor, dan dapat memperhatikan jika ada sesuatu yang seharusnya dimonitor namun tidak merespon. Dalam lingkungan yang dinamis, Anda tidak dapat hanya menyediakan daftar aplikasi dan exporter sekali saja, karena daftar tersebut akan menjadi usang. Inilah yang menjadi peran dari service discovery.

Anda mungkin sudah memiliki beberapa database mesin, aplikasi, dan apa yang mereka lakukan. Ini mungkin berada di dalam database Chef, file inventaris untuk Ansible, berdasarkan tag pada instance EC2 Anda, dalam label dan anotasi di Kubernetes, atau mungkin hanya duduk di wiki dokumentasi Anda.

Prometheus memiliki integrasi dengan banyak mekanisme service discovery yang umum digunakan, seperti Kubernetes, EC2, dan Consul. Ada juga integrasi generik untuk yang memiliki pengaturan yang sedikit berbeda (lihat "File" dan "HTTP").

Namun, ini masih menimbulkan masalah. Hanya karena Prometheus memiliki daftar mesin dan layanan tidak berarti kita tahu bagaimana mereka cocok dengan arsitektur Anda. Sebagai contoh, Anda mungkin menggunakan tag Nama EC210 untuk menunjukkan aplikasi apa yang berjalan di mesin, sedangkan yang lain mungkin menggunakan tag yang disebut app.

Karena setiap organisasi melakukannya dengan sedikit perbedaan, Prometheus memungkinkan Anda untuk mengkonfigurasi bagaimana metadata dari service discovery dipetakan ke target monitoring dan labelnya menggunakan relabeling.

### Scraping

Scraping merupakan cara Prometheus untuk mengambil data metrics dari target yang ingin dimonitor. Caranya adalah dengan mengirimkan permintaan HTTP yang disebut "scrape". Hasil dari permintaan ini kemudian diparsing dan dimasukkan ke dalam storage Prometheus. Selain itu, Prometheus juga menambahkan beberapa metrics yang berguna, seperti apakah scrape berhasil dan berapa lama waktu yang dibutuhkan. Proses scrape dilakukan secara teratur, biasanya diatur agar terjadi setiap 10 hingga 60 detik untuk setiap target yang dimonitor.

Perlu diketahui bahwa Prometheus menggunakan sistem pull, di mana Prometheus yang memutuskan kapan dan apa yang akan di-scrape, berdasarkan pada konfigurasinya. Ada juga sistem push, di mana target monitoring yang akan memutuskan apakah ia akan dimonitor dan seberapa sering. Terdapat perdebatan sengit online tentang kedua desain ini, yang seringkali menyerupai perdebatan seputar Vim versus EMACS. Namun, sebagai pengguna Prometheus, kamu harus memahami bahwa sistem pull sudah menjadi bagian inti dari Prometheus, dan mencoba untuk mengubahnya menjadi sistem push bukanlah pilihan yang bijak.

### Storage

Prometheus menyimpan data secara lokal dalam basis data kustom. Sistem terdistribusi sulit untuk dijadikan andalan keandalannya, maka Prometheus tidak mencoba melakukan klastering. Selain keandalan, hal ini membuat Prometheus lebih mudah untuk dijalankan.

Selama bertahun-tahun, penyimpanan telah mengalami beberapa desain ulang, dengan sistem penyimpanan di Prometheus 2.0 menjadi iterasi ketiga. Sistem penyimpanan dapat menangani pengambilan jutaan sampel per detik, sehingga memungkinkan untuk memantau ribuan mesin dengan satu server Prometheus. Algoritma kompresi yang digunakan dapat mencapai 1,3 byte per sampel pada data dunia nyata. SSD direkomendasikan, tetapi tidak mutlak diperlukan.

### Dashboard

![dashboard](assets/2023-05-10-17-58-27.png)
Prometheus memiliki beberapa API HTTP yang memungkinkan Anda untuk meminta data mentah dan mengevaluasi kueri PromQL. API ini dapat digunakan untuk menghasilkan grafik dan dashboard. Secara default, Prometheus menyediakan penjelajah ekspresi. Ini menggunakan API ini dan cocok untuk kueri ad hoc dan eksplorasi data, tetapi bukan sistem dashboard umum.

Disarankan untuk menggunakan Grafana untuk dashboard. Ini memiliki berbagai fitur, termasuk dukungan resmi untuk Prometheus sebagai sumber data. Grafana dapat menghasilkan berbagai jenis dashboard, seperti yang terlihat pada Gambar 1-2. Grafana mendukung berbicara dengan beberapa server Prometheus, bahkan dalam satu panel dashboard.

### Recording Rules dan Alerts

Walaupun PromQL dan mesin penyimpanan sangat kuat dan efisien, menggabungkan metrik dari ribuan mesin secara langsung setiap kali Anda merender grafik dapat menjadi sedikit lambat. Recording rules memungkinkan ekspresi PromQL dievaluasi secara teratur dan hasilnya diambil ke dalam mesin penyimpanan.

Alerting rules adalah bentuk lain dari recording rules. Mereka juga mengevaluasi ekspresi PromQL secara teratur, dan semua hasil dari ekspresi tersebut menjadi alert. Alert dikirim ke Alertmanager.

### Manajemen Alert

Alertmanager menerima alert dari server Prometheus dan mengubahnya menjadi notifikasi. Notifikasi dapat mencakup email, aplikasi obrolan seperti Slack, dan layanan seperti PagerDuty.

Alertmanager tidak hanya mengubah alert menjadi notifikasi secara membabi buta satu per satu. Alert terkait dapat digabungkan menjadi satu notifikasi, dikurangi untuk mengurangi pager storms, dan berbagai routing dan output notifikasi dapat dikonfigurasi untuk setiap tim yang berbeda Anda. Alert juga dapat dibisukan, mungkin untuk menunda masalah yang sudah Anda sadari sebelumnya saat Anda tahu pemeliharaan dijadwalkan.

Peran Alertmanager berhenti pada pengiriman notifikasi; untuk mengelola respons manusia terhadap insiden, Anda harus menggunakan layanan seperti PagerDuty dan sistem tiket.

TIP
Alert dan ambang batasnya dikonfigurasi di Prometheus, bukan di Alertmanager.
