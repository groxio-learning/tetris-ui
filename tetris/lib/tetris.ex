defmodule Tetris do
  alias Tetris.{Bottom, Brick, Points}
  
  def prepare(brick) do
    brick
    |> Brick.prepare
    |> Points.move_to_location(brick.location)
  end
  
  def drop(brick, bottom, color) do
    new_brick = 
      Brick.down(brick)
    
    maybe_do_drop(
      Bottom.collides?(bottom, prepare(new_brick)), 
      bottom, 
      brick, 
      new_brick, 
      color
    )  
  end
  
  def maybe_do_drop(true=_collided, bottom, old_brick, _new_block, color) do
    points = 
      old_brick
      |> prepare 
      |> Points.with_color(color)
    
    {count, new_bottom} =  
      bottom 
      |> Bottom.merge(points) 
      |> Bottom.full_collapse
      
    %{
      block: Brick.new_random, 
      bottom: new_bottom,
      score: score(count)
    }
  end
  
  def maybe_do_drop(false=_collided, bottom, _old_block, new_block, _color) do
    %{
      block: new_block, 
      bottom: bottom,
      score: 1
    }
  end
  
  def score(count) do
    100 * round(:math.pow(2 ** count))
  end
  
  def try_left(brick, bottom), do: try_move(brick, bottom, &Brick.left/1)
  def try_right(brick, bottom), do: try_move(brick, bottom, &Brick.right/1)
  def try_spin_90(brick, bottom), do: try_move(brick, bottom, &Brick.spin_90/1)
  
  defp try_move(brick, bottom, f) do
    new_brick = f.(brick)
    
    if Bottom.collides?(bottom, prepare(new_brick)) do
      brick
    else
      new_brick
    end
  end

end
