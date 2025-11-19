# ADR 0003 — Segurança de APIs: Validação, Rate Limiting e Sanitização

## Contexto
Regras de melhores práticas exigem validação robusta, proteção contra abusos e sanitização de entradas para assegurar integridade e confidencialidade.

## Decisão
- Habilitar `ValidationPipe` global com `whitelist` e `forbidNonWhitelisted`.
- Implementar rate limiting nas rotas críticas (login, pagamentos, notificações).
- Sanitizar inputs e aplicar cabeçalhos de segurança; TLS em todo tráfego.

## Consequências
- Redução de superfície de ataque; prevenção de payloads indevidos.
- Proteção contra abuse/spam; melhor resiliência operacional.

## Implementação
- DTOs com `class-validator`; transformação com `class-transformer`.
- Middleware/guard de rate limiting; configuração por rota.
- Bibliotecas de sanitização; hardening de Nginx/reverse proxy.
- Gestão de segredos com `.env` e vault; RLS no Postgres.

## Revisão
- Auditorias periódicas; testes de penetração; monitoramento de falhas e alertas proativos.