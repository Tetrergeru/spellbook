defmodule BackendWeb.Users.Tests do
  use BackendWeb.ConnCase

  import BackendWeb.Router.Helpers

  setup %{conn: conn} do
    {:ok, %{conn: conn}}
  end

  test "can register user", %{conn: conn} do
    attrs = %{
      nickname: "foobar",
      password: "foobar1234",
      email: "foo@bar.foo"
    }

    response =
      conn
      |> post(users_path(conn, :create), attrs)
      |> json_response(200)

    assert(%{"access_token" => _, "refresh_token" => _} = response)
  end
end
