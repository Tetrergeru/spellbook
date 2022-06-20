defmodule Backend.Users.Commands.CreateUser do
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(attrs) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end
end
