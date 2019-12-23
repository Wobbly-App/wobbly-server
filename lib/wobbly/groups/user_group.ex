defmodule Wobbly.Groups.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wobbly.Groups.Group
  alias Wobbly.Veil.User

  @foreign_key_type :binary_id
  @primary_key false
  schema "users_groups" do
    belongs_to :user, User
    belongs_to :group, Group
    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id])
  end
end
