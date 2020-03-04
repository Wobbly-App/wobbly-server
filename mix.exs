defmodule Wobbly.MixProject do
  use Mix.Project

  def project do
    [
      app: :wobbly,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.json": :test]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ejabberd, "~> 20.2"},
      {:logger_lager_backend, "~> 0.2.0"},
      {:credo, "~> 1.2", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.10.1", only: :dev},
      {:excoveralls, "~> 0.12.1", only: :test},
      {:husky, "~> 1.0", only: :dev, runtime: false},
    ]
  end
end
