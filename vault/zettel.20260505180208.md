---
id: zettel.20260505180208
title: "Mac M1 16GB realistis untuk local coding agent, tapi 30B bukan daily driver"
desc: "Target model lokal yang masuk akal untuk Mac M1 16GB adalah 7B–14B, bukan 30B sebagai default."
updated: 1777985390751
created: 1777983816916
tags:
  - zettel
  - mac
  - llm
  - hardware
---

Berdasarkan eksperimen lokal, Mac M1 16GB paling realistis jalan dengan model `qwen2.5-coder:7b` sebagai baseline dan `qwen2.5-coder:14b` sebagai benchmark pendek.

Model 30B seperti `qwen3-coder:30b` terlalu berat untuk dijadikan daily driver di platform ini karena rentan swap dan memory pressure.

Jadi kategori "SML" untuk coding personal di M1 16GB sebaiknya difokuskan pada model yang bisa berjalan tanpa swap dan masih menyisakan ruang untuk VS Code/browser.
