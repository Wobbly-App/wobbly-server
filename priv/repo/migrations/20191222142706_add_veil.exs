defmodule Wobbly.Repo.Migrations.AddVeil do
  use Ecto.Migration

  def change do
    create table(:veil_users, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:email, :string)
      add(:verified, :boolean, default: false)

      timestamps()
    end

    create(unique_index(:veil_users, [:email]))

    create table(:veil_requests) do
      add(:user_id, references(:veil_users, type: :uuid, on_delete: :delete_all))
      add(:unique_id, :string)
      add(:phoenix_token, :string)

      timestamps()
    end

    create(index(:veil_requests, [:unique_id]))

    create table(:veil_sessions) do
      add(:user_id, references(:veil_users, type: :uuid, on_delete: :delete_all))
      add(:unique_id, :string)
      add(:phoenix_token, :string)

      timestamps()
    end

    create(index(:veil_sessions, [:unique_id]))
  end
end
