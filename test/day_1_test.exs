defmodule Day1Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_1"
      |> File.read!
      |> Day1.solve_1
      
    assert result == 280
  end
  
  test "Part 2" do
    result = 
      "input/day_1"
      |> File.read!
      |> Day1.solve_2
      
    assert result == 1797
  end
end