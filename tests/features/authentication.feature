Feature: Autenticação e Autorização (RBAC)
  Como usuário do sistema
  Quero autenticar e acessar recursos conforme meu papel
  Para garantir segurança e isolamento entre tenants

  Background:
    Given existe um tenant válido
    And existe um usuário com papel "Usuario" e um "SuperAdmin"
    And as credenciais estão corretas

  Scenario: Login com sucesso gera tokens
    When o usuário realiza login
    Then o sistema retorna token JWT e refresh token
    And o token expira conforme política definida

  Scenario: Acesso negado por papel insuficiente
    Given o usuário está autenticado como "Inquilino"
    When tenta acessar recurso restrito a "Usuario"
    Then o sistema retorna erro 403

  Scenario: Isolamento por tenant
    Given o usuário está autenticado no tenant A
    When tenta acessar dado do tenant B
    Then o sistema retorna erro 404 ou 403 e registra tentativa