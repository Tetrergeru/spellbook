defmodule BackendWeb.Policies.V1.PrivatePolicy do
  @behaviour Bodyguard.Policy

  alias Backend.Users.Entities.User

  def authorize(action, %User{}, _)
      when action in [:show, :update],
      do: :ok

  def authorize(_action, _user, _params), do: false
end
