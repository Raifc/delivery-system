# Sistema de transportadoras
Aplicação desenvolvida para gerenciar transportadoras e suas funcionalidades. 
Funcionalidades:
- Busca de atualizações de rota;
- Cadastro de transportadoras e seus respectivos preços, prazos de entrega e veículos;
- Consulta de preços e prazos de acordo com o volume e peso do pacote a ser transportado; 
- Criação e gerenciamento de ordens de serviço

## Requisitos e versões
- [Rails 7.0.3]
- [Ruby 3.0.0]
- [rspec-rails 5.1.2]
- [capybara 3.37.1]


## Executando a aplicação
- Com todos os requisitos satisfeitos:
- Clone o repositório através do git clone. 
- Abra o diretório em seu terminal.
- Em seu terminal, rode `bundle install`.
- Em seu terminal, rode `rails db:seed`.
- Em seu terminal, rode `rails server`, isto irá iniciar a aplicação.
- Em seu navegador, acesse: `localhost:3000`.
### Fazendo Login
- Acesse o sistema como administrador utilizando admin@sistemadefrete.com.br como endereço de email e 123456 como senha.
- Acesse o sistema como usuário utilizando user@transportes.com.br como endereço de email e 123456 como senha.

## Executando testes
- Após rodar o comando `bundle install`:
- Com o repositório aberto em seu terminal, rode `rspec`
