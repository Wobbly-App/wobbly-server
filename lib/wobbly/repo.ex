defmodule Wobbly.Repo do
  use Ecto.Repo,
    otp_app: :wobbly,
    adapter: Ecto.Adapters.Postgres
end
