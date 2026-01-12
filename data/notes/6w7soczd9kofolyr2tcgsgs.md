
## 1. Pendahuluan

Lo mungkin udah sering denger soal **Flowise**—platform open-source yang simpel buat bikin chatflow AI dan integrasi ke berbagai sumber data. Kenapa Flowise? Karena dia bener-bener plug and play: lu tinggal deploy, bikin workflow, dan langsung bisa ngobrol pake LLM kayak ChatGPT. Ga usah repot setup backend ribet—langsung gas.

Di tutorial kali ini, kita bakal setup Flowise dari awal sampe jalan di server, pake VM. Tapi apa sih **VM** itu?
Singkatnya, VM (Virtual Machine) adalah server virtual yang lu bisa sewa dan kontrol sendiri. Ibaratnya kayak PC lo, tapi jalan di cloud. Lu bisa pilih: mau di Azure, AWS, GCP—semua sama prinsipnya. Kali ini, gue contohin di **Azure VM**, tapi langkahnya bakal sama aja kalau lu mau pake yang lain.

Kenapa pake VM?

* Karena **Flowise** itu butuh environment yang stabil dan bisa diakses internet.
* Ga ribet: lu punya full akses buat ngatur environment, install apa aja, aman.
* Bisa di-scale: nanti butuh worker, tinggal jalanin worker. Mau load balancer? Tinggal setup.

Jadi, di sini kita bakal **bikin VM di Azure, setup environment (Docker, Compose), deploy Flowise sampe kelar**.
Nextnya, lu bisa lanjut ke worker (buat load queue), bikin backup otomatis, sampe customin environment. Tapi yang penting: Flowise harus hidup dulu.

Oke, Section 2 gue lanjut!

---

## 2. Persiapan VM

Sebelum Flowise bisa jalan, kita butuh environment-nya dulu: **VM** (Virtual Machine) yang siap jadi rumah Flowise. Gue bakal bahas mulai dari bikin VM sampe nyiapin environment dasarnya.

Oke, mari kita revisi dan bikin lebih detail, biar bener-bener komprehensif. Ini **Section 2.1 Buat VM di Azure** yang lebih mendalam!

---

### 2.1 Buat VM di Azure (Langkah Lengkap)

**Kenapa VM?**
Karena Flowise bakal jalan stabil di environment yang dedicated. Azure VM ini semacam “rumah” yang lu kelola sendiri — lu bisa atur CPU, RAM, disk space, dan keamanan sesuai kebutuhan.

**Langkah-langkah lengkapnya:**

#### a. Akses Portal Azure

1. Buka browser dan login ke [Azure Portal](https://portal.azure.com/).
2. Di sidebar kiri, klik **Virtual Machines**.

#### b. Mulai Buat VM

1. Klik **+ Create** > **Azure Virtual Machine**.
2. Lu bakal lihat form “Create a virtual machine”.

#### c. Basic Details

* **Subscription**: biasanya udah default ke subscription lu.
* **Resource Group**: pilih yang udah ada, atau klik **Create new** buat bikin resource group baru (misalnya `rg-flowise`).
* **Virtual machine name**: nama VM lu, misalnya `test-vm-1`.
* **Region**: pilih region yang dekat sama user. Kalau buat testing, `Southeast Asia` atau `East Asia` biasanya bagus.
* **Availability options**: default `No infrastructure redundancy required` (oke buat testing).
* **Image**: pilih **Ubuntu 22.04 LTS** (versi stabil dan familiar).
* **Size**: klik **See all sizes** dan pilih yang pas. Buat testing, `B1s` udah cukup (1 vCPU, 1 GB RAM).
* **Authentication type**:
  * Pilih **SSH public key** biar lebih aman.
  * **Username**: misalnya `azureuser`.
  * **SSH public key source**: biasanya lu udah punya key di `~/.ssh/id_rsa.pub`. Copy paste ke kolom ini.
* **Inbound port rules**:
  * **Public inbound ports**: `Allow selected ports`.
  * **Select inbound ports**: pilih `SSH (22)`.
  * Nanti kita atur port lain (3000 buat Flowise, 6379 buat Redis).`

#### d. Disk dan Storage

* **OS disk type**: defaultnya **Standard SSD** (cukup untuk testing).
* Kalau butuh data disk tambahan, nanti bisa attach disk lain.

#### e. Networking

* Azure otomatis bikin Virtual Network dan Subnet.
* **Public IP**: biar lu bisa SSH, pastikan aktif.
* **NIC network security group**: defaultnya bikin **Basic** rule SSH (22). Nanti lu bisa atur rule buat 3000 & 6379 manual kalau perlu.

#### f. Management, Monitoring, dan lainnya

* Buat testing, lu bisa biarin default.
* Kalau buat production, pastikan:

  * **Boot diagnostics**: aktif.
  * **Auto-shutdown**: aktifin biar hemat biaya kalo lupa shutdown.

#### g. Review & Create

* Klik **Review + create**.
* Azure bakal validasi. Kalau ga ada error, klik **Create**.

Tunggu 1–2 menit sampe VM ready.

---

#### h. SSH ke VM

* Setelah VM aktif, liat **Public IP address** di dashboard VM.
* Di terminal lokal lu:

```bash
ssh azureuser@<public-ip>
```

Ganti `<public-ip>` dengan IP VM lu. Kalau pake password, dia bakal minta password. Kalau pake SSH key, langsung connect.

#### i. Atur Firewall Buat Port Flowise & Redis

By default, cuma port 22 yang kebuka. Flowise jalan di port 3000 dan Redis di 6379. Jadi:

1. Balik ke Azure Portal.
2. Masuk ke VM > **Networking**.
3. Klik **Add inbound port rule**:

   * **Source**: Any
   * **Source port ranges**: \*
   * **Destination**: Any
   * **Destination port ranges**: 3000
   * **Protocol**: TCP
   * **Action**: Allow
   * **Priority**: 300 (biar ga bentrok sama rule lain).
   * **Name**: allow-3000
4. Ulangi buat port 6379 (Redis).

---

#### j. Sekarang VM lu siap

* OS Ubuntu 22.04 LTS
* Port 22 (SSH), 3000 (Flowise), 6379 (Redis) udah kebuka
* SSH udah bisa dipake

Udah. Tinggal setup environment dasar (update OS, pasang Docker, dll.) di section selanjutnya.


### 2.2 Akses VM

Setelah VM jadi, lu dapet public IP. Buka terminal lokal lu:

```bash
ssh azureuser@<public-ip>
```

Ganti `<public-ip>` pake IP VM yang lu buat.

Kalau pake password, dia minta password. Kalau SSH key, tinggal masuk aja.

Udah connect? Mantap. Kita lanjut ke setup dasar.

### 2.3 Update & Install Basic Tools

Karena ini VM fresh, kita update dulu biar paketnya aman dan terbaru:

```bash
sudo apt update && sudo apt upgrade -y
```

Install tools basic yang sering kepake:

```bash
sudo apt install -y git curl wget htop
```

Nanti lu bisa pake `htop` buat monitor load VM.

### 2.4 Pasang Docker & Docker Compose

Flowise butuh Docker biar ga ribet dependensi.

1. Install Docker:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

2. Cek Docker udah jalan:

```bash
sudo systemctl status docker
```

3. Install Docker Compose (biar gampang manage multi-container):

```bash
sudo apt install -y docker-compose
```

4. Biar ga pake `sudo` terus, tambahin user ke grup Docker:

```bash
sudo usermod -aG docker $USER
```

Keluar SSH (`exit`) dan masuk lagi biar group Docker langsung aktif.

---

Di sini, VM lu udah siap buat deploy Flowise. Docker dan Compose udah jalan. Next, kita bakal setup Flowise bareng config dasar (pake file `.env`, `docker-compose.yml`, dll).

Oke, lanjut ke **Section 3: Deploy Flowise**?

Oke, kita lanjut ke **Section 3: Setup Environment Dasar di VM**. Ini bagian penting biar VM lu siap buat deploy Flowise dan Redis.

---

### 3. Setup Environment Dasar di VM

Begitu lu SSH ke VM, kita langsung rapihin environment-nya supaya stabil dan ga bikin pusing ke depannya.

**a. Update OS**
Pertama, update OS ke versi terbaru biar aman dan stabil:

```bash
sudo apt update && sudo apt upgrade -y
```

Ini bakal ambil update security patch dan package terbaru. Tunggu sampe kelar.

---

**b. Install Dependency Dasar**
Flowise butuh Docker & Docker Compose. Kita pasang dulu:

1. **Install Docker:**

```bash
sudo apt install docker.io -y
```

2. **Enable dan Start Docker:**

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

3. **Cek Docker:**

```bash
docker --version
```

Harusnya muncul versi Docker.

---

**c. Install Docker Compose**
Docker Compose biasanya ga include di Ubuntu. Kita install manual:

```bash
sudo apt install docker-compose -y
```

Cek versi:

```bash
docker-compose --version
```

---

**d. Tambah User ke Group Docker (opsional)**
Supaya ga perlu `sudo` tiap kali jalanin Docker:

```bash
sudo usermod -aG docker $USER
```

Keluar dan login lagi biar groupnya kebaca:

```bash
exit
```

Terus SSH lagi ke VM.

---

**e. Cek Firewall (Opsional)**
Kadang firewall VM nutup port default:

```bash
sudo ufw status
```

Kalau aktif dan lu mau atur rule:

```bash
sudo ufw allow 3000/tcp
sudo ufw allow 6379/tcp
sudo ufw reload
```

---

**f. Tes Docker**
Lu bisa coba jalanin container dummy buat tes:

```bash
docker run hello-world
```

Kalau muncul “Hello from Docker!”, environment Docker lu udah beres.

---

**g. Siapin Direktori Project**
Lu bisa buat satu folder buat simpen semua file:

```bash
mkdir ~/myapp
cd ~/myapp
```

---

### 4. Deploy Flowise & Redis pakai Docker Compose

Sekarang kita udah punya environment yang siap tempur. Waktunya deploy Flowise barengan Redis pake Docker Compose.

---

**a. Buat File `.env`**

Simpan environment variable di satu file `.env`. Contoh paling basic:

```bash
cat <<EOF > .env
PORT=3000
DATABASE_PATH=/root/.flowise
SECRETKEY_PATH=/root/.flowise
LOG_PATH=/root/.flowise/logs
BLOB_STORAGE_PATH=/root/.flowise/storage
JWT_AUTH_TOKEN_SECRET=secret
JWT_REFRESH_TOKEN_SECRET=secret
JWT_ISSUER=flowise
JWT_AUDIENCE=flowise
EXPRESS_SESSION_SECRET=flowise

REDIS_HOST=redis
REDIS_PORT=6379
MODE=queue
QUEUE_NAME=flowise-queue
QUEUE_REDIS_EVENT_STREAM_MAX_LEN=100000
EOF
```

---

**b. Buat File `docker-compose.yml`**

Ini file utama yang bakal jalanin Flowise & Redis:

```yaml
version: '3.1'

services:
  redis:
    image: redis:alpine
    container_name: docker_redis_1
    restart: always
    ports:
      - '6379:6379'

  flowise-web:
    image: flowiseai/flowise
    container_name: flowise-web
    restart: always
    environment:
      - PORT=${PORT}
      - MODE=${MODE}
      - REDIS_HOST=${REDIS_HOST}
      - REDIS_PORT=${REDIS_PORT}
      - QUEUE_NAME=${QUEUE_NAME}
      - QUEUE_REDIS_EVENT_STREAM_MAX_LEN=${QUEUE_REDIS_EVENT_STREAM_MAX_LEN}
      - DATABASE_PATH=${DATABASE_PATH}
      - SECRETKEY_PATH=${SECRETKEY_PATH}
      - LOG_PATH=${LOG_PATH}
      - BLOB_STORAGE_PATH=${BLOB_STORAGE_PATH}
      - JWT_AUTH_TOKEN_SECRET=${JWT_AUTH_TOKEN_SECRET}
      - JWT_REFRESH_TOKEN_SECRET=${JWT_REFRESH_TOKEN_SECRET}
      - JWT_ISSUER=${JWT_ISSUER}
      - JWT_AUDIENCE=${JWT_AUDIENCE}
      - EXPRESS_SESSION_SECRET=${EXPRESS_SESSION_SECRET}
    ports:
      - '${PORT}:${PORT}'
    volumes:
      - ~/.flowise:/root/.flowise
```

---

**c. Jalankan Docker Compose**

```bash
sudo docker-compose --env-file .env up -d
```

Docker Compose bakal:

* Download image Redis & Flowise
* Jalanin container
* Otomatis restart kalo VM reboot

---

**d. Cek Status**

```bash
sudo docker ps
```

Harusnya muncul dua container:

* `docker_redis_1`
* `flowise-web`

---

**e. Akses Flowise**

Buka browser, ketik:

```
http://<IP_VM>:3000
```

Harusnya udah muncul Flowise Dashboard.

---

**f. Troubleshoot Kecil**

* Kalo container crash:

  ```bash
  sudo docker logs flowise-web
  ```
* Kalo Redis error:

  ```bash
  sudo docker logs docker_redis_1
  ```

---

**g. Next: Setup Worker**
Flowise ini udah jalan, tapi dia masih single instance. Worker Redis belum di-setup. Nanti worker Redis ini yang bakal scale dan handle background job.



### 5. Konfigurasi Environment

Oke, di tahap ini kita udah punya Flowise repo dan file-file pentingnya. Sekarang waktunya bikin file environment variable biar Flowise tau di mana dia harus nyimpen data dan konek ke Redis (kalau pakai).

---

#### a. Kenapa Penting?

File `.env` ini penting banget. Semua setting environment — port, database path, secret key, Redis, dll — disimpen di sini. Biar kalo lu mau deploy lagi di server lain, tinggal copy file `.env` doang. Praktis!

---

#### b. Bikin File `.env` Dasar

Lu bisa bikin file `.env` langsung di VM:

```bash
nano .env
```

Terus isiin basic config kayak gini:

```env
PORT=3000

# Path default storage Flowise
DATABASE_PATH=/root/.flowise
SECRETKEY_PATH=/root/.flowise
LOG_PATH=/root/.flowise/logs
BLOB_STORAGE_PATH=/root/.flowise/storage

# Basic JWT dan session secret
JWT_AUTH_TOKEN_SECRET=secret
JWT_REFRESH_TOKEN_SECRET=secret
JWT_ISSUER=flowise
JWT_AUDIENCE=flowise
EXPRESS_SESSION_SECRET=flowise

# Redis config
REDIS_HOST=redis
REDIS_PORT=6379
MODE=queue
QUEUE_NAME=flowise-queue
QUEUE_REDIS_EVENT_STREAM_MAX_LEN=100000
```

Simpan file `.env` ini. Ini settingan yang udah cukup buat jalanin Flowise web plus Redis queue worker (opsional).

---

#### c. Opsi Setting (Bisa Dikosongin / Custom)

Kalau mau minimalis banget, lu bisa **skip** beberapa setting kayak SMTP, storage S3, atau Postgres. Flowise bisa jalanin semua data langsung di path `~/.flowise` default.

Tapi kalo lu mau:

* Connect ke Postgres → Lu bisa tambah `DATABASE_TYPE`, `DATABASE_HOST`, `DATABASE_PORT`, dll.
* Pakai storage S3 / GCS → Lu bisa tambah `STORAGE_TYPE`, `S3_*`, `GOOGLE_*`.
* Aktifin monitoring (Prometheus, OpenTelemetry) → Tambah `METRICS_*` di `.env`.

---

#### d. Cek Kembali

Sebelum lu `docker-compose up -d`, pastiin file `.env` lu udah:
✅ Path storage
✅ JWT secret
✅ Redis config (kalau mau pakai queue)
✅ Port (3000 default)

---

#### e. Gunakan `.env` di Docker Compose

Pas lu jalanin Docker Compose, jangan lupa pake parameter `--env-file`:

```bash
sudo docker-compose --env-file .env up -d
```

Dengan ini, Docker Compose bakal inject semua setting di `.env` ke environment container. Jadi config lu rapih dan gampang dikelola.

---

### 6. Jalankan Flowise Web

Nah, sekarang lu udah punya semua yang lu butuhin — Docker Compose, file `.env`, dan repo Flowise yang udah di-clone. Waktunya ngejalanin Flowise biar bisa lu akses lewat browser!

---

#### a. Jalankan Docker Compose

Cukup satu perintah ini, asalkan lu udah di direktori yang sama sama `docker-compose.yml`:

```bash
sudo docker-compose --env-file .env up -d
```

Penjelasannya:

* `--env-file .env` → buat baca file `.env` lu.
* `-d` → biar container jalan di background, gak ganggu terminal.

---

#### b. Cek Status

Cek container yang lagi jalan:

```bash
sudo docker ps
```

Harusnya lu bakal liat:

* `flowise-web` (container Flowise)
* `docker_redis_1` (container Redis, kalau lu setup Redis juga)

Kalau statusnya **Up**, artinya udah beres!

---

#### c. Akses Flowise di Browser

Sekarang, lu tinggal buka browser dan masuk ke:

```
http://<IP_VM>:3000
```

Contoh:

```
http://20.212.155.7:3000
```

Harusnya lu udah liat dashboard Flowise — itu artinya **Flowise udah running!**

---

#### d. Apa yang Dilakuin Flowise

Pas Flowise Web udah jalan, dia bakal:

* Buka port 3000 buat antarmuka (dashboard web).
* Simpen semua data (flow, setting, secret) di folder `~/.flowise` (volume mapping).
* Kalau Redis aktif dan lu udah set `MODE=queue`, dia juga siap ngoper ke worker (nanti lu setup).

---

#### e. Troubleshooting Singkat

Kalau lu gak bisa akses di browser:

* Cek firewall VM (port 3000 udah kebuka belum?).
* Cek status container pakai `sudo docker ps` (ada yang restart?).
* Liat log container Flowise:

```bash
sudo docker logs flowise-web
```

Biasanya error log cukup jelas, kayak salah path atau conflict port.


---

### 7. (Opsional) Setup Worker

Worker ini sebenernya **bukan wajib** — Flowise Web udah cukup kalau trafficnya santai. Tapi kalau lu mau:

* **Load lebih berat** (banyak user / banyak flow jalan bareng).
* **Pakai mode queue** biar lebih scalable.
* **Pisahin job processing** biar web lebih ringan.

Worker adalah jawabannya.

---

#### a. Apa itu Worker?

Secara singkat:

* **Flowise Web**: frontend dan API.
* **Flowise Worker**: backend yang kerjain job intensif (eksekusi alur RAG, LLM, dkk).

Worker **ngambil job** dari Redis, yang jadi queue. Jadi Redis **harus jalan dulu**.

---

#### b. Kapan Worker Ini Kepake?

Worker jalan kalau di `.env` lu set:

```env
MODE=queue
```

Di Flowise Web, dia cuma ngirim job ke Redis. Worker yang bakal ambil job dan eksekusi.

---

#### c. Setup Docker Compose Worker

Biasanya **worker Compose file** (`docker-compose.worker.yml`) beda sama `docker-compose.yml` web. Contoh file:

```yaml
version: '3.1'

services:
  worker:
    image: flowiseai/flowise
    restart: always
    environment:
      - MODE=queue
      - QUEUE_NAME=flowise-queue
      - REDIS_HOST=redis
      - REDIS_PORT=6379
      - WORKER_CONCURRENCY=100
      - DATABASE_PATH=/root/.flowise
      - SECRETKEY_PATH=/root/.flowise
      - LOG_PATH=/root/.flowise/logs
      - BLOB_STORAGE_PATH=/root/.flowise/storage
    entrypoint: /bin/sh -c "sleep 3; flowise worker"
    depends_on:
      - redis
    volumes:
      - ~/.flowise:/root/.flowise

  redis:
    image: redis:7
    restart: always
```

Worker ini bakal **nyambung ke Redis** (port 6379) dan siap tarik job.

---

#### d. Jalankan Worker

Kalau Redis udah jalan:

```bash
sudo docker-compose --env-file .env -f docker-compose.worker.yml up -d
```

Cek worker status:

```bash
sudo docker ps
```

Harusnya container `worker` statusnya **Up**.

---

#### e. Kapan Worker Ini Bakal "Aktif"?

Worker jalan terus, tapi dia **baru "sibuk"** kalau ada job masuk:

* Flowise Web lempar job (misal deploy Flow).
* Worker ambil job dari Redis dan eksekusi.

Kalau job kosong, worker standby aja.

---

#### f. Tips Tambahan

* Pastikan `MODE=queue` di Web dan Worker sama.
* Kalau lu pake volume mapping `~/.flowise`, Worker share data yang sama sama Web.
* Redis **harus stabil** — worker butuh Redis buat ngambil job.

### 8. Troubleshooting & Tips

Walaupun setup Flowise di VM lumayan gampang, pasti ada beberapa masalah yang sering muncul. Nah, di section ini, gue kasih tips troubleshooting dan juga beberapa tools yang bisa bantu lu mantau performa container.

---

#### a. Container Restart Terus

Kalau lu lihat container **restart terus** di `docker ps` (statusnya “Restarting”), biasanya karena:

* File `.env` belum lengkap atau ada yang typo.
* Redis belum jalan (padahal Web/Worker butuh Redis).
* Volume `~/.flowise` belum ada permission (biasanya di VM fresh, butuh `sudo chown`).
* Port conflict: port `3000` (web) atau `6379` (Redis) udah kepake sama service lain.

**Solusi:**

* Cek log container:

  ```bash
  sudo docker logs flowise-web
  ```
* Pastikan file `.env` valid:

  ```bash
  cat .env
  ```
* Tes Redis udah running:

  ```bash
  sudo docker ps | grep redis
  ```

---

#### b. Port Conflict

Kalau muncul error `port already in use` pas `docker-compose up`, itu tandanya port 3000 atau 6379 udah dipake.

**Solusi:**

* Cari service yang pake port itu:

  ```bash
  sudo lsof -i :3000
  sudo lsof -i :6379
  ```
* Kill service yang ganggu:

  ```bash
  sudo kill -9 <pid>
  ```

---

#### c. Worker Gak Jalan / Diam Aja

Worker gak ngapa-ngapain?

* Cek Redis:

  ```bash
  sudo docker logs docker_redis_1
  ```
* Pastikan `MODE=queue` di `.env` Web dan Worker **sama**.
* Worker cuma “bangun” kalau ada job. Jadi lu coba jalanin Flow biar dia ada kerjaan.

---

#### d. Cara Baca Log Container

Penting nih buat debugging:

```bash
sudo docker logs flowise-web
sudo docker logs worker
```

Kalau lognya terlalu panjang, bisa pakai `tail`:

```bash
sudo docker logs -f flowise-web
```

---

#### e. Tools Bantu: Portainer & Docker Dashboard

Kalau lu mau **liat container secara visual**, cobain tools kayak:

* **Portainer**: UI buat manage container, liat logs, restart, dll.
* **Docker Dashboard** (kalau lu pake Docker Desktop).

Install Portainer:

```bash
docker volume create portainer_data
docker run -d -p 9000:9000 -p 8000:8000 --name portainer \
    --restart=always -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data portainer/portainer-ce
```

Akses di browser:

```
http://<VM_IP>:9000
```

---

#### f. Tips Tambahan

* **Backup data `.flowise`**: semua logs, DB, dan storage Flowise ada di folder ini.
* **Auto restart**: Compose udah `restart: always`, jadi kalau VM reboot, container auto naik lagi.
* **Scaling**: kalau Flowise makin rame, lu bisa deploy Worker di VM lain (asal Redisnya bareng).

### 9. Next Step: Worker dan Beyond

Kalau lu udah deploy Flowise Web, biasanya yang kepikiran selanjutnya adalah:

---

#### a. Kapan Perlu Setup Worker?

Flowise Worker itu kayak “otak tambahan” buat ngerjain job berat (kayak scraping, generate response panjang, dll.). Worker **jalanin job** yang dikasih Flowise Web.

* **Kalau Flowise Web doang**: semua job jalan di Web, bisa overload.
* **Kalau pake Worker**: job dijalanin Worker, Web lebih ringan.

Worker **wajib** kalau lu:

* Mau performa lebih stabil
* Ada job yang panjang
* Niat integrasi Flowise di production

---

#### b. Redis Jadi “Penghubung” Web & Worker

Redis itu **queue broker** di Flowise:

* Flowise Web naro job ke Redis
* Worker ambil job dari Redis

Makanya Redis wajib kalau pake Worker. Redis bisa lu deploy bareng (satu Compose) atau **cluster** (kalau mau scalable).

---

#### c. Opsi Lanjutan: SSL & Load Balancer

Kalau lu udah deploy Web & Worker, next step biasanya:

* **Pasang SSL** (HTTPS) pake Nginx Proxy Manager atau Caddy.
* **Load balancer**: kalo lu deploy banyak Worker, lu load balance biar stabil.

---

#### d. Opsi Auth Tambahan

Flowise udah support **Basic Auth** di level dashboard.
Tapi kalo mau lebih secure, bisa:

* Reverse Proxy (Nginx Proxy Manager) + Basic Auth.
* OAuth2 / SSO pake Nginx atau external proxy.

---

#### e. Upgrade & Update Flowise

Flowise lumayan aktif update, jadi lu juga perlu jaga:

```bash
docker pull flowiseai/flowise
docker-compose down && docker-compose up -d
```

Jangan lupa backup dulu `.flowise` biar data aman.

---

#### f. Integrasi Lain

Flowise itu enak karena bisa:

* Dipake bareng chatbot di WhatsApp, Discord, Slack, dll.
* Ditaro di workflow automation (kayak n8n, Zapier).
* Pake OpenAI atau LLM lain (Claude, Qwen, Ollama).
