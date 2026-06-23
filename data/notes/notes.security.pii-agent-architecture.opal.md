
## Problem
Opal mengangkat dua masalah utama untuk personal AI memory: trusted hardware tidak cukup skalabel untuk menyimpan memori panjang, dan untrusted cloud storage, walaupun terenkripsi, masih bisa bocor lewat access pattern. Artinya, personal AI yang menyimpan catatan pengguna berisiko membocorkan data bukan hanya lewat konten tetapi juga melalui pola retrieval.

## Solution
Solusi Opal adalah memisahkan data-dependent reasoning ke dalam trusted enclave, sementara bulk personal data disimpan di untrusted disk melalui ORAM. Penulis menyatakan: "decouple all data-dependent reasoning from the bulk of personal data, confining it to the trusted enclave. Untrusted disk then sees only fixed, oblivious memory accesses." Sistem ini memakai dua ORAM on-disk untuk embedding dan raw chunks, sementara enclave menangani query, reindexing, dan capacity management.

## Real case implementation
Dalam implementasinya, personal assistant menyimpan memori pengguna di cloud yang tidak dipercaya, namun hanya mengirim akses ORAM fixed-size ke disk. Pertanyaan seperti "tampilkan catatan rapat terakhir" diproses di enclave yang memiliki knowledge graph ringan, sehingga informasi sensitif tidak pernah keluar secara langsung. Ini cocok untuk use case personal AI yang menyimpan email, note, dan conversation history.

## Relevance
Opal relevan untuk desain agent yang perlu mengenali user-supplied PII dalam memori. Pendekatannya mengajarkan bahwa private memory harus melindungi konten sekaligus access pattern, sedangkan request ke model cloud hanya boleh membawa representasi aman.

Original paper: https://arxiv.org/abs/2604.02522

Link: [[notes.security.pii-agent-architecture]]
