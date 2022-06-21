defmodule Backend.SpellBooks.Commands.Tests do
  use Backend.DataCase

  alias Backend.SpellBooks
  alias Backend.SpellBooks.Entities.SpellBook

  alias Backend.Spells

  alias Backend.Users

  setup do
    insert(:spell, %{name: "Eye of Platipus"})
    insert(:spell, %{name: "Viking's Breath"})
    insert(:spell, %{name: "Vanishing Mark"})
    insert(:spell, %{name: "Nuklear Fish"})

    insert(:user, %{nickname: "John Doe"})
    insert(:user, %{nickname: "Bearmongler"})

    :ok
  end

  test "get_spellbook test" do
    spellbook = insert(:spellbook)
    spellbook_id = spellbook.id
    assert {:ok, %SpellBook{id: ^spellbook_id}} = SpellBooks.get_spellbook(spellbook_id)
  end

  test "list_spellbooks test" do
    {:ok, user} = Users.get_user_nickname("Bearmongler")

    some_spellbooks = [insert(:spellbook, %{user: user}), insert(:spellbook, %{user: user})]

    new_spellbook = insert(:spellbook)
    spellbooks = some_spellbooks ++ [new_spellbook]

    ids = Enum.map(spellbooks, fn spellbook -> spellbook.id end)
    new_id = new_spellbook.id

    assert %{entries: users_spellbooks} = SpellBooks.list_spellbooks(%{"current_user" => user})
    assert %{entries: all_spellbooks} = SpellBooks.list_spellbooks()

    users_ids = Enum.map(users_spellbooks, fn spellbook -> spellbook.id end)
    all_ids = Enum.map(all_spellbooks, fn spellbook -> spellbook.id end)

    assert [^new_id] = ids -- users_ids
    assert [] = users_ids -- ids

    assert [] = ids -- all_ids
    assert [] = all_ids -- ids
  end

  test "delete_spellbook test" do
    spellbook = insert(:spellbook)

    spellbook_id = spellbook.id
    assert {:ok, %SpellBook{id: ^spellbook_id}} = SpellBooks.get_spellbook(spellbook_id)

    SpellBooks.delete_spellbook(spellbook)

    assert {:error, :not_found} = SpellBooks.get_spellbook(spellbook_id)
  end

  test "update_spellbook test" do
    spellbook = insert(:spellbook)

    spellbook_id = spellbook.id

    assert {:ok, %SpellBook{id: ^spellbook_id}} = SpellBooks.get_spellbook(spellbook_id)

    SpellBooks.update_spellbook(
      spellbook,
      %{"character_name" => "Master of Renaming"}
    )

    assert {:ok, %SpellBook{character_name: "Master of Renaming"}} =
             SpellBooks.get_spellbook(spellbook_id)
  end

  test "get_spellbook has spells" do
    {:ok, user} = Users.get_user_nickname("Bearmongler")

    {:ok, spell1} = Spells.get_spell_name("Viking's Breath")
    {:ok, spell2} = Spells.get_spell_name("Vanishing Mark")
    {:ok, spell3} = Spells.get_spell_name("Nuklear Fish")

    spells = [spell1, spell2, spell3]

    spellbook = insert(:spellbook, %{user: user})

    SpellBooks.update_spellbook(spellbook, %{"spells" => spells})

    assert {:ok, %SpellBook{spells: res_spells}} = SpellBooks.get_spellbook(spellbook.id)

    ids = Enum.map(spells, fn spell -> spell.id end)
    res_ids = Enum.map(res_spells, fn spell -> spell.id end)

    assert [] = ids -- res_ids
    assert [] = res_ids -- ids
  end

  test "get nonexisting spell test" do
    assert {:error, :not_found} = SpellBooks.get_spellbook(666)
  end
end
