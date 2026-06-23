
## Inti Pemikiran

Allen Holub menekankan bahwa AI coding agents seharusnya menjadi **akselerator engineering**, bukan pengganti proses engineering itu sendiri. Kesalahan fatal banyak developer saat ini adalah menganggap "AI maksimal" berarti menyerahkan desain fitur besar ke agent dan menerima tumpukan kode yang terlalu luas untuk dipahami.

Menurut Allen, produktivitas bukan diukur dari volume output kode, tapi dari seberapa cepat sebuah *story* selesai dengan kualitas tinggi dan kompleksitas yang terkendali.

## Strategi Implementasi "Waras"

Untuk menjaga kontrol dan kualitas, Allen menerapkan beberapa prinsip utama:

### 1. Kerja Incremental & Small Batches
Alih-alih memberikan prompt besar untuk membangun seluruh fitur, Allen memecah pekerjaan menjadi batch kecil dan *vertical slice* yang tipis.
- **Tujuan**: Menghindari *comprehension debt* dan memudahkan review.
- **Metode**: Membangun potongan kecil end-to-end yang memiliki nilai domain nyata, bukan membangun layer horizontal secara masif.

### 2. Human-Led Architecture
AI tidak boleh menjadi arsitek utama. Engineer tetap memegang kendali penuh atas:
- Struktur besar sistem.
- Definisi API dan messaging.
- Boundary antar komponen.
- Cara komponen masuk ke dalam sistem.

AI digunakan untuk mengimplementasikan komponen kecil di dalam boundary yang sudah ditentukan oleh manusia.

### 3. Arsitektur sebagai Guardrail
Arsitektur yang koheren adalah guardrail terbaik bagi AI. Dengan boundary yang jelas, AI lebih sulit merusak bagian lain dari codebase.
- **Pola yang disarankan**: DDD nested aggregates/entities, message-based components, dan hardened perimeters.
- **Efek**: AI bekerja di dalam "kotak" dengan interface yang jelas.

### 4. Test sebagai Kontrak Manusia (Anti-Self-Justification)
Ini adalah poin paling krusial. Allen **tidak membiarkan AI menulis test**.
- **Alasannya**: AI cenderung menulis test yang membenarkan kode salah yang dibuatnya sendiri (*self-justification*), atau hanya mengetes detail implementasi kecil, bukan behavior domain.
- **Pola TDD**: Manusia menulis test terlebih dahulu $\rightarrow$ AI diminta membuat kode yang harus pass test tersebut.
- **Prinsip**: Yang menulis kode tidak boleh sekaligus menentukan bukti bahwa kodenya benar.

## Kritik terhadap "Agent Swarm" dan Output Volume

Allen mengkritik tren "parallel swarm" (menjalankan banyak agent paralel) sebagai upaya perusahaan AI untuk membakar token tanpa menghasilkan output yang benar-benar berguna.
- **Cognitive Load**: Terlalu banyak agent paralel meningkatkan beban kognitif dan context switching.
- **Mental Model**: Menghasilkan terlalu banyak kode sekaligus merusak mental model engineer terhadap sistemnya sendiri.

## Sintesis dengan Loop Engineering

Jika *Loop Engineering* (Addy Osmani/Matt Van Horn) fokus pada desain sistem, feedback, dan orkestrasi, maka pendekatan Allen Holub adalah **syarat disiplin** agar loop tersebut tidak menjadi mesin penghasil sampah.

| Dimensi | Loop Engineering (Sistem) | Allen Holub (Disiplin) |
|---|---|---|
| **Fokus** | Orkestrasi, Feedback, Memory | Arsitektur, Test, Boundary |
| **Tujuan** | Otomasi & Leverage | Kualitas & Understanding |
| **Risiko** | Comprehension Debt | Under-utilization of AI |
| **Sintesis** | Loop boleh jalan, tapi arsitektur dan test harus tetap dipegang manusia. | |

## Referensi
- Thread X: https://x.com/allenholub/status/2064743466693751082
