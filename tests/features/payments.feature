Feature: Gestão de Pagamentos
  Como usuário
  Quero emitir e conciliar cobranças de contratos
  Para controlar receitas e inadimplências

  Background:
    Given existe um contrato ativo com fatura gerada

  Scenario: Emissão de fatura mensal
    When gero fatura do ciclo atual
    Then fatura recebe valor, vencimento e status "pendente"

  Scenario: Pagamento via gateway
    When o inquilino paga via cartão/pix
    Then webhook atualiza status para "pago" e gera comprovante

  Scenario: Inadimplência e lembrete
    When fatura permanece "pendente" após vencimento
    Then sistema envia lembrete e registra evento