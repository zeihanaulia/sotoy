

**Ngulik Bareng: Open Graph – Biar Link Lo Gak Nanggung**

![alt text](assets/til.frontend.open-graph-biar-ketika-sharelink-gan-makin-kece/image.png)

Pernah nggak lo share link artikel, produk, atau portfolio lo di grup WA atau medsos, tapi yang muncul cuma link polos? Nah, di sinilah Open Graph (OG) berperan penting.

OG itu standar yang pertama kali diperkenalkan Facebook. Intinya, lo bisa tambahin beberapa meta tag di HTML, supaya waktu link lo dishare, yang muncul bukan cuma teks URL doang. Judul, deskripsi, gambar, semua bisa lo atur biar lebih menarik dilihat.

Cara kerjanya simpel. Lo taruh tag kayak gini di bagian `<head>` HTML lo:

```html
<meta property="og:title" content="Resep Bakso Super Kenyal" />
<meta property="og:description" content="Rahasia bikin bakso yang kenyalnya luar biasa." />
<meta property="og:image" content="https://example.com/images/bakso.jpg" />
<meta property="og:url" content="https://example.com/resep/bakso-kenyal" />
```

Nanti, begitu link lo dibuka di WhatsApp, Facebook, Twitter, LinkedIn—mereka bakal otomatis nampilin preview yang lebih rapi dan informatif.

Kenapa ini penting?
Selain bikin link lo kelihatan lebih “niat”, OG juga bikin orang lebih penasaran buat ngeklik. Ini nambahin peluang engagement, bikin link lo lebih profesional, dan bantu naikin citra brand atau personal branding lo.

Ada beberapa hal yang penting buat diperhatiin:
Judul dan deskripsi jangan kepanjangan. Judul sekitar 60 karakter, deskripsi 110–150 karakter udah cukup padat dan menarik. Gambar juga usahain proporsional, biasanya ukuran 1200x630px udah pas di kebanyakan platform medsos. Jangan sampe filenya kegedean, biar waktu share link, previewnya cepet muncul.

Kalau mau lebih lengkap, Twitter juga punya standar sendiri—`twitter:card`, `twitter:title`, `twitter:description`, `twitter:image`—yang bisa lo tambahin biar previewnya nggak berantakan.

Satu hal yang suka dilupain: selalu cek preview sebelum lo publish. Tools kayak Facebook Sharing Debugger dan Twitter Card Validator itu ngebantu lo banget. Tinggal masukin link lo, terus lo bisa liat tampilan previewnya udah bener apa belum.

Lo bisa dalemin lagi lewat beberapa referensi kayak situs resmi [Open Graph Protocol](https://ogp.me/), dokumentasi di [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta), atau tools yang udah disediain sama Facebook dan Twitter.

Open Graph ini emang kesannya sepele, tapi dampaknya gede banget. Bukan cuma soal tampil keren, tapi juga soal kredibilitas dan profesionalitas lo di mata orang lain. Link lo jadi lebih “ngomong”, dan orang lain lebih yakin buat ngeklik.