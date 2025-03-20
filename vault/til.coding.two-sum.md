---
id: k49ys33x1rdlqhb78830u7b
title: Two Sum
desc: ''
updated: 1742346484606
created: 1742318794356
---

Given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to `target`.
You may assume that each input would have **exactly one solution**, and you may not use the same element twice.
You can return the answer in any order.

Example 1:

Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

Example 2:

Input: nums = [3,2,4], target = 6
Output: [1,2]

Example 3:

Input: nums = [3,3], target = 6
Output: [0,1]
 
Constraints:

2 <= nums.length <= 104
-109 <= nums[i] <= 109
-109 <= target <= 109
Only one valid answer exists.
 

Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?


### Solusi

### Brute force

Soalnya mudah di mengerti, gue udah tau kalau maksudnya adalah cari index yang jika di jumlah = target. Jadi bisa ambil approach seperti ini.

1. Bikin variable arr berupa array
2. Looping `nums`
3. Value dari index iterasi akan dikurangi oleh target lalu disimpan di variable.
4. jika nums = [2,7,11,15], maka 9 - 2 = 7, simpan di dalam variable arr {7,}.
5. lalu lanjut ke iterasi selanjutnya, cari apakah ada 7 didalam variable arr, jika ada ambil indexnya maka return index dalam variable arr 0 dan index iterari yaitu 1. return [0, 1]


Hasilnya [eksekusinya](https://leetcode.com/problems/two-sum/submissions/1578248970/), runtime 31ms dan Memory 5.73 MB.

### Maps

Golang punya hash table. Jadi bisa juga dimanfaatkan untuk menyimpan hasil dari pengurangan. logikanya

1. bikin variable hash
2. looping nums [2,7,11,15]
3. iterasi 1: x = 0, nums[x] = 2, check apakah target - nums[x] ada didalam hash atau tidak
4. tidak ada, masukan "nums[x], x" kedalam hash map, jadi [2,0]
5. iterasi 2: x = 1,nums[x] = 7, check apakah target - nums[x] ada didalam hash atau tidak
6. ada, target - 7 = 2. value dari 2 adalah 0
7. return value dari hash map yaitu 0, dan x yaitu 1, jadi []int{0,1}

Hasil [esekusinya](https://leetcode.com/problems/two-sum/submissions/1578286649/), runtime 0ms dan memory 5.91. Ada kenaikan 3.14% memory tapi mempercepat runtime dari 31ms ke 0ms 100% improvement. Kenaikan adalah dampak dari penambahan data key value dari maps.



