defmodule Parseroo.Application do
  use Application

  def start(_type, _args) do
    children = [
      Parseroo.Repo,
      ParserooWeb.Telemetry,
      {Phoenix.PubSub, name: Parseroo.PubSub},
      ParserooWeb.Endpoint,
      {Oban, oban_config()}
    ]

    opts = [strategy: :one_for_one, name: Parseroo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ParserooWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do
    opts = Application.get_env(:parseroo, Oban)

    # Prevent running queues or scheduling jobs from an iex console.
    if Code.ensure_loaded?(IEx) and IEx.started?() do
      opts
      |> Keyword.put(:crontab, false)
      |> Keyword.put(:queues, false)
    else
      opts
    end
  end
end
