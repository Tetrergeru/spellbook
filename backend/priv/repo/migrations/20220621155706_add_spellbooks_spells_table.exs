defmodule Backend.Repo.Migrations.AddSpellbooksSpellsTable do
  use Ecto.Migration

  def change do
    create table(:spellbook_spells, primary_key: false) do
      add(:spellbook_id, references(:spellbooks))
      add(:spell_id, references(:spells))
    end

    create(index(:spellbook_spells, [:spellbook_id]))
    create(index(:spellbook_spells, [:spell_id]))
    create(unique_index(:spellbook_spells, [:spellbook_id, :spell_id]))
  end
end
