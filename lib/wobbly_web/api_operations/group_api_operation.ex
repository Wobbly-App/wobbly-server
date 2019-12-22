defmodule WobblyWeb.ApiOperations.GroupApiOperation do
  alias OpenApiSpex.Operation
  alias WobblyWeb.Schemas.{Group, GroupCreate, GroupUpdate, UUID}

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
        200 => Operation.response("List of groups", "application/json", Group)
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
        200 => Operation.response("The new group", "application/json", Group)
      }
    }
  end

  @spec show_operation() :: Operation.t()
  def show_operation() do
    %Operation{
      tags: ["groups"],
      summary: "Create a new group",
      requestBody: Operation.request_body("JSON body", "application/json", UUID),
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
      requestBody: Operation.request_body("JSON body", "application/json", GroupUpdate),
      responses: %{
        200 => Operation.response("The group", "application/json", Group)
      }
    }
  end
end
