defmodule Backend.Factories do
  use ExMachina.Ecto, repo: Backend.Repo

  use Backend.Factories.{
    UserFactory,
    SpellFactory
  }
end
