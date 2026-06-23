
## Inti penjelasan
Pertanyaan kedua dari paper CAMP adalah: apa yang baru dari CPE?

Jawaban pendeknya: CPE memindahkan privacy risk dari level single message ke level session. Dalam agentic conversation, bukan cuma satu pesan yang penting; yang penting adalah akumulasi dan kombinasi entitas PII sepanjang percakapan.

## Unit analisis yang berubah
Per-turn masker bertanya:
- "Apakah pesan ini mengandung PII?"

CPE bertanya:
- "Setelah semua pesan sejauh ini digabung, apakah percakapan ini sudah membentuk profil yang bisa mengidentifikasi user?"

Itu adalah perubahan cara pandang utama.

## Struktur CPE
CPE digarap dengan tiga komponen utama.

### 1. Entity type
Pertama, sistem mengkategorikan PII berdasarkan jenisnya: Person, Location, Organization, Email, Phone, DOB, SSN, Medical Condition, Salary, dan seterusnya.

### 2. Base sensitivity weight
Kedua, setiap entity type diberi bobot sensitivitas dasar. Contoh bobot dalam paper:
- SSN / credit card: 1.0
- DOB: 0.9
- Medical condition: 0.85
- Email: 0.8
- Phone: 0.75
- Person / Salary: 0.6
- Location / IP: 0.5
- Organization: 0.3

Bobot ini menjawab: "seberapa sensitif entity ini ketika berdiri sendiri?"

### 3. Co-occurrence graph
Ketiga, CPE membangun graph dari entity types yang muncul bersama dalam session.
- node = tipe entity
- edge = dua tipe entity muncul bersama dalam session

Graph ini memungkinkan CPE menangkap kombinasi risiko.
Entity yang muncul sendirian memiliki degree rendah. Entity yang muncul bersama banyak entity lain punya degree tinggi, sehingga kontribusinya meningkat.

## Bagaimana amplifier bekerja
Paper memakai amplifier berbasis degree node:

f(v) = 1 + α × deg(v)

- `f(v)` adalah faktor peningkat untuk node `v`
- `deg(v)` adalah jumlah koneksi node itu di graph
- `α` adalah parameter yang mengatur seberapa agresif kombinasi menaikkan risiko

Kalau `α = 0.3` dan sebuah node punya degree 3, amplifier-nya menjadi 1.9. Dengan kata lain, entity itu hampir dua kali lipat lebih berbahaya karena ia muncul dalam kombinasi yang kaya.

## CPE sebagai skor
CPE dihitung sebagai total bobot entity setelah diamplifikasi:

CPE(t) = Σ_v w(v) × (1 + α × deg(v))

- `w(v)` = base sensitivity weight entity `v`
- `deg(v)` = seberapa banyak entity `v` terkoneksi dengan entity lain
- `CPE(t)` = skor cumulative exposure pada turn ke-`t`

## Mengapa ini bukan sekadar "daftar PII"
Kalau sistem hanya mencatat jenis entity, ia hanya punya daftar. CPE lebih dari itu karena ia memberi skor pada akumulasi dan kombinasi.

- Base weight menjawab "bagaimana sensitif entity ini sendirian?"
- Co-occurrence graph menjawab "bagaimana entity ini jadi lebih berbahaya ketika digabung dengan entity lain?"
- CPE menggabungkan keduanya.

## Contoh kenaikan non-linear
Bayangkan percakapan bertahap:
- Turn 1: Person saja -> CPE rendah
- Turn 2: tambah Location -> CPE tumbuh lebih dari jumlah sederhana
- Turn 3: tambah Organization -> CPE tumbuh lagi karena semua node sekarang punya degree lebih tinggi

Ini penting: CPE tidak bertambah linear seperti penjumlahan bobot; ia bisa tumbuh superlinear karena kombinasi antar entity.

## Batasan CPE
CPE terlihat matematis, tetapi banyak komponennya masih heuristic.

### 1. Bobot entity tetap subjektif
Nilai sensitivitas entity seperti Person = 0.6 atau Organization = 0.3 adalah keputusan desain, bukan hasil eksperimen teruji panjang.

### 2. Edge amplifier masih sederhana
Degree-based amplifier memperlakukan semua co-occurrence sebagai sama. Padahal tidak semua kombinasi entity sama bahayanya.

### 3. Nilai spesifik entity tidak dihitung
CPE paper fokus pada tipe entity, bukan uniqueness atau rarity dari nilai actual. "Location=Jakarta" dan "Location=Dusun kecil X" diperlakukan sama di level tipe.

### 4. Implicit inference belum tertangkap
CPE naik hanya jika extractor mendeteksi PII. Kalau user memberikan clue implisit—misalnya "kantor super-app ijo"—ekstraktor mungkin tidak menangkapnya, tapi model/adversary masih bisa menebak.

### 5. Threshold masih knob manual
Paper mencoba τ = 1.5, 2.0, 2.5, tetapi belum memberi cara sistematis untuk memilih threshold yang valid di domain nyata.

## Kenapa CPE masih penting
Meski belum sempurna, CPE punya nilai sebagai engineering pattern. Ia membawa perhatian ke dua hal yang sering dilupakan:
- privacy risk adalah properti session, bukan message,
- kombinasi entitas dapat menaikkan risiko lebih besar daripada jumlah entitas.

Dengan cara ini, CPE memperkenalkan mekanisme trigger policy untuk retroactive intervention, bukan sekadar detection.

## Related notes
- [[notes.security.pii-agent-architecture.camp]]
- [[notes.security.pii-agent-architecture.camp.per-turn-masking]]
- [[notes.security.pii-agent-architecture]]
