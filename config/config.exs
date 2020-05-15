# General application configuration
use Mix.Config

config :wobbly,
  ecto_repos: [Wobbly.Repo]

# Configures the endpoint
config :wobbly, WobblyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C6BHatPJlIwt/QFSE2X1+yFCB5qSyh8tFCq2dHN2AAqgeE+f2SedW7o12gBbscri",
  render_errors: [view: WobblyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Wobbly.PubSub,
  live_view: [signing_salt: "31z4cf8/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Pow authentication
config :wobbly, :pow,
  user: Wobbly.Users.User,
  repo: Wobbly.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
