defmodule SlackWebhook.Mixfile do
  use Mix.Project

  def project do
    [app: :slack_hook,
     description: "Sends simple messages to Slack channel using webhook API.",
     version: "0.2.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
     {:jason, "~> 1.1"},
     {:httpoison, "~> 1.6.0"},
     {:earmark, "~> 1.2", only: :dev},
     {:ex_doc, "~> 0.18", only: :dev}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      contributors: ["Mika Kalathil"],
      links: %{
        "GitHub" => "https://github.com/mikaak/slack_hook"
      }
    ]
  end
end
