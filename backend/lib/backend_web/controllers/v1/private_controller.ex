defmodule BackendWeb.V1.PrivateController do
  use BackendWeb, :controller

  alias BackendWeb.Policies.V1.PrivatePolicy

  action_fallback(BackendWeb.FallbackController)

  def index(conn, %{"current_user" => current_user} = _params) do
    with :ok <- Bodyguard.permit(PrivatePolicy, :show, current_user, nil) do
      render(conn, "show.json", %{ok: true})
    end
  end
end
