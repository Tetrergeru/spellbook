defmodule Backend.Users.Services.GuardianService do
  use Guardian, otp_app: :backend

  alias Backend.Users
  alias Backend.Users.Entities.User
  alias Backend.Changeset.Error

  def sign(%User{} = user) do
    with {:ok, access_token} <- create_access_token(user),
         {:ok, refresh_token} <- create_refresh_token(user) do
      {:ok, access_token, refresh_token}
    end
  end

  def current_user(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> {:error, :not_authorized}
      user -> {:ok, user}
    end
  end

  def subject_for_token(%User{id: id} = _user, _claims) do
    {:ok, "User:#{id}"}
  end

  def subject_for_token(_, _), do: {:error, Error.auth_error("Unknown resource type")}

  def resource_from_claims(%{"sub" => "User:" <> id}) do
    Users.get_user(id)
  end

  def resource_from_claims(_), do: {:error, Error.auth_error("Unhandled resource type")}

  defp create_access_token(user) do
    options = [token_type: :access, ttl: {1, :day}]
    {:ok, token, _claims} = encode_and_sign(user, %{}, options)
    {:ok, token}
  end

  defp create_refresh_token(user) do
    options = [token_type: :refresh, ttl: {30, :days}]
    {:ok, token, _claims} = encode_and_sign(user, %{}, options)
    {:ok, token}
  end
end

defmodule Backend.Users.Guardian.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :backend,
    error_handler: Backend.Users.Guardian.ErrorHandler,
    module: Backend.Users.Services.GuardianService

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end

defmodule Backend.Users.Guardian.ErrorHandler do
  use BackendWeb, :controller

  alias Backend.Changeset.Error
  alias BackendWeb.ErrorView

  def auth_error(conn, {type, _reason}, _opts) do
    error =
      type
      |> to_string()
      |> Error.auth_error()

    conn
    |> put_status(401)
    |> put_view(ErrorView)
    |> render("401.json", error: error)
  end
end

defmodule Backend.Changeset.Error do
  @derive Jason.Encoder
  @enforce_keys [:code]
  defstruct [:code, :field, :details]

  def auth_error(reason) do
    %__MODULE__{code: "authentication", details: reason}
  end

  def login_error do
    %__MODULE__{code: "login_error", details: "Invalid email/nickname or password"}
  end
end
