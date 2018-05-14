defmodule SlackHook do
  @moduledoc """
  Sends simple HTTP(S) request to Slack API to display short message on your channel.
  Remember to configure your webhook at config/config.exs:
        config :slack_hook, :url, "https://hooks.slack.com/services/*/*/*"

        config :slack_hook,
          default_url: "https://hooks.slack.com/services/*/*/*",
          urls: [some_name: "https://hooks.slack.com/services/*/*/*", other_name: "https://hooks.slack.com/services/*/*/*"]

  """

  @doc """
  Sends message to default channel.
  """
  def send(msg), do: SlackHook.send(msg, :default)

  @doc """
  Sends message to selected webhook url.
  Use if your application uses more than one hook.
  """
  def send(msg, key, opts \\ %{})
  def send(msg, key, opts) when is_atom(key), do: HTTPoison.post(get_url(key), get_content(msg, opts))
  def send(msg, url, opts) when is_bitstring(url), do: HTTPoison.post(url, get_content(msg, opts))

  @doc """
  Sends asynchronous message to selected webhook url.
  Use when you want to "fire and forget" your notifications.
  """
  def async_send(msg), do: SlackHook.async_send(msg, :default)

  @doc """
  Sends asynchronous message to selected webhook url.
  """
  def async_send(msg, key, opts \\ %{})
  def async_send(msg, key, opts) when is_atom(key) do
    HTTPoison.post(get_url(key), get_content(msg, opts), [], async: true)
  end

  def async_send(msg, url, opts) when is_bitstring(url) do
    HTTPoison.post(url, get_content(msg, opts), [], async: true)
  end

  defp get_url(:default), do: Application.get_env(:slack_hook, :default_url, false) || single_url()
  defp get_url(name), do: :slack_hook |> Application.get_env(:urls, []) |> Keyword.get(name, "")

  defp single_url, do: Application.get_env(:slack_hook, :url, "")

  defp get_content(msg, opts), do: Jason.encode!(Map.put(opts, :text, msg))
end
