# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Rails version
  8.0.0

- Ruby version
  3.4.1

- System dependencies
  Postgres

- Configuration
  bundle install

- Database creation
  bin/rails db:create

- Database initialization
  bin/rails db:setup

- How to run the test suite
  bundle exec rspec

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- Running instructions
  bin/rails server

- ...

# Add linter (rubocop)

# Run services in background

# Current step:

# Next steps:

- Decide if we are going to create endpoints for proposals (I think it is a good idea)
- Do not forget to create a rake task which will remove all simulation proposals where valid_proposal = false

# Create APIs for each action and remove views

- Add API versioning strategy - ok

# Improve endpoint to deal with 10.000 simulations at once

- Considere utilizar técnicas de paralelismo e/ou processamento assíncrono para
  melhorar a performance.
- Nota: O candidato pode optar por lidar com a alta volumetria de forma assíncrona ou
  síncrona, conforme achar mais adequado.
- Abstraia no código a utilização de serviços de mensageria (como SQS, Kafka,
  RabbitMQ), sem a necessidade de implementação completa. Descreva como seriam
  utilizados em um cenário real.

# conver funcionalities with tests

- Escreva testes unitários e de integração para os principais componentes da aplicação.
- Inclua testes de desempenho para garantir que a aplicação lide bem com alta
  volumetria de cálculos.
- Utilize ferramentas de teste adequadas (Jest, PyTest, JUnit, etc.)

# Review application and refactor it adding patterns

# Update README file with requests examples

# Criar documentação com SWAGGER

# Sugestão de Bônus:

- Implementar notificação por email com os resultados da simulação.
- Adicionar suporte para diferentes cenários de taxa de juros (fixa e variável).
- Criar um Dockerfile e docker-compose para facilitar o setup da aplicação.
- Adicionar suporte para diferentes moedas e conversão de taxas.
