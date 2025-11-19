Feature: Gestão de Imóveis
  Como usuário
  Quero cadastrar e manter meus imóveis
  Para gerenciar contratos e inquilinos

  Background:
    Given estou autenticado como "Usuario"

  Scenario: Criar imóvel
    When crio um imóvel com dados válidos
    Then o imóvel é salvo e retorna ID

  Scenario: Atualizar imóvel
    Given existe um imóvel
    When atualizo atributos permitidos
    Then o sistema persiste mudanças e registra auditoria

  Scenario: Listar imóveis por tenant
    When consulto a lista de imóveis
    Then somente imóveis do meu tenant são retornados