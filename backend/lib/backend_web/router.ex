defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :user_auth do
    plug(Backend.Users.Guardian.Pipeline)
  end

  pipeline :ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(BackendWeb.CurrentUserPlug)
  end

  scope "/api/v1", BackendWeb.V1 do
    pipe_through([:api])

    post("/users", UsersController, :create)
    resources("/users", UsersController, only: [:index])

    post("/login", LoginController, :create)

    resources("/spells", SpellsController, only: [:index])

    pipe_through([:user_auth, :ensure_auth])

    post("/spells", SpellsController, :create)

    post("/spellbooks", SpellBooksController, :create)
    resources("/spellbooks", SpellBooksController, only: [:index])
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: BackendWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
