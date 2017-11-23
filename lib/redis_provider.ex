defmodule RedisProvider do
    alias RedisProvider.{Provider}

    def start_link(), do: Redix.start_link(host: "localhost", port: 6379)
    def start_link(host, port), do: Redix.start_link(host, port)

    def start_link(name) do
      {:ok, conn} = start_link()
      true = Process.register(conn, name)
      {:ok, conn}
    end

    defdelegate push(conn, key, value), to: Provider

    defdelegate del(conn, key), to: Provider

    defdelegate get_map(conn, key), to: Provider
    defdelegate get_string(conn, key), to: Provider
    defdelegate get_list(conn, key), to: Provider
    defdelegate get_atom(conn, key), to: Provider
    defdelegate get_int(conn, key), to: Provider
end
