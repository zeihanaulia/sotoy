
Loop AI yang membaca data dari sumber eksternal (GitHub issues, web, Slack) secara otomatis mewarisi *attack surface* dari sumber tersebut. Setiap input eksternal adalah potensi *injection point* yang bisa memanipulasi instruksi agent.

Keamanan loop tidak bisa hanya mengandalkan "prompt yang kuat", tetapi harus menggunakan arsitektur keamanan: permission minimal, sandbox eksekusi, dan approval boundary untuk aksi yang berdampak tinggi.

Relasi: [[notes.ai-agents.loop-engineering]]
