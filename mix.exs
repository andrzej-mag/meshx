defmodule Meshx.MixProject do
  use Mix.Project

  @version "0.1.0-dev"
  @source_url "https://github.com/andrzej-mag/meshx"

  def project do
    [
      app: :meshx,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      name: "Meshx",
      description: "Service mesh support"
    ]
  end

  def application, do: []

  defp deps, do: [{:ex_doc, "~> 0.24.2", only: :dev, runtime: false}]

  defp package do
    [
      files: ~w(lib docs .formatter.exs mix.exs),
      maintainers: ["Andrzej Magdziarz"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      extras: ["docs/README.md"]
    ]
  end
end
