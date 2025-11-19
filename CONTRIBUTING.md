# Contribuição — Guia de Boas Práticas

## Objetivo
Padronizar o fluxo de trabalho, qualidade e segurança para evoluir o sistema com consistência e previsibilidade.

## Fluxo de Trabalho (Git/GitHub)
- Crie uma issue descrevendo a mudança e relacione requisitos/ADRs.
- Abra uma branch: `feature/<id-issue>-descricao` ou `bugfix/<id-issue>-descricao`.
- Abra PR vinculando a issue e ADRs relevantes.
- Exija aprovação de revisão e passing checks (lint, testes, cobertura, SAST).
- Use labels e milestones para planejamento (ex.: v0.1, v0.2).

## Padrão de Commits (Conventional Commits)
- `feat: ...`, `fix: ...`, `docs: ...`, `refactor: ...`, `test: ...`, `chore: ...`.
- Inclua escopo quando aplicável: `feat(auth): add refresh token rotation`.
- Mensagens curtas e objetivas; descreva breaking changes em nota.

## Estratégia de Branches
- `main`: estável e versionada.
- `feature/*`, `bugfix/*`, `hotfix/*`: trabalho diário.
- Releases por tag (semver): `v0.1.0`, `v0.2.0`.

## Qualidade e Segurança (Quality Gates)
- Lint/Prettier obrigatórios; sem erros/avisos.
- Testes unitários e de integração obrigatórios; cobertura mínima:
  - Módulos críticos (auth, contratos, pagamentos) ≥ 80%.
- SAST/Dependabot; verificação de secrets; escaneamento de imagens Docker.
- Bloquear merge quando qualquer check falhar.

## Testes
- Unitários: padrão Arrange-Act-Assert; doubles para dependências.
- Integração: Supertest; uso de Testcontainers opcional para Postgres.
- E2E: Detox (mobile) e rotas críticas da API.
- BDD: Given-When-Then com `.feature` em `tests/features`.

## ADRs (Architecture Decision Records)
- Local: `docs/adrs/`.
- Registre decisões arquiteturais e tecnológicas (ex.: ORM, segurança, módulos).
- Use o template `0000-adr-template.md` e referencie ADRs nas issues/PRs.

## Codestyle e Convenções (TypeScript/NestJS)
- Código e docs em inglês; `one export per file`.
- Tipagem explícita; evitar `any`; funções curtas e imutabilidade preferida.
- Nomenclatura: PascalCase (classes), camelCase (variáveis/métodos), kebab-case (arquivos/pastas), UPPERCASE (envs).
- JSDoc em classes e métodos públicos; `tsconfig` com `strict: true`.

## Arquitetura NestJS
- Modular por domínio.
- `CoreModule`: filtros globais, middlewares, guards e interceptors.
- `SharedModule`: serviços/utilitários compartilhados.
- DTOs com `class-validator`/`class-transformer`; Swagger/OpenAPI.

## Validação e Segurança
- `ValidationPipe` global com `whitelist` e `forbidNonWhitelisted`.
- Rate limiting nas rotas críticas; sanitização de inputs; TLS e cabeçalhos de segurança.
- JWT + refresh; Postgres RLS; auditoria de acessos.
- Segredos via `.env` (não versionado) e vault quando aplicável.

## Documentação
- Atualize `README.md`, `plano-implementacao-tarefas.md` e fluxogramas quando alterar arquitetura/fluxos.
- Mantenha Swagger sincronizado com endpoints e DTOs.

## Revisões e Releases
- Inclua checklist de qualidade no PR.
- Gere notas de release com mudanças, migrações e riscos.