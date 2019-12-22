defmodule WobblyWeb.Schemas do
  alias OpenApiSpex.Schema

  defmodule AuthResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "AuthResponse",
      description: "Response when signinh in/up",
      type: :object,
      properties: %{
        ok: %Schema{type: :boolean, description: "true if successful"}
      }
    })
  end

  defmodule Session do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Session",
      description: "A session ID",
      type: :object,
      properties: %{
        session_id: %Schema{type: :string, description: "Session ID"}
      },
      example: %{
        session_id: "QUOGYC2PGPH56ETRFLCFM4I5RDJ6NMCJX4KRCVFXWYWTL75YRZOQ===="
      }
    })
  end

  defmodule UserCreate do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UserCreate",
      description: "POST body for signing in/up",
      type: :object,
      properties: %{
        email: %Schema{type: :string, description: "Email address", format: :email}
      },
      required: [:email],
      example: %{
        email: "demo@domain.com"
      }
    })
  end

  defmodule SessionCreate do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "SessionCreate",
      description: "POST body for creating a session",
      type: :object,
      properties: %{
        request_id: %Schema{type: :string, description: "Session request ID"}
      },
      required: [:request_id],
      example: %{
        request_id: "XLD5KU3O7YIFXRMHDECCZU5G3XAIJKSQ53K224X4DDIPFTGT6JLQ===="
      }
    })
  end

  defmodule SessionDelete do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "SessionDelete",
      description: "POST body for deleting a session",
      type: :object,
      properties: %{
        session_id: %Schema{type: :string, description: "Session unique ID"}
      },
      required: [:session_id],
      example: %{
        session_id: "ugh"
      }
    })
  end
end
