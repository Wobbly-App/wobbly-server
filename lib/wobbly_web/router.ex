defmodule WobblyWeb.Router do
  use WobblyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug WobblyWeb.APIAuthPlug, otp_app: :wobbly
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: WobblyWeb.APIAuthErrorHandler
  end

  scope "/api", WobblyWeb.API, as: :api do
    pipe_through :api

    # Public API endpoints
    scope "/v1", V1, as: :v1 do
      resources "/registration", RegistrationController, singleton: true, only: [:create]
      resources "/session", SessionController, singleton: true, only: [:create, :delete]
      post "/session/renew", SessionController, :renew
    end

    # Protected API endpoints
    scope "/v1", V1, as: :v1 do
      pipe_through :api_protected

      resources "/groups", GroupController, only: [:index, :create, :show, :update]
      resources "/messages", MessageController, only: [:create, :index]
    end
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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: WobblyWeb.Telemetry
    end
  end
end
