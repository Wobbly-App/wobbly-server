defmodule WobblyTest do
  use ExUnit.Case
  doctest Wobbly

  test "greets the world" do
    assert Wobbly.hello() == :world
  end
end
