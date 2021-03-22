defmodule Parseroo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Parseroo.Repo,
      # Start the Telemetry supervisor
      ParserooWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Parseroo.PubSub},
      # Start the Endpoint (http/https)
      ParserooWeb.Endpoint
      # Start a worker by calling: Parseroo.Worker.start_link(arg)
      # {Parseroo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Parseroo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ParserooWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
