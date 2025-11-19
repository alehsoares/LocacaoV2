# Sistema de Gestão de Locações

## Requisitos Funcionais
Quero desenvolver um sistema que seja responsivo, que poderá ser acesso via mobile ou PC. 

Esse sistema será um SaaS gerenciador de locações, onde teremos a seguinte estrutura:

- Super Admin -> Responsável pelo SaaS -> terá visão total dos dados e usuários
- Usuário -> Usuário que assinou o serviço -> terá visão somente dos imóveis pertencentes a ele, assim como os dados dos moradores
- Imóveis -> serão criados pelos usuários.
- Inquilinos -> serão criados pelos usuários e serão associados à um ou mais imóveis. -> terá a visão do imóvel que alugo, assim como o contrato dessa locação e demais serviços relacionados à locação
- Contrato -> Formalização entre a relação de usuário x imóvel x inquilino 
- Gestão dos pagamentos -> Para cada contrato terá a gestão dos pagamentos
- Gestão de serviços -> Para cada contrato terá a gestão de serviços, como por exemplo, limpeza, manutenção, etc. que poderá ser solicitado por parte do inquilino e terá um custo associado a ele ou abatimento no valor do aluguel, se necessário.
- Gestão da conta -> O usuário terá acesso à dados referentes à sua conta no sistema, seja para visualizar mensalidade, limites do sistema, histórico de pagamentos, etc.
- Notificações -> O sistema terá a funcionalidade de notificar o usuário e/ou inquilino sobre eventos importantes, como por exemplo, a expiração do contrato, o pagamento pendente, etc.
- Interface intuitiva -> O sistema terá uma interface intuitiva, facilitando o uso para os usuários e inquilinos, pois os usuários e/ou inquilinos podem ser idosos ou pessoas que não usam tecnologias com frequência.

## Requisitos Não Funcionais
- Segurança -> O sistema terá um nível de segurança adequado, garantindo a proteção dos dados dos usuários e inquilinos.
- Performance -> O sistema terá um bom desempenho, respondendo rapidamente às solicitações dos usuários e inquilinos.
- Disponibilidade -> O sistema terá alta disponibilidade, garantindo que esteja acessível 24 horas por dia, 7 dias por semana.
- Escalabilidade -> O sistema terá a capacidade de escalar para atender a um aumento na carga de usuários e inquilinos, sem comprometer o desempenho.
- Manutenibilidade -> O sistema terá uma arquitetura bem projetada, facilitando a manutenção e atualização do software no futuro.

## Tecnologias Utilizadas
- Front-end -> React Native
- Back-end -> Node.js
- Banco de Dados -> Postgres
- Hospedagem -> VPS Contabo
