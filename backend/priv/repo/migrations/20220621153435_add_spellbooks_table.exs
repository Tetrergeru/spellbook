defmodule Backend.Repo.Migrations.AddSpellbooksTable do
  use Ecto.Migration

  def change do
    create table(:spellbooks) do
      add(:character_name, :string)
      add(:character_level, :integer)
      add(:user_id, references(:users))

      timestamps()
    end
  end
end
