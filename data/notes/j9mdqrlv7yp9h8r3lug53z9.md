
## Installation

Untuk mempremudah instalasi kong kita bisa menggunakan [docker-kong](https://github.com/Kong/docker-kong). 
Tinggal `make kong-postgres` aja.

## Konfigurasi

Diagram yang mau kita buat kurang lebih akan seperti ini.

![Desain Api Gateway](assets/20220908112039.png)  

Semua request melalui `http://localhost:8000`, path selanjutnya akan diisi dengan `/api/version`. untuk version ada beberapa cara bisa melalui path ada juga yang melalui header.
