use Mix.Config

# Configure your database
config :wobbly, Wobbly.Repo,
  username: "postgres",
  password: "postgres",
  database: "wobbly_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wobbly, WobblyWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :veil,
  # How many recent sessions to keep in cache (to reduce database operations)
  sessions_cache_limit: 0,
  # How many recent users to keep in cache
  users_cache_limit: 0
