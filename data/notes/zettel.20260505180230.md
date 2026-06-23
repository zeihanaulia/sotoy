
Untuk coding agent, biaya terbaik bukan cuma tarif per token. Yang penting adalah berapa token total yang digunakan sampai task selesai.

Sehingga model murah bisa kalah jika:

- loopnya panjang,
- outputnya besar,
- prompt perlu banyak retry,
- agent sering menyala ulang konteks.

Dalam banyak kasus, model yang sedikit lebih mahal per token tapi dapat menyelesaikan task dengan lebih sedikit step akan lebih murah secara total.
