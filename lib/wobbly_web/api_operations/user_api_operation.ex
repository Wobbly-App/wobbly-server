defmodule WobblyWeb.ApiOperations.UserApiOperation do
  alias OpenApiSpex.Operation
  alias WobblyWeb.Schemas.User

  @spec open_api_operation(atom) :: Operation.t()
  def open_api_operation(action) do
    operation = String.to_existing_atom("#{action}_operation")
    apply(__MODULE__, operation, [])
  end

  @spec show_operation() :: Operation.t()
  def show_operation() do
    %Operation{
      tags: ["users"],
      summary: "Show user",
      description: "Show a user by ID",
      operationId: "UserController.show",
      parameters: [
        Operation.parameter(:id, :path, :integer, "User ID", example: 123, required: true)
      ],
      responses: %{
        200 => Operation.response("User", "application/json", User)
      }
    }
  end
end
