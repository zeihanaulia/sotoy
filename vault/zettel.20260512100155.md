---
id: zettel.20260512100155
title: "OrbStack dan Docker Desktop bisa coexist selama migrasi"
desc: "Saya menemukan bahwa transisi ke OrbStack paling aman dilakukan dengan coexistence, bukan uninstall langsung." 
updated: 1778604764492
created: 1778604148169
tags:
  - zettel
  - docker
  - orbstack
  - macos
---

Gue sekarang menyarankan pendekatan tranisi yang lebih aman: install OrbStack dulu, pakai context switch, lalu uninstall Docker Desktop hanya jika OrbStack sudah terbukti cocok.

OrbStack dan Docker Desktop menggunakan Docker context system yang sama, jadi lo bisa switch antara backend tanpa kehilangan akses CLI. Ini memberi fallback yang berguna selama fase awal.

Dari pengalaman gue, ini lebih baik daripada langsung uninstall Docker Desktop, terutama kalau lo masih butuh tes kompatibilitas atau ingin rollback cepat.
