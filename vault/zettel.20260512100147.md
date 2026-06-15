---
id: zettel.20260512100147
title: "Self-host model 400B untuk kantor biasa sering bukan pilihan yang layak"
desc: "Pengalaman menunjukkan investasi self-host model besar hanya masuk akal ketika inference compute adalah core business." 
updated: 1778604764488
created: 1778604126428
tags:
  - zettel
  - ai
  - self-host
  - strategy
---

Dari sudut pandang gue, kantor biasa yang butuh internal productivity assistant bukan tipe organisasi yang seharusnya mulai dengan self-host model 400B. Investasinya bukan cuma GPU; itu capex, opex, power, cooling, networking, security, observability, capacity planning, dan on-call.

Yang gue tangkap dari diskusi ini adalah bahwa keputusan self-host harus dilandasi oleh volume dan alasan bisnis yang jelas: inference cost masuk ke margin produk, atau data governance benar-benar memaksa. Kalau tujuan utama cuma internal workflow, API-first jauh lebih realistis.

Kalau lo masih menimbang 40 GPU untuk 5 concurrent coding agents, itu sinyal bahwa model besar dijadikan solusi infrastruktur, bukan solusi produk. Dalam konteks vLLM/LiteLLM yang raw dan mudah crash, angka 40 GPU bukan cuma soal kemampuan GPU; itu juga soal apakah stack admission control, pool isolation, dan retry logic sudah ada. Dengan situasi seperti yang kita bahas, 40 GPU untuk 5 session sering kali terlalu ambisius karena runtime bisa kalah jauh dari jumlah GPU.

Itu biasanya tanda keputusan sudah melewati batas ROI yang sehat, apalagi kalau infrastruktur self-host belum punya lapisan produksi yang sama seperti hosted provider.
