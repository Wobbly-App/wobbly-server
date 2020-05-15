defmodule Wobbly.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string

      timestamps()
    end

    create table(:groups_users) do
      add :group_id, references(:groups)
      add :user_id, references(:users)

      timestamps()
    end
  end
end
