defmodule Wobbly.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wobbly.Groups.UserGroup

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "groups" do
    field :description, :string
    field :name, :string

    many_to_many :members, Wobbly.Veil.User, join_through: UserGroup

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
