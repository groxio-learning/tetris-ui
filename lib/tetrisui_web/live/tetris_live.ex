defmodule TetrisuiWeb.TetrisLive do
  use Phoenix.LiveView
  import Phoenix.HTML, only: [raw: 1]
  
  @box_width 20
  @box_height 20

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
      <div>
        <%= raw svg_head() %>
        <%= raw box({1, 1}, :red) %>
        <%= raw svg_foot() %>
      </div>
    """
  end
  
  def svg_head() do
    """
    <svg 
    version="1.0" 
    id="Layer_1" 
    xmlns="http://www.w3.org/2000/svg" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    width="200" height="400" 
    viewBox="0 0 200 400" 
    xml:space="preserve">
    """
  end
  
  def svg_foot(), do: "</svg>"
  
  
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
      width="#{@box_width - 2}" height="#{@box_height - 2}"/>
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
end