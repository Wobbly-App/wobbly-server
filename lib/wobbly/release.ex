defmodule Wobbly.Release do
  @moduledoc """
  Used to run migrations in an Elixir release.
  e.g.
  $ _build/prod/rel/wobbly/bin/wobbly eval "Wobbly.Release.migrate"

  See https://hexdocs.pm/phoenix/releases.html#ecto-migrations-and-custom-commands
  """
  @app :wobbly

  def migrate do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.load(@app)
    Application.fetch_env!(@app, :ecto_repos)
  end
end
