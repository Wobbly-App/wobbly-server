defmodule WobblyWeb.API.V1.MessageController do
  use WobblyWeb, :controller

  alias Wobbly.Messages
  alias Wobbly.Messages.Message

  action_fallback WobblyWeb.FallbackController

  def index(conn, _params) do
    messages =
      conn
      |> Pow.Plug.current_user()
      |> Messages.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    message_params = message_params
    |> Map.put("sender", Pow.Plug.current_user(conn))

    with {:ok, %Message{} = _message} <- Messages.create_message(message_params) do
      send_resp(conn, 200, "")
    end
  end

  def show(conn, %{"id" => id}) do
    message = Messages.get_message!(id)
    render(conn, "show.json", message: message)
  end
end
