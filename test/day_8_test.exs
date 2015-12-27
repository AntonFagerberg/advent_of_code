defmodule Day8Test do
  use ExUnit.Case

  test "Part 1" do
    result = 
      "input/day_8"
      |> File.read!
      |> Day8.solve_1
      
    assert result == 1371
  end

  test "Part 2" do
    result = 
      "input/day_8"
      |> File.read!
      |> Day8.solve_2
      
    assert result == 2117
  end
end