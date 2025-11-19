Feature: Gestão da Conta do Usuário (SaaS)
  Como usuário do SaaS
  Quero acompanhar plano, limites e cobranças da assinatura
  Para controlar custos e capacidade

  Background:
    Given estou autenticado como "Usuario"

  Scenario: Visualizar plano e limites
    When acesso o painel da conta
    Then vejo plano atual, limites e uso corrente

  Scenario: Histórico de cobranças do SaaS
    When consulto faturas da assinatura
    Then sistema lista valores, status e comprovantes

  Scenario: Alerta de limite excedido
    When uso excede limite contratado
    Then sistema bloqueia operações e orienta upgrade