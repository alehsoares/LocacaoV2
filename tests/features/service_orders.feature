Feature: Serviços/Ordens de Serviço
  Como inquilino
  Quero solicitar serviços relacionados ao imóvel alugado
  Para manter o bom funcionamento e registrar custos/abatimentos

  Background:
    Given estou autenticado como "Inquilino"
    And existe contrato ativo

  Scenario: Abrir OS
    When abro uma OS de manutenção
    Then o sistema cria OS com status "aberta"

  Scenario: Aprovação pelo usuário
    Given a OS está "aberta"
    When o usuário aprova a execução
    Then status muda para "aprovada" e custo estimado é registrado

  Scenario: Faturamento/Abatimento
    When a OS é concluída
    Then custo é faturado ou abatido no aluguel conforme regra