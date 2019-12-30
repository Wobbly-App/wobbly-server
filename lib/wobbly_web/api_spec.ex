defmodule WobblyWeb.ApiSpec do
  @moduledoc """
  General setup for our OpenAPI schema (uses the OpenApiSpex library).
  """
  alias OpenApiSpex.{Components, Info, OpenApi, Paths, SecurityScheme, Server}
  alias WobblyWeb.{Endpoint, Router}

  @behaviour OpenApi
  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [
        # Populate the Server info from a phoenix endpoint
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: "Wobbly",
        version: Application.spec(:wobbly, :vsn) |> List.to_string()
      },
      # populate the paths from a phoenix router
      paths: Paths.from_router(Router),
      components: %Components{
        securitySchemes: %{
          apiKeyAuth: %SecurityScheme{
            type: "apiKey",
            in: "header",
            name: "session_unique_id"
          }
        }
      },
      security: [
        %{apiKeyAuth: []}
      ]
    }
    # discover request/response schemas from path specs
    |> OpenApiSpex.resolve_schema_modules()
  end
end
