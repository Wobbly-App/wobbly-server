defmodule WobblyWeb.Schemas do
  alias OpenApiSpex.Schema

  defmodule User do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "User",
      description: "A user of the app",
      type: :object,
      properties: %{
        id: %Schema{type: :uuid, description: "User ID"},
        email: %Schema{type: :string, description: "Email address", format: :email},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      required: [:email],
      example: %{
        "id" => 123,
        "email" => "joe@gmail.com",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end

  defmodule UserResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UserResponse",
      description: "Response schema for single user",
      type: :object,
      properties: %{
        data: User
      },
      example: %{
        "data" => %{
          "id" => 123,
          "email" => "joe@gmail.com",
          "inserted_at" => "2017-09-12T12:34:55Z",
          "updated_at" => "2017-09-13T10:11:12Z"
        }
      }
    })
  end
end
