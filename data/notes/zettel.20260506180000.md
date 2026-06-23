
`verify.sh` bukan sensor otomatis. Ia adalah single verification entrypoint: satu command stabil yang menjalankan check yang sudah disiapkan tim.

Karena itu:
- kalau `verify.sh` hanya berisi `lint`, `typecheck`, dan `test`, ia tidak akan otomatis menemukan N+1.
- ia hanya akan mendeteksi N+1 jika sensor N+1 sudah ditambahkan ke dalamnya, seperti Semgrep rule, query-count regression test, atau runtime query profiler.

Intinya: `verify.sh` membuat definition of done executable, bukan membuat definition of done sendiri.

Related: [[notes.agentic-engineering.single-verification-entrypoint]]
