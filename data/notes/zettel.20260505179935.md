
Agentic coding tools bukan sekadar chatbot. Kalau mereka diberi akses filesystem dan shell di mesin developer, maka mereka harus diperlakukan seperti process lokal dengan permission boundary yang jelas.

Karena developer workstation menyimpan lebih dari source code — secret file, AWS/Azure/K8s creds, shell history, editor session, extention state — keamanan agentic coding bergantung pada seberapa ketat boundary itu.

Intinya: pertanyaan yang paling relevan bukan "model apa yang digunakan?" tetapi "agent ini punya akses ke file/path apa, perintah apa yang bisa dijalankan, dan data apa yang bisa keluar ke network?"