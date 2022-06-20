defmodule BackendWeb.FallbackController do
  use BackendWeb, :controller

  alias BackendWeb.ErrorView
  alias Ecto.Changeset

  def call(%Conn{} = conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", %{})
  end

  def call(%Conn{} = conn, {:error, "invalid password"}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render("invalid_password.json", %{})
  end

  def call(%Conn{} = conn, {:error, :forbidden}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render("403.json", %{})
  end

  def call(%Conn{} = conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("422.json", changeset: changeset)
  end
end
