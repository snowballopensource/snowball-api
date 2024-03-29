defmodule Snowball.Mixfile do
  use Mix.Project

  def project do
    [app: :snowball,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [mod: {Snowball, []},
     applications: applications()]
  end

  defp applications do
    [:phoenix,
     :cowboy,
     :logger,
     :phoenix_ecto,
     :postgrex,
     :comeonin,
     :ex_aws,
     :httpoison,
     :sweet_xml,
     :honeybadger]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:postgrex, "~> 0.11.2"},
     {:phoenix_ecto, "~> 3.0"},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 2.4"},
     {:secure_random, "~> 0.2"},
     {:ex_aws, "~> 0.5.0", github: "jamescmartinez/ex_aws", override: true},
     {:httpoison, "~> 0.9.0"},
     {:sweet_xml, "~> 0.6.1"},
     {:arc, "~> 0.5.2"},
     {:arc_ecto, "~> 0.4.2"},
     {:honeybadger, "~> 0.5"},
     {:ex_phone_number, github: "socialpaymentsbv/ex_phone_number", branch: :develop},
     {:envy, "~> 1.0.0", only: [:dev, :test]},
     {:credo, "~> 0.3", only: [:dev, :test]},
     {:ex_machina, "~> 1.0", only: :test},
     {:faker, "~> 0.5", only: :test}]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
