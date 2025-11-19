# Plano Detalhado — Sistema de Gestão de Locações (SaaS)

Este documento consolida a análise de requisitos, arquitetura proposta, seleção tecnológica, cronograma, plano de qualidade e documentação para o sistema descrito em `instructions.md` (`d:\AleHSoares\Projetos\Trae\LocacaoV2\instructions.md`).

## 1. Análise de Requisitos

### 1.1. Requisitos Funcionais (extraídos e detalhados)
- Super Admin: visão total de dados e usuários; administração do SaaS (ref.: `instructions.md:8`).
- Usuário (cliente do SaaS): acesso apenas aos seus imóveis e dados dos moradores (ref.: `instructions.md:9-10`).
- Inquilinos: criados pelo usuário; associação a um ou mais imóveis; acesso ao imóvel e contrato e serviços relacionados (ref.: `instructions.md:11`).
- Contrato: formaliza relação usuário × imóvel × inquilino (ref.: `instructions.md:12`).
- Gestão de pagamentos: por contrato, acompanhar cobranças, status, comprovantes (ref.: `instructions.md:13`).
- Gestão de serviços: por contrato, ordens de serviço (limpeza, manutenção etc.), solicitação pelo inquilino, custo/abatimento no aluguel (ref.: `instructions.md:14`).
- Gestão da conta: usuário visualiza mensalidade, limites, histórico de pagamentos da assinatura SaaS (ref.: `instructions.md:15`).
- Notificações: alertas para usuário e/ou inquilino sobre expiração de contrato, pagamento pendente, eventos críticos (ref.: `instructions.md:16`).
- Interface intuitiva e responsiva: uso em mobile e PC; acessibilidade para públicos com baixa familiaridade tecnológica (ref.: `instructions.md:4,17`).

### 1.2. Requisitos Não Funcionais (extraídos e detalhados)
- Segurança: proteção de dados, isolamento entre clientes, conformidade (ref.: `instructions.md:20`).
- Performance: respostas rápidas; metas de latência p95 (ref.: `instructions.md:21`).
- Disponibilidade: alta disponibilidade; operação 24×7 (ref.: `instructions.md:22`).
- Escalabilidade: capacidade de crescer em número de usuários/inquilinos sem degradação (ref.: `instructions.md:23`).
- Manutenibilidade: arquitetura bem projetada, modular, com baixo acoplamento (ref.: `instructions.md:24`).

### 1.3. Stakeholders
- Super Admin do SaaS.
- Usuários (proprietários/administradores de imóveis).
- Inquilinos.
- Equipe de Suporte/Operações.
- Financeiro/Contabilidade (do SaaS e dos usuários, para integração de cobranças).
- Equipe de Engenharia (dev/backend/frontend/mobile, QA, DevOps).

### 1.4. Casos de Uso Principais
- Autenticação e autorização (RBAC) para Super Admin, Usuário e Inquilino.
- Onboarding de Usuário (assinatura SaaS) e criação de imóveis.
- Gestão de Inquilinos e associação a imóveis.
- Criação e assinatura de contratos (inclui anexos e termos).
- Emissão e controle de cobranças (mensalidades do contrato e do SaaS).
- Registro e tratamento de serviços/solicitações (OS) com fluxo de aprovação e faturamento.
- Notificações (expiração, pendências, eventos operacionais) via push/email/SMS.
- Gestão da conta do Usuário (limites, histórico de pagamentos, planos).
- Relatórios e dashboards (ocupação, inadimplência, custos, receitas).

### 1.5. Métricas de Sucesso (MVP)
- Disponibilidade ≥ 99,9% mensal.
- Latência p95 de API ≤ 200 ms em operações padrão.
- Zero vazamento entre tenants (testes de isolamento passam 100%).
- Tempo de onboarding (cadastro + primeiro imóvel) ≤ 10 minutos.
- Cobertura de testes ≥ 80% em módulos críticos (auth, contratos, domínio imobiliário).

### 1.6. Critérios de Aceitação (MVP)
- Auth/RBAC: login/logout; renovação de token; acesso respeita papéis; isolamento por tenant.
- Imóveis/Inquilinos: CRUD completo; associação N:N com validações; histórico.
- Contratos: criação, versão, anexos, status (ativo/suspenso/encerrado).
- Serviços: abertura pelo inquilino, aprovação pelo usuário, execução (sem faturamento/abatimento).
- Conta: exibição de limites/plano e informações básicas da assinatura (sem cobrança SaaS ativa).
- UI/UX: responsivo; acessibilidade básica (contraste, tamanho fonte, labels).

## 2. Arquitetura do Sistema

### 2.1. Estilo Arquitetural
- Modular monolito orientado a domínios (DDD leve) como fase inicial, com fronteiras claras para futura extração em microserviços.
- Multi-tenant: esquema único com `tenant_id` em todas as entidades e Postgres Row-Level Security (RLS) + filtros em camada de serviço.

### 2.2. Componentes Principais
- Identidade e Acesso: autenticação (JWT), autorização (RBAC), gestão de sessões/refresh.
- Tenants/Assinaturas: cadastro de usuários do SaaS, planos, limites e faturamento SaaS.
- Imóveis: cadastro, atributos, documentação.
- Inquilinos: cadastro, documentos, relação N:N com imóveis.
- Contratos: termos, anexos, status, vínculo usuário × imóvel × inquilino.
- Pagamentos: faturas, boletos/cartão/pix (gateway), conciliação e comprovantes.
- Serviços/OS: solicitações, aprovação, execução, custos/abatimentos.
- Notificações: orquestração de eventos, canais (push/email/SMS), templates e logs.
- Observabilidade/Auditoria: logs estruturados, métricas, rastreabilidade, trilhas de auditoria.
- Portal Super Admin: administração global (usuários, planos, limites, saúde do sistema).

### 2.3. Interações e Fluxos
- REST/HTTPS para operações síncronas; WebSocket para notificações em tempo real.
- Fila de mensagens (Redis + BullMQ) para tarefas assíncronas (notificações, conciliação, expirações).
- Webhooks para integrações (gateway de pagamento, provedores de email/SMS/push).

### 2.4. Modelo de Dados (visão de alto nível)
- `tenant(id, nome, plano, limites, status)`
- `user(id, tenant_id, role, email, hash_senha, ativo)`
- `property(id, tenant_id, endereço, atributos...)`
- `person(id, tenant_id, tipo=inquilino, dados...)`
- `property_person(property_id, person_id, vínculo)`
- `contract(id, tenant_id, property_id, person_id, status, anexos...)`
- `invoice(id, tenant_id, contract_id, valor, vencimento, status)`
- `payment(id, tenant_id, invoice_id, método, status, comprovante_url)`
- `service_order(id, tenant_id, contract_id, tipo, custo, status)`
- `notification(id, tenant_id, canal, template, status, meta)`
- `account_billing(id, tenant_id, plano, ciclo, faturas)`

### 2.5. Segurança
- JWT assinado + refresh; 2FA opcional.
- Postgres RLS + validações por `tenant_id` em todas as queries.
- Criptografia em repouso para dados sensíveis e em trânsito (TLS).
- Gestão de segredos via variáveis de ambiente (.env) com vault opcional.
- Auditoria de acessos e alterações em entidades críticas.

## 3. Seleção de Tecnologias (alinhada ao arquivo)

### 3.1. Front-end (Mobile)
- React Native (ref.: `instructions.md:27`), UI com componentes nativos.
- Navegação: `@react-navigation/native`.
- Testes: `@testing-library/react-native` e `detox` (E2E).

### 3.2. Back-end
- Node.js LTS (ref.: `instructions.md:28`).
- Framework: NestJS (organização modular, DI, robustez). Alternativa: Express + estrutura própria.
- ORM: Prisma (tipos fortes, migrações, suporte Postgres).
- Jobs/Fila: BullMQ com Redis.
- Documentação de API: OpenAPI/Swagger.

### 3.3. Banco de Dados
- Postgres (ref.: `instructions.md:29`) para relacional principal.
- Redis para cache/fila e sessões.

### 3.4. Infra e CI/CD
- Hospedagem: VPS Contabo (ref.: `instructions.md:30`).
- Contêineres: Docker + Docker Compose; Nginx como reverse proxy; TLS com Let's Encrypt.
- CI/CD: GitHub Actions (lint, testes, build, docker, deploy).
- Observabilidade: Prometheus + Grafana ou APM (Sentry para erros).

### 3.5. Justificativas
- NestJS/Prisma aceleram entrega e trazem padrões sólidos (modularidade/manutenibilidade).
- Redis/BullMQ simplificam orquestração de tarefas assíncronas e escalabilidade inicial.
- Docker/Nginx em VPS são acessíveis, com caminho de evolução para Kubernetes quando necessário.

## 4. Cronograma de Desenvolvimento (MVP)

- Fase 0 — Descoberta/Design (2 semanas):
  - Detalhar requisitos, ADRs, backlog, protótipos de UX.
  - Entregáveis: documentação de requisitos, protótipo navegável.

- Fase 1 — Fundamentos (3 semanas):
  - Setup repositórios, CI/CD, Docker, base NestJS, Prisma, schemas iniciais, Auth/RBAC.
  - Entregáveis: login, cadastro, tenants, isolamento básico, Swagger inicial.

- Fase 2 — Domínio Imobiliário (4 semanas):
  - Imóveis, Inquilinos, associações N:N, contratos e anexos.
  - Entregáveis: CRUDs completos, fluxo de criação de contrato.

- Fase 3 — Serviços Básicos (3 semanas):
  - OS/serviços com fluxo de abertura, aprovação e execução (sem integração de custo/faturamento).
  - Entregáveis: ciclo de vida de OS com auditoria e histórico.

- Fase 4 — Conta (2 semanas):
  - Painel básico de conta SaaS (planos e limites, sem cobrança ativa).
  - Entregáveis: visualização de plano/limites e uso.

- Fase 5 — Qualidade/Observabilidade (3 semanas):
  - Testes unitários/integrados/E2E, cobertura; logs/métricas; hardening segurança.
  - Entregáveis: cobertura ≥80% nos módulos críticos; dashboards operacionais.

- Fase 6 — Beta/Feedback (2 semanas):
  - Piloto com poucos usuários; ajustes de UX e performance.
  - Entregáveis: relatório de feedback e melhorias aplicadas.

- Fase 7 — Produção/Go-Live (2 semanas):
  - Preparação infra, monitoramento, runbooks; migrações finais.
  - Entregáveis: ambiente produtivo estável, plano de suporte.

## 5. Plano de Qualidade

### 5.1. Testes
- Unitários: serviços e regras de negócio (Jest).
- Integração: API + DB (Supertest + Testcontainers quando possível).
- E2E: fluxos críticos no mobile (Detox) e API end-to-end.
- BDD: cenários `.feature` (Cucumber) para casos de uso principais.

### 5.2. Padrões de Código e Revisões
- ESLint + Prettier; Conventional Commits; PRs com revisão obrigatória.
- ADRs para decisões arquiteturais; documentação atualizada em cada release.

### 5.3. Monitoramento e Métricas
- Logs estruturados (JSON), correlação de requisições.
- Métricas de latência, erros, throughput, filas.
- Alertas proativos (picos de erro/latência, falha em notificações).

## 6. Documentação

### 6.1. Técnica Necessária
- Diagramas (arquitetura, dados, sequência de eventos).
- OpenAPI para API; guias de módulos.
- Runbooks de operação; instruções de deploy.

### 6.2. Manuais e Guias
- README de setup (dev e produção em VPS Contabo).
- Manual do usuário (Super Admin, Usuário, Inquilino).

### 6.3. Diagramas
- Fluxograma arquitetural inicial em `fluxograma-atual.md` (Mermaid) cobrindo mobile, backend, DB, filas e canais de notificação.

---

## 7. Roteiro de Entregáveis por Release (MVP)
- v0.1: Auth/RBAC, Tenants, CRUD básico de Imóveis/Inquilinos.
- v0.2: Contratos com anexos; Swagger completo dos domínios.
- v0.3: Serviços/OS sem faturamento; auditoria e histórico.
- v0.4: Conta SaaS básica (planos/limites); relatórios operacionais iniciais.
- v1.0 (MVP): Go-live sem pagamentos/notificações; monitoramento; suporte e SLA.

## 8. Riscos e Mitigações
- Gateway de pagamento: latência/indisponibilidade — fila + retentativas + webhooks resilientes.
- Notificações: entrega variável — multi-provedor e fallback.
- Isolamento multi-tenant: erro humano em queries — RLS + testes de isolamento automatizados.
- Escala em VPS: limitação de recursos — observabilidade e planejamento de migração para Kubernetes.

## 9. Critérios de Pronto para Produção
- Cobertura de testes atingida; auditoria de segurança; documentação e runbooks.
- Observabilidade ativa; alertas configurados; backups e DR testados.