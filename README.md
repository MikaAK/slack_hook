SlackWebhook
============

Sends simple messages to Slack channel using webhook API.

## Usage

1. Register new integration here: https://my.slack.com/services/new/incoming-webhook/
   You will receive Webhook URL similar to https://hooks.slack.com/services/*/*/*

2. Add dependency in `mix.exs`.
```elixir
{:slack_hook, "~> 0.0.1"}
```
3. Add Webhook URL to your application configuration.
```elixir
config :slack_hook, :url, "https://hooks.slack.com/services/*/*/*"
#or
config :slack_hook,
   default_url: "https://hooks.slack.com/services/*/*/*",
   urls: [my_other_point: "https://hooks.slack.com/services/*/*/*"]
```
4. Send synchronous message.
```elixir
SlackWebhook.send "lorem ipsum"
```
5. Send asynchronous message.
```elixir
SlackWebhook.async_send "lorem ipsum"
```

6. Send message to configed url.
```elixir
SlackWebhook.async_send "lorem ipsum", :my_other_point
```

7. Send message to configed url.
```elixir
SlackWebhook.async_send "lorem ipsum", "https://hooks.slack.com/services/*/*/*"
```
## Sync vs Async

Unless you want to handle exceptions, use `async_send`.
If you compare synchronous:
```elixir
iex(10)> :timer.tc fn -> SlackWebhook.send "test" end
{239446,
```

And asynchronous:
```elixir
iex(10)> :timer.tc fn -> SlackWebhook.async_send "test" end
{604, {:ok, %HTTPoison.AsyncResponse{id: #Reference<0.0.2.666>}}}
```
You will get:
```
send (avg)| async_send (avg)
----------|-----------------
239446 us | 685 us
```
Of course, in asynchronous code we don't wait for reply to handle possible errors and that's where the boost come from.
If you use Slack notifications for anything critical, use `send`.
Otherwise, use `async_send`, enjoy speed and clear process mailbox from time to time.


