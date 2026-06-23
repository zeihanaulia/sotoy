
Link: https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/

Given a 1-indexed array of integers numbers that is **already sorted in non-decreasing order**, find two numbers such that they add up to a specific target number. Let these two numbers be `numbers[index1]` and `numbers[index2]`where `1 <= index1 < index2 <= numbers.length`.

Return the indices of the two numbers, `index1` and `index2`, **added by one** as an integer array `[index1, index2]` of length 2.

The tests are generated such that there is *exactly one solution*. You may not use the same element twice.

Your solution must use only constant extra space.

Example 1:

```
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
```

Example 2:

```
Input: numbers = [2,3,4], target = 6
Output: [1,3]
Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
```

Example 3:

```
Input: numbers = [-1,0], target = -1
Output: [1,2]
Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].
```

Constraints:

- 2 <= numbers.length <= 3 * 104
- -1000 <= numbers[i] <= 1000
- numbers is sorted in non-decreasing order.
- -1000 <= target <= 1000
- The tests are generated such that there is exactly one solution.


## Solusi

Caranya masih sama seperti [[til.coding.two-sum]], tapi di deskripsi ada tambahan `added by one as an integer array [index1, index2] of length 2.` Jadi pada sat return kita tambahin 1. Langsung aja ke solusi maps ya, karen sama. Jadi gini:

### Maps

Golang punya hash table. Jadi bisa juga dimanfaatkan untuk menyimpan hasil dari pengurangan. logikanya

1. bikin variable hash
2. looping nums [2,7,11,15]
3. iterasi 1: x = 0, nums[x] = 2, check apakah target - nums[x] ada didalam hash atau tidak
4. tidak ada, masukan "nums[x], x" kedalam hash map, jadi [2,0]
5. iterasi 2: x = 1,nums[x] = 7, check apakah target - nums[x] ada didalam hash atau tidak
6. ada, target - 7 = 2. value dari 2 adalah 0
7. return value dari hash map yaitu 0, dan x yaitu 1, jadi []int{0+1,1+1}

Hasilnya [esekusinya](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/submissions/1578506826/). Runtime 0ms dan Memory 8.09 MB. Dicoba esekusi dengan [brute force](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/submissions/1578513843/), Runtime 312ms dan Memory 7.82 MB. 

### Two Pointer

Karena di deskripsi ada clue **already sorted in non-decreasing order**, Ada teknik lain yang bisa digunakan, yaitu two pointer. Ini bisa menurunkan memory.

Dengan menggunakan 2 pointer, lo bisa menggerakan kedua index, index dari kiri dan dari kanan. 

```bash
Index:  0   1   2   3
        ┌───┬───┬───┬───┐
nums =  │ 1 │ 5 │ 5 │ 7 │
        └───┴───┴───┴───┘
         ↑           ↑
        left        right
```

Soal two sum cocok menggunakan solusi ini. Tapi check array apakah sudah terurut atau belum kalau belum `sort` dulu aja. Logikannya gini:

1. Inisiasi two pointer, `left = 1`, `right = len(nums)-1`
2. Look sampai `left < right`. Jika kondisi sudah sampai sini, artinya semua kemungkinan sudah di check.
   1. Jika kondisi `sum == target`, Maka ini jawaban yang kita akan return
   2.  Jika kondisi `sum < target`, Maka kita perlu angka yang lebih besar, jadi kita geser yang kiri `left++`
   3.  Jika kondisi `sum > target`, Maka kira perlu angka yang lebih kecil, jadi kita geser yang kanan `right--`

### Dry Run

nums = [2, 7, 11, 15]
target = 9

| Iteration | left | right | nums[left] | nums[right] | sum | Pergeseran |
|-----------|------|-------|-----------|------------|-------|------------|
|    1      |  0   |   3   |     2     |     15     |  17 | 17 > 9, geser kanan |
|    2      |  0   |   2   |     2     |     11     |  15 | 15 > 9, geser kanan |
|    3      |  0   |   1   |     2     |      7     |   9 | 9 == 9, return [left, right] |

---

nums = [3,2,3]
target = 6

| Iteration | left | right | nums[left] | nums[right] | sum | Pergeseran |
|-----------|------|-------|-----------|------------|-----|------------|
|    1      |  0   |   2   |     3     |      3     |   6 | 6 == 6, return [left, right] |

---

nums = [3,2,4]
target = 6

| Iteration | left | right | nums[left] | nums[right] | sum | Pergeseran |
|-----------|------|-------|-----------|------------|-----|------------|
|    1      |  0   |   2   |     3     |      4     |   7 | 7 > 6, geser kanan |
|    2      |  0   |   1   |     3     |      2     |   5 | 5 < 6, geser kiri |
|    3      |  1   |   2   |     2     |      4     |   6 | 6 == 6, return [left, right] |

Hasil [esekusinya](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/submissions/1578516728/), runtime di 0ms dan memory ada di 7.94 MB.