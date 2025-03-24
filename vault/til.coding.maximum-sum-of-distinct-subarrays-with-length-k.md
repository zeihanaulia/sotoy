---
id: eo4tsx2lyb5ek8fdofer98q
title: Maximum Sum of Distinct Subarrays with Length K
desc: ''
updated: 1742788580503
created: 1742443701789
---

You are given an integer array nums and an integer k. Find the maximum subarray sum of all the subarrays of nums that meet the following conditions:

- The length of the subarray is k, and
- All the elements of the subarray are **distinct**.

Return the maximum subarray sum of all the subarrays that meet the conditions. If no subarray meets the conditions, return 0.

A **subarray** is a contiguous non-empty sequence of elements within an array.

 
**Example 1:**

Input: nums = [1,5,4,2,9,9,9], k = 3
Output: 15
Explanation: The subarrays of nums with length 3 are:
- [1,5,4] which meets the requirements and has a sum of 10.
- [5,4,2] which meets the requirements and has a sum of 11.
- [4,2,9] which meets the requirements and has a sum of 15.
- [2,9,9] which does not meet the requirements because the element 9 is repeated.
- [9,9,9] which does not meet the requirements because the element 9 is repeated.
We return 15 because it is the maximum subarray sum of all the subarrays that meet the conditions

**Example 2:**

Input: nums = [4,4,4], k = 3
Output: 0
Explanation: The subarrays of nums with length 3 are:
- [4,4,4] which does not meet the requirements because the element 4 is repeated.
We return 0 because no subarrays meet the conditions.
 

**Constraints:**

- 1 <= k <= nums.length <= 10^5
- 1 <= nums[i] <= 10^5

## Memahami soal

### 1. Constraints

- `1 <= k <= nums.length <= 10^5` isi dari `k` dari 1 - 100k
- `1 <= nums[i] <= 10^5` jumlah nums bisa sampai 100k

Tidak ada problem yang signifikan. Bisa mulai dari brute force.

### 2. Memahami clue

- `sum of all the subarrays of nums` Jumlahkan array 
- `The length of the subarray is k` berdasarkan `k` 
- `All the elements of the subarray are distinct.` Semua element adalah distinct, jadi tidak ada angka yang duplicate. Artinya perlu dibersihkan dulu atau perlu di check apakah dari sub array ada angka yang sama atau tidak.
- `Return the maximum subarray sum of all the subarrays that meet the conditions` cari maksimal sum dari subarray tersebut.
- `A subarray is a contiguous non-empty sequence of elements within an array.` subarray tidak boleh kosong dan harus berurutan, urutannya harus sama kaya aslinya

### 3. Melihat Example

**1. Example 1:**

> Input: nums = [1,5,4,2,9,9,9], k = 3
> 
> Output: 15
> 
> Explanation: The subarrays of nums with length 3 are:
> - [1,5,4] which meets the requirements and has a sum of 10.
> - [5,4,2] which meets the requirements and has a sum of 11.
> - [4,2,9] which meets the requirements and has a sum of 15.
> - [2,9,9] which does not meet the requirements because the element 9 is repeated.
> - [9,9,9] which does not meet the requirements because the element 9 is repeated.
> We return 15 because it is the maximum subarray sum of all the subarrays that meet the conditions

Dari example 1,kita bisa lihat array yang mau dijumlahkan adalah 3, maka pecah dari array dan ambil per 3 element. Sampai disini kepikiran buat di slice, kaya gini misalnya `arr[1:3]`.
Di pecah menjadi 3 sub array, lalu cek apakah dalam array ada nomor yang sama atau tidak.
Jika ada maka skip.

Example 2:

> Input: nums = [4,4,4], k = 3
> Output: 0
> Explanation: The subarrays of nums with length 3 are:
> - [4,4,4] which does not meet the requirements because the element 4 is repeated.
> We return 0 because no subarrays meet the conditions.

Dari sini kita bisa tau, kalau ada angka yang sama langsung return 0 aja.


## Solusi

### Brute Force

Kita bagi jadi 2 iterasi

1. Prepare SubArray
   1. Definisikan dulu `[][]int{}`
   2. Looping nums dengan kondisi `for i:=0; i < len(nums); i++`
   3. Masukan angka dalam nums sesuai dengan `k` jadi `subarray = append(subarray, nums[i:k+i])`
2. Sum Subarray dengan kondisi
   1. Looping SubArray jika ada angka yang sama, maka skip
   2. Jika tidak sama, maka hitung.

Percobaan peratama gagal nih, kena time limit di leetcode. Karena ngecek satu satu. Kita pelajari teknik baru, Yaitu sliding window


### Sliding Window

1. Jika `k` lebih besar dari array `n`, langsung return `0`
2. Inisialisasi Variable:
   1. `maxSum`: ini akan digunakan untuk menyimpan nilai maksimum dari semua subarray valid dengan tipe (int64)
   2. `currentSum`: Menyimpan jumlah elemen dalam window saat ini dengan tipe (int64)
   3. `left`: Pointer kiri /batas awal window dengan tipe (int)
   4. `seen`: Digunakan untuk tracking element unik dengan tipe `make(map[int]bool)`
3. Sliding window dengan Two Pounter
   1. Check Duplikat
      1. Selama elemen `nums[right]` sudah ada dalam set
         1. Buang elemen paling kiri nums[left] dari window
         2. Kurangi `currentSum` dengan nilai `nums[left]`
         3. Geser `left` pointer ke kanan `left++`
   2. Tambahin elemen ke window
      1. Masukin `nums[right]` ke dalam set
      2. Tambahin `nums[right]` ke currentSum
   3. Check Panjang Window
      1. Jika panjang window sama dengan `k`
         1. Update `maxSum` jika `currentSum` lebih besar
         2. Buang elemen paling kiri dengan elemen `nums[left]`
         3. Kurangi `sum` dengan elemen `nums[left]`
4. Return `maxSum`