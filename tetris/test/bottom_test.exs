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
  
  test "compute complete ys" do
    bottom = new_bottom(20, [{{19, 19}, {19, 19, :red}}])
    
    assert complete_ys(bottom) == [20]
  end
  
  test "collapse single row" do
    bottom = new_bottom(20, [{{19, 19}, {19, 19, :red}}])
    actual = Map.keys(collapse_row(bottom, 20))
    refute {19, 19} in actual 
    assert {19, 20} in actual 
    assert Enum.count(actual) == 1
  end
  
  def new_bottom(complete_row, xtras) do
    (xtras ++ 
    (1..10
      |> Enum.map(fn x -> 
        {{x, complete_row}, {x, complete_row, :red}}
      end)))
    |> Map.new
  end
end
