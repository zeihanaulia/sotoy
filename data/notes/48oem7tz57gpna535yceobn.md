

## Scaling to 100 million

Bagaimana memproses 100 juta request

### Allow for evolutionary architechture

Liat area yang kita fokuskan untuk mendapatkan kejelasan.
Ibaratnya seperti kaca mata, ketika tidak pakai kacamata maka terasa buram dan tidak jelas.
Ketika pakai kaca mata maka semuanya akan tampak jelas dan fokus.

Jadi bagaimana untuk memastikan system kita survive under the load operations.

### Weakest Link


- Disaster Recovert
- Multi Region
- Near Customer
- Canary
- Feature Toggle
- Multi Currency
- Multi Langugage
- Compliance
- Integration
- Data regulatory
- Expansion strategy
- Cost
- Service Availablity

### Bagaimana untuk achieve HA pada postgresql

Salah satu caranya adalah dengan Multi Availability Zone. Read replica gak akan memberikan HA. Kalau Multi Region digunakan ketika lo mau melakukan global deployment.
Misalnya coca cola dia punya US, canada dan eropa, agar databasenya HA mereka harus membuat database sharding untuk memisahkan data, lo gak perlu menggunakan database yang sama



### Bagaimana cara membuat resilient architechture

## Fail Point

Salah satu yang sangat penting, bagaimana kita mengumpulkan requirement.
Indentify requriement dan temukan paint point.
Apa yang akan kita fokuskan.
Lhat dari scalebiliy persepective

## Empathy Map
Setelah itu kita jadikan KPI key indicator performance
Lalu lo akan ke product manager dan satukan apa KPI engineer dengan mereka
Lalu cari tau lagi apa yang salah, apa yang berhasil dan terus cari permasalahannya
Apa issue yang kita hadapi dan cari learning dari tempat lain juga


## Microservice Issue

## Bulk Head

## Sharding

Bagaimana kita melakukan pembedaan dengar perbedaan customer

## Resilient Pattern

Apa pattern yang sudah kita miliki

## Caching

Apa saja yang bisa kita cache

## Failure Injection