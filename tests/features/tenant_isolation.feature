Feature: Isolamento Multi-Tenant
  Como operador do sistema
  Quero garantir que dados não vazem entre tenants
  Para assegurar privacidade e conformidade

  Background:
    Given existem dois tenants A e B
    And há imóveis e contratos em ambos os tenants

  Scenario: Query filtra por tenant_id
    When a API consulta contratos do tenant A
    Then somente contratos de A são retornados

  Scenario: RLS impede acesso direto
    When uma query tenta acessar registros do tenant B sem permissão
    Then o Postgres RLS bloqueia e retorna erro

  Scenario: Backup e restore por tenant
    When um restore seletivo é feito para tenant A
    Then dados de B não são afetados