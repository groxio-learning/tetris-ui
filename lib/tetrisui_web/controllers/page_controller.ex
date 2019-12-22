defmodule TetrisuiWeb.PageController do
  use TetrisuiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
