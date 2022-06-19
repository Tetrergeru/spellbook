defmodule Backend.Spells.Commands.CreateSpell do
  alias Backend.Spells.Entities.Spell
  alias Backend.Repo

  def process(attrs) do
    %Spell{}
    |> Spell.create_changeset(attrs)
    |> Repo.insert()
  end
end
