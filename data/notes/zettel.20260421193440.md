
## Pertanyaan yang dibuka

1. Apa bedanya PATCH, BAD SPEC, dan INTENT GAP dalam AI-native workflow?
2. Kenapa penting memperbaiki layer yang tepat saat review atau koreksi?
3. Bagaimana konsekuensinya jika masalah di-layer salah justru diperbaiki?

## Klaim utama

Tidak semua kegagalan berasal dari kode. Dalam AI-native engineering, ada tiga layer diagnosis yang berbeda:

* PATCH: implementasi lokal perlu diperbaiki,
* BAD SPEC: boundary atau spec eksekusi perlu direvisi,
* INTENT GAP: pemahaman awal tentang maksud user perlu diklarifikasi ulang.

Memperbaiki pada layer yang salah sering membuat rework jadi lebih besar daripada manfaatnya.

## Definisi

### PATCH

Masalahnya ada di level implementasi lokal. Intent dan spec sudah benar, tetapi detail implementasi, bug, atau edge case belum ditangani.

Contoh: error handling tidak meliputi kondisi tertentu, test case terlewat, atau helper dipanggil dengan argumen yang salah.

### BAD SPEC

Intent awal benar, tetapi spesifikasi yang dibekukan terlalu lemah atau tidak lengkap. Agent menerjemahkan spec secara konsisten, tetapi spec itu sendiri tidak memuat constraint yang penting.

Contoh: acceptance criteria tidak mencakup keamanan, format response salah, atau precondition tidak ditentukan.

### INTENT GAP

Masalah lebih dalam: tim atau agent salah memahami apa yang sebenarnya diminta. Baik spec maupun implementasi bisa konsisten, tapi terhadap pemahaman yang keliru.

Contoh: fitur dibuat sesuai pengertian awal, tetapi user sebenarnya menginginkan behavior lain.

## Mengapa perbedaan ini penting

AI-native workflows seperti Quick Dev mengandalkan agen yang dapat melakukan banyak perubahan cepat. Ini memperbesar biaya jika perbaikan dipaksa pada layer yang salah.

* Jika PATCH dilakukan saat BAD SPEC asli, kode bisa jadi valid tapi terus gagal di use case yang tepat.
* Jika BAD SPEC diubah saat sebenarnya ada INTENT GAP, tim kehilangan arah karena batas yang diperbaiki masih salah.
* Jika INTENT GAP ditangani sebagai PATCH, tim akan terus mengejar gejala tanpa menyelesaikan kebutuhan bisnis.

## Prinsip yang harus dipegang

1. Temukan level kegagalan pertama kali masuk.
2. Perbaiki di layer itu.
3. Jika diperlukan, dorong koreksi ke layer yang lebih dalam, bukan hanya tambal di atasnya.

## Hubungan ke Quick Dev

Quick Dev menempatkan review sebagai triage. Ia memisahkan respons menjadi:

* PATCH untuk kesalahan lokal,
* BAD SPEC untuk koreksi boundary,
* INTENT GAP untuk klarifikasi ulang mogul.

Ini membuat workflow lebih disiplin: output yang tampak baik tidak otomatis dibiarkan. Review harus menentukan apakah masalahnya di kode, spec, atau pemahaman dasar.

## Lihat juga

* [[zettel.20260421174123]] — BMAD Quick Dev mengoptimalkan attention manusia, bukan sekadar kecepatan model
* [[zettel.20260421175034]] — Simulasi Quick Dev: reset password via email menunjukkan PATCH, BAD SPEC, dan INTENT GAP
* [[zettel.20260421174751]] — Quick Dev diagram: node-by-node diagnosis layer dan alur koreksi
* [[zettel.moc.ai-native]]
