defmodule HizzleWeb.Router do
  use HizzleWeb, :router
  require Ueberauth
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug Phoenix.LiveView.Flash
    # plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_live do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {HizzleWeb.LiveLayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", HizzleWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/", HizzleWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/song", SongController, :index
    get "/logout", AuthController, :logout

    live("/thermostat", ThermostatLive, session: [:path_params, :current_user])
  end

  # Other scopes may use custom stacks.
  # scope "/api", HizzleWeb do
  #   pipe_through :api
  # end
end
