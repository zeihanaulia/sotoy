---
id: idf3tarmf7z2bvtid79a0b3
title: Package Explanation
desc: ''
updated: 1746616252103
created: 1746616241368
---

# Penamaan Package Java & Spring Boot: Kenapa Harus Seribet Itu?

Kalau lo datang dari dunia Go atau Node.js yang cenderung simple dan flat, struktur package Java kelihatan ribet banget. Kenapa mesti ada `id.mycompany.adm` segala? Kenapa gak cukup `app`, `service`, atau `main` aja?

Nah, ini gue jelasin secara naratif dan pakai logika, bukan sekadar ikut-ikutan best practice.

## Package Itu Bukan Sekadar Folder

Di Java, package itu bukan cuma struktur folder buat nyimpan file `.java`. Package itu juga berfungsi sebagai namespace yang ngatur akses antar class, dan jadi identitas unik suatu bagian dari aplikasi lo.

Jadi kalau lo punya class `UserService` di dua tempat berbeda, misalnya:

* `id.mycompany.billing.UserService`
* `id.mycompany.userprofile.UserService`

Itu sah-sah aja karena beda package. Gak bakal bentrok. Java compiler tahu mana yang mana. Di Go, namespace biasanya ngikut dari import path (misal: `github.com/myorg/userprofile/service`), dan konsepnya mirip walaupun lebih fleksibel.

## Kenapa Harus "id.mycompany"?

Nama package di Java umumnya pakai domain perusahaan dalam bentuk terbalik (`reverse domain name`). Jadi kalau domain lo `mycompany.id`, lo tulis `id.mycompany`.

Kenapa dibalik? Karena di dunia Java, ini udah jadi cara umum buat bikin namespace yang unik. Google misalnya pakai `com.google`, Apache pakai `org.apache`, Spring pakai `org.springframework`, dan seterusnya.

Tujuannya biar gak bentrok. Bayangin semua orang pakai `app.service` — kacau nanti kalau semua library campur di satu project.

## Tambahan Modul di Akhir

Setelah `id.mycompany`, lo tambahin nama aplikasi atau modulnya. Misalnya `adm` buat `ADMInfoHandlerWrapper`. Jadi lengkapnya:

```
id.mycompany.adm
```

Kalau mau lebih rapi, lo bisa strukturin lagi kayak:

```
id.mycompany.adm.controller
id.mycompany.adm.service
id.mycompany.adm.repository
```

Mirip banget sama layered architecture yang dipakai di mana-mana: controller buat HTTP layer, service buat business logic, repository buat database access.

## Tapi Gue Cuma Pake Buat Service Kecil, Emang Perlu?

Kalau lo lagi nulis microservice kecil buat internal, dan yakin itu gak bakal digabung ke sistem besar, ya boleh aja lo flatten semua jadi satu package: `app` misalnya. Spring Boot gak bakal ngambek.

Tapi kalau lo main di monorepo, enterprise system, atau ngembangin open source lib, pake struktur `id.mycompany.module` itu penting banget. Framework kayak Spring Boot juga scan komponen berdasarkan package. Jadi kalau lo nyebar bean lo ke package yang gak kerelasi sama root package, Spring bisa gak nemu komponen lo. Trust me, itu pain point yang umum banget di project Java.

## Kesimpulan

Penamaan package `id.mycompany.adm` itu bukan buat gaya-gayaan. Itu cara Java ngebuat struktur yang scalable, traceable, dan gak bentrok kalau proyek lo makin besar. Lo boleh aja mulai dari yang simple, tapi seiring waktu lo bakal ngerasa sendiri kenapa struktur itu jadi penting. Beda konteks, beda kebutuhan.

Kalau lo mau ngulik lebih dalam soal konvensi ini, ini beberapa referensi yang bisa lo baca:

* [Oracle Java Package Naming Guide](https://docs.oracle.com/javase/tutorial/java/package/namingpkgs.html)
* [Structuring Code in Spring Boot](https://docs.spring.io/spring-boot/reference/using/structuring-your-code.html)
* [Baeldung: Java Packages](https://www.baeldung.com/java-packages)