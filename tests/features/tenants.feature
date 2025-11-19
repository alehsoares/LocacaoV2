Feature: Gestão de Inquilinos
  Como usuário
  Quero cadastrar inquilinos e associá-los a imóveis
  Para formalizar contratos e gerenciar locações

  Background:
    Given estou autenticado como "Usuario"

  Scenario: Criar inquilino
    When cadastro um inquilino com dados obrigatórios
    Then o sistema retorna ID e status ativo

  Scenario: Associar inquilino a múltiplos imóveis
    Given existem dois imóveis válidos
    When associo o inquilino aos dois imóveis
    Then a relação N:N é criada com sucesso

  Scenario: Restrições de duplicidade
    When tento cadastrar inquilino já existente
    Then o sistema orienta mesclar ou rejeita duplicidade