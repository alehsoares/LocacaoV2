# Sistema de Gestão de Locações — Plano de Execução (Ambiente Dev)

Este projeto descreve o plano e a arquitetura do sistema (SaaS) de gestão de locações. Como ainda não há código implementado, este README orienta o setup inicial e ferramentas recomendadas.

## Pré-requisitos
- Node.js LTS (>= 18)
- npm, yarn ou pnpm
- Docker e Docker Compose
- Git

## Estrutura sugerida de pastas (quando iniciar implementação)
```
backend/
  src/
  prisma/
  .env
mobile/
  src/
  .env
infra/
  docker-compose.yml
  nginx/
  scripts/
tests/
  features/
```

## Ambientes e Variáveis
- `backend/.env`: credenciais do Postgres, Redis, JWT secrets.
- `mobile/.env`: URLs da API e chaves de push.
- Nunca versionar segredos; usar vault ou repositório seguro.

## Execução local (quando houver código)
- Banco e Redis via Docker Compose:
  - `docker compose up -d`
- Backend:
  - `cd backend`
  - `npm install`
  - `cp .env.example .env` e ajustar `DATABASE_URL`
  - `npm run dev` (Swagger em `http://localhost:3000/docs`)
- Mobile:
  - `npm install`
  - `npm run start` e abrir no emulador/dispositivo.

## Testes (visão geral)
- API: Jest + Supertest.
- Mobile: @testing-library/react-native; E2E com Detox.
- BDD: `cucumber-js` com `.feature` em `tests/features`.

## Escopo MVP
- Inclui: Auth/RBAC, Tenants, Imóveis, Inquilinos, Contratos, Serviços/OS (sem faturamento).
- Exclui: Pagamentos (faturas, conciliação, gateway) e Notificações (multi-canal).
- Conta SaaS: painel básico de planos/limites, sem cobrança ativa.
- Observabilidade e segurança mantidas.

## Codestyle e Convenções (TypeScript/NestJS)
- Código e docs em inglês; `one export per file`.
- Tipagem explícita em variáveis, parâmetros e retornos; evitar `any`.
- Funções curtas, single purpose, com nomes iniciando em verbo; imutabilidade preferida.
- Nomenclatura: PascalCase (classes), camelCase (variáveis/métodos), kebab-case (arquivos/pastas), UPPERCASE (envs).
- JSDoc em classes e métodos públicos.
- `tsconfig` com `strict: true` e regras de ESLint/Prettier alinhadas.

## Arquitetura NestJS (módulos e camadas)
- Modularização por domínio (um módulo por rota principal).
- `CoreModule`: filtros globais de exceção, middlewares, guards (RBAC), interceptors (logging/metrics).
- `SharedModule`: utilitários e serviços compartilhados.
- DTOs em pasta de modelos com validação via `class-validator` e transformação via `class-transformer`.
- Documentação de API com Swagger/OpenAPI.

## Validação e Segurança de API
- `ValidationPipe` global com `whitelist: true` e `forbidNonWhitelisted: true`.
- Rate limiting (Nest Rate Limiter) para rotas críticas.
- Sanitização de inputs; cabeçalhos de segurança e TLS.
- Autenticação JWT + refresh; RLS no Postgres; auditoria de acessos.
- Gestão de segredos via `.env` (não versionado) e vault quando aplicável.

## CI/CD — Quality Gates
- Lint e tests obrigatórios em PR; bloqueio de merge em caso de falha.
- Cobertura mínima (módulos críticos ≥ 80%) com relatórios publicados.
- SAST/Dependabot; verificação de secrets; escaneamento de imagens Docker.
- Build, containerização e deploy automatizados para VPS Contabo.

## Padrões de Testes
- Unitários: Arrange-Act-Assert; doubles para dependências.
- Integração: Supertest + Testcontainers (opcional) para DB.
- E2E: Detox para mobile e cenários críticos na API.
- BDD: Given-When-Then conforme `tests/features`.

## Documentação
- Plano detalhado em `plano-implementacao-tarefas.md`.
- Fluxograma arquitetural em `fluxograma-atual.md`.
- Especificação de cenários BDD em `tests/features`.
- Roadmap pós-MVP em `docs/roadmap-pos-mvp.md`.

### ADRs (Architecture Decision Records)
- Local: `docs/adrs/`
- Decisões registradas:
  - `0001-arquitetura-nestjs-modular.md`: organização em módulos, Core/Shared, filtros/guards/interceptors.
  - `0002-orm-prisma-vs-mikroorm.md`: escolha do Prisma, justificativas e trade-offs.
  - `0003-seguranca-apis-validation-rate-limiting-sanitizacao.md`: políticas de validação e segurança.

## Contribuição
- Consulte `CONTRIBUTING.md` para fluxo de trabalho, padrões de commits, quality gates, ADRs e convenções.

## CI/CD (recomendação)
- GitHub Actions: jobs para lint, tests, build, container, deploy em VPS Contabo.
- Docker + Nginx reverso com TLS (Let's Encrypt).

## Observabilidade
- Logs estruturados (pino/winston), Sentry para erros.
- Métricas com Prometheus + Grafana ou APM gerenciado.

## Segurança
- Postgres RLS; JWT + refresh; armazenamento seguro de segredos.
- Backups e DR; hardening de Nginx e host.

## Status
- Este repositório contém documentação e planejamento; implementação será feita em branch dedicada conforme governança de versionamento.