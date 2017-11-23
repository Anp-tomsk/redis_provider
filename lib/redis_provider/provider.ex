defmodule RedisProvider.Provider do
  alias RedisProvider.{BasicTypesAdapter, ListAdapter, RedisWrapper}

  def push(conn, key, value) when is_list(value) do
    ListAdapter.push(key, value)
    |> RedisWrapper.execute(conn)
  end

  def push(conn, key, value) do
    BasicTypesAdapter.set(key, value)
    |> RedisWrapper.execute(conn)
  end

  def del(conn, key) do
    BasicTypesAdapter.del(key)
    |> RedisWrapper.execute(conn)
  end

  def get_list(conn, key) do
    ListAdapter.len(key)
    |> RedisWrapper.execute(conn)
    |> fn {:ok, len} ->
      ListAdapter.get_range(key, 0, len)
      |> RedisWrapper.execute(conn)
    end.()
  end

  def get_atom(conn, key) do
    get_basic_type(conn, key)
    |> handle_response(&String.to_atom/1)
  end

  def get_int(conn, key) do
    get_basic_type(conn, key)
    |> handle_response(&String.to_integer/1)
  end

  def get_string(conn, key) do
    get_basic_type(conn, key)
  end

  defp get_basic_type(conn, key) do
    BasicTypesAdapter.get(key)
    |> RedisWrapper.execute(conn)
  end

  defp handle_response({:ok, result}, type_cast) do
    {:ok, type_cast.(result)}
  end

end
