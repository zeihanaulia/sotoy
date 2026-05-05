---
applyTo: "vault/**/*.md"
description: "Instruksi untuk menangani permintaan hands-on: buat file handson baru dari topik notes sebelumnya, lalu jadikan tutorial dengan POV orang pertama."
---

## Hands-on rule

Jika user secara eksplisit meminta "hands on" atau praktik langsung, anggap ini sebagai permintaan untuk membuat artefak praktik, bukan hanya ringkasan atau referensi.

### Ketika user minta hands-on

- Pilih topik notes yang sudah ada atau topik yang relevan dengan konteks permintaan.
- Buat file baru di namespace `notes.*.handson.*`.
- Isi file dengan format tutorial/praktik yang jelas, step-by-step, dan berfokus pada bagaimana melakukan sesuatu.
- Tulis dengan POV orang pertama: "gue", "lo", dan jelaskan proses seolah gue sedang cerita pengalaman atau guide langsung.
- Pastikan konten hands-on memakai contoh, langkah nyata, dan alasan kenapa langkah itu dilakukan.
- Jangan cuma ulangi konsep umum. Hands-on harus praktis dan executable sebanyak mungkin.

### Struktur minimal hands-on

- Pendahuluan singkat: jelaskan konteks dan tujuan praktis.
- Langkah-langkah: uraikan urutan kerja yang realistis.
- Tips / jebakan: beri highlight pada risiko, batasan, atau troubleshooting.
- Referensi langsung: kalau relevan, link ke catatan awal atau sumber yang mendasari topik.

### Kapan jangan gunakan hands-on

- Jika permintaan hanya berupa ringkasan teori, definisi, atau diskusi konseptual.
- Jika sumbernya bersifat umum dan belum ada aplikasi praktis yang jelas.
- Jika user hanya meminta "reference" atau "summary", gunakan Notes / Handbook / Daily sesuai kategori.
