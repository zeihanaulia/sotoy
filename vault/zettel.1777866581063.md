---
id: zettel.1777866581063
title: "Runtime web automation khusus menukar kompatibilitas luas dengan efisiensi fokus"
desc: "Runtime web automation yang ringan bisa efektif untuk subset use case, tetapi bukan pengganti browser lengkap untuk semua halaman modern."
updated: 1777866581063
created: 1777866581063
tags:
  - zettel
  - browser-automation
  - runtime
  - tradeoff
---

Obscura terasa seperti bukti konsep bahwa web automation bisa dipangkas jadi runtime kecil dan cepat, tapi harga yang dibayar adalah ruang lingkup yang lebih sempit.

Kalau dilihat secara praktis, ini bukan klaim "pengganti Chrome". Ini klaim "pengganti browser lengkap untuk use case tertentu":

- startup cepat dan footprint rendah cocok untuk sesi singkat atau banyak instance.
- stealth dan patch fingerprint bisa membantu di permukaan browser.
- tapi hal-hal seperti eksekusi JavaScript kompleks, WebAssembly berat, dan kompatibilitas web modern tetap berisiko lebih tinggi dibanding browser full stack.

Inti yang layak diingat:

- runtime khusus bisa jadi pilihan yang bagus untuk scraping/automation terkontrol dengan target halaman yang tidak terlalu agresif.
- efisiensi semacam itu hanya masuk akal jika use case sudah jelas dan batasannya dikelola.
- kalau tujuannya adalah "bisa jalan di semua halaman web seperti browser normal", maka runtime ringan biasanya bukan jawaban.

Batasannya membuatnya lebih cocok sebagai alat khusus, bukan platform pengganti. Itu penting karena membedakan hype dari nilai praktis.
