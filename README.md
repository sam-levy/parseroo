# Parseroo

![Parseroo](https://pixy.org/src/24/245157.png)

Parseroo is your partner when integrating with customers. Parseroo parses and adapts the payload from different providers in a fast and concurrent way.

## Run locally (without Docker)

### Elixir

To install Elixir on your local environment you can use the [ASDF manager](https://asdf-vm.com/#/core-manage-asdf).
To install the version being used by this project you can use the `asdf install` command.

### Database

To create an instance of the PostgreSQL you will need the [docker-compose](https://docs.docker.com/compose/install/) installed and then you can run the `docker-compose up db -d` command.

**Note:** the `-d` option is to run the container on the background. You can see more about the `docker-compose up` command in the [documentation](https://docs.docker.com/compose/reference/up/).

**Note:** the `db` option is to only run database container.

Then, you should execute the `mix ecto.setup` command to create the application database, run the migrations, and seed data.

**Note:** the test database will be created when you first run the `mix test` command.

:warning: Don't run `mix ecto.setup` with `MIX_ENV=test`. Since the task inserts data into the database, it won't be clean when the tests run, generating failures.

#### Seeds

You can seed some data by running `mix run priv/repo/seeds.exs`.

This will add the following scenarios in the database:
- Married couple with both on the contract
- Married couple with only one of them on the contract
- Single person alone on the contract
- Single person with third parties on the contract

This allows testing on the application frontend more easily.

:warning: Be aware that before adding anything to the database, the seeds will delete all records from it. So, if you added some records to your database that you don't want to delete, you should not run the seeds. You can also modify the seeds before running it, but do not commit your changes.

### Application

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install --prefix assets`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Run with Docker

  * If you already have docker installed just run `docker-compose up`
  * To run commands (like seeds) inside the container run `docker-compose run parseroo /bin/bash`

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
