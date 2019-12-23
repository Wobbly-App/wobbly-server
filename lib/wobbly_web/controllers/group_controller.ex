defmodule WobblyWeb.GroupController do
  use WobblyWeb, :controller

  alias Wobbly.Groups
  alias Wobbly.Groups.Group

  action_fallback WobblyWeb.FallbackController
  defdelegate open_api_operation(action), to: WobblyWeb.ApiOperations.GroupApiOperation

  def index(conn, _params) do
    groups = Groups.list_user_groups(conn.assigns.veil_user)
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Groups.create_group(group_params, conn.assigns.veil_user) do
      conn
      |> put_status(:created)
      |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Groups.get_group!(id)

    with {:ok, %Group{} = group} <- Groups.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end
end
