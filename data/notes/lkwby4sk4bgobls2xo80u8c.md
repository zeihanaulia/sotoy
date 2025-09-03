<!-- markdownlint-disable no-missing-space-atx -->
#software-architechture
#diagram
<!-- markdownlint-disable no-missing-space-atx -->

C4 Diagram terdiri dari 4 tahap

1. Context
2. Contaners
3. Component
4. Code

Yang akan digambar hanya 1-3 saja, sedangkan code itu adalah code yang akan kita tulis. ref: [simon tweet](https://twitter.com/simonbrown/status/1580504505086795778)
Context menggambarkan `Big Picture` atau bagaimana user akan menggunakan sistem yang sedang kita bangun.

## C4 on VSCode with PlantUML extension

Salah satu tools untuk mempermudah membuat diagram salah satunya dengan vscode dan plugin PlantUML

![plantuml extension](assets/C4-plantuml-extension.png)

Jadi si plantuml ini dapat menterjemahkan code atau notasi menjadi gambar menggunakan plantuml server.

Cara setupnya cukup mudah, kita membutuhkan plantuml server yang bisa di run menggunakan docker

```bash
docker run -d -p 3025:8080 plantuml/plantuml-server:jetty
docker run -d -p 3025:8080 plantuml/plantuml-server:tomcat
```

Lalu sematkan link server di settings vscode

![config plantuml vscode](assets/C4-config-plantuml-vscode.png)

Setelah itu untuk menggunakan C4 kita butuh tambahan annotation yang bisa kita gunakan dari [https://github.com/plantuml-stdlib/C4-PlantUML](https://github.com/plantuml-stdlib/C4-PlantUML)

kita coba dengan membuat file context.puml

```bash
@startuml Basic Sample
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

Person(admin, "Administrator")
System_Boundary(c1, "Sample System") {
    Container(web_app, "Web Application", "C#, ASP.NET Core 2.1 MVC", "Allows users to compare multiple Twitter timelines")
}
System(twitter, "Twitter")

Rel(admin, web_app, "Uses", "HTTPS")
Rel(web_app, twitter, "Gets tweets from", "HTTPS")
@enduml
```

lalu kita render dan hasilnya

![plantuml vscode preview](assets/C4-plantuml-vscode-preview.png)
