defmodule Backend.SpellBooks.Entities.SpellBook do
  use Ecto.Schema

  import Ecto.Changeset

  alias Backend.Users.Entities.User
  alias Backend.Spells.Entities.Spell
  alias Backend.Repo

  @required [
    :user_id
  ]

  @optional [
    :character_name,
    :character_level
  ]

  schema "spellbooks" do
    field(:character_name, :string)
    field(:character_level, :integer)

    belongs_to(:user, User)

    many_to_many(:spells, Spell,
      join_through: "spellbook_spells",
      on_replace: :delete,
      unique: true,
      join_keys: [spellbook_id: :id, spell_id: :id]
    )

    timestamps()
  end

  def create_changeset(%__MODULE__{} = spellbook, attrs) do
    spellbook
    |> Repo.preload(:spells)
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_number(:character_level, less_than_or_equal_to: 20, greater_than_or_equal_to: 1)
    |> assoc_constraint(:user)
    # Set the association
    |> put_assoc(:spells, attrs["spells"])
  end
end
