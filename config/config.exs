# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hizzle, Hizzle.Repo,
  database: "hizzle_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

# Configures the endpoint
config :hizzle, HizzleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+QTvSaCaD5jlkBzLnxP/hnkCpNHk2nqlCKFaB5vhvUqL2RFXXsAVTxr0ty7IIvlz",
  render_errors: [view: HizzleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hizzle.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "05i23wipEhtsaBUitAvTZQYvDTgQyOe6"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix,
  json_library: Jason,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Configures Ueberauth
config :ueberauth, Ueberauth,
  providers: [
    auth0: {Ueberauth.Strategy.Auth0, []}
  ]

config :hizzle,
  ecto_repos: [Hizzle.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
