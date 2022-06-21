defmodule Backend.Spells do
  alias Backend.Spells.Commands.CreateSpell

  alias Backend.Spells.Queries.{
    ListSpells,
    FindSpell,
  }

  defdelegate create_spell(attrs), to: CreateSpell, as: :process
  defdelegate list_spells(params \\ %{}), to: ListSpells, as: :process
  defdelegate find_spell(id), to: FindSpell, as: :process
end
