
#go #docker

```Dockerfile
FROM golang:1.17 as build
WORKDIR /app
ADD . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .
CMD ["go", "run", "main.go"]

FROM gcr.io/distroless/base-debian10 as production
COPY --from=build /app/main /
EXPOSE 8080

CMD ["/main"]
```

- `FROM golang:1.17 as build`
	
	build akan dialankan pada golang versi1.17, versi bisa disesuaikan dengan versi golang saat ini.

- `WORKDIR /app`

	Buat folder /app sebagai working directory 

- `ADD . .`

	copy source code kita dengan `ADD . .`

- `RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .`

	build source code hingga menjadi binary dan filenya nanti akan bernama main

- `FROM gcr.io/distroless/base-debian10 as production`

	selanjutnya ambil image minimal menggunakan distroless base image.
	info selanjutnya bisa dibaca disini [https://github.com/GoogleContainerTools/distroless](https://github.com/GoogleContainerTools/distroless).

- `COPY --from=build /app/main /`

	lalu copy binary apliasi yang sudah dibuat sebelumnya.

- `COPY --from=build /app/main /`

	copy binary dari build stage ke root
  
- `EXPOSE 8080`

	expose 8080

- `CMD ["/main"]`

	runing command `/main`
