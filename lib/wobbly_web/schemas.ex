defmodule WobblyWeb.Schemas do
  alias OpenApiSpex.Schema

  defmodule UUID do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UUID",
      description: "An ID",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "The v4 UUID"}
      }
    })
  end

  defmodule AuthResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "AuthResponse",
      description: "Response when signing in/up",
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
        session_id: "QUOGYC2PGPH56ETRFLCFM4I5RDJ6NMCJX4KRCVFXWYWTL75YRZOQ===="
      }
    })
  end

  defmodule GroupNameAndDescription do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "GroupNameAndDescription",
      description: "Core data about a group",
      type: :object,
      properties: %{
        name: %Schema{type: :string, description: "The group's name"},
        description: %Schema{type: :string, description: "The group's description"}
      },
      example: %{
        name: "Bike Couriers Edinburgh",
        description: "A group for UberEats and Deliveroo couriers."
      }
    })
  end

  defmodule GroupCreate do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "GroupCreate",
      description: "POST body for creating a group",
      type: :object,
      properties: %{
        group: GroupNameAndDescription
      },
      required: [:name],
      example: %{
        group: %{
          name: "Bike Couriers Edinburgh",
          description: "A group for UberEats and Deliveroo couriers."
        }
      }
    })
  end

  defmodule Group do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Group",
      description: "A Wobbly group",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "UUID of the group"},
        name: %Schema{type: :string, description: "The group's name"},
        description: %Schema{type: :string, description: "The group's description"}
      },
      example: %{
        id: "f6a77221-56a6-45e7-bebf-b15ac97bd15c",
        name: "Bike Couriers Edinburgh",
        description: "A group for UberEats and Deliveroo couriers."
      }
    })
  end

  defmodule GroupUpdate do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "GroupUpdate",
      description: "POST body for updating a group",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "UUID of the group"},
        group: Group
      },
      example: %{
        id: "f6a77221-56a6-45e7-bebf-b15ac97bd15c",
        group: %{
          name: "Bike Couriers Edinburgh",
          description: "A group for UberEats and Deliveroo couriers."
        }
      }
    })
  end
end
