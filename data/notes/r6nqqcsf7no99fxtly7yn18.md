
Apa itu sliding window. Ini adalah teknik algoritma yang digunakan untuk mengjitung sesuatu secara berkelanjutan pada subarray atau substring yang berukuran tetap atau dinamis dalam sebuah array atau string.

Pake gambar biar muda bayanginnya. Bagaimana menjumlahkan setiap 3 angka dari subarray. Teukan jumlah paling besarnya.

![alt text](assets/til.coding.1-technique.sliding-window/image.png)

Berdasarkan gambar di atas, Logikanya berarti gimana caranya bisa jumlahin angka

- 1, 2, 6 = 9
- 2, 6, 2 = 10
- 6, 2, 4 = 12
- 2, 4, 1 = 7

Jadi logikannya gini


```go

func findMax(arr []int, k int) int {

	// Mengambil panjang array
	n := len(arr)

	// Cek apakah panjang array kurang dari k
	if n < k {
		return 0
	}

	sum := 0

	// Hitung jumlah awal dari subarray pertama dengan panjang k
	for i := 0; i < k; i++ {
		sum += arr[i]
        // Debugging
		fmt.Printf("Sum iterasi %v: Tambah: %v, Sum Sekarang: %v \n", i, arr[i], sum)
	}

	// Set nilai maksimum sebagai sum pertama
	max := sum

	// Geser jendela ke kanan satu per satu
	for i := k; i < n; i++ {
		// Kurangi elemen paling kiri dari jendela sebelumnya dan tambah elemen baru di kanan
		sum = sum - arr[i-k] + arr[i]

		// Debugging: Cetak elemen yang keluar dan masuk serta jumlah saat ini
		fmt.Println("Buang:", arr[i-k], "Tambah:", arr[i], "Sum Sekarang:", sum)

		// Perbarui max jika jumlah saat ini lebih besar
		if max < sum {
			max = sum
		}
	}

	// Kembalikan jumlah maksimum yang ditemukan
	return max
}

```

## Referensi

- https://www.geeksforgeeks.org/window-sliding-technique/