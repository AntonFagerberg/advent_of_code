defmodule Day5Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_5"
      |> File.read!
      |> Day5.solve_1
      
    assert result == 258
  end

  test "Part 2" do
    result = 
      "input/day_5"
      |> File.read!
      |> Day5.solve_2
      
    assert result == 53
  end
end