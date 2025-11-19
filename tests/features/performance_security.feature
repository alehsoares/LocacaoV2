Feature: Performance e Segurança
  Como equipe de engenharia
  Quero garantir metas de latência e proteção de dados
  Para atender requisitos não funcionais

  Background:
    Given ambiente com carga simulada

  Scenario: Latência p95
    When executo testes de carga nas principais rotas
    Then p95 permanece abaixo de 200ms

  Scenario: RLS ativa
    When executo consultas com diferentes perfis
    Then RLS impede acessos indevidos entre tenants

  Scenario: Erros e alertas
    When ocorrem picos de erro 5xx
    Then alertas são disparados e logs correlacionam requisições