
Secret exposure bukan cuma soal token yang ke-commit ke Git. Secret juga bisa bocor karena tool lokal, shell history, editor extension, atau build script yang membaca atau mengirim secret dari workstation.

Artinya, pemeriksaan keamanan harus mencakup scanning repo dan audit trust boundary lokal.

Hubungkan ide ini dengan:
- [[notes.security.overtrust]]
- [[notes.security.agentic-coding-permission-boundary]]
