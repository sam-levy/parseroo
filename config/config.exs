# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :parseroo,
  ecto_repos: [Parseroo.Repo]

config :parseroo, Parseroo.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id],
  migration_timestamps: [type: :utc_datetime_usec]

# Configures the endpoint
config :parseroo, ParserooWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sAdm1+MYNUe45HZcQmqF+I1tC76x2u/diZgYuOQxkEywgKshC8Q4w+f69FStJV9f",
  render_errors: [view: ParserooWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Parseroo.PubSub,
  live_view: [signing_salt: "g13mC1+j"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :money,
  default_currency: :BRL,
  symbol: false,
  symbol_on_right: false,
  symbol_space: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
