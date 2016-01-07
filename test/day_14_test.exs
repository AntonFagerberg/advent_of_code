defmodule Day14Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_14"
      |> File.read!
      |> Day14.solve_1
      
    assert result == 2640
  end
  
  
  test "Part 2" do
    result = 
      "input/day_14"
      |> File.read!
      |> Day14.solve_2
      
    assert result == 1102
  end

end