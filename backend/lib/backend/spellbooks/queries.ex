defmodule Backend.SpellBooks.Queries.ListSpellBooks do
  import Ecto.Query, only: [from: 2]

  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(params) do
    result =
      SpellBook
      |> by_user(params["current_user"].id)
      |> select_fields()
      # |> Repo.preload(:spells)
      |> Repo.all()

    Enum.map(result, fn x -> select_spellbook(x) end)
  end

  defp by_user(query, user_id) do
    from i in query,
      where: i.user_id == ^user_id
  end

  defp select_fields(query) do
    from(i in query,
      preload: [:spells]
    )
  end

  defp select_spellbook(%{
         id: id,
         character_name: character_name,
         character_level: character_level,
         spells: spells
       }) do
    %{
      id: id,
      character_name: character_name,
      character_level: character_level,
      spells: Enum.map(spells, fn x -> select_spell(x) end)
    }
  end

  defp select_spell(%{
         id: id,
         name: name
       }) do
    %{id: id, name: name}
  end
end

defmodule Backend.SpellBooks.Queries.FindSpellBook do
  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Repo

  def process(id) do
    Repo.find(SpellBook, id)
  end
end
