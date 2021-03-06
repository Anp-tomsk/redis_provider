defmodule RedisProvider.Mixfile do
  use Mix.Project

  def project do
    [
      app: :redis_provider,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {RedisProvider.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:redix, ">= 0.0.0"}
    ]
  end
end
