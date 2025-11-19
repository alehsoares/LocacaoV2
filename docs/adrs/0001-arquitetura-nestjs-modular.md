# ADR 0001 — Arquitetura NestJS Modular

## Contexto
A aplicação demanda modularidade por domínio, com capacidade de aplicar políticas globais (exceções, segurança, observabilidade) e compartilhar utilitários entre módulos.

## Decisão
- Adotar arquitetura modular por domínio (um módulo por rota principal).
- Criar `CoreModule` para filtros globais, middlewares, guards e interceptors.
- Criar `SharedModule` para serviços/utilitários compartilhados.
- Padronizar DTOs com `class-validator` e `class-transformer`.
- Documentar API com Swagger/OpenAPI.

## Consequências
- Maior coesão por domínio e menor acoplamento.
- Facilita testes e evolução; fronteiras claras para futura extração de microserviços.

## Implementação
- Estrutura inicial de pastas com módulos por domínio.
- Registro de filtros/guards/interceptors no `CoreModule`.
- Pastas de `dto`, `entities`, `services` em cada módulo.

## Revisão
- Reavaliar na Fase 2/3 quanto a fronteiras e necessidades de extração.