defmodule Backend.Spells.Commands.CreateSpell do
  alias Backend.Spells.Entities.Spell
  alias Backend.Repo

  def process(attrs) do
    %Spell{}
    |> Spell.create_changeset(attrs)
    |> Repo.insert()
  end
end

defmodule Backend.Spells.Commands.DeleteSpell do
  alias Backend.Spells.Entities.Spell
  alias Backend.Repo

  def process(%Spell{} = spell) do
    Repo.delete(spell)
  end
end

defmodule Backend.Spells.Commands.UpdateSpell do
  alias Backend.Spells.Entities.Spell
  alias Backend.Repo

  def process(%Spell{} = spell, attrs) do
    spell
    |> Spell.create_changeset(attrs)
    |> Repo.update()
  end
end
