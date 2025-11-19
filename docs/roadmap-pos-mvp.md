# Roadmap Pós-MVP — Reintrodução de Pagamentos e Notificações

## Objetivo
Planejar a evolução do produto após o MVP, reintroduzindo módulos de Pagamentos e Notificações com foco em segurança, escalabilidade e confiabilidade operacional.

## Visão por Releases
- v1.1 — Pagamentos (MVP do módulo)
  - Emissão de faturas (invoice) por contrato.
  - Integração com gateway para cartão/Pix.
  - Webhooks assinados, idempotência e conciliação.
  - Recibo e trilha de auditoria.
- v1.2 — Notificações (MVP do módulo)
  - Multi-canal: e-mail, SMS, push.
  - Templates e preferências (opt-in/out).
  - Retentativas exponenciais e DLQ opcional.
  - Rastreamento de status (queued/sent/delivered/failed).
- v1.3 — Conta SaaS (Cobrança ativa)
  - Faturamento de assinatura (account billing/invoice).
  - Limites e alertas; relatórios operacionais ampliados.
- v1.4 — Qualidade/Observabilidade
  - Testes de carga, hardening e métricas avançadas.
  - Playbooks de incidentes e DR testado.

## Seleção de Provedores (Critérios)
- Gateway de Pagamento
  - Opções: Pagar.me/Stone, Mercado Pago, Stripe (cartão/pix, suporte BR).
  - Critérios: latência/SLAs, custo por transação, suporte a Pix, Webhooks confiáveis, SDKs TS, conciliação.
- E-mail
  - Opções: AWS SES, SendGrid, Mailgun.
  - Critérios: reputação de entrega, custo, métricas e templates.
- SMS
  - Opções: Twilio, TotalVoice, Zenvia.
  - Critérios: cobertura nacional, preço, callbacks, provisionamento simples.
- Push
  - Opções: Firebase Cloud Messaging (FCM).
  - Critérios: integração RN, confiabilidade, custo zero/baixo.

## Critérios de Aceitação
- Pagamentos (v1.1)
  - Emissão de faturas por ciclo com `status=pendente`.
  - Checkout/intent com retorno seguro (QR/URL), assinatura valida em webhook.
  - Atualização para `status=pago` com idempotência; armazenamento de comprovante.
  - Fluxo de falha com registro e comunicação interna; estorno (refund) suportado.
  - Conciliação assíncrona executada e auditada.
- Notificações (v1.2)
  - Enfileiramento por canal com templates; variáveis resolvidas.
  - Entrega rastreada (sent/delivered) e retentativas em falha com backoff.
  - Preferências e opt-in/out por perfil; limites e rate control.
  - DLQ e reprocessamento manual documentado.
- Conta SaaS (v1.3)
  - Cobranças da assinatura com faturas e recibos; limites aplicados.

## Dependências de Infra
- DNS e TLS válidos; endpoints públicos para webhooks (pagamento/notificações).
- Segredos em vault ou gerenciador seguro; `.env` segregado por ambiente.
- Redis dimensionado para filas de pagamentos/notificações; políticas de retenção.
- Observabilidade: Sentry, métricas (latência, erros, throughput), dashboards.
- CI/CD: pipelines com gates (lint/tests/coverage/SAST/scan Docker), deploy automatizado.

## Segurança e Conformidade
- LGPD: consentimento para notificações, retenção de dados e direito de exclusão.
- Webhooks: verificação de assinatura, replay protection, idempotência por `gateway_ref`/hash.
- Rate limiting em rotas críticas; sanitização de entrada; RLS no Postgres.

## Plano de Testes
- Unitários: regras de negócio (invoice/payment/notification).
- Integração: API + DB com Testcontainers; webhooks simulados.
- E2E: fluxos de pagamento (sucesso/falha/estorno) e notificações (envio/retentativas).
- Carga: latência p95 ≤ 200ms em rotas principais e estabilidade de filas sob pico.
- BDD: expandir `.feature` existentes para cobrir casos pós-MVP.

## Cronograma Proposto
- v1.1 Pagamentos — 4 semanas
  - Semana 1: schema, emissão de faturas, integração gateway sandbox.
  - Semana 2: webhooks/assinatura, idempotência e conciliação.
  - Semana 3: recibos, auditoria, observabilidade e testes.
  - Semana 4: carga/piloto e documentação.
- v1.2 Notificações — 3 semanas
  - Semana 1: templates/preferências, fila/retentativas.
  - Semana 2: provedores, callbacks, métricas e DLQ.
  - Semana 3: testes E2E, carga e UX (opt-in/out).
- v1.3 Conta SaaS — 3 semanas
  - Semana 1: modelagem e faturas da assinatura.
  - Semana 2: integrações e relatórios.
  - Semana 3: testes/carga e documentação.

## Riscos e Mitigações
- Latência/indisponibilidade em provedores: fallback, retentativas, DR.
- Entrega de notificações inconsistente: multi-provedor, monitoramento e tuning.
- Vazamento entre tenants: RLS + testes de isolamento em pipelines.

## Aprovação
Este roadmap será submetido para aprovação dos stakeholders e alinhamento com capacidade da equipe e orçamento de provedores.