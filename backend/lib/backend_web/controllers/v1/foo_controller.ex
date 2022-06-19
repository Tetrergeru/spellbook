defmodule BackendWeb.V1.FooController do
  use BackendWeb, :controller

  action_fallback(BackendWeb.FallbackController)

  def index(conn, %{"id" => id}) do
    case id do
      "foo" -> render(conn, "index.json", %{})
      _ -> {:error, :not_found}
    end
  end

  def index(conn, %{}) do
    {:error, :not_found}
  end
end
