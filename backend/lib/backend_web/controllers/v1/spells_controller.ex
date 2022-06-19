defmodule BackendWeb.V1.SpellsController do
  use BackendWeb, :controller

  alias Backend.Spells

  action_fallback(BackendWeb.FallbackController)

  def index(conn, params) do
    spells = Spells.list_spells()
    render(conn, "index.json", %{spells: spells})
  end

  def create(conn, attrs) do
    res = Spells.create_spell(attrs)
    with {:ok, _} <- res do
      render(conn, "create.json", %{ok: true})
    end
  end
end
