defmodule BackendWeb.SpellBooks.Tests do
  use BackendWeb.ConnCase

  import BackendWeb.Router.Helpers
  alias Backend.SpellBooks

  setup %{conn: conn} do
    spells = [
      insert(:spell, %{name: "Eye of Platipus"}),
      insert(:spell, %{name: "Viking's Breath"}),
      insert(:spell, %{name: "Vanishing Mark"}),
      insert(:spell, %{name: "Nuklear Fish"})
    ]

    user = insert(:user)
    {:ok, %{conn: conn, user: user, spells: spells}}
  end

  test "index/2 returns list spellbooks", %{conn: conn, user: user} do
    conn = as_user(conn, user)

    [spellbook_1, spellbook_2, spellbook_3] = insert_list(3, :spellbook, %{user: user})
    attrs = %{page: 1, page_size: 5}

    response =
      conn
      |> get(spell_books_path(conn, :index), attrs)
      |> json_response(200)

    spellbook_1_id = spellbook_1.id
    spellbook_2_id = spellbook_2.id
    spellbook_3_id = spellbook_3.id

    assert %{
             "entries" => [
               %{"id" => ^spellbook_1_id},
               %{"id" => ^spellbook_2_id},
               %{"id" => ^spellbook_3_id}
             ],
             "page_number" => 1,
             "page_size" => 5,
             "total_entries" => 3,
             "total_pages" => 1
           } = response
  end

  test "index/2 returns error for unsigned", %{conn: conn, user: user, spells: _} do
    insert_list(3, :spellbook, %{user: user})
    attrs = %{page: 1, page_size: 5}

    response =
      conn
      |> get(spell_books_path(conn, :index), attrs)
      |> json_response(401)

    assert %{"errors" => ["Unauthorized"]} = response
  end

  test "index/2 return spells in spellbook", %{conn: conn, user: user, spells: spells} do
    conn = as_user(conn, user)

    spellbook = insert(:spellbook, %{user: user})
    spellbook_id = spellbook.id

    SpellBooks.update_spellbook(spellbook, %{"spells" => spells})

    attrs = %{page: 1, page_size: 5}

    response =
      conn
      |> get(spell_books_path(conn, :index), attrs)
      |> json_response(200)

    assert %{
             "entries" => [
               %{"id" => ^spellbook_id, "spells" => res_spells}
             ]
           } = response

    ids = Enum.map(spells, fn spell -> spell.id end)
    res_ids = Enum.map(res_spells, fn spell -> spell["id"] end)

    assert [] = ids -- res_ids
    assert [] = res_ids -- ids
  end
end
