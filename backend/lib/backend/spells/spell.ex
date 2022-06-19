defmodule Backend.Spells do
  alias Backend.Spells.Commands.CreateSpell

  alias Backend.Spells.Queries.{
    ListSpells
  }

  defdelegate create_spell(attrs), to: CreateSpell, as: :process
  defdelegate list_spells(params \\ %{}), to: ListSpells, as: :process
end
