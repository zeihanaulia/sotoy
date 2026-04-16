---
id: book-summaries.site-reliability-engineering
title: Site Reliability Engineering
desc: ''
updated: 1682477476684
created: 1682477340762
published: false
---

## Chapter 1. Introduction

> Hope is not a strategy.
>
>           - Traditional SRE saying

### Pendekatan Sysadmin untuk Manajemen Layanan

Secara historis, perusahaan-perusahaan telah mempekerjakan administrator sistem untuk menjalankan sistem komputasi yang kompleks.

Pendekatan administrator sistem atau sysadmin ini melibatkan pengumpulan komponen perangkat lunak yang sudah ada dan mengimplementasikannya untuk bekerja bersama untuk menghasilkan sebuah layanan. Sysadmin kemudian bertugas untuk menjalankan layanan dan menanggapi peristiwa dan pembaruan ketika mereka terjadi. Seiring dengan kompleksitas sistem dan volume lalu lintas yang meningkat, menghasilkan peningkatan yang sesuai dalam peristiwa dan pembaruan, tim sysadmin bertumbuh untuk menyerap pekerjaan tambahan. Karena peran sysadmin membutuhkan keterampilan yang jauh berbeda dengan yang dibutuhkan oleh pengembang produk, pengembang dan sysadmin dibagi menjadi tim-tim diskrit: "pengembangan" dan "operasi" atau "ops."

Model manajemen layanan sysadmin memiliki beberapa keunggulan. Bagi perusahaan yang memutuskan bagaimana menjalankan dan menempatkan staf dalam suatu layanan, pendekatan ini relatif mudah diimplementasikan: sebagai paradigma industri yang familiar, banyak contoh dari mana dapat dipelajari dan diemulasi. Sebuah bakat yang relevan sudah banyak tersedia. Sejumlah alat, komponen perangkat lunak (siap pakai atau sebaliknya), dan perusahaan integrasi tersedia untuk membantu menjalankan sistem yang sudah dirakit, sehingga tim sysadmin pemula tidak perlu membuat sistem dari awal.

Pendekatan sysadmin dan pemisahan pengembangan/ops memiliki sejumlah kelemahan dan kesalahan. Ini secara luas dibagi menjadi dua kategori: biaya langsung dan biaya tidak langsung.

Biaya langsung tidaklah halus atau ambigu. Menjalankan layanan dengan tim yang mengandalkan intervensi manual baik untuk pengelolaan perubahan maupun penanganan peristiwa menjadi mahal ketika layanan dan/atau lalu lintas ke layanan tumbuh, karena ukuran tim secara alami bertambah seiring dengan beban yang dihasilkan oleh sistem tersebut."

Maksud dari paragraf ini adalah membahas pendekatan tradisional dalam manajemen layanan yang melibatkan penggunaan administrator sistem atau sysadmin untuk menjalankan sistem komputasi yang kompleks. Pendekatan ini melibatkan pengumpulan komponen perangkat lunak yang sudah ada dan mengimplementasikannya untuk bekerja bersama untuk menghasilkan layanan. Sysadmin bertanggung jawab untuk menjalankan layanan dan menanggapi peristiwa dan pembaruan ketika mereka terjadi. Namun, pendekatan ini memiliki kelemahan dan kesalahan yang meliputi biaya langsung dan tidak langsung ketika tim yang mengandalkan intervensi manual digunakan untuk pengelolaan perubahan dan penanganan peristiwa. Karena itu, tim sysadmin pemula tidak perlu membuat sistem dari awal untuk menghindari biaya yang mahal.

Biaya tidak langsung dari pemisahan antara pengembangan dan operasi bisa sulit dideteksi, tetapi seringkali lebih mahal bagi organisasi dibandingkan dengan biaya langsung. Biaya ini muncul karena dua tim tersebut berbeda latar belakang, keterampilan, dan insentif. Mereka menggunakan kosakata yang berbeda untuk menggambarkan situasi; mereka memiliki asumsi yang berbeda tentang risiko dan kemungkinan solusi teknis; dan mereka memiliki asumsi yang berbeda tentang tingkat stabilitas produk yang ditargetkan. Pemisahan antara kedua tim dapat dengan mudah menjadi masalah insentif, serta komunikasi, tujuan, dan akhirnya, kepercayaan dan saling menghargai. Akibatnya, ini bisa menjadi sebuah patologi.

Tim operasi tradisional dan rekan mereka di pengembangan produk seringkali berakhir dalam konflik, terutama dalam hal seberapa cepat perangkat lunak dapat dirilis ke produksi. Pada intinya, tim pengembangan ingin meluncurkan fitur baru dan melihatnya diadopsi oleh pengguna. Sedangkan, tim operasi ingin memastikan layanan tidak rusak saat mereka memegang pager. Karena sebagian besar masalah terjadi karena perubahan - konfigurasi baru, peluncuran fitur baru, atau jenis lalu lintas pengguna baru - tujuan kedua tim secara fundamental dalam ketegangan.

Kedua kelompok memahami bahwa tidak dapat diterima untuk menyatakan kepentingan mereka secara terang-terangan ("Kami ingin meluncurkan apa saja, kapan saja, tanpa hambatan" versus "Kami tidak ingin pernah mengubah apa pun dalam sistem setelah itu berfungsi"). Dan karena kosakata dan asumsi risiko mereka berbeda, kedua kelompok sering kali menggunakan perang parit yang familiar untuk memajukan kepentingan mereka. Tim operasi berusaha menjaga sistem yang berjalan terhadap risiko perubahan dengan memperkenalkan pintu gerbang peluncuran dan perubahan. Misalnya, ulasan peluncuran mungkin mengandung pemeriksaan eksplisit untuk setiap masalah yang pernah menyebabkan gangguan di masa lalu - yang bisa menjadi daftar sepanjang apa pun, dengan tidak semua elemen memberikan nilai yang sama. Tim pengembangan dengan cepat belajar bagaimana merespons. Mereka memiliki lebih sedikit "peluncuran" dan lebih banyak "flag flips," "incremental updates," atau "cherrypicks." Mereka mengadopsi taktik seperti sharding produk sehingga fitur-fitur yang lebih sedikit yang tunduk pada ulasan peluncuran.

### Google Approach to Service Management: Site Reliability Engineering

Konflik bukanlah bagian yang tidak terelakkan dalam menawarkan layanan perangkat lunak. Google telah memilih untuk menjalankan sistem kami dengan pendekatan yang berbeda: tim Site Reliability Engineering kami fokus pada perekrutan insinyur perangkat lunak untuk menjalankan produk kami dan membuat sistem untuk menyelesaikan pekerjaan yang sebaliknya akan dilakukan, sering kali secara manual, oleh sysadmin.

Apa itu Site Reliability Engineering, seperti yang telah didefinisikan di Google? Penjelasan saya sederhana: SRE adalah apa yang terjadi ketika Anda meminta seorang insinyur perangkat lunak untuk merancang sebuah tim operasi. Ketika saya bergabung dengan Google pada tahun 2003 dan diberi tugas untuk menjalankan sebuah "Tim Produksi" dari tujuh insinyur, seluruh hidup saya sampai saat itu telah menjadi insinyur perangkat lunak. Jadi saya merancang dan mengelola grup tersebut dengan cara yang saya inginkan jika saya bekerja sebagai SRE sendiri. Kelompok itu sejak itu berkembang menjadi tim SRE saat ini di Google, yang tetap setia pada asal-usulnya seperti yang direncanakan oleh seorang insinyur perangkat lunak seumur hidup.

Bangunan utama dari pendekatan Google terhadap manajemen layanan adalah komposisi setiap tim SRE. Secara keseluruhan, SRE dapat dibagi menjadi dua kategori utama.

50-60% adalah Insinyur Perangkat Lunak Google, atau lebih tepatnya, orang-orang yang telah direkrut melalui prosedur standar untuk Insinyur Perangkat Lunak Google. 40-50% sisanya adalah kandidat yang sangat dekat dengan kualifikasi Insinyur Perangkat Lunak Google (yaitu, 85-99% dari keterampilan yang dibutuhkan), dan yang juga memiliki kumpulan keterampilan teknis yang berguna untuk SRE tetapi jarang dimiliki oleh kebanyakan insinyur perangkat lunak. Secara jauh, keahlian dalam sistem internal UNIX dan jaringan (Layer 1 hingga Layer 3) adalah dua jenis keterampilan teknis yang paling umum kami cari.

