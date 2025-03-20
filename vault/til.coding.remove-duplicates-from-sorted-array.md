---
id: 3vy0eya1ih1ovj9csi7xwnu
title: Remove Duplicates from Sorted Array
desc: ''
updated: 1742351949317
created: 1742346679252
---

Given an integer array nums sorted in **non-decreasing order**, remove the duplicates [in-place(https://en.wikipedia.org/wiki/In-place_algorithm)] such that each unique element appears only **once**. The **relative order** of the elements should be kept the same. Then return the number of unique elements in nums.

Consider the number of unique elements of nums to be k, to get accepted, you need to do the following things:

Change the array nums such that the first k elements of nums contain the unique elements in the order they were present in nums initially. The remaining elements of nums are not important as well as the size of nums.
Return k.
Custom Judge:

The judge will test your solution with the following code:

> int[] nums = [...]; // Input array
> int[] expectedNums = [...]; // The expected answer with correct length
>
> int k = removeDuplicates(nums); // Calls your implementation
>
> assert k == expectedNums.length;
> for (int i = 0; i < k; i++) {
>     assert nums[i] == expectedNums[i];
> }

If all assertions pass, then your solution will be **accepted**.

Example 1:

Input: nums = [1,1,2]
Output: 2, nums = [1,2,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).

Example 2:

Input: nums = [0,0,1,1,1,2,2,3,3,4]
Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).
 

Constraints:

1 <= nums.length <= 3 * 104
-100 <= nums[i] <= 100
nums is sorted in non-decreasing order.



## Memahami problemnya

1. Pelajari constraintnya

- `1 <= nums.length <= 3 * 104` = lengthnya bisa sampai 30rb digit, artinya kalau pake brute force ini bakalan lama banget
- `-100 <= nums[i] <= 100` = setiap angka dalam array berisi -100 sampai 100.
- `nums is sorted in non-decreasing order`. Array sudah diurutkan dalam [non-decreasing order](https://stackoverflow.com/questions/1963474/is-a-non-decreasing-sequence-increasing) artinya urutannya terus naik, 1-2-3-4 dant tidak menurun, tapi memungkinkan duplicate 1-1-1-2-3-4-4-4.


2. Cek narasi dari soalnya

- Sorted in **non-decreasing order** = karena dia sudah terurut jadi bisa nih pake two pointer buat remove duplicatenya.
- Remove the duplicates [in-place(https://en.wikipedia.org/wiki/In-place_algorithm)] = berarti gak boleh bikin array baru, tapi ubah aja array nums.
- each unique element appears only **once** = jadi hasilnya setiap angka cuma muncul sekali
- The **relative order** of the elements should be kept the same = pastikan urutan arraynya harus sama jangan diubah dan gak boleh di sort ulang.
- Then return the number of unique elements in nums. =  hasilnya jumlah dari nilai uniknya (k), dan gak perlu hapus nilai (k).

3.Check examle

Example 1:

```bash
Input: nums = [1,1,2]
Output: 2, nums = [1,2,_]
```

- Duplikat angka 1 dihapus
- Lalu array tetap dalam urutan yang sama
- Outputnya jumlah element unit yaitu k = 2

Example 2:

```bash
Input: nums = [0,0,1,1,1,2,2,3,3,4]
Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
```

- Semua yang duplikat dihapus
- Urutan angkanya tetap sama
- Outputnya k = 5
- Bagian setelah k tidak dibiarkan, artinya jika di len size tetap sama


## Solusi

Dari pemahaman soal kita sudah tau, bakal pake two pointer.
Kita tau data sorted kiri lebih kecil dari kanan tapi bisa sama, jadi kita akan cata perubahan yang tidak samanya saja karena kita mau cari keunikannya. jadi kalau ada array [1,1,2], kita geser terus ke kiri, jadi [1,2,2] karena jika ada perbedaan antara nums[left] != nums[right] maka nums[left] = nums[right] dan left kita tambah, jadi indexnya akan maju.
Jadi logikanya gini

1. Definisikan `left=0`
2. Looping dengan kondisi `right=1; right < len(nums); right++` 
   2.1. Jika `nums[left] != nums[right]` maka nums[left] = nums[right] dan tambahkan nlai `left++` 
3. Return left + 1