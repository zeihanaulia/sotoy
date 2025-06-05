---
id: 5w0lto1q5ywc95uktplo5f5
title: Setup Vm Azure Terraform
desc: ''
updated: 1749091726653
created: 1749091121822
---

## 1. Install Terraform (TF)

Terraform itu tool buat bikin infrastruktur via kode. Jadi lo bisa definisiin semuanya (VM, jaringan, IP, dll) dari satu file konfig. Ga perlu klik-klik di Azure Portal.

Lo bisa install Terraform via:

* Brew (kalau di Mac):

  ```bash
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform
  ```
* Nix (kalau lo anak Nix):

  ```nix
  home.packages = [ pkgs.terraform ];
  ```

Cek versi:

```bash
terraform -v
```

Pastikan versi minimal 1.x ke atas biar support syntax terbaru.

---

## 2. Init Project

Bikin folder project, misalnya `infra`, terus lo buat beberapa file utama:

* `main.tf`: isi semua resource Azure.
* `variables.tf`: semua variabel yang reusable didefinisikan di sini.
* `terraform.tfvars`: isinya nilai-nilai variabel real-nya.

Contoh `variables.tf`:

```hcl
variable "subscription_id" {}
variable "tenant_id" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_name" {}
variable "admin_username" {}
variable "ssh_public_key" {}
```

Contoh isi `terraform.tfvars`:

```hcl
subscription_id    = "<ID Azure lo>"
tenant_id          = "<Tenant ID Azure lo>"
resource_group_name = "rg-tf-dev"
location           = "East Asia"
vm_name            = "vm-tf-test"
admin_username     = "azureuser"
ssh_public_key     = "ssh-ed25519 AAAA...."
```

---

## 3. Isi `main.tf`

Di `main.tf`, lo akan definisiin semua resource yang dibutuhin:

* Resource Group
* Virtual Network
* Subnet
* Public IP
* Network Interface
* Network Security Group
* VM Linux itu sendiri

Contoh NSG rule buat allow port 80:

```hcl
security_rule {
  name                       = "Allow-HTTP"
  priority                   = 1002
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
```

Dan jangan lupa attach NSG ke NIC:

```hcl
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
```

---

## 4. Terraform Init & Apply

Command ini buat jalanin proses provisioning:

```bash
terraform init     # download provider
terraform plan     # ngecek perubahan apa aja
terraform apply    # eksekusi beneran
```

Kalau apply berhasil, VM akan dibuat lengkap dengan IP publik.

---

## 5. Provision Docker di VM

Setelah VM jadi, lo bisa SSH ke dalam:

```bash
ssh azureuser@<public-ip>
```

Lalu, upload dan jalankan script provisioning:

```bash
scp provision.sh azureuser@<public-ip>:
ssh azureuser@<public-ip>
sudo bash provision.sh
```

Isi `provision.sh` bisa seperti ini:

```bash
#!/bin/bash
apt update -y
apt install -y git curl unzip ufw fail2ban
curl -fsSL https://get.docker.com | sh
usermod -aG docker azureuser
curl -L "https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ufw allow 22
ufw allow 80
ufw allow 443
ufw --force enable
```

Script ini akan pasang Docker, Docker Compose, dan nyalain firewall.

---

## 6. Test Docker Webserver

Kita bikin service web simpel pakai Nginx.

Contoh `Dockerfile`:

```Dockerfile
FROM nginx:alpine
COPY ./html /usr/share/nginx/html
```

Contoh `docker-compose.yml`:

```yaml
version: '3'
services:
  web:
    build: .
    ports:
      - "80:80"
```

Isi file `html/index.html` buat test:

```html
<h1>It works!</h1>
<p>This page is served from inside a Docker container.</p>
```

Jalankan container:

```bash
docker compose up -d --build
```

Cek di browser:

```
http://<public-ip>
```

Kalau muncul tulisan "It works!", berarti sukses.

---

## 7. Catatan Penting

* Kalau ada yang ngubah konfigurasi langsung via Azure Portal, itu **nggak sinkron sama Terraform**.
* Saat lo jalankan `terraform apply` lagi, bisa aja konfigurasi lama dari `.tf` overwrite perubahan manual tadi.
* Jadi, sebaiknya semua perubahan dilakukan via kode.

---

## Next Steps:

Beberapa hal yang bisa lo lanjutin:

* Pasang domain dengan DNS A record ke IP publik
* Tambah TLS pakai Nginx proxy atau Caddy
* Deploy app beneran kayak Flowise, FastAPI, Botpress
* CI/CD pipeline pakai GitHub Actions buat push ke VM otomatis