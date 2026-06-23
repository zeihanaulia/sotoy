
## Pertanyaan yang dibuka

1. Mengapa kemampuan AI menulis kode memindahkan hambatan utama dari implementasi ke spesifikasi?
2. Apa risiko kunci ketika spesifikasi lemah dalam workflow AI-native?
3. Bagaimana spesifikasi berfungsi sebagai boundary antara niat manusia dan aksi agent?

## Jawaban

Kemampuan AI menulis kode membuat pekerjaan implementasi teknis menjadi lebih murah. Ketika biaya pembuatan kode turun, kesalahan paling mahal tidak lagi terjadi pada tulisan kode itu sendiri, tetapi pada ketidaksesuaian antara apa yang diminta dan apa yang dihasilkan.

Spec menjadi boundary operasional yang menjawab:

* apa yang sedang dibangun,
* apa batasnya,
* apa acceptance criteria-nya,
* apa constraint pentingnya,
* dan apa yang jangan dilakukan.

Tanpa spec yang jelas, AI akan mengisi kekosongan dengan tebakan yang tampak valid secara syntaksis tapi salah arah secara domain.

### Risiko utama jika spec lemah

* AI menghasilkan kode yang terlihat benar namun tidak memenuhi tujuan.
* Perubahan cepat menjadi false confidence: banyak commit baik, tapi tidak tepat.
* Review manusia jadi lebih sulit karena output sudah tersebar di banyak file.
* Rework meningkat karena masalahnya bukan kode, tapi definisi tugas.

### Peran spec sebagai boundary

Spesifikasi adalah jembatan antara intent manusia dan aksi agent. Ia memberitahu agent bukan hanya "lakukan ini", tetapi juga "lakukan ini dalam batas yang ini." Jika agent diberi ruang tanpa boundary, ia cenderung mengisi ruang itu dengan solusi generik yang tidak relevan.

Spec adalah kontrol operasional: semakin otonom agent, semakin penting spec sebagai guardrail.

## Mengapa ini penting untuk AI-native engineering

Karena AI-native bukan sekadar mempermudah penulisan kode. Ini soal memindahkan pusat gravitasi kerja dari "menulis kode" ke "mendefinisikan kebutuhan dan membuat batas yang dapat dieksekusi." 

Jika AI hanya dilihat sebagai penulis kode, maka focus masih di level lamanya. Jika AI dipandang sebagai pelaku operasional, maka spec menjadi kotak kendali yang menentukan arah, bukan sekadar catatan awal.

## Lihat juga

* [[zettel.20260421161001]] — AI-native adalah jargon strategi yang menandai asumsi desain AI sebagai fondasi, bukan sekadar fitur tambahan
* [[zettel.20260421162310]] — AI-native Software Engineering memindahkan gravitasi kerja engineering ke orkestrasi dan verifikasi AI
* [[zettel.20260421172800]] — BMAD project context adalah konstitusi implementasi untuk AI agents, bukan dokumentasi biasa
* [[zettel.moc.ai-native]]
