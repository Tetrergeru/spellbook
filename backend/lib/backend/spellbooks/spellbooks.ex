defmodule Backend.SpellBooks do
  alias Backend.SpellBooks.Commands.{
    CreateSpellBook,
    DeleteSpellBook,
    UpdateSpellBook
  }

  alias Backend.SpellBooks.Queries.{
    ListSpellBooks,
    GetSpellBook,
  }

  defdelegate create_spellbook(attrs), to: CreateSpellBook, as: :process
  defdelegate delete_spellbook(spellbook), to: DeleteSpellBook, as: :process
  defdelegate update_spellbook(spellbook, attrs), to: UpdateSpellBook, as: :process

  defdelegate list_spellbooks(params \\ %{}), to: ListSpellBooks, as: :process
  defdelegate get_spellbook(id), to: GetSpellBook, as: :process
end
