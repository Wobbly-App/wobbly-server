defmodule Wobbly.Veil.Session do
  @moduledoc """
  Veil's Session Schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Wobbly.Veil.User

  schema "veil_sessions" do
    field(:unique_id, :string)
    field(:phoenix_token, :string)
    belongs_to(:user, User, type: :binary_id)

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:unique_id, :phoenix_token, :user_id])
    |> validate_required([:unique_id, :phoenix_token, :user_id])
  end
end
