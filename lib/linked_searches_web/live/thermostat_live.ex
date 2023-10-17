defmodule LinkedSearchesWeb.ThermostatLive do
  use LinkedSearchesWeb, :live_view

  def render(assigns) do
    ~H"""
    Current temperature: <%= @temperature %>
    """
  end

  def mount(_params, _session, socket) do
    temperature = 3
    {:ok, assign(socket, :temperature, temperature)}
  end
end