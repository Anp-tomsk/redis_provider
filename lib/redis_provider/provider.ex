defmodule RedisProvider.Provider do
  alias RedisProvider.{BasicAdapter, ListAdapter, MapAdapter, RedisWrapper}

  def push(conn, key, value) when is_list(value) do
    ListAdapter.push(key, value)
    |> RedisWrapper.execute(conn)
  end

  def push(conn, key, value) when is_map(value) do
    MapAdapter.set(key, value)
    |> RedisWrapper.execute(conn)
  end

  def push(conn, key, value) do
    BasicAdapter.set(key, value)
    |> RedisWrapper.execute(conn)
  end

  def del(conn, key) do
    BasicAdapter.del(key)
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

  def get_map(conn, key) do
    MapAdapter.keys(key)
    |> RedisWrapper.execute(conn)
    |> fn {:ok, keys} ->
      MapAdapter.get_values(key, keys)
      |> RedisWrapper.execute_pipe(conn)
      |> fn {:ok, values} ->
        {:ok, create_map(values, keys, Map.new)}
      end.()
    end.()
  end

  defp create_map([], [], map), do: map
  defp create_map([head_value|tail_value], [head_key|tail_key], map) do
    create_map(tail_value, tail_key, Map.put(map, head_key, head_value))
  end

  defp get_basic_type(conn, key) do
    BasicAdapter.get(key)
    |> RedisWrapper.execute(conn)
  end

  defp handle_response({:ok, result}, type_cast) do
    {:ok, type_cast.(result)}
  end

end
