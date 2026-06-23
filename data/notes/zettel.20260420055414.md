
> Satu ADR = satu keputusan. Jika satu dokumen memuat banyak keputusan, batasan hilang, diskusi jadi kabur, dan riwayat perubahan susah dilacak.

Catatan gue:

- ADR yang menggulung banyak keputusan ke dalam satu file merusak sifatnya sebagai unit keputusan.
- Ketika satu keputusan berubah, sulit menentukan apakah ADR masih valid atau perlu supersede.
- Format file terpisah dengan nama deskriptif membuat katalog keputusan bisa dipindai cepat.

Implikasi:

- Perlu disiplin memilih level keputusan: hanya yang signifikan layak di-ADR-kan.
- Penamaan file harus mencerminkan keputusan agar tim bisa membaca daftar ADR tanpa membuka semua file.
- Granularitas ADR membantu memisahkan diskusi teknis menjadi topik yang lebih mudah di-review.

→ Dikuatkan oleh [[zettel.literature.architecture-decision-records]]
