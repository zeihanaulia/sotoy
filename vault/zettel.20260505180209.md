---
id: zettel.20260505180209
title: "Copilot billing berubah dari message budget ke compute/token budget"
desc: "Peralihan Copilot ke AI Credits membuat penggunaan lebih mirip API compute daripada flat chat subscription."
updated: 1777985390759
created: 1777983816959
tags:
  - zettel
  - copilot
  - billing
  - economics
---

Perubahan billing GitHub Copilot dari premium request units ke GitHub AI Credits mengubah cara kita menghitung biaya.

Sekarang biaya bergantung pada total token input, output, dan cached, bukan hanya jumlah pesan pengguna.

Artinya, agentic workflow panjang harus diperlakukan sebagai compute job, bukan sebagai chat interaction sederhana.
