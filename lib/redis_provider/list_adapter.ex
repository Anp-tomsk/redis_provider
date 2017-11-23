defmodule RedisProvider.ListAdapter do
  def push(key, values) do
    ["RPUSH", key | values]
  end

  def len(key) do
    ["LLEN", key]
  end

  def get_range(key, start, offset) do
    ["LRANGE", key, start, offset]
  end
end
