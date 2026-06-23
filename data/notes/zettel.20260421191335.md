
## Pertanyaan yang dibuka

1. Bagaimana melakukan pre-mortem ketika belum pernah ada kegagalan sejenis?
2. Apakah pre-mortem pada akhirnya cuma menebak dengan asumsi?
3. Metode apa yang membuat pre-mortem tetap grounded meski tanpa point data historis?

## Klaim utama

Pre-mortem pada kode atau design baru bukan sekadar nebak-nebak. Ia adalah proses asumsi terstruktur yang menggunakan evidence, pola risiko, dan analogi domain untuk menguji kegagalan potensial.

## Penjelasan

Jika belum ada event nyata, pre-mortem tetap valid dengan cara ini:

* mulailah dari outcome yang jelas: "apa saja yang membuat ini gagal?"
* gunakan evidence yang tersedia: domain, teknologi, user behaviour, dependency, regulasi, dan pengalaman tim.
* pisahkan asumsi eksplisit dari tebakan kabur: tulis "saya asumsikan X" dan cari alasan kenapa X mungkin benar.
* lihat pola risiko umum di area serupa: deployment, auth, data integrity, performance, maintenance.

Jadi bukan "kita tebak kalau ini akan gagal". Yang dilakukan adalah:

* mendefinisikan kegagalan potensial,
* memetakan jalur yang bisa mencapainya,
* lalu mencari bukti atau counter-evidence untuk setiap jalur.

Kalau validasi penuh tidak tersedia, pre-mortem menghasilkan daftar risiko yang terstruktur, bukan prediksi pasti.

## Contoh pendek

Untuk fitur baru upload file:

* asumsi: file size selalu kecil
* risiko: user mengunggah file besar dan menyebabkan OOM
* bukti: tidak ada limit di UI, sistem ukur file belum dipasang
* mitigasi: tetapkan limit, tambahkan validation, observability untuk ukuran upload

Di sini, pre-mortem tidak bergantung pada event "server pernah OOM". Ia hanya pakai pola risiko dan asumsi yang bisa diuji.

## Implikasi

* Pre-mortem tetap bisa dilakukan meski sistem belum pernah gagal.
* Kualitasnya tergantung pada struktur pertanyaan dan evidence, bukan pada data kegagalan historis.
* Hal yang paling berbahaya adalah pre-mortem yang hanya berisi "kayaknya bisa gagal kalau..." tanpa bukti atau pola.
* Jika tim punya pengalaman serupa di domain lain, itu lebih berharga daripada data historis langsung.

## Referensi

* Gary Klein, "Performing a Project Premortem", Harvard Business Review, September 2007 — sumber primer pre-mortem modern. https://hbr.org/2007/09/performing-a-project-premortem
* Wikipedia, "Pre-mortem" — ringkasan konsep dan hubungan dengan prospective hindsight. https://en.wikipedia.org/wiki/Premortem

## Contoh nyata

Tim product launch yang menggunakan pre-mortem sering menemukan risiko seperti dependency pihak ketiga down, error message yang memicu overload helpdesk, dan asumsi performa yang terlalu optimistis sebelum ada kegagalan nyata.

## Lihat juga

* [[zettel.20260421184801]] — Pre-mortem analysis memaksa perencanaan menilai hasil dengan asumsi kegagalan
* [[zettel.20260421184845]] — Socratic questioning mengungkap asumsi lewat pertanyaan terarah
* [[zettel.20260421184757]] — Advanced Elicitation memaksa model menggunakan lensa berpikir eksplisit untuk reconsider output
