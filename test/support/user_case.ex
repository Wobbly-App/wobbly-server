defmodule Wobbly.UserCase do
  use ExUnit.CaseTemplate
  alias Wobbly.{Veil, Repo}
  alias Wobbly.Veil.User

  setup_all do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Wobbly.Repo)
    # we are setting :auto here so that the data persists for all tests,
    # normally (with :shared mode) every process runs in a transaction
    # and rolls back when it exits. setup_all runs in a distinct process
    # from each test so the data doesn't exist for each test.
    Ecto.Adapters.SQL.Sandbox.mode(Wobbly.Repo, :auto)
    {:ok, user} = Veil.create_user("demo@demo.com")

    on_exit(fn ->
      # this callback needs to checkout its own connection since it
      # runs in its own process
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(Wobbly.Repo)
      Ecto.Adapters.SQL.Sandbox.mode(Wobbly.Repo, :auto)

      # we also need to re-fetch the %User struct since Ecto otherwise
      # complains it's "stale"
      user = Repo.get!(User, user.id)
      Repo.delete!(user)
      :ok
    end)

    [user: user]
  end
end
