
#go

Ada banyak cara dalam membuat HTTP Server pada golang.
Kita bisa menggunakan standard libary golang `net/http` atau selain itu. seperti:

- chi
- mux
- gin
- dll

### Standard Library

```go
package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"time"
)

var (
	port            = flag.Int("port", 8080, "http port to listen on")
	shutdownTimeout = flag.Duration("shutdown-timeout", 30*time.Second,
		"shutdown timeout (5s,5m,5h) before connections are cancelled")
)

func main() {
	flag.Parse()

	http.HandleFunc("/info", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("===================================================")
		log.Printf("Query-string: %s", r.URL.RawQuery)
		log.Printf("Path: %s", r.URL.Path)
		log.Printf("Method: %s", r.Method) // type method yang diterima 
		log.Printf("Host: %s", r.Host)

		for k, v := range r.Header { // baca header
			log.Printf("Header %s=%s", k, v)
		}

		if r.Body != nil { // baca body / payload data
			body, _ := ioutil.ReadAll(r.Body)
			log.Printf("Body: %s", string(body))
		}
		log.Printf("===================================================")

		w.WriteHeader(http.StatusAccepted)
	})

	port := 8080
	s := &http.Server{
		Addr:           fmt.Sprintf(":%d", port),
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}
	
	c := make(chan os.Signal, 1)
	signal.Notify(c, syscall.SIGINT, syscall.SIGTERM)

	go func() {
		log.Printf("Listening on port :%d\n", port)
		if err := s.ListenAndServe(); err != nil {
			if err != http.ErrServerClosed {
				log.Fatal(err)
			}
		}
	}()

	sig := <-c
	log.Printf("shutting down: %+v", sig)

	ctx, cancel := context.WithTimeout(context.Background(), *shutdownTimeout)
	defer cancel()

	if err := s.Shutdown(ctx); err != nil {
		log.Fatal(err)
	}
}
```
