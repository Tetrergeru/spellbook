defmodule Backend.Spells do
  alias Backend.Spells.Commands.{
    CreateSpell,
    DeleteSpell,
    UpdateSpell
  }

  alias Backend.Spells.Queries.{
    ListSpells,
    GetSpell
  }

  defdelegate create_spell(attrs), to: CreateSpell, as: :process
  defdelegate delete_spell(spell), to: DeleteSpell, as: :process
  defdelegate update_spell(spell, attrs), to: UpdateSpell, as: :process

  defdelegate list_spells(params \\ %{}), to: ListSpells, as: :process
  defdelegate get_spell(id), to: GetSpell, as: :process
end
