defmodule RedisProviderTest do
  use ExUnit.Case

  test "push atom and get should be completed" do
    {:ok, conn} = RedisProvider.start_link()
    assert {:ok, "OK"} = RedisProvider.push(conn, "atom:key", :value)
    assert {:ok, :value} = RedisProvider.get_atom(conn, "atom:key")
  end

  test "push int value and get it returned int val" do
    {:ok, conn} = RedisProvider.start_link()
    assert {:ok, "OK"} = RedisProvider.push(conn, "int:key", 1)
    assert {:ok, 1} = RedisProvider.get_int(conn, "int:key")
  end

  test "push string value and get it returned string val" do
    {:ok, conn} = RedisProvider.start_link()
    assert {:ok, "OK"} = RedisProvider.push(conn, "key", "string_value")
    assert {:ok, "string_value"} = RedisProvider.get_string(conn, "key")
  end

  test "push array value and get it return array" do
    {:ok, conn} = RedisProvider.start_link()
    assert {:ok, _} = RedisProvider.del(conn, "list:key")
    assert {:ok, _} = RedisProvider.push(conn, "list:key",  Enum.to_list(1..5))
    assert {:ok, ["1", "2", "3", "4", "5"]} = RedisProvider.get_list(conn, "list:key")
  end
end
