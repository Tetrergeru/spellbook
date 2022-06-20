defmodule BackendWeb.V1.LoginController do
  use BackendWeb, :controller

  alias Backend.Users
  alias Backend.Users.Services.GuardianService

  action_fallback(BackendWeb.FallbackController)

  def create(conn, %{"nickname" => nickname, "password" => password}) do
    with {:ok, user} <- Users.get_user_nickname(nickname),
         {:ok, _} <- Argon2.check_pass(user, password),
         {:ok, access_token, refresh_token} <- GuardianService.sign(user) do
      render(conn, "create.json", %{
        access_token: access_token,
        refresh_token: refresh_token
      })
    end
  end

  def create(_conn, _) do
    {:error, :forbidden}
  end
end
