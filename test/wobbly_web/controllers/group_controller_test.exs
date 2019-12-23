defmodule WobblyWeb.GroupControllerTest do
  use WobblyWeb.ConnCase
  import Plug.Conn

  alias Wobbly.{Groups, Repo, Veil}
  alias Wobbly.Groups.Group
  alias Wobbly.Veil.User

  @create_attrs %{
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:user) do
    users = Repo.all(User)

    {:ok, user} =
      if length(users) > 0 do
        {:ok, users |> Enum.at(0)}
      else
        Veil.create_user("demo@demo.com")
      end

    user
  end

  def fixture(:group) do
    user = fixture(:user)
    {:ok, group} = Groups.create_group(@create_attrs, user)
    group
  end

  setup %{conn: conn} do
    user = fixture(:user)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> assign(:veil_user_id, user.id)
      |> assign(:veil_user, user)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all groups", %{conn: conn} do
      conn = get(conn, Routes.group_path(conn, :index))
      assert json_response(conn, 200) |> Map.get("data") == []
    end
  end

  describe "create group" do
    test "renders group when data is valid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @create_attrs)
      assert %{"data" => %{"id" => id}} = json_response(conn, 201)

      conn = recycle_conn(conn)
      conn = get(conn, Routes.group_path(conn, :show, id))

      assert %{
               "data" => %{
                 "id" => id,
                 "description" => "some description",
                 "name" => "some name"
               }
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update group" do
    setup [:create_group]

    test "renders group when data is valid", %{conn: conn, group: %Group{id: id} = group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @update_attrs)
      assert %{"data" => %{"id" => ^id}} = json_response(conn, 200)

      conn = recycle_conn(conn)
      conn = get(conn, Routes.group_path(conn, :show, id))

      assert %{
               "data" => %{
                 "id" => id,
                 "description" => "some updated description",
                 "name" => "some updated name"
               }
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, group: group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  # Not implemented
  # describe "delete group" do
  #   setup [:create_group]

  #   test "deletes chosen group", %{conn: conn, group: group} do
  #     conn = delete(conn, Routes.group_path(conn, :delete, group))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.group_path(conn, :show, group))
  #     end
  #   end
  # end

  defp create_group(_) do
    group = fixture(:group)
    {:ok, group: group}
  end

  defp recycle_conn(conn) do
    saved_assigns = conn.assigns

    conn
    |> recycle()
    |> Map.put(:assigns, saved_assigns)
  end
end
