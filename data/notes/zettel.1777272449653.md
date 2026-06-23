
## Ide inti

Dengan membaca respons server sebagai `ReadableStream`, frontend bisa menerima dan merender output LLM sedikit demi sedikit saat server masih menghasilkannya. Ini mengubah respons HTTP dari "payload final" menjadi "alur data progresif".

## Penjelasan

Quote ini penting karena dia menunjukkan momen ketika tiga hal akhirnya ketemu:

- model menghasilkan output secara bertahap,
- server meneruskan output itu sebagai stream,
- browser membaca respons secara progresif.

Dalam cara lama, developer sering menganggap request web seperti:

1. kirim request,
2. tunggu sampai selesai,
3. terima seluruh respons,
4. baru proses dan render.

Untuk LLM, pola itu terasa jelek karena model sendiri bekerja token/chunk by chunk. Di sinilah `ReadableStream` jadi jembatan teknis: browser tidak lagi pasif menunggu paket akhir, melainkan aktif mengonsumsi data sepotong demi sepotong.

## Quote baseline

> The fetch function allows you to call your server and read its response as a ReadableStream.

## Catatan teknis

Dalam praktiknya, alur kliennya kira-kira seperti ini:

- `fetch(url)` ke server aplikasi,
- ambil `response.body`,
- gunakan `getReader()` atau `TextDecoderStream`,
- baca chunk secara berulang,
- append teks ke UI setiap kali chunk tersedia.

Itu juga mempertegas titik penting quote: bukan "call the model directly" tapi "call your server." Artinya pola arsitektur yang sehat biasanya tetap:

browser → your server → provider/model

Server tetap bertugas menyimpan API key, merakit prompt, filtering, logging, dan mengirim response stream kembali ke client.

## Implikasi

`ReadableStream` mengubah mental model HTTP untuk AI app dari batch-thinking ke stream-thinking. Ini cocok banget untuk text generation karena setiap chunk teks masih punya nilai parsial dan bisa langsung tampil.

UI yang terasa hidup di AI app bukan sekadar efek kosmetik; ia berdiri di atas primitive platform browser, kontrak server, dan strategi rendering progresif.

## Sumber

- Chapter 2
- [[zettel.literature.the-developers-guide-to-ai]]
- [[book-summaries.the-developers-guide-to-ai]]
