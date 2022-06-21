defmodule Backend.SpellBooks.Commands.CreateSpellBook do
  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Repo

  def process(attrs) do
    %SpellBook{}
    |> SpellBook.create_changeset(attrs)
    |> Repo.insert()
  end
end
