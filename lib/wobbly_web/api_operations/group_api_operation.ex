defmodule WobblyWeb.ApiOperations.GroupApiOperation do
  alias OpenApiSpex.Operation

  alias WobblyWeb.Schemas.{
    Group,
    GroupCreate,
    GroupResponse,
    GroupsResponse,
    GroupNameAndDescription
  }

  @spec open_api_operation(atom) :: Operation.t()
  def open_api_operation(action) do
    operation = String.to_existing_atom("#{action}_operation")
    apply(__MODULE__, operation, [])
  end

  @spec index_operation() :: Operation.t()
  def index_operation() do
    %Operation{
      tags: ["groups"],
      summary: "View the current user's groups",
      responses: %{
        200 => Operation.response("List of groups", "application/json", GroupsResponse)
      }
    }
  end

  @spec create_operation() :: Operation.t()
  def create_operation() do
    %Operation{
      tags: ["groups"],
      summary: "Create a new group",
      requestBody: Operation.request_body("JSON body", "application/json", GroupCreate),
      responses: %{
        200 => Operation.response("The new group", "application/json", GroupResponse)
      }
    }
  end

  @spec show_operation() :: Operation.t()
  def show_operation() do
    %Operation{
      tags: ["groups"],
      summary: "Get group details",
      parameters: [
        Operation.parameter(:id, :path, :string, "Group ID",
          example: "d1b42b3b-8dc6-4c9b-9a70-03db18a0ac78",
          required: true
        )
      ],
      responses: %{
        200 => Operation.response("The group", "application/json", Group)
      }
    }
  end

  @spec update_operation() :: Operation.t()
  def update_operation() do
    %Operation{
      tags: ["groups"],
      summary: "Update a group (that you are a member of)",
      parameters: [
        Operation.parameter(:id, :path, :string, "Group ID",
          example: "d1b42b3b-8dc6-4c9b-9a70-03db18a0ac78",
          required: true
        )
      ],
      requestBody:
        Operation.request_body("JSON body", "application/json", GroupNameAndDescription),
      responses: %{
        200 => Operation.response("The group", "application/json", Group)
      }
    }
  end
end
