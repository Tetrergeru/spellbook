defmodule Backend.SpellBooks.Queries.ListSpellBooks do
  import Ecto.Query, only: [from: 2]

  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Repo

  def process(%{"current_user" => current_user} = params) do
    result =
      SpellBook
      |> by_user(current_user.id)
      |> preload()
      |> Repo.paginate(params)

    %{result | entries: Enum.map(result.entries, fn x -> select_spellbook(x) end)}
  end

  def process(params) do
    result =
      SpellBook
      |> preload()
      |> Repo.paginate(params)

    %{result | entries: Enum.map(result.entries, fn x -> select_spellbook(x) end)}
  end

  defp by_user(query, user_id) do
    from(i in query,
      where: i.user_id == ^user_id
    )
  end

  defp preload(query) do
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

defmodule Backend.SpellBooks.Queries.GetSpellBook do
  alias Backend.SpellBooks.Entities.SpellBook
  alias Backend.Repo

  def process(id) do
    res =
      SpellBook
      |> Repo.get(id)
      |> Repo.preload([:spells])

    case res do
      %{} -> {:ok, res}
      _ -> {:error, :not_found}
    end
  end
end
