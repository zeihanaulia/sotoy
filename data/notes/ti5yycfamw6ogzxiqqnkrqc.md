
Diskusi kali ini tentang bagaimana memisahkan service yang tight coupling dan low cohesion menjadi loose coupling dan high cohesion.
Issuenya karena ada salah satu service di kantor yang sangat dependency dengan odoo, lalu ketika odoonya bermasalah service itu pun ikut bermasalah.

ChatGPT merekomendasikan beberapa approach salah satunya adalah membuat queue yang mana sebenarnya approach ini sudah terpikirkan tapi belum tau bagaimana mereliasisikannya dan tidak ada downtime.
Maka diskusi ini coba dikerucutkan dengan topik Membuat Aplikasi Loose Coupling.

## Rekomendasi buku bacaan

> Q: Untuk mempelajari cara memisahkan sistem Anda dari Odoo dan mengimplementasikan sistem OMS (Order Management System) tanpa menyebabkan downtime, Anda dapat mencari referensi dari beberapa sumber berikut:

- "Building Microservices" karya Sam Newman: Buku ini memberikan panduan yang baik tentang cara membuat sistem yang terpisah dan saling berintegrasi (loosely coupled), serta memberikan contoh implementasi sistem microservices yang dapat digunakan sebagai referensi.
- "Designing Data-Intensive Applications" karya Martin Kleppmann: Buku ini memberikan panduan tentang desain arsitektur aplikasi yang baik dan bagaimana mengatasi masalah skalabilitas dan reliabilitas dalam aplikasi data-intensive.
- "Scalability Rules" karya Martin L. Abbott dan Michael T. Fisher: Buku ini memberikan aturan-aturan yang dapat digunakan untuk meningkatkan skalabilitas sistem dan mengatasi masalah yang sering dihadapi dalam skalabilitas.
- "Release It!" karya Michael T. Nygard: Buku ini menjelaskan tentang bagaimana merilis aplikasi ke produksi dan mengatasi masalah yang sering dihadapi dalam operasional sistem.
- "The Site Reliability Workbook" karya Betsy Beyer, Niall Richard Murphy, David K. Rensin, Kent Kawahara, Stephanie Peisse: Buku ini menjelaskan tentang bagaimana merancang dan mengelola sistem yang dapat diandalkan dan mengatasi masalah yang sering dihadapi dalam operasional sistem.

Selain itu, Anda juga dapat mengejar kursus online atau belajar melalui dokumentasi teknis dari teknologi yang digunakan dalam sistem OMS yang akan Anda bangun. Hal ini akan membantu Anda untuk memahami bagaimana sistem OMS dapat diimplementasikan dengan baik dan mengatasi masalah yang mungkin muncul selama proses implementasi.

## Chapter yang relate dengan buku "Designing Data-Intensive Applications"

> Q: Di buku "Designing Data-Intensive Applications" karya Martin Kleppmann, topik tentang arsitektur sistem yang terpisah dan saling berintegrasi (loosely coupled) dibahas dalam beberapa chapter, diantaranya:

Chapter 2: Data Models and Query Languages
Chapter 3: Storage and Retrieval
Chapter 4: Data Processing
Chapter 7: Replication and Offline Processing
Chapter 8: Stream Processing
Chapter 9: Microservices and Serverless
Chapter 2 membahas tentang model data yang digunakan dalam aplikasi data-intensive dan bagaimana query languages digunakan untuk mengakses data. Chapter 3 membahas tentang cara penyimpanan dan pengambilan data dari sistem penyimpanan. Chapter 4 membahas tentang cara pemrosesan data dalam aplikasi data-intensive. Chapter 7 membahas tentang replikasi data dan pemrosesan offline, Chapter 8 membahas tentang pemrosesan stream data, dan Chapter 9 membahas tentang arsitektur microservices dan serverless.

Dalam chapter tersebut akan di bahas bagaimana membuat sistem yang terpisah dan saling berintegrasi (loosely coupled) sehingga dapat mengurangi downtime dan meningkatkan reliabilitas sistem. Dan juga akan dibahas bagaimana mengatasi masalah skalabilitas dan reliabilitas dalam aplikasi data-intensive.

### Point penting di Chapter 2: Data Models and Query Languages

Di chapter 2 dari buku "Designing Data-Intensive Applications" karya Martin Kleppmann, beberapa point penting yang dibahas adalah:

1. Data models yang digunakan dalam aplikasi data-intensive, seperti model relational, document-oriented, graph, key-value, dan column-family.
2. Bagaimana query languages digunakan untuk mengakses data dalam aplikasi data-intensive, seperti SQL, NoSQL, dan query languages yang digunakan dalam sistem distribusi.
3. Bagaimana menentukan model data yang tepat untuk aplikasi yang spesifik, termasuk trade-off antara kemudahan pengembangan dan performa.
4. Bagaimana mengimplementasikan model data yang tepat dalam aplikasi data-intensive, termasuk bagaimana mengubah model data seiring dengan perkembangan aplikasi.
5. Bagaimana mengelola konsistensi data dalam sistem distribusi, termasuk konsistensi tunggal, konsistensi seberat, dan konsistensi seberat-seberat.
6. Bagaimana mengatasi masalah seperti masalah konsistensi dan masalah skalabilitas dalam sistem distribusi
7. Bagaimana mengoptimalkan query dan index dalam sistem distribusi
8. Bagaimana mengatur data yang tidak terstruktur dan data yang terstruktur dalam sistem distribusi.
9. Bagaimana mengimplementasikan data warehousing dan business intelligence dalam sistem distribusi.
10 Bagaimana mengimplementasikan data lake dalam sistem distribusi

Jadi, chapter 2 ini memberikan gambaran tentang model data yang digunakan dalam aplikasi data-intensive dan bagaimana query languages digunakan untuk mengakses data, serta mengatasi masalah yang sering dihadapi dalam sistem distribusi.

#### Jelaskan tentang point 1. Data models yang digunakan dalam aplikasi data-intensive, seperti model relational, document-oriented, graph, key-value, dan column-family.

Data model adalah cara yang digunakan untuk menyimpan dan mengakses data dalam aplikasi data-intensive. Beberapa data model yang digunakan dalam aplikasi data-intensive meliputi:

1. Model relational: Model ini menyimpan data dalam tabel-tabel yang saling terkait. Data dalam tabel-tabel ini dapat diakses menggunakan query SQL. Use case dari model relational adalah aplikasi yang memerlukan data yang terstruktur dan dapat digunakan untuk mengelola data yang berhubungan dengan transaksi, seperti sistem manajemen inventori, sistem manajemen keuangan, dll.
2. Model document-oriented: Model ini menyimpan data dalam dokumen yang tidak terstruktur. Data dalam dokumen ini dapat diakses menggunakan query yang kurang terstruktur daripada query SQL. Use case dari model document-oriented adalah aplikasi yang memerlukan data yang tidak terstruktur, seperti aplikasi yang digunakan untuk mengelola data yang berhubungan dengan konten, seperti sistem manajemen konten, sistem manajemen dokumen, dll.
3. Model graph: Model ini menyimpan data dalam bentuk grafik yang saling terkait. Data dalam grafik ini dapat diakses menggunakan query yang ditentukan oleh pengembang. Use case dari model graph adalah aplikasi yang memerlukan data yang saling terkait dengan relasi, seperti aplikasi yang digunakan untuk mengelola data yang berhubungan dengan relasi sosial, seperti sistem manajemen relasi sosial, sistem manajemen rekomendasi, dll.
4. Model key-value: Model ini menyimpan data dalam pasangan key-value. Data dalam pasangan key-value ini dapat diakses menggunakan key yang ditentukan oleh pengembang. Use case dari model key-value adalah aplikasi yang memerlukan data yang cepat diakses, seperti aplikasi yang digunakan untuk mengelola data yang berhubungan dengan cache, seperti sistem cache, sistem manajemen sesi, dll.
5. Model column-family adalah sebuah model data yang menyimpan data dalam famili kolom yang saling terkait. Data dalam famili kolom ini dapat diakses menggunakan query yang ditentukan oleh pengembang. Use case dari model column-family adalah aplikasi yang memerlukan data yang dapat diakses dengan cepat dan dapat digunakan untuk mengelola data yang berhubungan dengan sensor, seperti sistem manajemen sensor, sistem pemantauan real-time, dll. Model column-family sangat cocok digunakan dalam aplikasi yang memerlukan data yang dapat diakses dengan cepat dan dapat digunakan untuk mengelola data yang berhubungan dengan sensor, seperti sistem manajemen sensor, sistem pemantauan real-time, dll. Model ini juga cocok digunakan dalam aplikasi yang memerlukan data yang dapat dikelompokkan dalam kolom yang berbeda dan dapat diakses dengan cepat. Contohnya, dalam aplikasi IoT (Internet of Things) yang memerlukan data dari berbagai sensor yang dapat diakses dengan cepat, model column-family dapat digunakan untuk mengelola data dari sensor tersebut.

Namun, perlu diingat bahwa setiap model data memiliki kelebihan dan kekurangan masing-masing, dan pemilihan model data yang tepat harus didasarkan pada karakteristik aplikasi dan kebutuhan data yang diperlukan.


#### Apa korelasinya chapter 2 dengan topik

Chapter 2 dari buku "Designing Data-Intensive Applications" karya Martin Kleppmann membahas tentang model data yang digunakan dalam aplikasi data-intensive dan bagaimana query languages digunakan untuk mengakses data. Hal ini sangat berhubungan dengan topik utama Anda, yaitu "membuat aplikasi loose coupling" atau pemisahan dengan Odoo tanpa ada downtime.

Salah satu cara untuk meningkatkan reliabilitas dan skalabilitas sistem adalah dengan membuat sistem yang terpisah dan saling berintegrasi (loosely coupled). Model data yang digunakan dalam aplikasi data-intensive dapat mempengaruhi bagaimana sistem tersebut dapat diintegrasikan dan dioperasikan.

Beberapa hal yang dapat Anda ambil dari chapter 2 untuk diimplementasikan dalam proses pemisahan dengan Odoo dan meningkatkan reliabilitas sistem antara lain:

1. Memilih model data yang sesuai dengan karakteristik aplikasi dan kebutuhan data yang diperlukan. Ini dapat mempengaruhi bagaimana data dapat diakses dan dioperasikan, dan dapat membantu dalam proses pemisahan dengan Odoo.
2. Mengelola konsistensi data dalam sistem distribusi, ini merupakan hal penting dalam proses pemisahan dengan Odoo dan meningkatkan reliabilitas sistem.

### Apa point point penting pada Chapter 3: Storage and Retrieval

1. Cara menyimpan data: Chapter ini membahas berbagai cara untuk menyimpan data, seperti menyimpan data dalam file, menyimpan data dalam database relasional, menyimpan data dalam database NoSQL, dll.
2. Indeks: Chapter ini membahas berbagai jenis indeks yang dapat digunakan untuk mengoptimalkan penyimpanan data dan pencarian data, seperti indeks B-Tree, indeks Hash, dll.
3. Penyimpanan data terdistribusi: Chapter ini membahas bagaimana data dapat disimpan pada mesin yang berbeda dan bagaimana data dapat diakses dari mesin yang berbeda.
4. Penyimpanan data lintas zona waktu: Chapter ini membahas bagaimana data dapat disimpan dan diakses dari zona waktu yang berbeda.
5. Backup dan restore: Chapter ini membahas bagaimana data dapat di-backup dan di-restore, dan bagaimana mengatasi masalah yang muncul saat mengembalikan data.
6. Konsistensi data: Chapter ini membahas bagaimana mengelola konsistensi data dalam sistem distribusi dan bagaimana mengatasi masalah konsistensi data.
7. Penyimpanan data di dalam cache : Chapter ini membahas bagaimana data dapat disimpan di cache dan bagaimana mengatasi masalah yang muncul saat mengelola data di cache.
8. Penyimpanan data dalam memori: Chapter ini membahas bagaimana data dapat disimpan dalam memori dan bagaimana mengatasi masalah yang muncul saat mengelola data dalam memori.
9. Penyimpanan data dalam cloud: Chapter ini membahas bagaimana data dapat disimpan dalam cloud dan bagaimana mengatasi masalah yang muncul saat mengelola data dalam cloud.
10. Penyimpanan data untuk analitik: Chapter ini membahas bagaimana data dapat disimpan untuk keperluan analitik, seperti data warehousing, data lake, dll.
11. Penyimpanan data untuk Machine Learning: Chapter ini membahas bagaimana data dapat disimpan untuk keperluan machine learning dan bagaimana mengatasi masalah yang muncul saat mengelola data untuk machine learning.

#### Yang dimaksud dengan "Cara menyimpan"

1. Menyimpan data dalam file: Data dapat disimpan dalam file-file teks atau binary yang dapat dibaca dan ditulis oleh aplikasi. Ini adalah cara yang paling sederhana untuk menyimpan data, tetapi tidak selalu efisien untuk mengelola data dalam skala besar. contoh tools
   1. Text File : Notepad, Sublime Text
   2. Binary File : Hadoop Distributed File System (HDFS), Google File System (GFS)
1. Menyimpan data dalam database relasional: Data dapat disimpan dalam database relasional seperti MySQL, PostgreSQL, dan Oracle. Database relasional menyediakan model data tabel-baris yang dapat digunakan untuk mengelola data yang terkait.
2. Menyimpan data dalam database NoSQL: Data dapat disimpan dalam database NoSQL seperti MongoDB, Cassandra, dan Redis. Database NoSQL menyediakan model data yang berbeda dari database relasional, seperti document-oriented, key-value, atau column-family. Model data ini lebih cocok untuk mengelola data yang besar, tidak terstruktur, atau yang memerlukan skalabilitas tinggi.

#### Ada apa saja jenis jenis index dan bagaimana cara kerjanya

1. B-Tree index: B-Tree adalah jenis indeks yang paling umum digunakan dalam database relasional dan sistem file. Ini adalah sebuah struktur data yang digunakan untuk menyimpan data dalam urutan tertentu dan memungkinkan untuk pencarian data yang cepat.
2. Hash index: Hash index menggunakan algoritma hash untuk mengindeks data dan mencari data dengan cepat. Hash index digunakan dalam database NoSQL seperti Redis dan Riak.
3. Trie index: Trie index digunakan untuk menyimpan data yang berupa string dan digunakan dalam pencarian kata dalam teks.
4. Space-Filling Curve: Indeks ini digunakan untuk menyimpan data geospasial dan digunakan dalam sistem yang berurusan dengan data geospasial.
5. Bloom Filter: Indeks ini digunakan untuk mengecek apakah suatu item ada dalam suatu set data atau tidak.
6. Bitmap Index: Indeks ini digunakan untuk menyimpan data yang memiliki nilai boolean, digunakan dalam sistem analitik.
7. inverted index: digunakan untuk mencari kata-kata dalam sebuah teks, digunakan dalam sistem pencarian.