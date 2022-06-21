defmodule Backend.Users do
  alias Backend.Users.Commands.{
    CreateUser,
    DeleteUser,
    UpdateUser
  }

  alias Backend.Users.Queries.{
    ListUsers,
    GetUser,
    GetUserNickname
  }

  defdelegate create_user(attrs), to: CreateUser, as: :process
  defdelegate delete_user(user), to: DeleteUser, as: :process
  defdelegate update_user(user, attrs), to: UpdateUser, as: :process

  defdelegate list_users(params \\ %{}), to: ListUsers, as: :process
  defdelegate get_user(id), to: GetUser, as: :process
  defdelegate get_user_nickname(nickname), to: GetUserNickname, as: :process
end
