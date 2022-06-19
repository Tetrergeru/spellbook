defmodule BackendWeb.V1.SpellsView do
  use BackendWeb, :view

  def render("index.json", %{spells: spells}) do
    render_many(spells, __MODULE__, "show.json", as: :spell)
  end

  def render("show.json", %{spell: spell}) do
    %{
      id: spell.id,
      name: spell.name,
      description: spell.description
    }
  end

  def render("create.json", %{ok: true}) do
    %{ok: true}
  end
end
