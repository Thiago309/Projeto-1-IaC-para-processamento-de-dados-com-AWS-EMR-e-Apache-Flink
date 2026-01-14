# Projeto 1 - IaC para processamento de dados com AWS EMR e Apache Flink

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Engenharia de Dados](https://img.shields.io/badge/Engenharia%20de%20Dados-orange?style=for-the-badge)

> **Resumo:** O objetivo principal deste projeto é automatizar a configuração e o gerenciamento da infraestrutura necessária para executar pipelines de processamento de dados em lote e streaming, capazes de lidar com grandes volumes de dados com baixa latência. Automatizei o provisionamento da Infraestrutura de engenharia de dados através de IaC com Terraform. No ambiente AWS utilizei o serviço de processamento distribuídos para big data: o cluster EMR com o sistemas de arquivos apache hadoop (hdfs) e o pacote de aplicativo Apache Flink. E como exemplo de processamento, executei um script de exemplo padrão do apache flink que conta a quantidade de palavras existentes em um determinado volume de dados.
---
## 📂 Estrutura do Projeto

```bash
PROJETO-1-IAC-PARA-PROCESSAMENTO-DE-DADOS-COM-AWS-EMR-E-APACHE-FLINK/
├── assets/                    # Recursos visuais (GIFs e imagens)
│   ├── gif.html
│   └── projeto1-sem-grade.gif
├── IaC/                       # Infraestrutura como Código (Terraform)
│   ├── emr/                   # Módulo do Cluster EMR
│   │   ├── emr.tf             # Configuração do Cluster
│   │   ├── iam.tf             # Roles e Políticas de acesso (IAM)
│   │   └── security_groups.tf # Regras de Firewall (Security Groups)
│   ├── network/               # Módulo de Rede
│   │   ├── constants.tf       # Definição de Multi AZ's
│   │   └── main.tf            # Definição de VPC e Subnets
│   ├── s3/                    # Módulo de Armazenamento
│   │   ├── job/               # Dados a serem enviados
│   │   │   └── dados.txt
│   │   └── s3.tf              # Criação dos Buckets
│   ├── ssh/                   # Configuração de chaves de acesso ssh
│   │   └── main.tf
│   ├── config.tfvars          # Valores das variáveis do projeto
│   └── main.tf                # Orquestrador principal do Terraform
├── .gitattributes
├── .gitignore
├── Dockerfile                 # Ambiente Docker para execução do Terraform
├── LEIAME.txt                 # Instruções rápidas
├── LICENSE
└── README.md                  # Documentação oficial
```
---
## ☁️ Diagrama de Arquitetura do Projeto

![Diagrama](./assets/projeto1-sem-grade.gif)
