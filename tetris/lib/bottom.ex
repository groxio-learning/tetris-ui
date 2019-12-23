defmodule Tetris.Bottom do
  def merge(bottom, points) do
    points
    |> Enum.map(fn {x, y, c} -> {{x, y}, {x, y, c}} end)
    |> Enum.into(bottom)
  end
  
  def collides?(bottom, {x, y, _color}), do: collides?(bottom, {x, y})
  def collides?(bottom, {x, y}) do
    !!Map.get(bottom, {x, y}) || x < 1 || x > 10 || y > 20
  end
  def collides?(bottom, points) when is_list(points) do
    Enum.any?(points, &collides?(bottom, &1))
  end
end