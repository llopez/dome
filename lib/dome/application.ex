defmodule Dome.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Dome.Repo,
      # Start the endpoint when the application starts
      DomeWeb.Endpoint,
      # Starts a worker by calling: Dome.Worker.start_link(arg)
      # {Dome.Worker, arg},
      {Tortoise.Connection, client_id: "dome", handler: {Dome.ThingHandler, []}, server: {Tortoise.Transport.Tcp, host: "192.168.0.13", port: 1883}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dome.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DomeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
