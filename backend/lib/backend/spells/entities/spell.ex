defmodule Backend.Spells.Entities.Spell do
  use Ecto.Schema

  import Ecto.Changeset

  alias Backend.Spells.Entities.SpellEntity
  alias Backend.Repo

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
    field :name, :string
    field :level, :integer
    field :description, :string
    field :material_component, :boolean, default: false
    field :somatic_component, :boolean, default: false
    field :verbal_component, :boolean, default: false
    field :school, :string
    field :concentration, :boolean, default: false
    field :material_component_price, :integer

    timestamps()
  end

  def create_changeset(%__MODULE__{} = item, attrs) do
    IO.inspect attrs
    item
    # |> Repo.preload(:spells)
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_number(:level, greater_than_or_equal_to: 0, less_than_or_equal_to: 9)
    |> unique_constraint(:name)
  end
end
