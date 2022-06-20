defmodule Backend.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:nickname, :string, null: false)
      add(:password_hash, :string, null: false)

      timestamps()
    end

    create(unique_index(:users, [:email]))
    create(unique_index(:users, [:nickname]))
  end
end
