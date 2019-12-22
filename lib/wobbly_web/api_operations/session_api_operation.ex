defmodule WobblyWeb.ApiOperations.SessionApiOperation do
  alias OpenApiSpex.Operation
  alias WobblyWeb.Schemas.{AuthResponse, Session, SessionCreate, SessionDelete}

  @spec open_api_operation(atom) :: Operation.t()
  def open_api_operation(action) do
    operation = String.to_existing_atom("#{action}_operation")
    apply(__MODULE__, operation, [])
  end

  @spec create_operation() :: Operation.t()
  def create_operation() do
    %Operation{
      tags: ["users"],
      summary: "Create a new session",
      requestBody: Operation.request_body("JSON body", "application/json", SessionCreate),
      responses: %{
        200 => Operation.response("new session", "application/json", Session)
      }
    }
  end

  @spec delete_operation() :: Operation.t()
  def delete_operation() do
    %Operation{
      tags: ["users"],
      summary: "Delete a session (i.e. sign out)",
      requestBody: Operation.request_body("JSON body", "application/json", SessionDelete),
      responses: %{
        200 => ok_response()
      }
    }
  end

  defp ok_response() do
    Operation.response("ok response", "application/json", AuthResponse)
  end
end
