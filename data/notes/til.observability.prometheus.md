
## Apa itu Prometheus

### Cara kerja prometheus

## Apa itu PromQL

PromQL(Prometheus Query Language) adalah functional query yang disediakan oleh prometheus agar user dapat melakukan query ke data yang telah disimpan secara real-time dan melakukan segala macam analisis, aggregation dan operasi.

Untuk memahami promql ada baiknya kita mengetahui dulu tipe data yang disimpan, yaitu time-series data.

### Apa itu time-series data

Time-series data didefinisikan sebagai seraikaian data yang diurutkan berdasarkan waktu.
Misalnya, Kalau lo mau mengukur penggunaan CPU, data yang akan dikumpulkan akan seperti ini.

| Timestamp     | CPU Utilization (%) |
|---------------|---------------------|
| 1591709873808 | 67                  |
| 1591709884270 | 68                  |

Di Prometheus, time-series object dibuat pada setiap metrik yang mau dimonitor dan setiap object itu unik diidentifikasi dengan nama metric yang berisi key-value.
Yang mana key berisi timestamp dan value adalah nilai yang mau diukur. Setiap key-value disebut dengan istilah "Sample".
Selain itu prometheus membrikan kemampuan untuk menambahkan label untuk memperkaya data atribut pada metrics.
Misalnya, Kalau lo mau mengukur berapa banyak request pada suatu endpoint, lo bisa membuat satu metrics `http_request_duration_seconds_count`.
lalu lo tambahkan label untuk memperinci diendpoint mana, jadi `http_request_duration_seconds_count{job="order-service", path="POST_/dispatch"}`.
Dengan memperkaya data, lo bisa dengan mudah melakukan filter ketika melakukan monitoring aplikasi lo.

### Selectors

Ada beberapa cara untuk melakukan selecting data. 

#### Select Metric

#### Filter by Label

Setelah selecting metrics kita bisa melakukan filter berdasarkan label, ada beberapa operator dasar yang bisa kita gunakan

| Description                                                                                                    | example                                                   |
|----------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
| ambil data dengan value "heap"                                                                                 | jvm_memory_bytes_used {area="heap"}                       |
| ambil data dengan value tidak sama dengan "heap"                                                               | jvm_memory_bytes_used {area!="heap"}                      |
| cari data pada label job dengan value berisi 'fed'                                                             | jvm_memory_bytes_used {job=~"fed.+"}                      |
| cari selain data pada label job dengan value berisi 'fed'                                                      | jvm_memory_bytes_used {job!~"fed.+"}                      |
| cari data pada label job dengan value berisi awalan 'f' atau 'j'                                               | jvm_memory_bytes_used {job=~"f.+\|j.+"}                   |
| cari data pada label area dengan value berisi 'heap' atau 'nonheap'                                            | jvm_memory_bytes_used {area=~"heap\|nonheap"}             |
| cari data pada label area dengan value berisi 'heap' atau 'nonheap' dan pada label job dengan awalan huruf 'j' | jvm_memory_bytes_used {area=~"heap\|nonheap", job=~'j.+'} |

#### Select to return range vectors

Selain dasar query tersebut, lo juga bisa mengembalikan nilai sample untuk setiap time series yang bebeda.
lo bisa menambahkan '[10m]' diakhir label, misalnya jvm_memory_bytes_used {area="heap"}[10m] artinya kita akan mengambil data dari query dalam rentang waktu 10 menit.
selain menit kita juga bisa 

- s: seconds
- m: minutes
- h: hours
- d: days
- w: weeks
- y: years

#### Select past/historical data

Kalau sebelumnya kita bisa mengambil data berdasarkan range, kita bisa juga melakukan mengambil data yang sudah lalu. misal

`jvm_memory_bytes_used Offset 7d`

