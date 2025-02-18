
## Dump notes

### Web APIs

- Metadata
  - Referensi metadata pada webapis
    - [https://opensource.zalando.com/restful-api-guidelines/#](https://opensource.zalando.com/restful-api-guidelines/#)
      - MUST contain API meta information [218]
      - MUST use semantic versioning [116]
      - MUST provide API identifiers [215]
      - MUST provide API audience [219]
      - MUST/SHOULD use functional naming schema [223]
      - MUST follow naming convention for hostnames [224]
  - [Nobody understands REST or HTTP](https://steveklabnik.com/writing/nobody-understands-rest-or-http)
  - [Metadata with stripe-go](https://www.youtube.com/watch?v=qeCDxIfneww&feature=emb_title)
  
- Idempotency
  - [https://openbanking.atlassian.net/wiki/spaces/DZ/pages/5786479/Payment+Initiation+API+Specification+-+v1.1.0#PaymentInitiationAPISpecification-v1.1.0-Idempotency.1](https://openbanking.atlassian.net/wiki/spaces/DZ/pages/5786479/Payment+Initiation+API+Specification+-+v1.1.0#PaymentInitiationAPISpecification-v1.1.0-Idempotency.1)
  - [https://www.payway.com.au/docs/rest.html#avoiding-duplicate-posts](https://www.payway.com.au/docs/rest.html#avoiding-duplicate-posts)
  - [https://gocardless.com/blog/idempotency-keys/](https://gocardless.com/blog/idempotency-keys/)
  - [https://stripe.com/docs/api/idempotent_requests](https://stripe.com/docs/api/idempotent_requests)

- Internazionale
  - Casdoor i18n

### Devcontainer

- [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)

### Nix

- [https://github.com/kclejeune/system](https://github.com/kclejeune/system)

### Datadog

- [2021 - Datadog Cloud Monitoring Quick Start Guide](https://learning.oreilly.com/library/view/datadog-cloud-monitoring/9781800568730/)
- [2019 - Building a real-time metrics database for trillions of points per day - Joel Barciauskas (Datadog)](https://learning.oreilly.com/videos/oreilly-software-architecture/0636920333777/0636920333777-video329424/)

### API Management

- API Gateway
  - KrakenD
  - Kong
  - Tyk

- API Evolution
  - [API Evolution without Versioning with Brandon Byars](https://www.infoq.com/podcasts/api-evolution-without-versioning)
    - [mountebank](http://www.mbtest.org/)

### Identity & Access Management

- All About JWT
  - [Symmetric vs Asymmetric JWTs](https://medium.com/@swayamraina/symmetric-vs-asymmetric-jwts-bd5d1a9567f6)
  - [The Hard Parts of JWT Security Nobody Talks About](https://www.pingidentity.com/en/resources/blog/post/jwt-security-nobody-talks-about.html)

- Existing tools
  - [Keycloak](https://www.keycloak.org/)
  - [Casdoor](https://github.com/casdoor/casdoor)

Referensi:

- [https://github.com/kdeldycke/awesome-iam](https://github.com/kdeldycke/awesome-iam)

### Frontend Development

#### Web

- React
- Vue

#### Mobile

- React Native
- Kotlin

### Software Architechture

#### Diagraming

- [https://c4model.com/](https://c4model.com/)
- [The C4 Model for Software Architecture](https://www.infoq.com/articles/C4-architecture-model/)
- [Automated Software Architecture Visualization & Emergent Understanding](https://esilva.net/articles/automated-software-architecture-visualization)
  
### Golang

- Error Handling
  - [Error Flags](https://npf.io/2021/04/errorflags/)
  - [Error handling in Go HTTP applications](https://www.joeshaw.org/error-handling-in-go-http-applications/)

- Memory Profiling
  - untuk gin [https://github.com/gin-contrib/pprof](https://github.com/gin-contrib/pprof)
  - ambil data heap
    - curl http://localhost:8787/debug/pprof/heap > heap.6.pprof
    - go tool pprof heap.pprof 
  
### Continous Profiling

- pyroscope
  - belum bisa melakukan profiling memory

### Observability

[[notes.observability]]

- [Observability-driven development with Go and Tracetest](https://tracetest.io/blog/observability-driven-development-with-go-and-tracetest) 
- [Why metrics, logs, and traces aren’t enough](https://www.elastic.co/blog/observability-profiling-metrics-logs-traces)
- [Grafana Docs](https://grafana.com/docs/grafana/latest/)

