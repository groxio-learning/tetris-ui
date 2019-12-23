defmodule TetrisuiWeb.Router do
  use TetrisuiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TetrisuiWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/tetris", TetrisLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", TetrisuiWeb do
  #   pipe_through :api
  # end
end
