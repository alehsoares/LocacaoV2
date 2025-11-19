# Fluxograma Arquitetural Atual — Sistema de Gestão de Locações (SaaS)

```mermaid
flowchart LR
  subgraph Client [Clientes]
    RN[App Mobile - React Native]
  end

  subgraph Edge [Proxy/Segurança]
    Nginx[Nginx + TLS]
  end

  RN -->|HTTPS/REST| Nginx
  Nginx --> API

  subgraph Backend [Backend - Node.js/NestJS]
    API[API REST]
    AUTH[Auth/RBAC]
    TEN[Tenants/Assinaturas]
    IMO[Imóveis]
    INQ[Inquilinos]
    CTR[Contratos]
    SVO[Serviços/OS]
    OBS[Observabilidade/Auditoria]
    Q[Fila de Jobs - BullMQ]
  end

  API --> AUTH
  API --> TEN
  API --> IMO
  API --> INQ
  API --> CTR
  API --> SVO
  API --> OBS

  subgraph Data [Dados]
    PG[(Postgres)]
    RED[(Redis)]
    STG[(Armazenamento anexos/S3 compat.)]
  end

  AUTH --> PG
  TEN --> PG
  IMO --> PG
  INQ --> PG
  CTR --> PG
  SVO --> PG
  OBS --> PG

  Q --> RED
  SVO --> Q

  subgraph Integrations [Integrações]
    EM[Email Provider]
    SMS[SMS Provider]
    PUSH[Push Provider]
  end

  Q --> EM
  Q --> SMS
  Q --> PUSH

  SVO --> RN

  classDef storage fill:#f7f7f7,stroke:#333,stroke-width:1px;
  class PG,RED,STG storage;
```

Notas:
- Fluxos síncronos via REST/HTTPS; assíncronos via fila BullMQ/Redis.
- Isolamento multi-tenant no Postgres (RLS) e camada de serviço.
- Notificações podem usar WebSocket/Push; emails/SMS via provedores externos.