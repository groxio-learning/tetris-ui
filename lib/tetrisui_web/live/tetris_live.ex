defmodule TetrisuiWeb.TetrisLive do
  use Phoenix.LiveView
  import Phoenix.HTML, only: [raw: 1]
  
  @box_width 20
  @box_height 20

  def mount(_session, socket) do
    {:ok, new_game(socket) }
  end

  def render(assigns) do
    ~L"""
      <h1>Hello</h1>
      <div phx-keydown="keydown" phx-target="window">
        <%= raw svg_head() %>
        <%= raw boxes(@tetromino) %>
        <%= raw svg_foot() %>
      </div>
    """
  end
  
  defp new_game(socket) do
    assign(socket, 
      state: :playing, 
      score: 0
    )
    |> new_block
    |> show
  end
  
  def new_block(socket) do
    brick = 
      Tetris.Brick.new_random()
      |> Map.put(:location, {3, 1})
    
    assign(socket, brick: brick)
  end
  
  def show(socket) do
    brick = socket.assigns.brick
    
    points = 
      brick
      |> Tetris.Brick.prepare
      |> Tetris.Points.move_to_location(brick.location)
      |> Tetris.Points.with_color(color(brick))
    
    assign(socket, tetromino: points)
  end
  
  def svg_head() do
    """
    <svg 
    version="1.0" 
    style="background-color: #F8F8F8"
    id="Layer_1" 
    xmlns="http://www.w3.org/2000/svg" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    width="200" height="400" 
    viewBox="0 0 200 400" 
    xml:space="preserve">
    """
  end
  
  def svg_foot(), do: "</svg>"
  
  def boxes(points_with_colors) do
    points_with_colors
    |> Enum.map( fn {x, y, color} -> 
      box({x, y}, color)
    end)
    |> Enum.join("\n")
  end
  
  
  def box(point, color) do
    """
    #{square(point, shades(color).light)}
    #{triangle(point, shades(color).dark)}
    """
  end
  def square(point, shade) do
    {x, y} = to_pixels(point)
    """
    <rect 
      x="#{x+1}" y="#{y+1}" 
      style="fill:##{shade};" 
      width="#{@box_width - 2}" height="#{@box_height - 1}"/>
    """
  end
  def triangle(point, shade) do
    {x, y} = to_pixels(point)
    {w, h} = {@box_width, @box_height}
    
    """
    <polyline 
        style="fill:##{shade}" 
        points="#{x + 1},#{y + 1} #{x + w},#{y + 1} #{x + w},#{y + h}" />
    """
  end
  
  defp to_pixels({x, y}), do: {x * @box_width, y * @box_height}
  
  defp shades(:red), do:    %{ light: "DB7160", dark: "AB574B"}
  defp shades(:blue), do:   %{ light: "83C1C8", dark: "66969C"}
  defp shades(:green), do:  %{ light: "8BBF57", dark: "769359"}
  defp shades(:orange), do: %{ light: "CB8E4E", dark: "AC7842"}
  defp shades(:grey), do:   %{ light: "A1A09E", dark: "7F7F7E"}
  
  defp color(%{name: :t}), do: :red
  defp color(%{name: :i}), do: :blue
  defp color(%{name: :l}), do: :green
  defp color(%{name: :o}), do: :orange
  defp color(%{name: :z}), do: :grey
  
  
  def move(direction, socket) do
    socket
    |> do_move(direction)
    |> show
  end
  
  def do_move(socket, :left) do
    assign(socket, brick: socket.assigns.brick |> Tetris.try_left(%{}))
  end
  def do_move(socket, :right) do
    assign(socket, brick: socket.assigns.brick |> Tetris.try_right(%{}))
  end
  def do_move(socket, :turn) do
    assign(socket, brick: socket.assigns.brick |> Tetris.try_spin_90(%{}))
  end

  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, move(:left, socket)}
  end
  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, move(:right, socket)}
  end
  def handle_event("keydown", %{"key" => "ArrowUp"}, socket) do
    {:noreply, move(:turn, socket)}
  end
  def handle_event("keydown", _, socket), do: {:noreply, socket}

end