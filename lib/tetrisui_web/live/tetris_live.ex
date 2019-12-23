defmodule TetrisuiWeb.TetrisLive do
  use Phoenix.LiveView
  import Phoenix.HTML, only: [raw: 1]

  def mount(_session, socket) do
    {
      :ok, 
      assign(socket, 
        tetromino: Tetris.Brick.new_random |> Tetris.Brick.to_string
      )
    }
  end

  def render(assigns) do
    ~L"""
      <h1>Hello</h1>
      <pre><%= @tetromino %></pre>
    """
  end
end