
Gue menangkap bahwa transformasi penting di AI security review bukan sekadar "agent yang lebih pintar", tapi "sistem yang bisa menjalankan, mengumpulkan, menguji, dan men-triage output agent".

Dalam konteks `deepsec`, value proposition-nya lebih kuat ketika:
- ada sandbox untuk menjalankan agent secara terisolasi,
- ada parallelism untuk menguji banyak hipotesis sekaligus,
- ada traceability agar setiap finding bisa dilacak ke run/prompt/model tertentu,
- ada proses triage untuk memilah false positive dan menggabungkan duplicate.

Kalau hanya mengandalkan agent tunggal, maka hasilnya cenderung eksploratif dan berisik. Tanpa harness yang disiplin, output AI security review bisa berubah jadi tumpukan noise yang malah membebani maintainer.
