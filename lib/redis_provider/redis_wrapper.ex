defmodule RedisProvider.RedisWrapper do
  def execute(command, conn) do
    conn |> Redix.command(command)
  end

  def execute_pipe(commands, conn) do
    IO.inspect(commands)
    conn |> Redix.pipeline(commands)
  end
end
