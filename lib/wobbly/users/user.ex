defmodule Wobbly.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    many_to_many :groups, Wobbly.Groups.Group, join_through: Wobbly.Groups.GroupUser

    timestamps()
  end
end
