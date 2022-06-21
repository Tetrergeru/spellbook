defmodule Backend.Spells.Entities.Spell do
  use Ecto.Schema

  import Ecto.Changeset
  alias Backend.SpellBooks.Entities.SpellBook

  @required [
    :name,
    :level,
    :description,
    :material_component,
    :somatic_component,
    :verbal_component,
    :school,
    :concentration
  ]

  @optional [
    :material_component_price
  ]

  schema "spells" do
    field(:name, :string)
    field(:level, :integer)
    field(:description, :string)
    field(:material_component, :boolean, default: false)
    field(:somatic_component, :boolean, default: false)
    field(:verbal_component, :boolean, default: false)
    field(:school, :string)
    field(:concentration, :boolean, default: false)
    field(:material_component_price, :integer)

    many_to_many(:spellbooks, SpellBook,
      join_through: "spellbook_spells",
      on_replace: :delete,
      unique: true,
      join_keys: [spell_id: :id, spellbook_id: :id]
    )

    timestamps()
  end

  def create_changeset(%__MODULE__{} = item, attrs) do
    item
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_number(:level, greater_than_or_equal_to: 0, less_than_or_equal_to: 9)
    |> validate_number(:material_component_price, greater_than_or_equal_to: 0)
    |> unique_constraint(:name)
  end
end
