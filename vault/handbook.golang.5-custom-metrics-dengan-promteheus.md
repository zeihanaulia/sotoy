---
id: 85suwlt8zylgcra3sradjfs
title: 5 Custom Metrics Dengan Promteheus
desc: ''
updated: 1668404817226
created: 1668404191056
---

```go
package middleware

import (
    "strconv"

    "github.com/gin-gonic/gin"
    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promauto"
)

var (
    dflBuckets = []float64{300, 1200, 5000}
)

const (
    reqsName           = "requests_total"
    latencyName        = "request_duration_milliseconds"
    patternReqsName    = "pattern_requests_total"
    patternLatencyName = "pattern_request_duration_milliseconds"
)

var (
    requestTotal = promauto.NewCounterVec(
        prometheus.CounterOpts{
            Namespace: "core",
            Name:      reqsName,
            Help:      "How many HTTP requests processed, partitioned by status code, method and HTTP path.",
        },
        []string{"code", "method", "path"},
    )
)

func APMPrometheus() gin.HandlerFunc {
    return func(c *gin.Context) {

        c.Next()

        status := strconv.Itoa(c.Writer.Status())
        requestTotal.With(prometheus.Labels{"code": status, "method": c.Request.Method, "path": c.FullPath()}).Inc()
    }
}

```

