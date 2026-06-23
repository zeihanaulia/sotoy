
Gue sekarang menyarankan pendekatan tranisi yang lebih aman: install OrbStack dulu, pakai context switch, lalu uninstall Docker Desktop hanya jika OrbStack sudah terbukti cocok.

OrbStack dan Docker Desktop menggunakan Docker context system yang sama, jadi lo bisa switch antara backend tanpa kehilangan akses CLI. Ini memberi fallback yang berguna selama fase awal.

Dari pengalaman gue, ini lebih baik daripada langsung uninstall Docker Desktop, terutama kalau lo masih butuh tes kompatibilitas atau ingin rollback cepat.
