defmodule Backend.Repo do
  use Ecto.Repo,
    otp_app: :backend,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10 

  def find(query, id) do
    case __MODULE__.get(query, id) do
      %_{} = schema ->
        {:ok, schema}

      nil ->
        {:error, :not_found}
    end
  end

  def find_by(query, by) do
    case __MODULE__.get_by(query, by) do
      %_{} = schema ->
        {:ok, schema}

      nil ->
        {:error, :not_found}
    end
  end
end
