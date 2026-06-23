
Untuk local LLM pada Mac M1 16GB, bukan ukuran model saja yang menentukan kinerja. Kalau memory pressure sudah memaksa swap, inference bisa melambat drastis.

Gejala yang gue lihat:

- RAM di angka 14.7GB dan swap 6.8GB,
- latency lokal naik dari detik ke menit,
- model kecil seperti `qwen2.5-coder:7b` bisa terasa stuck.

Simpulannya: optimalkan penggunaan RAM dan hindari swap sebelum menukar model atau meningkatkan GPU.
