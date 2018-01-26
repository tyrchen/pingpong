defmodule PingpongTest do
  use ExUnit.Case
  doctest Pingpong

  test "greets the world" do
    assert Pingpong.hello() == :world
  end
end
