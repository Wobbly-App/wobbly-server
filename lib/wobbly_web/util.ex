defmodule WobblyWeb.Util do

  @spec keys_to_snake_case(Map.t()) :: Map.t()
  def keys_to_snake_case(map) do
    map
    |> Enum.reduce(%{}, fn ({key, value}, acc) ->
      Map.put(acc, Recase.to_snake(key), value)
    end)
  end

end
