defmodule WobblyWeb.ApiOperations.UserApiOperation do
  alias OpenApiSpex.Operation
  alias WobblyWeb.Schemas.{AuthResponse, UserCreate}

  @spec open_api_operation(atom) :: Operation.t()
  def open_api_operation(action) do
    operation = String.to_existing_atom("#{action}_operation")
    apply(__MODULE__, operation, [])
  end

  @spec create_operation() :: Operation.t()
  def create_operation() do
    %Operation{
      tags: ["users"],
      summary: "Sign up / in",
      operationId: "UserController.create",
      requestBody: Operation.request_body("JSON body", "application/json", UserCreate),
      responses: %{
        200 => Operation.response("ok response", "application/json", AuthResponse)
      }
    }
  end
end
