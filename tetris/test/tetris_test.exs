defmodule TetrisTest do
  use ExUnit.Case
  import Tetris
  alias Tetris.{Brick}
  
  test "try to move right, success" do
    brick = Brick.new(location: {5, 1})
    bottom = %{}
    
    expected = brick |> Brick.right
    actual = try_right(brick, bottom)
    
    assert actual == expected
  end

  test "try to move right, failure returns original brick" do
    brick = Brick.new(location: {8, 1})
    bottom = %{}
    
    actual = try_right(brick, bottom)
    
    assert actual == brick
  end
  

end
