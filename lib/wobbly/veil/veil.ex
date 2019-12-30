defmodule Wobbly.Veil do
  @moduledoc """
  Veil's main context
  """
  alias Phoenix.{Controller, Token}
  alias Veil.{Cache, Secure}
  alias Wobbly.Repo
  alias Wobbly.Veil.{Request, Session, User}
  alias WobblyWeb.Endpoint
  alias WobblyWeb.Router.Helpers, as: RouterHelpers
  alias WobblyWeb.Veil.{LoginEmail, Mailer}

  # These are only used to sign request/session tokens that are saved in the database and
  # not sent to users.
  @request_salt "ink8S8TjVvDsrEwZNOwDXGBqHYoUL6QwLVOOSm+7ezkunQ=="
  @session_salt "Da7enKE5RxV9Hw8A7Yi1JzIx2pAeorqnqxzfsCOn/ndi1hU="

  @doc """
  Gets user associated with user_id
  """
  def get_user(user_id) do
    Cache.get_or_update(:veil_users, user_id, &get_user_repo/1)
  end

  defp get_user_repo(user_id) do
    Repo.get(User, user_id)
  end

  @doc """
  Gets user associated with email
  """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email |> String.downcase())
  end

  @doc """
  Creates an unverified user with the given email
  """
  def create_user(email) do
    %User{}
    |> User.changeset(%{email: email})
    |> Cache.put(:veil_users, &Repo.insert/1)
  end

  @doc """
  Deletes the given user
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Sets verified flag on the user associated with the user_id given, if needed
  """
  def verify_user(%User{} = user) do
    if not user.verified and not is_nil(user.email) do
      update_user(user, %{verified: true})
    else
      {:ok, user}
    end
  end

  def verify_user(user_id) do
    case get_user(user_id) do
      {:ok, user} -> verify_user(user)
      error -> error
    end
  end

  def update_user(%User{} = user, attrs) do
    case do_update_user(user, attrs) do
      {:ok, user} -> {:ok, user}
      error -> error
    end
  end

  defp do_update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Cache.put(:veil_users, &Repo.update/1)
  end

  @doc """
  Sends a new login email to the user
  """
  def send_login_email(conn, %User{} = user, %Request{} = request) do
    user.email
    |> LoginEmail.generate(new_session_url(conn, request.unique_id))
    |> Mailer.deliver()
  end

  def new_session_url(conn, unique_id) do
    cur_uri = Controller.endpoint_module(conn).struct_url()

    cur_path = RouterHelpers.session_path(conn, :create, request_id: unique_id)

    RouterHelpers.url(cur_uri) <> cur_path
  end

  @doc """
  Creates a new login request for the user provided
  """
  def create_request(conn, %User{} = user) do
    phoenix_token = Token.sign(conn, @request_salt, user.id)
    unique_id = Secure.generate_unique_id(conn)

    %Request{}
    |> Request.changeset(%{
      user_id: user.id,
      phoenix_token: phoenix_token,
      unique_id: unique_id
    })
    |> Repo.insert()
  end

  @doc """
  Gets the request associated with the unique id
  """
  def get_request(unique_id) do
    if request = Repo.get_by(Request, unique_id: unique_id) do
      {:ok, request}
    else
      {:error, :no_permission}
    end
  end

  @doc """
  Verifies that the phoenix_token inside the request/session is valid and has not expired
  """
  def verify(%Session{} = session) do
    verify(Endpoint, session)
  end

  def verify(%Request{} = request) do
    verify(Endpoint, request)
  end

  def verify(conn, %Session{phoenix_token: phoenix_token}) do
    max_age = Application.get_env(:veil, :session_expiry)
    verify_session_token(conn, phoenix_token, max_age)
  end

  def verify(conn, %Request{phoenix_token: phoenix_token}) do
    max_age = Application.get_env(:veil, :sign_in_link_expiry)
    Phoenix.Token.verify(conn, @request_salt, phoenix_token, max_age: max_age)
  end

  @doc """
  Creates a new session for the user associated with user_id
  """
  def create_session(conn, user_id) do
    %Session{}
    |> Session.changeset(%{
      user_id: user_id,
      phoenix_token: create_session_token(conn, user_id),
      unique_id: Secure.generate_unique_id(conn)
    })
    |> Cache.put(:veil_sessions, &Repo.insert/1, & &1.unique_id)
  end

  defp create_session_token(conn, user_id) do
    Phoenix.Token.sign(conn, @session_salt, user_id)
  end

  @doc """
  Gets the session associated with the unique id
  """
  def get_session(nil), do: {:error, :no_permission}

  def get_session(unique_id) do
    case Cache.get_and_refresh(:veil_sessions, unique_id) do
      {:ok, {:ok, session}} ->
        if is_nil(session) do
          if session = Repo.get_by(Session, unique_id: unique_id) do
            Cachex.put(:veil_sessions, unique_id, session)
            {:ok, session}
          else
            {:error, :no_session_found}
          end
        else
          {:ok, session}
        end

      error ->
        error
    end
  end

  @doc """
  Extends the session if it is older than the refresh_expiry_interval, by signing a new
  phoenix_token and replacing the one in the database
  """
  def extend_session(conn, %Session{phoenix_token: phoenix_token, user_id: user_id} = session) do
    max_age = Application.get_env(:veil, :refresh_expiry_interval)

    case verify_session_token(conn, phoenix_token, max_age) do
      {:error, :expired} ->
        session
        |> Session.changeset(%{phoenix_token: create_session_token(conn, user_id)})
        |> Cache.put(:veil_sessions, &Repo.update/1, & &1.unique_id)

      _ ->
        nil
    end
  end

  defp verify_session_token(conn, phoenix_token, max_age) do
    Phoenix.Token.verify(conn, @session_salt, phoenix_token, max_age: max_age)
  end

  @doc """
  Deletes the request/session
  """
  def delete(%Session{} = session) do
    Cachex.del(:veil_sessions, session.unique_id)
    Repo.delete(session)
  end

  def delete(%Request{} = request) do
    Repo.delete(request)
  end

  @doc """
  Deletes the session by unique id
  """
  def delete_session(unique_id) do
    case get_session(unique_id) do
      {:ok, session} -> delete(session)
      error -> error
    end
  end

  def delete_expired(list) when is_list(list) do
    list
    |> Enum.each(fn event ->
      case verify(event) do
        {:error, _} ->
          delete(event)

        {:ok, _} ->
          nil
      end
    end)
  end

  @doc """
  Deletes all expired requests
  """
  def delete_expired_requests do
    Request
    |> Repo.all()
    |> delete_expired()
  end

  @doc """
  Deletes all expired sessions
  """
  def delete_expired_sessions do
    Session
    |> Repo.all()
    |> delete_expired()
  end
end
