defmodule Backend.Users.Commands.Tests do
  use Backend.DataCase

  alias Backend.Users
  alias Backend.Users.Entities.User

  test "get_user test" do
    user = insert(:user)
    user_id = user.id
    assert {:ok, %User{id: ^user_id}} = Users.get_user(user.id)
  end

  test "get_user_nickname test" do
    user = insert(:user)
    user_id = user.id
    assert {:ok, %User{id: ^user_id}} = Users.get_user_nickname(user.nickname)
  end

  test "list_users test" do
    users = [insert(:user), insert(:user)]

    assert %{entries: res_users} = Users.list_users()

    ids = Enum.map(users, fn user -> user.id end)
    res_ids = Enum.map(res_users, fn user -> user.id end)

    assert [] = (ids -- res_ids)
    assert [] = (res_ids -- ids)
  end

  test "delete_user test" do
    user = insert(:user)

    user_id = user.id
    assert {:ok, %User{id: ^user_id}} = Users.get_user(user_id)

    Users.delete_user(user)

    assert {:error, :not_found} = Users.get_user(user_id)
  end

  test "update_user test" do
    user = insert(:user)

    user_id = user.id
    assert {:ok, %User{id: ^user_id}} = Users.get_user(user_id)

    Users.update_user(user, %{ "nickname" => "foobar" })

    assert {:ok, %User{ nickname: "foobar" }} = Users.get_user(user_id)
  end

  test "get nonexisting user test" do
    assert {:error, :not_found} = Users.get_user(1)
  end
end
