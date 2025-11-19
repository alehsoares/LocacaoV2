# ADR 0002 — ORM: Prisma vs MikroORM

## Contexto
As regras recomendam MikroORM; o planejamento indicou Prisma pela produtividade, tipagem e comunidade.

## Decisão
- Adotar Prisma como ORM principal para Postgres.

## Justificativas
- Tipos gerados fortes e integração estável com Node/NestJS.
- Migrações consistentes; tooling maduro e documentação ampla.
- Comunidade e ecossistema com exemplos e suporte.

## Trade-offs
- MikroORM oferece mapeamento rico e padrões de entidades mais próximos de JPA.
- Prisma limita alguns padrões avançados de entidades; compensado por simplicidade.

## Consequências
- Curva de adoção menor e entregas mais rápidas.
- Necessidade de atenção a padrões DDD para não acoplar serviços a Prisma.

## Implementação
- Definir `schema.prisma` com `tenant_id` em todas as tabelas.
- Migrações versionadas; convenções de repositórios e serviços isolando acesso ao ORM.

## Revisão
- Reavaliar ferramenta a cada marco significativo (ex.: v0.5) com métricas de performance/manutenibilidade.