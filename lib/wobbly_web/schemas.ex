defmodule WobblyWeb.Schemas do
  @moduledoc """
  Types/schemas for our OpenAPI schema.
  """
  alias OpenApiSpex.Schema

  defmodule AuthResponse do
    @moduledoc false
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
    @moduledoc false
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
    @moduledoc false
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
    @moduledoc false
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

  defmodule GroupNameAndDescription do
    @moduledoc false
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Group",
      description: "A Wobbly group (without its ID)",
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

  defmodule Group do
    @moduledoc false
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

  defmodule GroupCreate do
    @moduledoc false
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Group",
      description: "Data for creating a new group",
      type: :object,
      properties: %{
        group: %Schema{anyOf: [Group]}
      },
      example: %{
        group: %{
          name: "Bike Couriers Edinburgh",
          description: "A group for UberEats and Deliveroo couriers."
        }
      }
    })
  end

  defmodule GroupResponse do
    @moduledoc false
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Group",
      description: "A single Wobbly group",
      type: :object,
      properties: %{
        data: %Schema{anyOf: [Group]}
      },
      example: %{
        data: [
          %{
            id: "f6a77221-56a6-45e7-bebf-b15ac97bd15c",
            name: "Bike Couriers Edinburgh",
            description: "A group for UberEats and Deliveroo couriers."
          }
        ]
      }
    })
  end

  defmodule GroupsResponse do
    @moduledoc false
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Group",
      description: "A list of Wobbly groups",
      type: :object,
      properties: %{
        data: %Schema{description: "List of groups", type: :array, items: Group}
      },
      example: %{
        data: [
          %{
            id: "f6a77221-56a6-45e7-bebf-b15ac97bd15c",
            name: "Bike Couriers Edinburgh",
            description: "A group for UberEats and Deliveroo couriers."
          }
        ]
      }
    })
  end
end
