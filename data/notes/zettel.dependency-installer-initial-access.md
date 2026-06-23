
Install dependency seperti `npm install`, `pnpm install`, atau `pip install` dapat mengeksekusi lifecycle script dan hook yang jahat. Itu membuat installer dependency menjadi vector initial access, bukan sekadar cara mengambil paket.

Jika payload juga menulis file persistence di `.claude/` atau `.vscode/`, maka host atau repo dapat tetap terinfeksi setelah dependency itu dihapus.
