
Chapter 4 *The Joy of x* karya Steven Strogatz membahas hukum komutatif perkalian: `a × b = b × a`. Tapi bukan hafalan, dia kupas kenapa hukum ini tidak obvious, padahal dunia sehari-hari non-komutatif. Mulai dari PR anak, bahasa ambigu, repeated addition, array visual, aplikasi pajak/diskon, intuisi hidup, contoh gelap Gell-Mann, hingga fisika kuantum.

> Bab ini ajar jangan terima obvious tanpa bongkar; ganti representasi untuk pemahaman struktural; pisahkan matematika inti dari keribetan dunia nyata.

## Kenapa Judul “Commuting”?

“Commuting” dari commutative: urutan tidak ubah hasil. Judul juga nuansa tukar posisi, bertanya apa yang boleh bertukar tanpa ubah hasil.

## Lapisan Pertama: Kebingungan Bahasa

“Seven times three” ambigu: tujuh ditambah tiga kali, atau tiga ditambah tujuh kali? Definisi repeated addition buat komutatif belum obvious.

## Visualisasi: Repeated Addition sebagai Lompatan di Number Line

### 7 × 3: Tiga lompatan 7
```
0 ----7----14----21
```

### 3 × 7: Tujuh lompatan 3
```
0 --3--6--9--12--15--18--21
```
Proses beda, hasil sama. Komutatif terasa kejutan, bukan jelas.

## Representasi Kedua: Array Titik

### 7 × 3 sebagai 7 baris, 3 kolom
```
● ● ●
● ● ●
● ● ●
● ● ●
● ● ●
● ● ●
● ● ●
```
Putar jadi 3 baris, 7 kolom:
```
● ● ● ● ● ● ●
● ● ● ● ● ● ●
● ● ● ● ● ● ●
```
Objek sama, cuma diputar. Komutatif jadi konsekuensi simetri.

## Visualisasi Ketiga: Area Persegi Panjang

### 7 × 3 rectangle
```
+-------------+
|             |
|             | 3
|             |
+-------------+
      7
```
Diputar jadi 3 × 7:
```
+---+
|   |
|   |
|   |
|   |
|   |
|   |
|   |
+---+
  3 (tinggi 7)
```
Luas sama, orientasi ubah tapi isi tidak.

## Aplikasi Jeans: Diskon Dulu atau Pajak Dulu?

$50, diskon 20% (×0.80), pajak 8% (×1.08).

### Urutan A: Pajak dulu lalu diskon
50 × 1.08 × 0.80 = 54 × 0.80 = 43.2

### Urutan B: Diskon dulu lalu pajak
50 × 0.80 × 1.08 = 40 × 1.08 = 43.2

Hasil sama. Tunjukkan berpikir multiplikatif vs aditif.

## Beda Berpikir Aditif vs Multiplikatif

Aditif: tambah/kurang absolut. Multiplikatif: kali faktor relatif (persen). Pajak/diskon lebih natural multiplikatif.

## Non-Komutatif di Hidup Sehari-hari

Kaus kaki lalu sepatu ≠ sepatu lalu kaus kaki. Hidup latih intuisi urutan penting.

## Contoh Gell-Mann: Pergi ke MIT lalu Bunuh Diri

A = pergi ke MIT, B = bunuh diri. A lalu B ≠ B lalu A. Operasi hidup non-komutatif.

## Penutup: Fisika Kuantum Non-Komutatif

Posisi × momentum ≠ momentum × posisi. Fundamental; tanpa itu atom runtuh. Komutatif spesial di bilangan biasa.

## Peta Visual Seluruh Chapter

```
Repeated addition
7×3 = 7+7+7
3×7 = 3+3+3+3+3+3+3
-> hasil sama, tapi belum jelas

        ↓ ganti representasi

Array / rectangle
7 rows × 3 columns
3 rows × 7 columns
-> objek sama, diputar
-> komutatif terlihat

        ↓ aplikasikan

Tax and discount
×1.08 lalu ×0.80
atau ×0.80 lalu ×1.08
-> hasil sama

        ↓ contrast

Shoes and socks / life / quantum
A lalu B ≠ B lalu A
-> tidak semua commute
```

Alur: definisi → visualisasi → aplikasi → batas konsep.

## Sintesis Bab

Bab ini hidupkan heran komutatif: dari repeated addition tidak transparan, array buat jelas, aplikasi finansial, intuisi hidup non-komutatif, hingga quantum. Inti: kapan urutan boleh diabaikan, kapan segalanya?

Relasi:
- [Chapter 1 The Joy of x](zettel.literature.joy-of-x.chapter-1.fish-to-infinity.md) (abstraksi angka)
- [Chapter 2 The Joy of x](zettel.literature.joy-of-x.chapter-2.rock-groups.md) (struktur angka)
- [Chapter 3 The Joy of x](zettel.literature.joy-of-x.chapter-3.the-enemy-of-my-enemy.md) (perluasan ke negatif)
- [Chapter 5 The Joy of x](zettel.literature.joy-of-x.chapter-5.division-and-its-discontents.md) (perluasan ke pecahan)
- [Pedagogi Matematika Anak](zettel.20260418182808.md) (ajar perkalian ke anak)

Saran: Buat versi lebih visual lagi dengan diagram ASCII tambahan, atau lanjut Chapter 5.

Saran: Bedah beda berpikir aditif vs multiplikatif, atau lanjut Chapter 5.