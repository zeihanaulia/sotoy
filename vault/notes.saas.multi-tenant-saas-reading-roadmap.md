---
id: notes.saas.multi-tenant-saas-reading-roadmap
title: "Roadmap Baca Multi-Tenant SaaS"
desc: "Panduan buku lanjutan berdasarkan fungsi chapter di Building Multi-Tenant SaaS Architectures."
updated: 1778452613289
created: 1778384059557
tags:
  - saas
  - reading-roadmap
  - architecture
---

Gue melihat buku Tod Golding sebagai "hub" untuk peta SaaS multi-tenant. Kalau lo ingin deep dive, logikanya bukan cari buku yang judulnya mirip, tapi cari buku yang cocok dengan fungsi chapter itu dalam sistem.

Golding: peta SaaS multi-tenant.
Buku lanjutan: zoom lens per komponen.

## Prinsip dasar rekomendasi

- chapter mindset → buku arsitektur umum
- chapter mekanisme spesifik (auth, data, observability, Kubernetes) → buku yang fokus ke mekanisme itu
- Golding memberi konteks dan jaringan keputusan; follow-up memberi detail implementasi nyata

## Chapter → buku lanjutan

1. The SaaS Mindset
   - [Fundamentals of Software Architecture](https://www.thoughtworks.com/en-sg/insights/books/fundamentals-of-software-architecture)
   - [Software Architecture: The Hard Parts](https://www.oreilly.com/library/view/software-architecture-the/9781098115414/)

2. Multi-Tenant Architecture Fundamentals
   - [Designing Data-Intensive Applications](https://www.amazon.sg/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321)
   - [Designing Distributed Systems](https://books.google.com/books/about/Designing_Distributed_Systems.html?id=WiWDtgEACAAJ)

3. Multi-Tenant Deployment Models
   - [Fundamentals of Software Architecture](https://www.thoughtworks.com/en-sg/insights/books/fundamentals-of-software-architecture)
   - [Cloud Native Transformation](https://www.amazon.sg/Cloud-Native-Transformation-Practical-Innovation/dp/1492048909)

4. Onboarding and Identity
   - [OAuth 2 in Action](https://oauth.net/books/)
   - [API Security in Action](https://www.manning.com/books/api-security-in-action)

5. Tenant Management
   - [Platform Engineering](https://nlb.overdrive.com/media/11240886)
   - [Team Topologies](https://teamtopologies.com/book)

6. Tenant Authentication and Routing
   - [OAuth 2 in Action](https://oauth.net/books/)
   - [API Security in Action](https://www.manning.com/books/api-security-in-action)
   - [Building Microservices](https://samnewman.io/books/building_microservices_2nd_edition/)

7. Building Multi-Tenant Services
   - [Building Microservices, 2nd Edition](https://samnewman.io/books/building_microservices_2nd_edition/)
   - [Monolith to Microservices](https://samnewman.io/books/monolith-to-microservices/)

8. Data Partitioning
   - [Designing Data-Intensive Applications](https://www.amazon.sg/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321)
   - [Fundamentals of Data Engineering](https://www.amazon.com/Fundamentals-Data-Engineering-Robust-Systems/dp/1098108302)

9. Tenant Isolation
   - [API Security in Action](https://www.manning.com/books/api-security-in-action)
   - [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/raw/toc.html)

10. EKS (Kubernetes) SaaS: Architecture Patterns and Strategies
   - [Cloud Native DevOps with Kubernetes](https://books.apple.com/us/book/cloud-native-devops-with-kubernetes/id1614857310)
   - [Kubernetes Patterns](https://leanpub.com/k8spatterns/)

11. Serverless SaaS: Architecture Patterns and Strategies
   - [Serverless Architectures on AWS](https://www.manning.com/books/serverless-architectures-on-aws)
   - [Designing Distributed Systems](https://books.google.com/books/about/Designing_Distributed_Systems.html?id=WiWDtgEACAAJ)

12. Tenant-Aware Operations
   - [Observability Engineering](https://www.honeycomb.io/observability-engineering-oreilly-book)
   - [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/raw/toc.html)

13. SaaS Migration Strategies
   - [Monolith to Microservices](https://samnewman.io/books/monolith-to-microservices/)
   - [Cloud Native Transformation](https://www.amazon.sg/Cloud-Native-Transformation-Practical-Innovation/dp/1492048909)

14. Tiering Strategies
   - [Platform Engineering](https://nlb.overdrive.com/media/11240886)
   - [Fundamentals of Software Architecture](https://www.thoughtworks.com/en-sg/insights/books/fundamentals-of-software-architecture)

15. SaaS Anywhere
   - [Platform Engineering](https://nlb.overdrive.com/media/11240886)
   - [Designing Distributed Systems](https://books.google.com/books/about/Designing_Distributed_Systems.html?id=WiWDtgEACAAJ)

16. GenAI and Multi-Tenancy
   - [AI Engineering](https://nlb.overdrive.com/media/11413819)
   - [API Security in Action](https://www.manning.com/books/api-security-in-action)
   - [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/raw/toc.html)

17. Guiding Principles
   - [Fundamentals of Software Architecture](https://www.thoughtworks.com/en-sg/insights/books/fundamentals-of-software-architecture)
   - [Team Topologies](https://teamtopologies.com/book)

## Insight penting

Di chapter 8 dan 9, ada jebakan yang sering bikin orang salah paham.

- Data partitioning adalah keputusan struktur penyimpanan.
- Tenant isolation adalah properti yang ingin dicapai.

Kalau lo cuma lihat partisi data, lo bisa salah kaprah bahwa "separate DB pasti aman" atau "shared table pasti buruk". Padahal yang benar adalah melihat threat model, operating model, dan tujuan isolasi.

Golding di sini berperan sebagai integrator lintas topik; buku lanjutan itu yang kasih detail implementasi dan pattern untuk tiap problem.
