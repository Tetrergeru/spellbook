defmodule Backend.SpellBooks.Commands.CreateSpellBook do
  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Repo

  def process(attrs) do
    %SpellBook{}
    |> SpellBook.create_changeset(attrs)
    |> Repo.insert()
  end
end

defmodule Backend.SpellBooks.Commands.DeleteSpellBook do
  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Repo

  def process(%SpellBook{} = spellbook) do
    Repo.delete(spellbook)
  end
end

defmodule Backend.SpellBooks.Commands.UpdateSpellBook do
  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Repo

  def process(%SpellBook{} = spellbook, attrs) do
    spellbook
    |> SpellBook.create_changeset(attrs)
    |> Repo.update()
  end
end
