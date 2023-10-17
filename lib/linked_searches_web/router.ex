defmodule LinkedSearchesWeb.Router do
  use LinkedSearchesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LinkedSearchesWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LinkedSearchesWeb do
    pipe_through :browser

    live "/", ThermostatLive
    get "/home", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", LinkedSearchesWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:linked_searches, :dev_routes) do

    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
