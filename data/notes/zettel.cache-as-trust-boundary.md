
Cache dalam CI tidak semata-mata accelerasi. Jika cache restore mempengaruhi execution path workflow resmi, maka isi cache adalah bagian dari trust boundary.

Cache poisoning dapat menyalurkan payload dari PR untrusted ke workflow main yang trusted, menjadikan cache sebuah kendaraan eksekusi lintas boundary.
