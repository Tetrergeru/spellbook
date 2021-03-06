defmodule Backend.Users.Queries.ListUsers do
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(params) do
    Repo.paginate(User, params)
  end
end

defmodule Backend.Users.Queries.GetUser do
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(id) do
    Repo.find(User, id)
  end
end

defmodule Backend.Users.Queries.GetUserNickname do
  alias Backend.Users.Entities.User
  alias Backend.Repo

  def process(nickname) do
    Repo.find_by(User, [nickname: nickname])
  end
end
