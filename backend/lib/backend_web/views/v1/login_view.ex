defmodule BackendWeb.V1.LoginView do
  use BackendWeb, :view

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
