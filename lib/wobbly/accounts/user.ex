defmodule Wobbly.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
    field :nickname, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :nickname])
    |> validate_required([:email, :nickname])
    |> unique_constraint(:email)
  end
end
