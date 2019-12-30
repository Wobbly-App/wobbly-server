defmodule WobblyWeb.Router do
  use WobblyWeb, :router
  alias WobblyWeb.Veil

  @csp """
       default-src 'self' *.wobbly.app localhost;
       font-src fonts.googleapis.com fonts.gstatic.com;
       script-src 'unsafe-inline' cdnjs.cloudflare.com;
       style-src 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com fonts.gstatic.com;
       img-src 'self' data:"
       """
       |> String.replace(~r/\r|\n/, "")

  pipeline :api do
    plug OpenApiSpex.Plug.PutApiSpec, module: WobblyWeb.ApiSpec
    plug :accepts, ["json"]
    plug WobblyWeb.Plugs.Veil.UserId
    plug WobblyWeb.Plugs.Veil.User
  end

  pipeline :browser do
    plug :accepts, ["html"]

    plug :put_secure_browser_headers, %{
      "Content-Security-Policy" => @csp
    }
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
    resources "/groups", GroupController, except: [:new, :edit, :delete]
  end

  scope "/" do
    pipe_through :browser
    get "/swagger", OpenApiSpex.Plug.SwaggerUI, path: "/api/v1/openapi"
  end
end
