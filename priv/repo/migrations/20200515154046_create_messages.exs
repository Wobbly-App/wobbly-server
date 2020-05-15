defmodule Wobbly.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :sender_id, references(:users)
      add :recipient_id, references(:users)

      timestamps()
    end
  end
end
