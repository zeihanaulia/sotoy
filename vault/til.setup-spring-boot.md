---
id: co2rjq3ldux3qxdhx7dkbdf
title: Setup Spring Boot
desc: ''
updated: 1746615097326
created: 1746614779555
---

Siap! Ini dia versi **terbaru dan bersih** dari **step-by-step install Spring Boot pakai Gradle di WSL Ubuntu**, dengan **Java 21 (LTS)** dan **tanpa buka browser**.

---

## ✅ STEP-BY-STEP SPRING BOOT + GRADLE + JAVA 21 (WSL Ubuntu – Full CLI)

---

### 🧱 1. Install Dependency Dasar

```bash
sudo apt update
sudo apt install unzip curl zip -y
```

---

### ☕️ 2. Install SDKMAN

```bash
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

> ✅ SDKMAN = versi manager buat Java, Gradle, Spring CLI

---

### ☕️ 3. Install Java 21 (LTS)

```bash
sdk install java 21.0.7-tem
sdk default java 21.0.7-tem
java -version
javac -version
```

---

### ⚙️ 4. Install Gradle dan Spring Boot CLI

```bash
sdk install gradle
sdk install springboot
```

> Cek:

```bash
gradle -v
spring --version
```

---

### 📦 5. Generate Proyek Spring Boot (pakai CLI)

```bash
spring init \
  --boot-version=3.3.0 \
  --build=gradle \
  --type=gradle-project \
  --java-version=21 \
  --dependencies=web,lombok \
  --name=demo \
  demo

```

> Ini akan membuat folder `demo/` berisi project Spring Boot + Gradle.

---

### 🚀 6. Jalankan Spring Boot

```bash
cd demo
./gradlew bootRun
```

> Buka browser di Windows:

```
http://localhost:8080
```

---

### 🔨 7. Tambahkan Endpoint Controller

```bash
nano src/main/java/com/example/demo/HelloController.java
```

Isi:

```java
package com.example.demo;

import org.springframework.web.bind.annotation.*;

@RestController
public class HelloController {
    @GetMapping("/hello")
    public String hello() {
        return "Hello from Spring Boot in WSL!";
    }
}
```

Simpan & restart:

```bash
./gradlew bootRun
```

---

### 👨‍💻 8. (Opsional) Buka di VSCode

```bash
code .
```

> Pastikan sudah install extension **"Remote - WSL"** di VSCode.

---

Kalau semua step ini diikuti, kamu udah siap ngoding full Spring Boot di WSL 🎉
Mau lanjut setup PostgreSQL atau Docker juga?
