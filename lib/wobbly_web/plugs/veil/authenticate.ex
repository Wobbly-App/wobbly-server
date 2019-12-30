defmodule WobblyWeb.Plugs.Veil.Authenticate do
  @moduledoc """
  A plug to restrict access to logged in users
  We simply check to see if the user has the :veil_user_id assign set
  """

  def init(default), do: default

  def call(conn, _opts) do
    if is_nil(conn.assigns[:veil_user_id]) do
      conn
      |> Phoenix.Controller.put_view(WobblyWeb.Veil.ErrorView)
      |> Phoenix.Controller.render(:no_permission)
      |> Plug.Conn.halt()
    else
      conn
    end
  end
end
