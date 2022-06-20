defmodule BackendWeb.V1.UsersView do
  use BackendWeb, :view

  def render("index.json", %{users: users}) do
    render_many(users, __MODULE__, "show.json", as: :user)
  end

  def render("show.json", %{user: user}) do
    %{nickname: user.nickname}
  end

  def render("create.json", %{
        access_token: access_token,
        refresh_token: refresh_token
      }) do
    %{
      access_token: access_token,
      refresh_token: refresh_token
    }
  end
end
