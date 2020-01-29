defmodule ExPayrexx.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_payrexx,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # mod: {ExPayrexx.Application, []},
      extra_applications: [:logger, :exconstructor]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:mint, "~> 1.0"},
      {:castore, "~> 0.1"},
      {:jason, ">= 1.0.0"},
      {:exconstructor, "~> 1.1"}
    ]
  end
end
