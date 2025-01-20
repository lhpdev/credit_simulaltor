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

- How to run linter
  bin/rubocop

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- Running instructions
  bin/rails server

- ...

# Missing tasks:

- Create a rake task which will remove all simulation proposals where valid_proposal = false
- Implement email notification with simulation results.
- Add support for different interest rate scenarios (fixed and variable).
- Create a Dockerfile and docker-compose to facilitate application setup.
- Add support for different currencies and rate conversion.
- Create SWAGGER documentation
- Improve endpoint to deal with 10.000 simulations at once
- Abstract the use of messaging services (such as SQS, Kafka, RabbitMQ) in the code, without the need for a complete implementation. Describe how they would be used in a real scenario.
