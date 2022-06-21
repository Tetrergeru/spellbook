defmodule Backend.Factories.SpellBookFactory do
  defmacro __using__(_opts) do
    quote do
      alias Backend.SpellBooks.Entities.SpellBook
      alias Faker.{Internet, Lorem, Person}

      def spellbook_factory(attrs) do
        character_name = Map.get(
          attrs,
          :character_name,
          "#{Person.first_name()}_#{Person.last_name()}"
        )
        character_level = Map.get(attrs, :character_level, Faker.random_between(1, 20))
        user = Map.get(attrs, :user, insert(:user))
        spells = Map.get(attrs, :spells, [])

        %Ecto.Changeset{valid?: true, changes: changes} =
          SpellBook.create_changeset(%SpellBook{}, %{
            "character_name" => character_name,
            "character_level" => character_level,
            "user_id" => user.id,
            "spells" => spells
          })

        struct(%SpellBook{}, changes)
      end
    end
  end
end
