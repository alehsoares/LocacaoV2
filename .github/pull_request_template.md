# Template de Pull Request

## Descrição
Explique claramente o objetivo do PR, o problema que resolve e o escopo das mudanças.

## Checklist — Quality Gates e Conformidade
- [ ] Issue vinculada (ex.: `#123`) e contexto de negócio descrito
- [ ] ADR(s) referenciadas e, se necessário, novas ADRs criadas
- [ ] Lint/Prettier passando sem erros/avisos
- [ ] Testes unitários e de integração passando
- [ ] Cobertura mínima atingida (módulos críticos ≥ 80%) com relatório publicado
- [ ] Testes E2E (quando aplicável) passando
- [ ] BDD (`tests/features`) atualizado conforme mudanças
- [ ] Swagger/OpenAPI atualizado para endpoints/DTOs
- [ ] Validação: `ValidationPipe` global ativa; DTOs com `class-validator`/`class-transformer`
- [ ] Segurança: rate limiting em rotas críticas; sanitização de inputs; cabeçalhos/TLS
- [ ] Multi-tenant: verificados filtros por `tenant_id` e testes de isolamento (RLS)
- [ ] Observabilidade: logs estruturados e métricas para novas rotas/serviços
- [ ] CI/CD: SAST/Dependabot sem vulnerabilidades bloqueantes
- [ ] Secrets: verificação sem exposições
- [ ] Docker: imagem construída e escaneada (sem CVEs críticos)
- [ ] Documentação atualizada (`README.md`, `plano-implementacao-tarefas.md`, fluxogramas)
- [ ] Plano de rollback descrito quando aplicável

## Resumo das Mudanças
Liste os principais arquivos modificados e a natureza das alterações.

## ADRs Relacionadas
Referencie os arquivos em `docs/adrs/` relevantes para este PR.

## Evidências de Testes
Inclua saídas/resumos de cobertura, casos exercitados e links para pipelines.

## Plano de Deploy
Descreva passos, migrações e dependências; inclua validações pós-deploy.