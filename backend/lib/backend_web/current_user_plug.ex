defmodule BackendWeb.CurrentUserPlug do
  import Plug.Conn

  alias Backend.Users.Services.GuardianService

  def init(opts), do: opts

  def call(%Plug.Conn{params: params} = conn, _opts) do
    case GuardianService.current_user(conn) do
      {:ok, user} ->
        %{conn | params: Map.put(params, "current_user", user)}

      _ ->
        conn
        |> send_resp(401, "Access denied")
        |> halt()
    end
  end
end
