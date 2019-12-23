defmodule Tetris do
  alias Tetris.{Bottom, Brick, Points}
  
  def prepare(brick) do
    brick
    |> Brick.prepare
    |> Points.move_to_location(brick.location)
  end
  
  def try_move(brick, bottom, f) do
    new_brick = f.(brick)
    
    if Bottom.collides?(bottom, prepare(new_brick)) do
      brick
    else
      new_brick
    end
  end
  
  def try_left(brick, bottom), do: try_move(brick, bottom, &Brick.left/1)
  def try_right(brick, bottom), do: try_move(brick, bottom, &Brick.right/1)
  def try_spin_90(brick, bottom), do: try_move(brick, bottom, &Brick.spin_90/1)
end
