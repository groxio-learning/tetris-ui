defmodule BottomTest do
  use ExUnit.Case
  import Tetris.Bottom

  test "various collisions" do
    bottom = %{{1, 1} => {1, 1, :blue}}
    
    assert collides?(bottom, {1, 1})
    refute collides?(bottom, {1, 2})
    assert collides?(bottom, {1, 1, :blue})
    assert collides?(bottom, {1, 1, :red} )
    refute collides?(bottom, {1, 2, :red})
    assert collides?(bottom, [{1, 2, :red}, {1, 1, :red}])
    refute collides?(bottom, [{1, 2, :red}, {1, 3, :red}])
  end
  
  test "simple merge test" do
    bottom = %{{1, 1} => {1, 1, :blue}}
    
    actual = merge bottom, [{1, 2, :red}, {1, 3, :red}]    
    expected = %{
      {1, 1} => {1, 1, :blue}, 
      {1, 2} => {1, 2, :red}, 
      {1, 3} => {1, 3, :red}}
      
    assert actual == expected
  end
  
end
