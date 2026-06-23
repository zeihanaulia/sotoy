
Gue menemukan bahwa masalah utama ketika `qwen2.5-coder:7b` terasa stuck lewat GitHub Copilot adalah overhead agent, bukan model lokal yang gagal.

Penyebabnya biasanya:

- system prompt dan tool schema besar,
- repo context dan chat history yang luas,
- agent protocol / tool-call format,
- metadata file / domain rules.

Artinya, jika prompt sederhana seperti "hi" masih memicu ~12k token internal, maka performance bottleneck ada pada wrapper/harness dan bukan pada model 7B itu sendiri.

Konsekuensinya: untuk memperbaiki local coding agent, fokuskan audit pada agent harness dan context packaging sebelum ganti model.
