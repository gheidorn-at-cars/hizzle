defmodule Hizzle.MixProject do
  use Mix.Project

  def project do
    [
      app: :hizzle,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Hizzle.Application, []},
      extra_applications: [:logger, :runtime_tools, :ueberauth, :ueberauth_auth0, :edeliver]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.2"},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_html, "~> 2.13", github: "phoenixframework/phoenix_html", override: true},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:distillery, "~> 2.0"},
      {:ueberauth, "~> 0.5"},
      {:ueberauth_auth0, "~> 0.3"},
      {:poison, "~> 3.1"},
      {:edeliver, "~> 1.6.0"},
      {:libcluster, "~> 2.0.3"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
