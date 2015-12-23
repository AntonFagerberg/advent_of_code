defmodule Day3Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_3"
      |> File.read!
      |> Day3.solve_1
      
    assert result == 2081
  end
  
  test "Part 2" do
    result = 
      "input/day_3"
      |> File.read!
      |> Day3.solve_2
      
    assert result == 2341
  end
end