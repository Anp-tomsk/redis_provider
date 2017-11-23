defmodule RedisProvider do
    alias RedisProvider.Provider

    def start_link(), do: Redix.start_link(host: "192.168.99.100", port: 6379)

    defdelegate push(conn, key, value), to: Provider

    defdelegate del(conn, key), to: Provider

    defdelegate get_string(conn, key), to: Provider
    defdelegate get_list(conn, key), to: Provider
    defdelegate get_atom(conn, key), to: Provider
    defdelegate get_int(conn, key), to: Provider
end
