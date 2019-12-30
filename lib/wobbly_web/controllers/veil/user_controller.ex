defmodule WobblyWeb.Veil.UserController do
  use WobblyWeb, :controller
  alias Wobbly.Veil
  alias Wobbly.Veil.User
  require Logger

  action_fallback(WobblyWeb.Veil.FallbackController)

  defdelegate open_api_operation(action), to: WobblyWeb.ApiOperations.UserApiOperation

  @doc """
  If needed, creates a new user, otherwise finds the existing one.
  Creates a new request and emails the unique id to the user.
  """
  def create(conn, %{"email" => email}) when not is_nil(email) do
    if user = Veil.get_user_by_email(email) do
      sign_and_email(conn, user)
    else
      case Veil.create_user(email) do
        {:ok, user} -> sign_and_email(conn, user)
        error -> error
      end
    end
  end

  defp sign_and_email(conn, %User{} = user) do
    case Application.get_env(:wobbly, :env) do
      # Don't send emails in dev -- just log the generated session URL
      :dev ->
        case Veil.create_request(conn, user) do
          {:ok, request} ->
            Logger.info(Veil.new_session_url(conn, request.unique_id))
            render(conn, "ok.json")

          error ->
            error
        end

      _ ->
        with {:ok, request} <- Veil.create_request(conn, user),
             {:ok, _email} <- Veil.send_login_email(conn, user, request) do
          render(conn, "ok.json")
        else
          error ->
            error
        end
    end
  end
end
