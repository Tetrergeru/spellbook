defmodule BackendWeb.FallbackController do
  use BackendWeb, :controller

  alias BackendWeb.ErrorView

  def call(%Conn{} = conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", %{})
  end
end
