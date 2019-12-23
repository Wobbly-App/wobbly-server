defmodule Wobbly.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  alias Wobbly.Repo
  alias Wobbly.Groups.{Group, UserGroup}
  alias Wobbly.Veil.User
  require Logger

  @doc """
  Returns the list of groups of the current user.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups() do
    Repo.all(Group)
  end

  @doc """
  Returns a list of groups of the current user.
  """
  def list_user_groups(%User{} = user) do
    Repo.all(Ecto.assoc(user, :groups))
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value}, %{id: user_id})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value}, %{id: user_id})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}, %User{} = user) do
    with {:ok, group} <- create_group_only(attrs),
         {:ok, _user_group} <- add_member(group, user) do
      {:ok, group}
    else
      err -> err
    end
  end

  defp create_group_only(attrs) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{source: %Group{}}

  """
  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end

  def add_member(%Group{} = group, %User{} = user) do
    %UserGroup{
      user_id: user.id,
      group_id: group.id
    }
    |> (fn i ->
          Logger.info(inspect(i))
          i
        end).()
    |> Repo.insert(on_conflict: :nothing)
  end
end
