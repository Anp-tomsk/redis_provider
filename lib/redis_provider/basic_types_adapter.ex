defmodule RedisProvider.BasicTypesAdapter do

  def set(key, value) do
    ["SET", key, value]
  end

  def get(key) do
    ["GET", key]
  end

  def del(key) do
    ["DEL", key]
  end
end
