Feature: Notificações
  Como usuário ou inquilino
  Quero ser notificado sobre eventos importantes
  Para tomar ações no tempo correto

  Background:
    Given existe contrato com datas críticas

  Scenario: Expiração de contrato
    When o contrato está próximo da expiração
    Then sistema envia notificação para usuário e inquilino

  Scenario: Pagamento pendente
    When uma fatura está vencida
    Then sistema envia lembrete via email/SMS/push

  Scenario: Falha de entrega e retentativa
    When notificação falha
    Then sistema registra e reenvia conforme política