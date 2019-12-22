defmodule WobblyWeb.Veil.SessionController do
  use WobblyWeb, :controller
  alias Wobbly.Veil

  action_fallback(WobblyWeb.Veil.FallbackController)
  defdelegate open_api_operation(action), to: WobblyWeb.ApiOperations.SessionApiOperation

  @doc """
  Creates a new session using a unique id sent by email.
  If creating the new session is successful, the user is verified and the request is deleted.
  """
  def create(conn, %{"request_id" => request_unique_id}) do
    with {:ok, request} <- Veil.get_request(request_unique_id),
         {:ok, user_id} <- Veil.verify(conn, request),
         {:ok, session} <- Veil.create_session(conn, user_id) do
      Task.start(fn -> Veil.verify_user(user_id) end)
      Task.start(fn -> Veil.delete(request) end)

      conn
      |> render("show.json", session: session)
    else
      error ->
        error
    end
  end

  @doc """
  Deletes an existing session and logs the user out.
  """
  def delete(conn, %{"session_id" => session_unique_id}) do
    with {:ok, _del} <- Cachex.del(:veil_sessions, session_unique_id),
         {:ok, _session} <- Veil.delete_session(session_unique_id) do
      conn
      |> render("ok.json")
    else
      error ->
        error
    end
  end
end
