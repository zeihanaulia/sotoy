
`pull_request_target` berjalan di konteks base repo, bukan di konteks fork contributor. Jika workflow tersebut checkout hasil merge PR dan menjalankan build/install PR code, maka trigger trusted bisa menjadi jalur eksekusi untuk code untrusted.

Ini membuat PR takeover mungkin sebelum merge: attacker membuka PR dari fork, trusted workflow jalan, dan PR dapat memengaruhi pipeline resmi secara langsung. Ini adalah bentuk "pwn request".
