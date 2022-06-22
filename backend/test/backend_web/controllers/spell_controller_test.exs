defmodule BackendWeb.Spells.Tests do
  use BackendWeb.ConnCase

  import BackendWeb.Router.Helpers

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, %{conn: conn, user: user}}
  end

  test "unauthorised users can't create spell", %{conn: conn} do
    attrs = %{
      name: "Th Orb of Foobar",
      description: "Casts the great orb",
      level: 4,
      school: "destruction"
    }

    response =
      conn
      |> post(spells_path(conn, :create), attrs)
      |> json_response(401)

    assert(%{"errors" => ["Unauthorized"]} = response)
  end

  test "can create spell", %{conn: conn, user: user} do
    conn = as_user(conn, user)

    attrs = %{
      name: "Th Orb of Foobar",
      description: "Casts the great orb",
      level: 4,
      school: "destruction"
    }

    response =
      conn
      |> post(spells_path(conn, :create), attrs)
      |> json_response(200)

    assert(%{"ok" => true} = response)
  end
end
