defmodule Backend.Factories.SpellFactory do
  defmacro __using__(_opts) do
    quote do
      alias Backend.Spells.Entities.Spell
      alias Faker.{Internet, Lorem, Person}

      def spell_factory(attrs) do
        name = Map.get(attrs, :name, "#{Person.first_name()}'s Great Spell")
        level = Map.get(attrs, :level, Faker.random_between(1, 9))
        description = Map.get(attrs, :level, Lorem.sentence(8..16))
        material_component = Map.get(attrs, :level, Faker.random_between(1, 2) > 1)
        somatic_component = Map.get(attrs, :level, Faker.random_between(1, 2) > 1)
        verbal_component = Map.get(attrs, :level, Faker.random_between(1, 2) > 1)
        school = Map.get(attrs, :level, Person.first_name())
        concentration = Map.get(attrs, :level, Faker.random_between(1, 2) > 1)

        material_component_price =
          if material_component do
            Map.get(
              attrs,
              :material_component_price,
              Faker.random_between(1, 500)
            )
          else
            nil
          end

        %Ecto.Changeset{valid?: true, changes: changes} =
          Spell.create_changeset(%Spell{}, %{
            name: name,
            level: level,
            description: description,
            material_component: material_component,
            somatic_component: somatic_component,
            verbal_component: verbal_component,
            school: school,
            concentration: concentration,
            material_component_price: material_component_price
          })

        struct(%Spell{}, changes)
      end
    end
  end
end
