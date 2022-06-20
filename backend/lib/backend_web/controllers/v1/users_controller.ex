defmodule BackendWeb.V1.UsersController do
  use BackendWeb, :controller

  alias Backend.Users
  alias Backend.Users.Services.GuardianService

  action_fallback(BackendWeb.FallbackController)

  def index(conn, attrs) do
    users = Users.list_users(attrs)
    render(conn, "index.json", %{users: users})
  end

  def create(conn, attrs) do
    with {:ok, user} <- Users.create_user(attrs),
         {:ok, access_token, refresh_token} <- GuardianService.sign(user) do
      render(conn, "create.json", %{
        access_token: access_token,
        refresh_token: refresh_token,
      })
    end
  end
end
