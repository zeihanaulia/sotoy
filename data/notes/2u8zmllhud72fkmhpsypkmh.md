
Jadi gini cuy, lo pernah nggak sih lagi nulis kode terus lo mikir,
“Ini kolom cuma buat admin doang, yang lain jangan dikasih lihat.”
Tapi lo juga males nulis `if (isAdmin) columns.push(...)` karena ya… jelek aja dilihat.

Nah, di saat-saat kayak gitu, muncullah satu teknik yang kalau kata gue: underrated tapi power banget. Namanya **Conditional Spread**.

---

### Latar Belakang: Spread Biasa

Sebelum masuk ke versi kondisional, mari kita bahas dulu spread yang umum. Misalnya lo punya array tambahan:

```js
const extra = [4, 5];
const angka = [1, 2, 3, ...extra];
```

Gampang kan? `...extra` langsung ngelebarin array `[4, 5]` ke array utama.

Atau kalau lo main object:

```js
const defaultUser = { name: "Anon" };
const fullUser = { ...defaultUser, age: 30 };
```

Gak ada yang aneh. Ini basic-nya spread.

---

### Masuk ke Kasus Nyata: Kolom Table

Sekarang lo punya sebuah UI table, isinya kolom-kolom buat nampilin data service yang udah diparse. Ada kolom `name`, `filename`, `created_at`, dan satu kolom spesial: `prompt`.

Masalahnya, `prompt` ini confidential. Lo gak mau semua orang lihat, apalagi kalau user-nya bukan admin.
Jadi gimana caranya lo tetep bisa nulis array kolom secara rapi, tapi **kondisional**?

Kalau pake cara klasik:

```js
const columns = [
  { accessorKey: "name", header: "Name" },
  { accessorKey: "filename", header: "File" },
];

if (isAdmin) {
  columns.push({ accessorKey: "prompt", header: "Prompt" });
}
```

Ya bisa. Tapi lama-lama kolom lo makin banyak, kondisi makin kompleks, `if` berserakan, array mutasi di mana-mana. Gak enak.

---

### Di sinilah Conditional Spread Datang Menyelamatkan

Dengan satu line:

```js
const columns = [
  { accessorKey: "name", header: "Name" },
  { accessorKey: "filename", header: "File" },
  ...(isAdmin ? [{ accessorKey: "prompt", header: "Prompt" }] : []),
];
```

Lo udah nyelesaiin dua masalah sekaligus:

1. Nambahin kolom prompt cuma kalau admin
2. Tetep nulis array secara deklaratif, gak pake `push`

Lihat bagian `...(isAdmin ? [promptColumn] : [])`
Artinya simpel: **kalau lo admin**, tambahin kolom `prompt`. Kalau enggak, spread array kosong `[]` — yang artinya gak ngaruh apa-apa.

---

### Bukan Cuma Array, Bisa Juga di Object

Lo bisa pake trick yang sama buat object. Misalnya lo punya object user dan lo pengen nambahin property `badge` kalau user-nya premium:

```js
const user = {
  name: "Zeihan",
  ...(isPremium && { badge: "gold" }),
};
```

Kenapa ini works? Karena di JS:

* `false && {}` → hasilnya `false`, jadi `...false` gak nambah apa-apa
* `true && { badge: "gold" }` → hasilnya object, jadi `...{ badge: "gold" }` disebar

Jadi lo bisa punya object yang isinya nambah atau nggak nambah tergantung kondisi. Mirip kayak di Go lo lagi manggil fungsi variadic, tapi sebelum dipass-in lo punya `if` yang nentuin param mana yang masuk.

---

### Kapan Teknik Ini Berguna?

* Lagi bikin config `columns`, `tabs`, `routes`, `menu`, `props`
* Lo pengen hasil akhir yang rapi, clean, dan gak pakai mutasi array
* Lo pengen maintain logic access atau permission tanpa if-else berderet
* Lo ngoding pake framework declarative kayak React, Svelte, atau Vue

Di project gue, teknik ini jadi senjata utama buat nyusun UI yang kontekstual — berubah tergantung siapa user-nya, role-nya, atau setting-nya.

---

### Catatan Tambahan

Ada satu hal yang bikin ini makin enak: **nggak perlu bikin array baru di luar**. Lo langsung inject logika ke tempat di mana lo bangun array-nya.

Kalau lo mau makin modular, lo bisa ekstrak jadi fungsi `getDynamicColumns(isAdmin)` atau bahkan bikin `usePermission()` biar `canViewPrompt` tinggal dipakai di mana-mana.

Dan yang paling penting, syntax ini bikin lo keliatan pinter pas code review — padahal yang lo lakuin cuma spread ternary.

---
