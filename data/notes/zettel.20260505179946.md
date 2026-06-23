
Insight: Risiko utama di era agentic coding bukan hanya apakah kode punya bug, tetapi apakah lingkungan kerja developer memberi terlalu banyak trust kepada process, extension, dan config lokal yang dapat menyentuh credentials.

Karena banyak developer menjalankan tools dengan akses filesystem dan shell, keamanan workstation perlu dipindai sebagai trust boundary: siapa/apa yang dapat membaca `.env`, `~/.aws/credentials`, `~/.kube/config`, atau shell history, dan apakah agentic tool itu sendiri adalah jalur eksfiltrasi potensial.
