defmodule Backend.SpellBooks do
  alias Backend.SpellBooks.Commands.CreateSpellBook

  alias Backend.SpellBooks.Queries.{
    ListSpellBooks,
    FindSpellBook,
  }

  defdelegate create_spellbook(attrs), to: CreateSpellBook, as: :process
  defdelegate list_spellbooks(params \\ %{}), to: ListSpellBooks, as: :process
  defdelegate find_spellbook(id), to: FindSpellBook, as: :process
end
