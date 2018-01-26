defmodule Pingpong.MixProject do
  use Mix.Project

  def project do
    [
      app: :pingpong,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Pingpong.CLI]
    ]
  end

  defp deps do
    [
    ]
  end
end
