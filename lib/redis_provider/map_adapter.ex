defmodule RedisProvider.MapAdapter do

  def set(key, map) do
    ["HSET", key | key_values(map)]
  end

  def get(key, field) do
    ["HGET", key, field]
  end

  def keys(key) do
    ["HKEYS", key]
  end

  def get_values(key, keys) do
    keys |> Enum.map(fn map_key -> ["HGET", key, map_key] end)
  end

  def key_values(map), do:
    key_values(Map.keys(map), map)

  def key_values([], _map), do: []
  def key_values([head| tail], map), do:
    [head, map[head] | key_values(tail, map)]

end
