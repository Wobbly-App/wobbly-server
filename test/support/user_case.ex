defmodule Wobbly.UserCase do
  @moduledoc false
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox
  alias Wobbly.{Repo, Veil}
  alias Wobbly.Veil.User

  setup_all do
    :ok = Sandbox.checkout(Wobbly.Repo)
    # we are setting :auto here so that the data persists for all tests,
    # normally (with :shared mode) every process runs in a transaction
    # and rolls back when it exits. setup_all runs in a distinct process
    # from each test so the data doesn't exist for each test.
    Sandbox.mode(Wobbly.Repo, :auto)
    {:ok, user} = Veil.create_user("demo@demo.com")

    on_exit(fn ->
      # this callback needs to checkout its own connection since it
      # runs in its own process
      :ok = Sandbox.checkout(Wobbly.Repo)
      Sandbox.mode(Wobbly.Repo, :auto)

      # we also need to re-fetch the %User struct since Ecto otherwise
      # complains it's "stale"
      user = Repo.get!(User, user.id)
      Repo.delete!(user)
      :ok
    end)

    [user: user]
  end
end
