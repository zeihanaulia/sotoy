
Dari studi workflow ini, saya dapat bahwa agent AI seharusnya tidak langsung mengubah kode dari ticket. Workflow yang sehat mirip pabrik: intake → canonical backlog → grooming → fix queue → isolated execution → verifier terpisah → publish → reconcile.

Yang membuatnya aman adalah rantai evidence. Kalau patch dibuat, hasilnya harus diverifikasi secara independen dan dicatat dengan run ID, diff, test output, dan final status.

Kalau salah satu rantai ini putus, sistem seharusnya berhenti atau kembali ke manusia. Itu perbedaan antara automation yang tahan dan automation yang rapuh.
