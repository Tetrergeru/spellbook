defmodule BackendWeb.V1.SpellBooksView do
  use BackendWeb, :view

  def render("index.json", %{spellbooks: spellbooks}) do
    render_many(spellbooks, __MODULE__, "show.json", as: :spellbook)
  end

  def render("show.json", %{spellbook: spellbook}) do
    %{
      id: spellbook.id,
      character_name: spellbook.character_name,
      character_level: spellbook.character_level,
      spells: spellbook.spells
    }
  end

  def render("create.json", %{ok: true}) do
    %{ok: true}
  end
end
