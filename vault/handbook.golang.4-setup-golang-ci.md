---
id: handbook.golang.4-setup-golang-ci
title: 4 Setup Golang CI
desc: ''
updated: 1646862695992
created: 1646862422149
---

#go #linter

Linter sangat membantu untuk melakukan standarisasi code.
Mereka juga bisa mengecek jika ada kode yang tidak efektif atau bugs kecil.

Cara setupnya cukup mudah

- Windows & Linux

	untuk windows bisa gunakan git bash agar bisa menggunakan `curl`.

	```bash
		# binary will be $(go env GOPATH)/bin/golangci-lint
		curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.43.0

		golangci-lint --version
	```

- Mac

	```bash
		brew install golangci-lint
		brew upgrade golangci-lint
	```

Informasi lebih lanjut bisa cek di [https://golangci-lint.run/usage/install/](https://golangci-lint.run/usage/install/).
