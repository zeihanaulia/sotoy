---
id: r5515u2ryjoe3fudyqdgmiy
title: Terraform
desc: ''
updated: 1749450108053
created: 1749443611598
---

## **1. Kenapa Lo Perlu Peduli Sama Infrastructure as Code (IaC)?**

---

### **2009: Era Klik-Klik Next Sampai Capek**

Gue inget banget waktu jaman kuliah lagi belajar deploy website di warnet.
Lu mesti buka cPanel, klik "File Manager", upload `index.html`, terus klik "Extract".
Kalau ada database, buka "phpMyAdmin", create database manual, terus import file `.sql`.

Dan yang paling ngeselin:

> “Eh, kok di komputer dengan xampp bisa jalan, tapi di server malah error?”

Tiap deploy ke production rasanya kayak lagi nge-gacha. Kadang sukses. Kadang... server-nya blank putih.

Kenapa? Karena semuanya **manual dan gak tercatat**. Nggak ada yang tau siapa yang ganti setting `php.ini`. Atau kenapa tiba-tiba `mod_rewrite` gak aktif. wkwkwkwk

---

### **2014: DevOps Naik Daun, Tapi Kayak Dewa yang Gak Boleh Sakit**

Masuk era cloud. AWS makin populer. EC2 jadi temen semua orang.
Tapi setup-nya masih sama: lo SSH ke server, ketik:

```bash
sudo apt install nginx
sudo systemctl start nginx
```

Dan lo tulis semua itu... di Notes. Atau di Ms. Word yang gak pernah dibuka lagi.

Sampai suatu hari, lo udah gak ikut projectnya lagi, terus temen lo nanya:

> “Eh, lo dulu waktu deploy app X pake nginx atau apache ya?”

Dan lo cuma bisa jawab:

> “Gue juga gak yakin, coba cek history bash aja.”

---

### **2016–2017: Ketemu Docker, Tapi Belum Tahu Sebenernya Lo Butuh Dia**

Di masa ini, lo mulai main Docker.
Awalnya karena penasaran: *“Ini apaan sih kok bisa jalanin app tanpa install macem-macem?”*

Lo build image, `docker run`, terus amazed:

> “Buset, ini MySQL tinggal jalan gitu doang.”

Tapi waktu itu lo masih mikir:

> “Docker ini kayak virtual machine versi mini ya?”
> Padahal nggak gitu juga. Tapi gak apa-apa, semua orang pernah salah paham dulu.

---

### **2018: Baru Ansible Mulai Masuk Obrolan**

Mulai sering diskusi soal automation, provisioning, dan config.
Ada yang bilang:

> “Pakai Ansible dong, gak perlu SSH satu-satu.”

Dan lo mulai coba.

Lo tulis playbook, lo SSH-in semua VM, dan berhasil. Tapi... lo ngerasa capek.

```yaml
- name: install nginx
  apt:
    name: nginx
    state: present
```

Lo mikir, “Lah ini bedanya apa sama bash script yang dibungkus doang?”

Ansible jalan, tapi verbose.
Buat satu hal kecil, lo nulis satu file panjang.
Dan lo harus mikir urutan — **prosedural banget** cuy.

---

### **2020: Infrastruktur Udah Jadi Makhluk Sendiri**

Satu project sekarang udah gak cukup pakai 1 server.
Minimal:

* 1 buat app
* 1 buat database
* 1 buat monitoring
* dan load balancer biar gak malu-maluin pas demo

Belum lagi security group, subnet, IP publik, volume, DNS, TLS, sertifikat, user, IAM, cloudwatch, metric.

Lo sadar sekarang:

> "Kita gak bisa lagi jalanin semua ini pake tangan. Harus pake **kode**."

---

### **Datanglah Terraform: Lo Nulis Kode, Tapi yang Jalanin Mesin**

Terus lo ketemu Terraform.
Lo nulis kayak gini:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-abc123"
  instance_type = "t2.micro"
}
```

Dan... **BOOM!**
Servernya muncul. Otomatis. Konsisten. Bisa diulang. Bisa dibalikin ke kondisi awal.

Lo bisa `terraform plan` buat liat perubahan
Lo bisa `terraform apply` buat beneran ngerubah
Dan kalau lo nyesel: `terraform destroy` aja. Kayak hubungan yang salah dari awal.

---

### **Hari Ini: Infrastruktur Lo Gak Boleh Jadi Mitos**

Tim lo makin banyak.
Lo kerja bareng orang lain.
Kalau semua setup masih ada di kepala lo, berarti lo bottleneck.
Kalau lo disuruh liburan dan takut production error, berarti sistem lo belum bener.

Dengan Infrastructure as Code:

* Semua bisa direview kayak kode biasa
* Bisa ditest, dikontrol via CI/CD
* Bisa direstore kalau ada yang kacau
* Dan yang paling penting: **gak bikin lo jadi single point of failure**

---


## **Apa Itu Terraform dan Kenapa Banyak yang Milih Ini?**

Jadi gini...

Bayangin lo lagi kerja di startup baru. Lo baru deploy 3 VM manual di AWS buat staging.
Terus besoknya, disuruh deploy hal yang sama buat production.
Besoknya lagi, buat environment testing.
Dan lo mulai sadar:

> *“Eh, kok gue ngulang-ngulang ya? Ini kerjaan manusia atau robot sih?”*

Nah, di sinilah muncul ide gila:
**Kenapa gak lo tulis aja infrastrukturnya kayak lo nulis kode?**
Gak perlu klik-klik, gak perlu ngetik `ssh`, cukup `terraform apply`, dan *boom!*
Semua VM, database, security group, VPC, sampai DNS record langsung jadi.

Dari sini udah bisa dibayangin berapa banyak waktu "klak-klik" manual cuma bikin VM / hal yang sama.
Lu cuma perlu "copas" dan ganti beberapa variable, udah. jadi dalam hitungan menit. gokil sih.

---


### **Apa Itu Terraform dan Kenapa Banyak yang Milih Ini?**

Sebelumnya gue udah cerita, sekitar tahun 2018 gue mulai kenal sama Ansible.
Tapi, waktu itu bukan cuma Ansible doang yang rame di skena.
Ada juga nama-nama kayak **Chef**, **Puppet**, bahkan **SaltStack** yang ikut nongol di skena DevOps.

Semua menawarkan janji yang kurang lebih sama:

> “Biar lo gak perlu lagi setup server satu-satu pake SSH.”

Gue inget banget, waktu itu rasanya kayak ada lomba—siapa yang paling gampang bikin 10 server langsung jalan dan auto install semua service.

Tapi ternyata, itu semua belum cukup.

Soalnya makin lama gue utak-atik, makin sadar:
**"Ini baru setup di dalem server, tapi bikin infrastrukturnya sendiri masih ribet, bro."**

Lo tetep harus klik-klik bikin VM, bikin VPC, bikin load balancer…
Dan ini bikin gue mikir:

> “Kalau ngatur aplikasi aja udah bisa pake kode, masa bikin infrastrukturnya gak bisa?”

Dan akhirnya, gue ketemu sama si satu ini:
**Terraform.**

---

#### **Terus, Apa Bedanya Sama Ansible, Chef, atau Puppet?**

Bedanya bukan cuma di syntax atau nama variabel.
Bedanya ada di *cara lo mikir*.

Tools kayak **Ansible** itu ngajarin lo mikir prosedural.
Lo bilang ke server:

```yaml
- install nginx
- copy config
- start service
```

Lo kayak lagi masak di dapur, satu langkah demi langkah. Salah di salah satu langkah, masakan bisa jadi beda rasanya.

Sementara **Terraform** itu mikirnya kayak arsitek:
Lo bilang apa yang lo pengen, dan dia yang urus detailnya.

> *"Gue mau 3 VM di AWS region Singapore, instance-nya t3.micro, udah ada tag-nya 'env=staging'."*

Udah. Gak perlu kasih tau cara login ke AWS Console, klik tombol mana, urutannya gimana.
Dia bakal bandingin kondisi sekarang (state) sama keinginan lo (desired state), dan langsung bikin plan buat nyamain keduanya.

Ini yang disebut pendekatan **declarative**, dan ini bikin beda banget rasanya.

---

### **Kenapa Banyak yang Suka Terraform?**

#### 1. **Deklaratif dan Predictable**

Jadi Lo bilang mau 3 VM, dia kasih 3 VM. Lo ganti jadi 5, dia tambahin 2.
Dia juga ngasih tau sebelum jalan:

```bash
+ create aws_instance.web[2]
~ update aws_instance.web[0]
- destroy aws_instance.old
```

Jadi gak ada kejutan-kejutan konyol.

---

#### 2. **Cloud Agnostic, Tapi Tetep Spesifik**

Lo bisa pakai Terraform buat deploy ke:

* AWS
* Azure
* Google Cloud
* bahkan DigitalOcean, Oracle, dan on-prem

Tapi tetep bisa manfaatin fitur khas tiap cloud. Misal lo pengen pake **S3 bucket lifecycle**, tinggal tulis di config-nya — gak harus nyamain semua cloud biar setara.

---

#### 3. **Bisa Disimpan di Git dan Di-review Kayak Kode**

Karena semua infrastruktur lo ditulis pake `.tf`, lo bisa commit ke Git, review pake PR, kasih komentar, dan track history-nya.

Lo bakal bisa bilang:

> “Siapa yang hapus VPC minggu lalu?!”
> dan tinggal buka Git log.

---

#### 4. **Integrasi Sama CI/CD dan Workflow Modern**

* Lo bisa pasang `terraform plan` di GitHub Actions tiap ada PR.
* Lo bisa linting, formatting, sampai state backend di S3.
* Lo bisa kolaborasi via Terraform Cloud atau workspace manual.

Intinya: bisa masuk ke pipeline modern, tanpa harus ngotak-ngatik GUI cloud provider.


## **Proses Kerja Terraform**

Pertama kali gue pakai Terraform, gue sempet mikir,

> “Ini tool bisa bikin infrastruktur secara otomatis, jangan-jangan kayak magic ya?”

Ternyata bukan. Bukan sulap. Bukan sihir.
Tapi logika dan *state management* yang rapi dan disiplin banget.

Gue bakal ceritain alurnya step-by-step, biar lo ngerti cara kerjanya dari awal sampe akhir.

---

### **1. Lo Tulis Kebutuhan Lo (HCL - HashiCorp Configuration Language)**

Yang pertama lo lakuin: lo bikin file `.tf`.

Misalnya lo pengen jalanin container Docker pake image `nginx`, lo bisa tulis kayak gini:

```hcl
resource "docker_container" "nginx" {
  name  = "tutorial"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8000
  }
}
```

Lo gak nyuruh dia “install Docker dulu”, atau “buka port 80 manual”.
Lo tinggal deklarasi: gue mau container `nginx` jalan, expose port sekian.

Ini kayak lo bilang ke arsitek:

> “Gue mau rumah 2 lantai, kamar 3, kamar mandi 2, dan ada dapur outdoor.”

Bukan:

> “Pertama gali tanah, lalu cor pondasi, lalu pasang bata...”

---

### **2. Terraform Init – Kenalin Dulu Dunia Lo**

Begitu file lo selesai, langkah pertama:

```bash
terraform init
```

Ini penting karena Terraform butuh download plugin buat provider yang lo pakai.
Provider itu kayak jembatan antara Terraform dan platform yang lo kelola—bisa AWS, GCP, Docker, Azure, dan lain-lain.

Misalnya kalau lo deploy ke Docker, dia akan download plugin `kreuzwerker/docker`.
Kalau ke AWS, dia ambil plugin `hashicorp/aws`.

Tanpa ini, lo cuma punya file `.tf` doang yang gak tau nyambung ke mana.

---

### **3. Terraform Plan – Simulasi Tanpa Komitmen**

Lanjut ke tahap paling menarik:

```bash
terraform plan
```

Nah ini dia kekuatan utama Terraform: **rencana.**

Di sini lo bakal lihat:

* Apa yang bakal dibuat?
* Apa yang bakal dihapus?
* Apa yang bakal diubah?

Misalnya dia bilang:

```text
+ create docker_container.nginx
```

Artinya, dia bakal bikin container baru.

Tapi dia belum bener-bener bikin.
Ini cuma *preview*.
Kayak lo liat maket rumah dulu sebelum mulai bangun.

Dan bagian paling krusial?
**State file** – `terraform.tfstate`.

Ini file penting banget.
Isinya catatan lengkap:

> “Sekarang gue udah bikin resource ini, id-nya segini, status-nya gini.”

Jadi tiap kali lo `plan`, Terraform bakal bandingin:
**current state (di tfstate)** vs **desired state (di .tf)**.

---

### **4. Terraform Apply – Waktunya Eksekusi**

Kalau lo udah yakin sama hasil `plan`, lo tinggal jalanin:

```bash
terraform apply
```

Di sini dia bakal mulai ngebangun beneran.

Semua deklarasi lo di file `.tf` bakal diwujudkan jadi resource nyata:

* Docker container jalan
* EC2 instance muncul
* Load balancer aktif
* S3 bucket kepasang

Dan semuanya dicatat lagi ke dalam `terraform.tfstate`.

Jadi, kalau lo jalanin `apply` dua kali, dia gak bakal bikin dua kali.
Dia bakal bilang:

> “Semua udah sesuai, gak perlu diapa-apain.”

Idempotent, cuy. Konsisten.

---

### **5. Terraform Destroy – Kalau Lo Mau Ngebongkar Semuanya**

Punya iseng dan pengen bersihin semuanya?

```bash
terraform destroy
```

Terraform bakal baca file `tfstate` dan ngehapus semua resource yang dia bikin sebelumnya.
Ya, **cuma yang dia bikin**, yang lain kagak dia sentuh.

Ini bikin dia aman dan terkontrol.
Gak ada tuh cerita “asal delete” kayak lo tekan tombol terminate di AWS Console.

---

### **Bonus: State Bisa Disimpan di Cloud**

Kalau kerja sendirian, simpan `terraform.tfstate` lokal oke-oke aja.
Tapi kalau tim lo banyak? Lo harus simpan di **remote backend** kayak:

* S3 + DynamoDB (buat locking)
* Terraform Cloud
* Azure Blob
* GCS

Kenapa?
Karena:

1. Lo butuh **locking** biar gak dua orang edit infrastruktur barengan.
2. Lo butuh **backup** biar tfstate gak ilang.
3. Lo butuh **visibility**, siapa ngapain kapan.


## **Gandeng Temen: Packer, Docker, Ansible, Kubernetes**

*(Alias: Terraform Gak Berdiri Sendiri, Bro)*

Jadi gini…
Terraform itu keren, tapi dia gak bisa mmelakukan semuanya sendiri.
Dia perlu temen. Dan temen-temennya ini—Packer, Docker, Ansible, Kubernetes—punya peran masing-masing.

---

### **1. Packer – Si Tukang Cetak (Image Builder)**

Bayangin lo mau deploy 100 VM identik.
Kalau setiap kali setup lo harus install package satu-satu, masukin config manual, ya kelar hidup lo.

Nah, Packer datang sebagai penyelamat.
Dengan Packer, lo bisa bikin **template image** (bisa AMI di AWS, bisa Docker image, bisa VHD di Azure) yang udah siap pakai.

Contoh:
Lo tulis satu file `.json` atau `.hcl` buat bilang:

```hcl
- Base image: Ubuntu
- Install nginx
- Copy konfigurasi lo
- Buat snapshot image-nya
```

Jadinya?
Satu VM image yang tinggal **plug and play**.
Gak perlu setup dari nol tiap kali launch.

Biasanya workflow-nya begini:

1. Lo build image pakai Packer
2. Hasilnya dipakai sama Terraform buat deploy server
3. Server langsung siap tempur dari detik pertama

---

### **2. Docker – Bikin Aplikasi Lo Portabel**

Docker itu kayak bento box buat aplikasi.
Semua udah dikemas rapi di satu tempat:

* Code-nya
* Dependency-nya
* Runtime-nya

Dan yang paling gila:
Lo bisa build image-nya di laptop, terus jalanin di VM production tanpa drama "eh dependency-nya beda ya".

Makanya Docker dan Terraform itu cocok banget.
Dengan provider `kreuzwerker/docker`, lo bisa:

```hcl
resource "docker_container" "nginx" {
  image = "nginx"
  ports {
    internal = 80
    external = 8080
  }
}
```

Udah, lo punya container jalan lewat Terraform.
Gak perlu masukin command `docker run` satu-satu.

---

### **3. Ansible – Si Tukang Rapiin (Configuration Management)**

Lo udah punya server (misal via Terraform), tapi mau ngatur dalamnya:

* Install Python
* Setup cron job
* Pasang cert SSL

Disinilah Ansible masuk.

Dia tool configuration management berbasis YAML.
Bedanya sama Terraform?
Terraform ngurus *apa yang harus ada*,
Ansible ngurus *gimana caranya* ngerjain itu.

Dan yang asik, keduanya bisa kerjasama.

Contoh:

* Terraform deploy 5 VM, kasih tag `role=web`
* Ansible scan semua VM yang punya tag itu
* Ansible setup nginx di dalamnya

Efisien. Clean. Automation yang terstruktur.

---

### **4. Kubernetes – Si Jenderal Pasukan Container**

Kalau lo udah jalanin banyak Docker container, lo bakal ngerasain keribetan:

* Gimana kalau 1 container mati?
* Gimana cara auto scaling?
* Gimana rolling update?
* Gimana load balancing?

Nah, Kubernetes adalah jawabannya.

Tapi Kubernetes **kompleks**.
Lo gak deploy 1–2 command. Lo bikin cluster.
Lo butuh worker node, control plane, networking internal, volume, service discovery, dll.

Makanya best practice-nya:

1. Lo bikin **VM image khusus** pake Packer (udah ada Docker dan agent Kubernetes)
2. Deploy semua node pakai Terraform
3. Otomatis semua nyambung dan bikin cluster

Jadi kombinasi lengkapnya:

* Packer: bikin image
* Terraform: deploy VM dan cluster
* Kubernetes: orkestrasi container
* Docker: format aplikasinya
* Ansible: kalo masih mau pegang low-level config


## **Setup Terraform dan Deploy ke Docker: Error Pertama, Pahami Akar Masalahnya**

Waktu pertama kali nyobain Terraform, gue langsung tertarik buat nyambungin ke Docker.
Alasannya simpel:

* Gampang dites lokal
* Gak butuh akun cloud
* Bisa cepet lihat hasilnya

Gue ambil contoh paling basic dari dokumentasi:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"

  ports {
    internal = 80
    external = 8000
  }
}
```

Gue save file itu sebagai `main.tf`, lalu di terminal:

```bash
terraform init
terraform apply
```

Terus… **boom! Error.**

---

### **WSL dan Docker: Gak Semulus Itu, Ferguso**

Ternyata bagian ini:

```hcl
host = "npipe:////.//pipe//docker_engine"
```

Itu **khusus buat Windows native**, bukan WSL.
Di WSL, host Docker-nya beda: biasanya lo connect ke Docker via socket di `/var/run/docker.sock`.

Akhirnya gue ubah jadi:

```hcl
provider "docker" {
  host = "unix:///var/run/docker.sock"
}
```

Tapi di sinilah muncul masalah baru:

```bash
Error: unable to connect to Docker daemon
```

Padahal gue bisa `docker ps` di terminal WSL. Kok Terraform gak bisa connect?

---

### **Root Cause-nya? Permission dan Env Variable**

Gue coba debug:

```bash
echo $DOCKER_HOST
```

Ternyata kosong.
Docker CLI bisa jalan karena dia nyambung ke socket default, tapi Terraform butuh host yang eksplisit. Jadi lo harus set `DOCKER_HOST` environment variable, atau masukin langsung ke config Terraform.

Tapi belum selesai sampai situ.

Kadang juga muncul error permission:

```
permission denied while trying to connect to the Docker daemon socket
```

Solusinya:

```bash
sudo usermod -aG docker $USER
```

Lalu restart WSL, atau:

```bash
newgrp docker
```

---

### **Akhirnya Jalan**

Setelah ngoprek dikit, akhirnya:

```hcl
provider "docker" {
  host = "unix:///var/run/docker.sock"
}
```

Dan semua command Terraform bisa jalan normal:

```bash
terraform init
terraform apply
```

Container NGINX langsung jalan di port 8000.
Cek pakai browser:

```
http://localhost:8000
```

Muncul welcome page-nya NGINX. Akhirnya berhasil!

---
