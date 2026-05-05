---
id: til.copilot.usage-based-billing
title: "Copilot Pro tetap $10/bulan, tapi billingnya pindah ke AI Credits/token"
desc: "Perubahan GitHub Copilot Pro 1 Juni 2026 adalah unit billing dari premium requests ke token-based credits, bukan kenaikan harga langganan." 
tags:
  - til
  - copilot
  - github
  - ai-billing
created: 1777981824408
updated: 1777982315000
---

Copilot Pro masih $10/bulan, tapi model billingnya berubah dari premium request units ke GitHub AI Credits yang dihitung berdasarkan token (input, output, cached).

GitHub menegaskan 1 AI Credit = $0.01, jadi $10 Copilot Pro = 1.000 AI Credits.

Contoh model dari docs:
- GPT-5 mini: input $0.25 / 1M token, output $2.00 / 1M token, cached input $0.025 / 1M token.
- Claude Sonnet 4.6: input $3.00 / 1M token, output $15.00 / 1M token, cached input $0.30 / 1M token, cache write $3.75 / 1M token.

Dengan 10.000 input token dan 2.000 output token:
- GPT-5 mini kira-kira 0,65 credit.
- Claude Sonnet 4.6 kira-kira 6 credit.

Jadi perbedaan model bukan hanya 0x/0.25x vs 1x lagi; sekarang harga bergantung pada jenis token, panjang konteks, dan output.

Raptor mini tercatat di docs dengan pricing yang mirip GPT-5 mini. Itu artinya model ini lebih murah per token, jadi siapa pun yang sudah biasa pakai Raptor relatif lebih aman dibanding yang sering pakai model premium.

Di old UI, Raptor mini 0x bisa terasa "free" karena tidak mengurangi jatah premium/request secara kasat mata. Itu bukan berarti compute-nya gratis: sekarang di sistem AI Credits, setiap token input/output/cached tetap dihitung.

Thread Theo menegaskan pergeseran ini: flat/message-based billing lama bisa menyembunyikan cost besar ketika satu message memicu agent loop yang membawa konteks besar. Dalam billing baru, unitnya harusnya token, bukan sekadar message.
Namun angka seperti 59.726 tks di debug panel kemungkinan adalah ukuran context per model step, bukan total tagihan final. Jika agent menjalankan banyak langkah dengan konteks 40k–60k token per step, total token bisa cepat menumpuk.

Tapi ingat: long-running task tetap bisa berbiaya tinggi kalau total token input/output/cached-nya besar. Jadi hematnya bukan karena "agent gratis", tapi karena "model rate rendah".

Code completions dan next edit suggestions tetap unlimited untuk semua paid Copilot plans; yang kena credit adalah chat/agentic interaction dan fitur token-heavy.

Untuk annual plan yang masih berjalan, multiplier lama masih berlaku sampai masa annual habis. Setelah itu, pengguna akan pindah ke usage-based billing atau ke Copilot Free.
