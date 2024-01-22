
### Basic Configuration
  
```
{
    "endpoints": [
        {
            "endpoint": "/rbac",
            "input_headers":[
                "*"
            ],
            "output_encoding": "no-op",
            "backend": [
                {
                    "host": [ "https://iam.example.com" ],
                    "url_pattern": "/rbac"
                }
            ]
        },
    ]
}
```

snipet diatas adalah endpoint konfigurasi tempat dimana kita mendefinisikan seluruh endpoint yang ada pada service kita.
field `endpoint` adalah path yang akan diakses, kekurangan dari krakend community adalah dia tidak bisa wildcard.
Karena tidak bisa wildcard kita perlu ada generator untuk mengenerate seluruh endpoint yang ada dan disesuaikan dengan configurasi krakend.
lalu field `input_headers` kita isi dengan "*" jika kita ingin meneruskan header dari api gateway ke service upstream.
field "output_encoding" dengan value "no-op" perlu ditambahkan, jika tidak krakend secara default akan memanipulasi response yang krakend terima.
problem yang dirasakan jika tanpa `"output_encoding": "no-op"` adalah jika service upstream terkena error atau response code selain 200, krakend akan mengembalikan 500.
terakhir ada field `backend` kenapa field ini array of object, karena krakend dapat digunakan sebagai backend for front-end, sehingga kita bisa mengembalikan response dari beberapa endpoint berbeda.
didalam object `backend` kita define `host` menunjukan dimana service yang dituju dan `url_pattern` yang menunjukan path apa yang mau diakses.