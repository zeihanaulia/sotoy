
Perbedaan mendasar antara otomasi biasa (cron job) dan Loop Engineering adalah adanya *decision-maker* di dalam siklusnya. 

Otomasi biasa hanya menjalankan perintah pada waktu tertentu. Loop Engineering menjalankan agent yang mampu:
1. Membaca state saat ini.
2. Memilih langkah berikutnya berdasarkan feedback.
3. Menentukan apakah stopping condition sudah terpenuhi.

Dengan demikian, loop mengubah agent dari sekadar alat eksekusi menjadi unit kerja yang memiliki otonomi terbatas namun terarah.

Relasi: [[notes.ai-agents.loop-engineering]]
