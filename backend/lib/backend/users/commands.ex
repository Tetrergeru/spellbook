defmodule Backend.Users.Commands.CreateUser do
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(attrs) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end
end

defmodule Backend.Users.Commands.DeleteUser do
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(%User{} = user) do
    Repo.delete(user)
  end
end

defmodule Backend.Users.Commands.UpdateUser do
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(%User{} = user, attrs) do
    user
    |> User.create_changeset(attrs)
    |> Repo.update()
  end
end
