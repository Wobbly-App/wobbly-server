# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wobbly,
  ecto_repos: [Wobbly.Repo],
  env: Mix.env()

# Configures the endpoint
config :wobbly, WobblyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2Haw9+/GyAySP+4E3T+1kRoP8DdDTVCL7WEyNJLDoma+TUiKFnJ+VUcu3am5+gbG",
  render_errors: [view: WobblyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Wobbly.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# -- Veil Configuration    Don't remove this line
config :veil,
  site_name: "Wobbly",
  email_from_name: "Wobbly",
  email_from_address: "noreply@wobbly.app",
  # How long should emailed sign-in links be valid for?
  sign_in_link_expiry: 3_600,
  # How long should sessions be valid for?
  session_expiry: 86_400 * 30,
  # How often should existing sessions be extended to session_expiry
  refresh_expiry_interval: 86_400,
  # How many recent sessions to keep in cache (to reduce database operations)
  sessions_cache_limit: 250,
  # How many recent users to keep in cache
  users_cache_limit: 100

config :veil, Veil.Scheduler,
  jobs: [
    # Runs every midnight to delete all expired requests and sessions
    {"@daily", {Wobbly.Veil.Clean, :expired, []}}
  ]

# Defined in config/prod.secret.exs, uses environment variable
# SENDGRID_API_KEY
# (not needed in dev, since emails aren't sent in this environment)
# (instead, login URLs are logged to the console)
config :veil, WobblyWeb.Veil.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "foobar"

# -- End Veil Configuration

config :husky,
  pre_commit: "mix format && mix credo --all --strict && mix sobelow --config",
  pre_push:
    "mix format --check-formatted && mix credo --all --strict && mix sobelow --config && mix test"
