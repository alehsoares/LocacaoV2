Feature: Contratos de Locação
  Como usuário
  Quero criar e administrar contratos entre imóvel e inquilino
  Para formalizar a locação e gerenciar obrigações

  Background:
    Given existe um imóvel e um inquilino ativos

  Scenario: Criar contrato
    When crio contrato vinculando imóvel e inquilino
    Then o contrato é salvo com status "ativo" e datas válidas

  Scenario: Anexar documentos
    When adiciono anexos (PDF) ao contrato
    Then os arquivos são armazenados com referência segura

  Scenario: Encerrar contrato
    When encerro o contrato por término
    Then status altera para "encerrado" e notificações são emitidas