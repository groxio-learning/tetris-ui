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
  
  test "various collisions with top and lower margin" do
    bottom = %{}
    
    assert collides?(bottom, {0, 1})
    refute collides?(bottom, {1, 2})
    assert collides?(bottom, {11, 1, :blue})
    assert collides?(bottom, {1, 21, :red} )
    refute collides?(bottom, {1, 20, :red})
    assert collides?(bottom, [{11, 2, :red}, {10, 1, :red}])
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
