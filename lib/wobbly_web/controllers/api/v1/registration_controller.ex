defmodule WobblyWeb.API.V1.RegistrationController do
  use WobblyWeb, :controller

  alias Ecto.Changeset
  alias Plug.Conn
  alias WobblyWeb.ErrorHelpers
  alias WobblyWeb.Util

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, %{"user" => user_params}) do
    user_params = Util.keys_to_snake_case(user_params)
    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
      {:ok, _user, conn} ->
        json(conn, %{data: %{access_token: conn.private[:api_access_token], renewal_token: conn.private[:api_renewal_token]}})

      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

        conn
        |> put_status(500)
        |> json(%{error: %{status: 500, message: "Couldn't create user", errors: errors}})
    end
  end
end
