defmodule Backend.Spells.Commands.Tests do
  use Backend.DataCase

  alias Backend.Spells
  alias Backend.Spells.Entities.Spell

  test "get_spell test" do
    spell = insert(:spell)
    spell_id = spell.id
    assert {:ok, %Spell{id: ^spell_id}} = Spells.get_spell(spell_id)
  end

  test "get_spell_name test" do
    spell = insert(:spell)
    spell_id = spell.id
    assert {:ok, %Spell{id: ^spell_id}} = Spells.get_spell_name(spell.name)
  end

  test "list_spells test" do
    spells = [insert(:spell), insert(:spell), insert(:spell)]

    assert %{entries: res_spells} = Spells.list_spells()

    ids = Enum.map(spells, fn spell -> spell.id end)
    res_ids = Enum.map(res_spells, fn spell -> spell.id end)

    assert [] = (ids -- res_ids)
    assert [] = (res_ids -- ids)
  end

  test "delete_spell test" do
    spell = insert(:spell)

    spell_id = spell.id
    assert {:ok, %Spell{id: ^spell_id}} = Spells.get_spell(spell_id)

    Spells.delete_spell(spell)

    assert {:error, :not_found} = Spells.get_spell(spell_id)
  end

  test "update_spell test" do
    spell = insert(:spell)

    spell_id = spell.id
    assert {:ok, %Spell{id: ^spell_id}} = Spells.get_spell(spell_id)

    Spells.update_spell(spell, %{ "name" => "Eye of The Foobar" })

    assert {:ok, %Spell{ name: "Eye of The Foobar" }} = Spells.get_spell(spell_id)
  end

  test "get nonexisting spell test" do
    assert {:error, :not_found} = Spells.get_spell(666)
  end
end
