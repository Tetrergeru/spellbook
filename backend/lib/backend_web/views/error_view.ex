defmodule BackendWeb.ErrorView do
  use BackendWeb, :view

  def render("404.json", %{}) do
    %{errors: ["Not found"]}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
