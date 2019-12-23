defmodule Wobbly.GroupsTest do
  use Wobbly.DataCase

  alias Wobbly.{Groups, Repo, Veil}
  alias Wobbly.Groups.Group
  alias Wobbly.Veil.User

  @valid_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:user) do
    users = Repo.all(User)

    {:ok, user} =
      if length(users) > 0 do
        {:ok, users[0]}
      else
        Veil.create_user("demo@demo.com")
      end

    user
  end

  def fixture(:group) do
    user = fixture(:user)
    {:ok, group} = Groups.create_group(@valid_attrs, user)
    group
  end

  describe "view groups" do
    setup [:create_group]

    test "list_groups/0 returns all groups", %{group: %Group{} = group} do
      assert Groups.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id", %{group: %Group{} = group} do
      assert Groups.get_group!(group.id) == group
    end
  end

  describe "create groups" do
    setup [:get_or_create_user]

    test "create_group/1 with valid data creates a group", %{user: %User{} = user} do
      assert {:ok, %Group{} = group} = Groups.create_group(@valid_attrs, user)
      assert group.description == "some description"
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset", %{user: %User{} = user} do
      assert {:error, %Ecto.Changeset{}} = Groups.create_group(@invalid_attrs, user)
    end
  end

  describe "update groups" do
    setup [:create_group]

    test "update_group/2 with valid data updates the group", %{group: %Group{} = group} do
      assert {:ok, %Group{} = group} = Groups.update_group(group, @update_attrs)
      assert group.description == "some updated description"
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset", %{group: %Group{} = group} do
      assert {:error, %Ecto.Changeset{}} = Groups.update_group(group, @invalid_attrs)
      assert group == Groups.get_group!(group.id)
    end
  end

  describe "delete groups" do
    setup [:create_group]

    test "delete_group/1 deletes the group", %{group: %Group{} = group} do
      assert {:ok, %Group{}} = Groups.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_group!(group.id) end
    end
  end

  describe "group changesets" do
    setup [:create_group]

    test "change_group/1 returns a group changeset", %{group: %Group{} = group} do
      assert %Ecto.Changeset{} = Groups.change_group(group)
    end
  end

  defp get_or_create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  defp create_group(_) do
    group = fixture(:group)
    {:ok, group: group}
  end
end
