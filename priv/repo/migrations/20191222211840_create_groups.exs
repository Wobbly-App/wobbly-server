defmodule Wobbly.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :description, :string

      timestamps()
    end

    create table(:users_groups, primary_key: false) do
      add :user_id, references(:veil_users, type: :uuid, on_delete: :delete_all)
      add :group_id, references(:groups, type: :uuid, on_delete: :delete_all)

      timestamps()
    end

    create index(:users_groups, [:user_id])
    create index(:users_groups, [:group_id])
  end
end
