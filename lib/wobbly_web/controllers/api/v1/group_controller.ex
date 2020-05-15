defmodule WobblyWeb.API.V1.GroupController do
  use WobblyWeb, :controller

  alias Wobbly.Groups
  alias Wobbly.Groups.Group

  action_fallback WobblyWeb.FallbackController

  def index(conn) do
    conn
    |> Pow.Plug.current_user()
    |> Groups.list_groups()
  end

  def create(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Groups.create_group(group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_v1_group_path(conn, :show, group))
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
