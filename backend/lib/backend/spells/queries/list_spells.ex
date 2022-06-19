defmodule Backend.Spells.Queries.ListSpells do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias Backend.Spells.Entities.Spell
  alias Backend.Repo

  def process(params) do
    Spell
    |> with_level(params)
    |> select_fields()
    |> Repo.all()
  end

  defp with_level(query, %{level: nil}), do: query

  defp with_level(query, %{level: level}) do
    from i in query,
      where: i.level == ^level
  end

  defp with_level(query, _), do: query

  defp select_fields(query) do
    from i in query,
      select: %{
        id: i.id,
        name: i.name,
        description: i.description
      }
  end
end
