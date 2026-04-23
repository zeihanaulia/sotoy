

Elastic APM (Application Performance Monitoring) dapat membantu kita dalam hal visibility distributed workload.
Untuk mendapatkan insight kita haru membuat instrumentasi pada aplikasi kita.

## Membuat webrequest

Elastic APM Go Agent memiliki API "tracing" untuk menerima request ke server.
Secara default APM akan mengirimkan data ke http://localhost:8200. 
Jika kita menggunakan APM Server selain di localhost dan melakukan load environment variable pada aplikasi.
Maka khusus untuk variable yang terkait APM sebaiknya di init ketika running, bukan diaplikasi karena ada issue ini [apm-agent-go #618](https://github.com/elastic/apm-agent-go/issues/618).

```go
package main

import (
	"net/http"
`
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func hello(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("welcome"))
}

func main() {
	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Get("/", hello)
	http.ListenAndServe(":3000", r)
}
```

## Setup Kibana dan APM

### Local

Gw asummsikan semua sudah menggunakan docker, sehingga tinggal running dengan docker compose

```Dockerfile
version: '3.7'

services:

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.16.3
    environment:
      - bootstrap.memory_lock=true
      - cluster.name=docker-cluster
      - cluster.routing.allocation.disk.threshold_enabled=false
      - discovery.type=single-node
      - ES_JAVA_OPTS=-XX:UseAVX=2 -Xms1g -Xmx1g
    ulimits:
      memlock:
        hard: -1
        soft: -1
    volumes:
      - elasticsearch:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
    healthcheck:
      interval: 20s
      retries: 10
      test: curl -s http://localhost:9200/_cluster/health | grep -vq '"status":"red"'

  kibana:
    image: docker.elastic.co/kibana/kibana:7.16.3
    depends_on:
      elasticsearch:
        condition: service_healthy
    environment:
      ELASTICSEARCH_URL: http://elasticsearch:9200
      ELASTICSEARCH_HOSTS: http://elasticsearch:9200
    ports:
      - 5601:5601
    healthcheck:
      interval: 10s
      retries: 20
      test: curl --write-out 'HTTP %{http_code}' --fail --silent --output /dev/null http://localhost:5601/api/status
  
  apm-server:
    image: docker.elastic.co/apm/apm-server:7.16.3
    depends_on:
      elasticsearch:
        condition: service_healthy
      kibana:
        condition: service_healthy
    cap_add: ["CHOWN", "DAC_OVERRIDE", "SETGID", "SETUID"]
    cap_drop: ["ALL"]
    ports:
    - 8200:8200
    command: >
       apm-server -e
         -E apm-server.rum.enabled=true
         -E setup.kibana.host=kibana:5601
         -E setup.template.settings.index.number_of_replicas=0
         -E apm-server.kibana.enabled=true
         -E apm-server.kibana.host=kibana:5601
         -E output.elasticsearch.hosts=["elasticsearch:9200"]
    healthcheck:
      interval: 10s
      retries: 12
      test: curl --write-out 'HTTP %{http_code}' --fail --silent --output /dev/null http://localhost:8200/
volumes:
	elasticsearch:
	
```

### Trial Elastic Cloud 

Kalau gak mamu ribet, bisa cobain trial dari [elastic cloud](https://www.elastic.co/cloud/). Kita akan dapat trial selama 14 hari untuk melakukan explorasi fitur firur di APM. Setupnya cukup mudah tinggal klik-klik aja.
Setelah itu masuk ke menu APM, lalu kebagian agent untuk mendapatkan config yang seharusnya.

Kita membutuhkan data environtment variable untuk aplikasi.

```bash
# Initialize using environment variables:

# Set the service name. Allowed characters: # a-z, A-Z, 0-9, -, _, and space.
# If ELASTIC_APM_SERVICE_NAME is not specified, the executable name will be used.
export ELASTIC_APM_SERVICE_NAME=

# Set custom APM Server URL (default: http://localhost:8200)
export ELASTIC_APM_SERVER_URL=https://7ccb1cfa41f5426ba7f29ee7123e8f4c.apm.us-central1.gcp.cloud.es.io:443

# Use if APM Server requires a secret token
export ELASTIC_APM_SECRET_TOKEN=0aaRb0gVrRkaSQdkdR

# Set the service environment
export ELASTIC_APM_ENVIRONMENT=
```

## Instrumenting application

Modifikasi webserver yang kita buat sebelumnya, dengan menambahkan `apmhttp.Wrap(r)`

```go
package main

import (
	"net/http"
`	...

	apmchi "go.elastic.co/apm/module/apmchiv5"
	"go.elastic.co/apm/module/apmhttp"
)

...

func main() {
	r := chi.NewRouter()
	r.Use(apmchi.Middleware())
	...
	http.ListenAndServe(":3000", apmhttp.Wrap(r))
}
```

apmchi adalah middleware yang isinya pembuatan instrument untuk APM.
bukan hanya chi, ada beberapa library lain yang disupport secara resmi.
bisa dilihat disini [https://github.com/elastic/apm-agent-go/tree/main/module](https://github.com/elastic/apm-agent-go/tree/main/module) dan dokumentasinya di [Built-in instrumentation modules](https://www.elastic.co/guide/en/apm/agent/go/master/builtin-modules.html).


