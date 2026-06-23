
TIL: trusted publishing di konteks npm berarti OIDC + Sigstore + provenance attestation untuk memverifikasi identitas dan workflow CI saat publish. Itu jawaban untuk "percaya siapa yang publish", bukan "percaya bahwa publish itu dilakukan dengan kontrol yang aman."

Kasus Axios/OpenAI menunjukkan bahwa kalau attacker berhasil mengambil alih maintainer atau session, provenance bisa tetap valid sementara intent/kontrol sudah hilang.

Intinya:
- authenticity = rilis datang dari jalur resmi
- agency = publisher masih mengendalikan proses secara sah

Provenance hanya kuat terhadap pemalsuan origin. Ia lemah terhadap kompromi identitas asli dan social engineering.
