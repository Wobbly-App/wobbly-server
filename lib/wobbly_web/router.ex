defmodule WobblyWeb.Router do
  use WobblyWeb, :router
  alias WobblyWeb.Veil

  pipeline :api do
    plug OpenApiSpex.Plug.PutApiSpec, module: WobblyWeb.ApiSpec
    plug :accepts, ["json"]
    plug WobblyWeb.Plugs.Veil.UserId
    plug WobblyWeb.Plugs.Veil.User
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/api/v1" do
    pipe_through :api
    get "/openapi", OpenApiSpex.Plug.RenderSpec, []

    post("/users", Veil.UserController, :create)
    post("/sessions/new", Veil.SessionController, :create)
    delete("/sessions/signout", Veil.SessionController, :delete)
  end

  # Add routes that require authentication in this block.
  scope "/api/v1", WobblyWeb do
    pipe_through([:api, WobblyWeb.Plugs.Veil.Authenticate])
  end

  scope "/" do
    pipe_through :browser
    # TODO: don't include in non-dev environments
    get "/swagger", OpenApiSpex.Plug.SwaggerUI, path: "/api/v1/openapi"
  end
end
