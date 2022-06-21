defmodule BackendWeb.V1.SpellBooksController do
  use BackendWeb, :controller

  alias Backend.SpellBooks
  alias Backend.Spells

  action_fallback(BackendWeb.FallbackController)

  def index(conn, params) do
    spellbooks = SpellBooks.list_spellbooks(params)
    render(conn, "index.json", %{spellbooks: spellbooks})
  end

  def create(conn, attrs) do
    spells = Enum.map(attrs["spells"], fn id -> Spells.get_spell(id) end)

    if not Enum.all?(spells, fn x -> is_ok(x) end) do
      {:error, :not_found}
    else
      spells = Enum.map(spells, fn spell -> ok_to_spell(spell) end)

      attrs = Map.put(attrs, "spells", spells)
      attrs = Map.put(attrs, "user_id", attrs["current_user"].id)

      res = SpellBooks.create_spellbook(attrs)

      with {:ok, spellbook} <- res do
        render(conn, "create.json", %{spellbook: spellbook})
      end
    end
  end

  defp ok_to_spell({:ok, spell}) do
    spell
  end

  defp is_ok({:ok, _}) do
    true
  end

  defp is_ok(_) do
    false
  end
end
