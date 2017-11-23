defmodule RedisProvider.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(RedisProvider, [:store])
    ]

    options = [strategy: :one_for_one, name: RedisProvider.Supervisor]
    Supervisor.start_link(children, options)
  end

end
