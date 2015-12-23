defmodule Day2Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_2"
      |> File.read!
      |> Day2.solve
      
    assert result == 1586300
  end
  
  test "Part 2" do
    result = 
      "input/day_2"
      |> File.read!
      |> Day2.solve(true)
      
    assert result == 3737498
  end
end