defmodule BackendWeb.ErrorView do
  use BackendWeb, :view

  alias Ecto.Changeset

  def render("404.json", %{}) do
    %{errors: ["Not found"]}
  end

  def render("401.json", %{}) do
    %{errors: ["Unauthorized"]}
  end

  def render("invalid_password.json", %{}) do
    %{errors: ["invalid password"]}
  end

  def render("422.json", %{changeset: %Changeset{errors: errors}}) do
    %{errors: convert_errors(errors)}
  end

  defp convert_errors(errors) do
    Enum.map(errors, fn {field, {details, _details}} ->
      %{field: field, code: details}
    end)
  end

  def template_not_found(template, _assigns) do
    %{
      errors: %{detail: Phoenix.Controller.status_message_from_template(template)},
      template: template
    }
  end
end
