defmodule Wobbly.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wobbly.Users.User

  schema "messages" do
    field :body, :string
    belongs_to :sender, User
    belongs_to :recipient, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
