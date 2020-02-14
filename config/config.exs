# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :nfl_rushing, NflRushingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rD87qOMpJ6yY+/Ws1I3zVAshZzox6you667ihZ3txqWEsDmm9aKZqO9gvL7QE/OI",
  render_errors: [view: NflRushingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NflRushing.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "DDXVWe9R"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
