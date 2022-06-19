defmodule Backend.Repo.Migrations.AddSpellTable do
  use Ecto.Migration

  def change do
    create table(:spells) do
      add :name, :string, null: false
      add :level, :integer, null: false
      add :description, :string, null: false
      add :material_component, :boolean, default: false, null: false
      add :somatic_component, :boolean, default: false, null: false
      add :verbal_component, :boolean, default: false, null: false
      add :school, :string, null: false
      add :concentration, :boolean, default: false, nill: false
      add :material_component_price, :integer

      timestamps()
    end
    
    create unique_index(:spells, [:name])
  end
end
