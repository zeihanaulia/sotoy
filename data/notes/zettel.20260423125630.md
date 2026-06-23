
AI app tidak sedang mengajarkan model detail. Ia sedang mengajarkan bahwa AI app paling sering adalah aplikasi web biasa yang memiliki model sebagai dependency:

* user input diproses dulu di service layer,
* service memilih model dan menyusun prompt,
* model dipanggil lewat API / SDK,
* respons dikirim balik ke user, sering kali secara streaming.

Itu menjelaskan kenapa bagian ini memilih local Ollama: untuk memperlihatkan pola umum integrasi tanpa noise dari billing atau vendor cloud.

## Relevansi

* [[book-summaries.the-developers-guide-to-ai]] — overview struktur dan level buku sebagai peta praktis AI engineering untuk developer
* [[zettel.moc.ai-native]] — MOC AI-native engineering
