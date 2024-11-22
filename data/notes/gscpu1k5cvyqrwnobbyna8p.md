
#go

### Gunakan gofmt

[gofmt](https://pkg.go.dev/cmd/gofmt) adalah program untuk formating digolang.
Pastikan selalu ada disetiap code editor yang digunakan.

#### VSCode

Link: 
- [https://code.visualstudio.com/docs/languages/go](https://code.visualstudio.com/docs/languages/go)

#### Vim

Link:
- [https://github.com/fatih/vim-go/](https://github.com/fatih/vim-go/)

### Buat nama receiver tetap pendek

```go
type User struct {
	Name string
	IsActive bool
}

// gunakan
func (u User) Activated() {}

// jangan gunakan
func (user User) Activated() {}
func (self User) Activated() {}
func (this User) Activated() {}
```

Aktifkan [golangci-lint](https://github.com/golangci/golangci-lint) dengan [revive](https://revive.run/docs) untuk dapat pengecekan [receiver-naming](https://revive.run/r#receiver-naming).

### Memberikan nama package yang sesuai

Penamaan package sebaiknya sesuai dengan nama directory atau fungsi dari package tersebut.

- Fungsi: Implementasi elasticsearch ,Dir: /elasticsearch

```go
package elasticsearch
```

- Fungsi: Membuat order pesanan, Dir; /order

```go
package order
```

### Kelompokan import sesuai asalnya

Ada tiga bagian pada setiap import dan urutkan sesuai dengan asalnya, jangan urutkan sesuai abjad. Contoh

```go
import (
	// 1. Untuk standard library
	"context"

	// 2. Untuk external dependency yang digunakan
	"go.opentelemetry.io/otel"

	// 3. Untuk internal code yang kita atau tim kita tulis sendiri
	"github.com/zeihanaulia/my-project/internal"
)
```

### Gunakan nama pendek untuk scope yang terbatas

Nama pendek seperti 1 karakter huruf hanya boleh digunakan pada scope terbatas.
Misalnya seperti pada function for.

```go
for i:=0; i<5; i++ {}
```

sisanya berikan nama yang jelas sesuai maknanya.

### Context harus menjadi parameter pertama

Ada aturan pada penggunaan context:

1. Gunakan context sebagai parameter pertama pada function

	```go
	// Boleh
	func Create(ctx context.Context, args entity.Order) {}

	// Tidak boleh
	func Create(args entity.Order, ctx context.Context) {}
	```

2. Jangan simpan context sebagai field dalam struct 
   
	```go
	// Tidak boleh
	type User struct {
		ctx context.Context
		Name string
	}
	```

### Return diawal

Dalam setiap function yang mengembalikan nilai seharusnya return diawal.

```go
// Tidak boleh dilakukan
func ParseValue(value Value) (string, error) {
	if !value.MustBeTrue {
		return "", fmt.Errorf("must be true")
	} else {
		if value.Message == "" {
			return "", fmt.Errorf("value must be set")
		} else {
			if value.Priority == 0 {
				return "", fmt.Errorf("priority must be set")
			}

			return fmt.Sprintf("%d %s", value.Priority, value.Message), nil
		}
	}
}
```

Meskipun code diatas berjalan dengan benar, tapi secara bentuk tidak boleh dilakukan. 
Sebaiknya seperti ini.

```go
// Tidak boleh dilakukan
func ParseValue(value Value) (string, error) {
	if !value.MustBeTrue {
		return "", fmt.Errorf("must be true")
	} 

	if value.Message == "" {
		return "", fmt.Errorf("value must be set")
	} 

	if value.Priority == 0 {
		return "", fmt.Errorf("priority must be set")
	}

	return fmt.Sprintf("%d %s", value.Priority, value.Message), nil
}
```
