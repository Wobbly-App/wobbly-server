defmodule Wobbly.Groups.GroupUser do
  use Ecto.Schema

  schema "groups_users" do
    belongs_to :group, Wobbly.Groups.Group
    belongs_to :user, Wobbly.Users.User

    timestamps()
  end
end
