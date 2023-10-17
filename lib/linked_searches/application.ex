defmodule LinkedSearches.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LinkedSearchesWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:linked_searches, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LinkedSearches.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LinkedSearches.Finch},
      # Start a worker by calling: LinkedSearches.Worker.start_link(arg)
      # {LinkedSearches.Worker, arg},
      # Start to serve requests, typically the last entry
      LinkedSearchesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LinkedSearches.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LinkedSearchesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
