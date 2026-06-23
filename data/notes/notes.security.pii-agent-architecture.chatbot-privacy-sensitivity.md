
## Problem
Paper ini menemukan bahwa chatbot modern masih sering mengalirkan kembali PII dari prompt. Di aplikasi healthcare, personal assistant, dan hiring, model menerima data sensitif sebagai contoh atau record, dan output dapat mengembalikan informasi tersebut secara verbatim.

## Solution
Studi ini memperkenalkan konsep `Input Regurgitation` dan `Prompt-Induced Sanitization`. Input regurgitation mengukur seberapa sering model menyalin kembali PII. Prompt-induced sanitization mengukur apakah instruksi privasi dalam prompt dapat memaksa model untuk membersihkan output.

## Real case implementation
Implementasi nyata untuk agent adalah menempatkan sanitization di awal pipeline dan menggunakan prompt privacy hanya sebagai lapisan tambahan. Jika model digunakan untuk merangkum atau memproses dokumen sensitif, sistem harus memfilter input terlebih dahulu dan tidak bergantung pada model untuk menyingkirkan PII.

## Relevance
Temuan ini menegaskan bahwa fallback output sanitization bukanlah strategi privacy utama. Untuk user-supplied PII, desain agent terbaik adalah meminimalkan exposure input sejak awal, dengan prompt-induced sanitization sebagai penguat tambahan.

Original paper: https://arxiv.org/abs/2305.15008

Link: [[notes.security.pii-agent-architecture]]
