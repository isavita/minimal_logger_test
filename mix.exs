defmodule MinimalLoggerTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :minimal_logger_test,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MinimalLoggerTest.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.8"},
      {:plug, "~> 1.15"},
      {:jason, "~> 1.4"},
      {:logger_file_backend, "~> 0.0.13"}
    ]
  end
end
