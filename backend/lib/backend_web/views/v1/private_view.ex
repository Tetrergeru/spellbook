defmodule BackendWeb.V1.PrivateView do
  use BackendWeb, :view

  def render("show.json", %{ok: true}) do
    %{ok: true}
  end
end
