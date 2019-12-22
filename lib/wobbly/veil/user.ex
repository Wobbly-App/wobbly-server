defmodule Wobbly.Veil.User do
  @moduledoc """
  Veil's User Schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Wobbly.Veil.{Request, Session}
  alias Wobbly.Groups.Group

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "veil_users" do
    field(:email, :string)
    field(:verified, :boolean, default: false)

    has_many(:requests, Request)
    has_many(:sessions, Session)

    many_to_many :groups, Group, join_through: :users_groups

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:email, :verified])
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> make_email_lowercase()
    |> unique_constraint(:email)
  end

  defp make_email_lowercase(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{email: email}} ->
        put_change(changeset, :email, email |> String.downcase())

      _ ->
        changeset
    end
  end
end
