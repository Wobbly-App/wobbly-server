defmodule WobblyWeb.Router do
  use WobblyWeb, :router

  pipeline :api do
    plug OpenApiSpex.Plug.PutApiSpec, module: WobblyWeb.ApiSpec
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/api/v1" do
    pipe_through :api
    resources "/users", WobblyWeb.UserController, except: [:index, :new, :edit]
    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/" do
    pipe_through :browser
    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/v1/openapi"
  end
end
