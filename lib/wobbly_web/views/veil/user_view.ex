defmodule WobblyWeb.Veil.UserView do
  use WobblyWeb, :view

  def render("ok.json", _assigns) do
    %{ok: true}
  end
end
