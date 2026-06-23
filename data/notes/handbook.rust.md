

## Setup

- untuk install rust cukup mudah, cukup pakai `rustup`
- kalau install satu persatu pastikan `gcc` terinstall, lalu install `rustc` dan `cargo`
- cargo adalah dependency management, bukan hanya itu cargo juga bisa dipakai untuk build dan run program rust
  - `cargo new` untuk membuat project
  - `cargo build` untuk build program rust dan akan membuat file executable di `target/debug`
  - `cargo run` untuk build dan running program rust, tapi cargo tidak akan melakukan rebuild jika tidak ada program yang berubah
  - `cargo check` untuk mngecek code dan memastikan code bisa di compile tapi gak memproduce file executable
    - command ini bermanfaat untuk mengecek secara cepat dibandingkan melakukan `build`
  - `cargo build --release` untuk melakukan release ketika program sudah selesai.
    - command ini akan melakukan optimisasi dan akan membuat executable file di `target/release`
- lalu apa bedanya `rustc` dan `cargo`
  - untuk program yang simple cargo tidak jauh berbeda dengan rustc, tapi ketika kita membuat project yang banyak dependency ini akan sangat membantu

## Coding

- untuk membuat variable gunakan `let`
- by default variable di rust itu immutable, 
  - artinya ketika kita sudah memberikan nilai ke valu maka value tidak bisa diubah
- untuk membuat variable menjadi mutable, gunakan `mut` sebelum variable name

```rust
let apples = 5; // immutable
let mut bananas = 5; // mutable
```

- untuk `associated function` gunakan `::`
  - kalau di golang pake `.` String.new() kalau dirust String::new()
- untuk melakukan import dengan menggunakan keyword `use` di awal program
  - sebagai contoh `std::io`, memiliki `stdin()`, didalamnya ada `read_line`
    - maka penggunaannya `io::stdin().read_line(&mut guess).exepect("Failed to read line")`
- tanda `&` mengindikasikan kalau ini adalah reference
  - Reference yang tidak dapat diubah (&T): Ini memungkinkan Anda untuk membaca nilai tanpa mengubahnya.
  - Reference yang dapat diubah (&mut T): Ini memungkinkan Anda untuk mengubah nilai yang direferensikan.
- yang menarik dari sini, rust memaksa kita untuk memberikan result pada function stdin, melalui expect, `Result` ini bersifat enumeration `ok` dan `error`, jika error maka akan menampilak pesan yang ada pada kolom expect
- `crate` adalah collection dari source code rust,seperti go package
  - sebelum memulai menggunakan function yang ada di crate kita perlu menulis dependencies 
- carg memiliki mekanisme untuk memastikan kita bisa rebuild artifak yang sema setiap waktu
  - cargo akan menggunakan versi dari dependensi yang sudah di lock, menggunakan `cargo.lock`
- dalam penamaan variable rust mengizinkan untuk melakukan shadowing

  ```rust
    let mut guess = String::new();

    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");

    let guess: u32 = guess
        .trim()
        .parse()
        .expect("Please type a number!");
  ```

- code diatas diperbolehkan, ada 2 variale lalu variable tersebut diganti typenya dengan menggunakan expression `trim` dan `parse`
  - `guess` diambil dari variable guest pertama
  - lalu `trim()` method dari string akan mengeliminasi whitespace
  - lalu `parse()` yang melakukan convert string ke type lain
    - yang menariknya method parse ini hanya akan berkerja di character yang secara logika bisa di convert ke number
    - jadi kalau ada charakter selain number, maka akan terjadi error, maka dari itu diperlukan method `expect()`
- untuk error handling, rust menyediakan expression `match`, expression ini bisa digunakan untuk menagkap error.
  - jika sebelumnya `expect()` digunakan untuk menuliskan ekspektasi input, `match` bisa menangkapnya
  - fungsi `parse` memiliki result dan result pasti berisi `ok` dan `err`
  - `match` seperti `catch` dibahasa pemrograman lain
- variable
  - variable immutable by default
  - jika mau mutable tambahakan `mut`
  - variable itu scopenya local, tidak bisa digunakan diluar fn
  - rust tidak mengizinkan unused variable
- constant
  - memiliki cakupan statis, tidak dihapus dari memory selama program berjalan dan bisa diakses dari manasaja didalam module tempat constant itu dideklarasikan atau module lain jika public
  - nilai dari const harus ditentukan pada waktu kompilasi, jadi tidak bisa di set ketika program sudah berjalan atau selalu immutable
  - untuk penomoran rust menggunakan convention huruf besar dengan underscore contoh `THREE_HOURS_IN_SECONDS`
- shadowing
  - yang menarik dari shadowing adalah kita bisa mengubah value tanpa `mut`

```rust
fn main() {
    let x = 5;

    let x = x + 1;

    {
        let x = x * 2;
        println!("The value of x in the inner scope is: {x}");
    }

    println!("The value of x is: {x}");
}
```

- kode diatas bisa digunakan untuk mengubah nilai dari `x`, sebelumnya nilai `x` adalah 5, lalu `x` diubah menjadi `x + 1` yaitu 6, lalu `x` diubah kembali didalam inner scope `x * 6` yaitu 12, karena itu didalam scope maka tidak akan mengubah value yang ada di luar scope, jadi jika di print `x` yang diluar scope maka akan tetap `6`
- Data type
  - Scalar Types
    - integers
      - integer adalah number tanpa fractional component / tanpa pecahan
        - jadi integer adalah bilangan bulat
        - integer terdiri dari unsigned dan signed
          - signed: -1
          - unsgned: 1 (semua bilangan positif)

            | Length | Signed | Usigned |
            |--------|--------|---------|
            | 8-bit	|i8	|u8|
            | 16-bit|i16	|u16|
            | 32-bi|t|i32	|u32|
            | 64-bi|t|i64	|u64|
            | 128-b|it|i128	|u128|
            | arch	|isize	|usize|
        
        - arch ini maksudnya arsitektur dependent, tipedata ini karena ukurannya bergantuk pada arsitektur sistem yang digunakan 
    - floating-point numbers
    - booleans
    - characer
      - di rust charakter ada type berbeda, char dan string. 
        - char: Ini adalah tipe data untuk karakter tunggal. Di Rust, char selalu mewakili satu karakter Unicode Scalar Value, yang mungkin lebih luas daripada hanya ASCII. char didefinisikan menggunakan single quotes, seperti 'a', '1', atau '🎉'.
        - String atau &str: Ini adalah tipe data untuk string, yaitu urutan karakter. String adalah string yang dapat tumbuh, berubah, dan dimiliki, sementara &str adalah referensi ke string yang ada di tempat lain, biasanya tidak dapat diubah. String didefinisikan menggunakan double quotes, seperti "hello" atau "world".
  - Compound Types
    - tuples
      - tipe data komposit yang dapat mentimpan sekumpulan nilai dengan tipe berbeda. contoh
  
        ```rust
        fn main() {
            let tup = (500, 6.4, 1);

            let (x, y, z) = tup;

            println!("The value of y is: {y}");
            println!("The value of z is: {z}");
            println!("The value of x is: {x}");

            // index
            let x = tup.0;
            let y = tup.1;
            let z = tup.2;
                    
            println!("The value of y is: {y}");
            println!("The value of z is: {z}");
            println!("The value of x is: {x}");
        }
        ```
    - array
      - ini sama seperti array pada bahasa lain, tapi bedanya array gak bisa berbeda type
- Function
  - tidak ada yang berbeda sama seperti bahasa lain, bedanya return value di rust tidak perlu keyword return seperti golang `return`
- Control Flow
  - if expression
    - if expression bisa digunakan berbarengan dengan let
    
    ```rust
    fn main() {
        let condition = true;
        let number = if condition { 5 } else { 6 };

        println!("The value of number is: {number}");
    }
    ```
  - loops
    - loop
      - loop ini adalah basic looping dari rust, yang menariknya loop di sini bisa dibuat lable
        - loop label dimulai dengan single quote, contoh codenya
            
            ```rust
            fn main() {
                let mut count = 0;
                'counting_up: loop {
                    println!("count = {count}");
                    let mut remaining = 10;

                    loop {
                        println!("remaining = {remaining}");
                        if remaining == 9 {
                            break;
                        }
                        if count == 2 {
                            break 'counting_up;
                        }
                        remaining -= 1;
                    }

                    count += 1;
                }
            }
            ```
    - while
      - dengan while kita bisa menambahkan kondisi
      - kodisinya berupa true or false
    - for
