defmodule WobblyWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use WobblyWeb, :controller
  require Logger

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(WobblyWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(WobblyWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, error}) do
    Logger.error(inspect(error))

    conn
    |> put_status(:internal_server_error)
    |> put_view(WobblyWeb.ErrorView)
    |> render(:"500")
  end
end
