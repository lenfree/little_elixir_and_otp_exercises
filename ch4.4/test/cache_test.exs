defmodule CacheTest do
  use ExUnit.Case
  doctest Cache

  test "insert a list of values to a key" do
    {:ok, _pid} = Cache.start()
    :ok = Cache.write(:stooges, ["larry", "bird"])
    assert Cache.read(:stooges) == ["larry", "bird"]
  end

  test "delete a key from map" do
    {:ok, _pid} = Cache.start()
    :ok = Cache.write(:stooges, ["larry", "bird"])
    :ok = Cache.delete(:stooges)
    assert Cache.read(:stooges) == nil
  end

  test "check if a key from map exists" do
    {:ok, _pid} = Cache.start()
    :ok = Cache.write(:stooges, ["larry", "bird"])
    assert Cache.exists?(:stooges) == true
    assert Cache.exists?(:hello) == false
  end

  test "clear map should return empty map" do
    {:ok, _pid} = Cache.start()
    :ok = Cache.write(:stooges, ["larry", "bird"])
    _values = Cache.read(:stooges)
    Cache.clear()
    assert Cache.read(:stooges) == nil
  end
end
