
A phrase is a **palindrome** if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string s, return true if it is a **palindrome**, or false otherwise.

Example 1:

Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.
Example 2:

Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.
Example 3:

Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.
 

Constraints:

1 <= s.length <= 2 * 105
s consists only of printable ASCII characters.

## Memahami Problem

### 1. Constrains

- `1 <= s.length <= 2 * 10^5` lengthnya akalan sampe 200rb karakter
- `s consists only of printable ASCII characters.` string berisi ASCII character, jadi kemungkinan akan ada special charakter.

Dari sini gue dapet insight kalau harus remove dulu special karakter dan spasi. agar semuanya jadi alphanumeric jadi ada angka juga.

### 2. Memahami deskripsi soal

- `converting all uppercase letters into lowercase` convert dulu ke lowercase
- `removing all non-alphanumeric characters` hapus semua non-alphanumeric karakter
- `it reads the same forward and backward` kalau dibaca dari depan dan belakan terbaca sama

### 3. Memahami contoh

Example 1

```
Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.
```

setelah dihapus semua special character dan di lowercase dan terbaca sama dari depan dan belakang, maka ini disebut palindrome

Example 2

```
Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.
```

ini tidak terbaca sama dari depan dan belakang, maka ini bukan palindrome

Example 3

```
Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.
```

Kalau string kosong langsung aja return true

## Solusi

### Brute Force

1. Hapus spesial karakter
2. Ubah string jadi lower case
3. looping agar bisa dieja dari belakang dan masukan kedalam variable  `backward` dengan type []string
4. Join slice strings.Join(backward, "")
5. Check apakah sama jika dibaca forward dan backward

### Two Pointer

Kalau menggunakan two pointer, logikanya bisa gini

1. Definisikan `left = 0` dan `right = len(s) -`
2. Loop dengan kondisi `left < right`
   1. Loop dengan kondisi `left < righ && s[left]`, Jika bukan alphanumeric geser kiri, `left++`
   2. Loop dengan kondisi `left < righ && s[right]`, Jika bukan alphanumeric geser kanan, `right++`
   3. Jika `s[left]` lowercase tidak sama dengan `s[right]` maka return false
   4. Jika sama, geser kiri dan kanan
3. Jika loop selesai return true