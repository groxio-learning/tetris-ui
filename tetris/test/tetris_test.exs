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
  
  test "drops without merging" do
    brick = Brick.new(location: {5, 5})
    bottom = %{}
    
    expected = 
      %{
        block: Brick.down(brick),
        bottom: %{}, 
        score: 1
      }
      
    actual = drop(brick, bottom, :red)
    
    assert actual == expected
  end

  test "drops and merges" do
    brick = Brick.new(location: {5, 16})
    bottom = %{}
    
    actual = Tetris.drop(brick, bottom, :red)
    
    assert Map.get(actual.bottom, {7, 20}) == {7, 20, :red}
  end
  

end
